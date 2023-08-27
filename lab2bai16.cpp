#include <iostream>
using namespace std;

int main()
{
	char r;
	int a, b;
	
	for (int i = 1; i <=100; i++)
	{
	cout << "Loai tai khoan: ";
	cin >> r;
	
	if (r != 'v' && r != 't')
	{
		cout << "Khong co loai tai khoan nay" << endl;
		break;
	}
	
	cout << "So du cuoi thang: ";
	cin >> a;
	
	cout << "So du toi thieu: ";
	cin >> b;
	
	if (r == 't')
	{
		if (a < b)
			cout << "So tien con trong tai khoan: " << a - 10 << endl;
		else
			cout << "So tien con trong tai khoan: " << a*104/100 << endl;
	}
	if (r == 'v')
	{
		if (a < b)
			cout << "So tien con trong tai khoan: " << a - 25 << endl;
		else
			if (a - b >= 5000)
				cout << "So tien con trong tai khoan: " << a*103/100 << endl;
			else
				cout << "So tien con trong tai khoan: " << a*105/100 << endl;
	}
	}
	
	return 0;
}
