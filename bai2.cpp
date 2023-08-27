#include<iostream>
using namespace std;

int main() 
{
	bool a[100000];
	int count = 1, n, i = 2;
	
	cin >> n;
	
	for (int i = 0; i < 100000; i++)	
	
			a[i] = false;
	
	a[2] = a[3] = a[5] = true;
	
	while(count <= n)
	{
		if (a[i] == true)
		{
			count += 1;
			a[2*i] = a[3*i] = a[5*i] = true;
		}
		i += 1;
	}
	cout << i - 1;
	
	return 0;
}
