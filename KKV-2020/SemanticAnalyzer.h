#pragma once
#include "LT.h"
#include "IT.h"
#include "Error.h"
#include "Log.h"

namespace SA {
	class SemanticAnalyzer {
	private:
		LT::LexTable lextable;
		IT::IdTable idtable;
		void CheckReturn();
		void ParmsOfStandFunc();
		void Types();
		void FuncReturn();
		void CorrectAmountOfParmsAndSignatures();
		void CheckStringLiteralOperations();
		void CheckWhile();
		void CheckVarLikeFunc();
	public:
		void Start(const Log::LOG& log);
		SemanticAnalyzer(LT::LexTable lextable, IT::IdTable idtable);
	};
}