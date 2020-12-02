#include "pch.h"
#include <bitset>

extern "C" {
	char* __stdcall Concat(char* str2, char* str1) {
		if (str1 == NULL || str2 == NULL)
			return (char*)"NULL";
		char* out = (char*)calloc(255, sizeof(char));
		if (out == NULL)
			return NULL;
		for (size_t i = 0; i < strlen(str1); i++)
			out[i] = str1[i];
		for (size_t i = 0, q = strlen(str1); i < strlen(str2); i++, q++)
			out[q] = str2[i];
		out[strlen(str1) + strlen(str2)] = '\0';
		return out;
	}

	unsigned long __stdcall Copy(char* origin, char*& destination) {
		if (origin == NULL)
			return NULL;
		destination = (char*)calloc(255, sizeof(char));
		if (destination == NULL)
			return NULL;
		for (size_t i = 0; i < strlen(origin); i++)
			destination[i] = origin[i];
		destination[strlen(origin)] = '\0';
		return strlen(destination);
	}

	void __stdcall ConsoleWriteInt(unsigned long number) {
		if (number == 0) {
			std::cout << "0\n";
			return;
		}
		char* out = (char*)calloc(33, sizeof(char));
		if (out == NULL)
			return;

		static char c[65]{};
		c[0] = '\0';

		unsigned long val;
		for (val = 1UL << (sizeof(unsigned long) * 8 - 1); val > 0; val >>= 1)
			strcat(c, ((number & val) == val) ? "1" : "0");

		int i = 0;
		while (c[i] != '1')
			i++;

		for (int j = i, q = 0; j < strlen(c); j++, q++)
			out[q] = c[j];

		std::cout << out << std::endl;
		return;
	}

	void __stdcall ConsoleWrite(const char* buffer) {
		setlocale(0, "");
		if (buffer == NULL) {
			std::cout << "NULL\n";
			return;
		}
		std::cout << buffer << std::endl;
		return;
	}
}