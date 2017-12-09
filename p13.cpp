#include "stdafx.h"
#include<iostream>

int main()
{
	using namespace std;
	cout << "Enter the row of matrix p : ";// ��������к���
	int row;
	cin >> row;
	cout << "Enter the col of matrix p : ";
	int col;
	cin >> col;
	double** p = new double*[row];
	for (int i = 0; i<row; i++)
		p[i] = new double[col];
	for (int i = 0; i<row; i++)             //�������P��Ԫ��
		for (int j = 0; j<col; j++)
			cin >> p[i][j];
	double sum = 0.0;
	for (int ii = 0; ii<row; ii++)          //���
		for (int jj = 0; jj<col; jj++)
			sum = sum + p[ii][jj];
	double mean;
	mean = sum / (row*col);                  //��������
	double m = 0.0;
	double variance;
	for (int i = 0; i<row; i++)              //���㷽��
		for (int j = 0; j<col; j++)
			m = m + (p[i][j] - mean)*(p[i][j] - mean);
	variance = m / (row*col);
	cout << "The Expectation of matrix p: " << mean << endl;
	cout << "The Variance of matrix p: " << variance << endl;
	cout << "The Standard Deviation of matrix p: " << sqrt(variance) << endl;
	for (int i = 0; i<row; i++)
	{
		delete[] p[i];
		p[i] = NULL;
	}
	delete[] p;
	p = NULL;
	return 0;
}

