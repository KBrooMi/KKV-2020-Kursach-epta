#include "pch.h"
#include "SemanticAnalyzer.h"

SA::SemanticAnalyzer::SemanticAnalyzer(LT::LexTable lextable, IT::IdTable idtable)
{
	this->lextable = lextable;
	this->idtable = idtable;
}

void SA::SemanticAnalyzer::Start(const Log::LOG& log)
{
	Types();
	CheckReturn();
	ParmsOfStandFunc();
	FuncReturn();
	CorrectAmountOfParms();
	CheckStringLiteralOperations();
	CheckWhile();
	CheckVarLikeFunc();
	*log.stream << "-------------------------------------------------------------------------------------\n";
	*log.stream << "—емантический анализ выполнен без ошибок\n";
}

void SA::SemanticAnalyzer::CheckReturn()
{
	bool main = false;
	for (int i = 0; i < lextable.size; i++)
		if (lextable.table[i].lexema == LEX_RETURN) {
			if (main) {
				if ((lextable.table[i + 1].lexema == LEX_ID || lextable.table[i + 1].lexema == LEX_LITERAL)
					&& idtable.table[lextable.table[i + 1].idxTI].iddatatype != IT::IDDATATYPE::INT)
					throw ERROR_THROW_SEM(708, lextable.table[i].sn);
			}
			else if (lextable.table[i + 1].lexema == LEX_ID) {
				if (idtable.table[lextable.table[i + 1].idxTI].idtype == IT::IDTYPE::F)
					throw ERROR_THROW_SEM(700, lextable.table[i].sn);
			}
		}
		else if (lextable.table[i].lexema == LEX_MAIN)
			main = true;
}

void SA::SemanticAnalyzer::ParmsOfStandFunc()
{
	for (int i = 0; i < lextable.size; i++)
		switch (lextable.table[i].lexema) {
		case LEX_PRINT: {
			if (lextable.table[i + 1].lexema != LEX_ID && lextable.table[i + 1].lexema != LEX_LITERAL)
				throw ERROR_THROW_SEM(704, lextable.table[i].sn);
			break;
		}
		case LEX_COPY: {
			int parmsCount = 0;
			while (lextable.table[i].lexema != LEX_SEMICOLON) {
				i++;
				if (parmsCount > 0) {
					if (lextable.table[i].lexema == LEX_LITERAL)
						throw ERROR_THROW_SEM(709, lextable.table[i].sn);
				}
				if (lextable.table[i].lexema == LEX_ID || lextable.table[i].lexema == LEX_LITERAL) {
					parmsCount++;
					if (idtable.table[lextable.table[i].idxTI].iddatatype != IT::IDDATATYPE::STR)
						throw ERROR_THROW_SEM(702, lextable.table[i].sn);
				}
			}
			if (parmsCount != 2)
				throw ERROR_THROW_SEM(703, lextable.table[i - 1].sn);
			break;
		}
		case LEX_CONCAT: {
			int parmsCount = 0;
			while (lextable.table[i].lexema != LEX_SEMICOLON) {
				i++;
				if (lextable.table[i].lexema == LEX_ID || lextable.table[i].lexema == LEX_LITERAL) {
					parmsCount++;
					if (idtable.table[lextable.table[i].idxTI].iddatatype != IT::IDDATATYPE::STR)
						throw ERROR_THROW_SEM(702, lextable.table[i].sn);
				}
			}
			if (parmsCount != 2)
				throw ERROR_THROW_SEM(703, lextable.table[i - 1].sn);
			break;
		}
		}
}

void SA::SemanticAnalyzer::Types()
{
	IT::IDDATATYPE datatype;
	bool isFuncParm = false;
	for (int i = 0; i < lextable.size; i++) {
		if (lextable.table[i].lexema == LEX_EQUAL) {
			datatype = idtable.table[lextable.table[i - 1].idxTI].iddatatype;
			while (lextable.table[i].lexema != LEX_SEMICOLON) {
				i++;
				switch (lextable.table[i].lexema) {
				case LEX_ID: {
					if (idtable.table[lextable.table[i].idxTI].iddatatype != datatype)
						throw ERROR_THROW_SEM(706, lextable.table[i].sn);
					if (idtable.table[lextable.table[i].idxTI].idtype == IT::IDTYPE::F)
						while (lextable.table[i].lexema != LEX_RIGHTHESIS)
							i++;
					break;
				}
				case LEX_LITERAL: {
					if (idtable.table[lextable.table[i].idxTI].iddatatype != datatype)
						throw ERROR_THROW_SEM(706, lextable.table[i].sn);
					else if (idtable.table[lextable.table[i].idxTI].iddatatype == datatype && datatype == IT::IDDATATYPE::STR)
						if (idtable.table[lextable.table[i].idxTI].value.vstr.len == 0)
							throw ERROR_THROW_SEM(710, lextable.table[i].sn);
					break;
				}
				case LEX_CONCAT: {
					if (datatype != IT::IDDATATYPE::STR)
						throw ERROR_THROW_SEM(706, lextable.table[i].sn);
					while (lextable.table[i].lexema != LEX_RIGHTHESIS)
						i++;
					break;
				}
				case LEX_COPY: {
					if (datatype != IT::IDDATATYPE::INT)
						throw ERROR_THROW_SEM(706, lextable.table[i].sn);
					while (lextable.table[i].lexema != LEX_RIGHTHESIS)
						i++;
					break;
				}
				}
			}
		}
	}
}

