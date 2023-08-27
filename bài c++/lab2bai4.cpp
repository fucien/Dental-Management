#include <iostream>
#include <cmath>
using namespace std;

int main()
{
	int n;
	
	cout << "Nhap so nguyen: ";
	cin >> n;
	
	if (n%2 == 0)
	cout << n << " la so chan";
	else 
	cout << n << " la so le";
	
	return 0;
}
