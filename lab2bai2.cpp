#include <iostream>
using namespace std;

int main()
{
	int a, b, c;
	string d;
	
	cout << "Nhap diem 3 mon: ";
	cin >> a >> b >> c;
	
	if (a + b + c >= 15 && a >=4 && b >= 4 && c >= 4)
	{
		d = "Dau";
		cout << d << endl;
	
	if (a >= 5 && b >= 5 && c >= 5)
		cout << "Hoc deu cac mon";
	if (a < 5 || b < 5 || c < 5)
		cout <<"Hoc chua deu";
	}
	else
		cout << "Rot";
	
	return 0;
}
