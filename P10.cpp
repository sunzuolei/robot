// P10.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include<iostream>
#include<string>
#include<iomanip>
const int nRow = 4;
const int nCol = 5;
const double pStart = 0.7;
const double pSenseCorrect = 0.7;

int main()
{
	using namespace std;
	double p[nRow][nCol];
	string Measurements[nRow][nCol];
	string world[nRow][nCol] = {{ "red","green","green","red","red" },
								{ "red","red","green","red","red" },
								{ "red","red","green","green","red" },
								{ "red","red","red","red","red" }, };
	double prior_value = (1 - pStart) / (nRow * nCol - 1);
	for (int i = 0; i < nRow; i++)
		for (int j = 0; j < nCol; j++)
			p[i][j] = prior_value;
	p[2][1] = pStart;
	for (int i = 0; i < nRow; i++)
		for (int  j = 0; j < nCol; j++)
			Measurements[i][j] = "green";
	int hit;
	double sum = 0;
	double q[nRow][nCol];
	for (int ii = 0; ii < nRow; ii++)
		for (int jj =0; jj< nCol; jj++)
		{
			if (Measurements[ii][jj] == world[ii][jj])
				hit = 1;
			else 
				hit = 0;
			q[ii][jj] = p[ii][jj] * (hit * pSenseCorrect + (1 - hit) * (1 - pSenseCorrect));
			sum = sum + q[ii][jj];
		}
	for (int i =0; i < nRow; i++)
		for (int j = 0; j < nCol; j++)
			q[i][j] = q[i][j] / sum;
	double q_max = q[1][1];
	int max_row =0; 
	int max_col = 0;
	for (int i = 0; i < nRow; i++)
		for (int j = 1; j < nCol; j++)
			if (q[i][j] > q_max)
			{
				q_max = q[i][j];
				max_row = i;
				max_col = j;
			}
	cout<<"The Prior: "<<endl;
	for (int i = 0; i < nRow; i++)
		for (int j = 0; j < nCol; j++)
		{
			cout << setiosflags(ios::fixed) << setprecision(7) << "p[" << i << "][" << j << "] : " << p[i][j] << "\t";			
			if (j == nCol)
				cout <<endl;
		}
	cout << endl << endl;
	cout<<"The probability after sensing : "<<endl;
	for (int i =0; i < nRow; i++)
		for (int j =0; j < nCol; j++)
		{
			cout << setiosflags(ios::fixed) << setprecision(7) << "q[" << i << "][" << j << "] : " << q[i][j] << "\t";
			if (j == nCol)
				cout << endl;
		}
	cout << endl;
	cout << "The largest probability is q[" << max_row << "]" << "[" << max_col << "] : " << q[max_row][max_col] << endl;
}


	
