#include<iostream>
using namespace std;

int main() 
{
	int N, A, B, C, S = 0;
	
	cin >> N;
	
	while(N > 9)
	{
		B = N%10;
		N = N/10;
		A = N%10;
		C = A*10 +B;
		S += C;
	}
	cout << S;
	
	return 0;
}
