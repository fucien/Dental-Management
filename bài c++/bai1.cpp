#include<iostream>
using namespace std;

int main() 
{
	int t, h;
	
	cin >> t;
	
	for (int i = 0; i <= t; i++)
	{
		h = 3 + 10*i - i*i;
		
		if (h <= 0)
		{
			cout << "t = " << i << " h = " << 0;
			break;
		}
		else
			cout << "t = " << i << " h = " << h;
			cout << endl;
	}
}