void SA::SemanticAnalyzer::FuncReturn()
{
	for (int i = 0; i < lextable.size; i++)
		if (lextable.table[i].lexema == LEX_ID && idtable.table[lextable.table[i].idxTI].idtype == IT::IDTYPE::F
			&& lextable.table[i - 1].lexema == LEX_FUNCTION) {
			IT::IDDATATYPE iddatatype = idtable.table[lextable.table[i].idxTI].iddatatype;
			while (lextable.table[i].lexema != LEX_RETURN)
				i++;
			if (idtable.table[lextable.table[i + 1].idxTI].iddatatype != iddatatype)
				throw ERROR_THROW_SEM(707, lextable.table[i].sn);
		}
}

void SA::SemanticAnalyzer::CorrectAmountOfParms()
{
	std::string buf;
	buf.reserve(ID_MAXSIZE);
	int parms = 0, funcparms = 0;
	for (int i = 0; i < lextable.size; i++)
		if (lextable.table[i].lexema == LEX_EQUAL) {
			while (lextable.table[i].lexema != LEX_SEMICOLON) {
				i++;
				if (lextable.table[i].lexema == LEX_ID && idtable.table[lextable.table[i].idxTI].idtype == IT::IDTYPE::F) {
					buf = idtable.table[lextable.table[i].idxTI].id;
					int mainLine = i;
					std::vector<IT::IDDATATYPE> types;
					while (lextable.table[i].lexema != LEX_RIGHTHESIS) {
						i++;
						if (lextable.table[i].lexema == LEX_ID || lextable.table[i].lexema == LEX_LITERAL) {
							parms++;
							types.push_back(idtable.table[lextable.table[i].idxTI].iddatatype);
						}
					}
					for (int j = 0; j < i; j++)
						if (lextable.table[j].lexema == LEX_ID && idtable.table[lextable.table[j].idxTI].idtype == IT::IDTYPE::F
							&& buf == idtable.table[lextable.table[j].idxTI].id) {
							j++;
							int k;
							for (j, k = 0; lextable.table[j].lexema != LEX_RIGHTHESIS; j++)
								if (lextable.table[j].lexema == LEX_ID) {
									if (idtable.table[lextable.table[j].idxTI].iddatatype != types[k])
										throw ERROR_THROW_SEM(705, lextable.table[mainLine].sn);
									funcparms++;
									k++;
								}
							break;
						}
				}
			}
			if (funcparms != parms)
				throw ERROR_THROW_SEM(701, lextable.table[i].sn);
		}
}

void SA::SemanticAnalyzer::CheckStringLiteralOperations()
{
	std::vector<char> operators = { LEX_MINUS, LEX_PLUS, LEX_DIRSLASH, LEX_STAR, LEX_PERCENT };
	for (int i = 0; i < lextable.size; i++)
		if (lextable.table[i].lexema == LEX_EQUAL)
			if ((lextable.table[i + 1].lexema == LEX_LITERAL || lextable.table[i + 1].lexema == LEX_ID)
				&& idtable.table[lextable.table[i + 1].idxTI].iddatatype == IT::IDDATATYPE::STR)
				if (std::find(operators.begin(), operators.end(), lextable.table[i + 2].lexema) != operators.end())
					throw ERROR_THROW_SEM(712, lextable.table[i].sn);
}

void SA::SemanticAnalyzer::CheckWhile()
{
	for (int i = 0; i < lextable.size; i++)
		if (lextable.table[i].lexema == LEX_WHILE)
			if (idtable.table[lextable.table[i + 2].idxTI].iddatatype != IT::IDDATATYPE::INT)
				throw ERROR_THROW_SEM(704, lextable.table[i].sn);
}

void SA::SemanticAnalyzer::CheckVarLikeFunc()
{
	for (int i = 0; i < lextable.size; i++)
		if (lextable.table[i].lexema == LEX_EQUAL)
			while (lextable.table[i].lexema != LEX_SEMICOLON) {
				i++;
				if (lextable.table[i + 1].lexema == LEX_LEFTHESIS && lextable.table[i].lexema == LEX_ID
					&& idtable.table[lextable.table[i].idxTI].idtype != IT::IDTYPE::F)
					throw ERROR_THROW_SEM(711, lextable.table[i].sn);
			}
}