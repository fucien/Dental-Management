#include <iostream>
using namespace std;

int main()
{
	double W, H, a;
	
	for (int i = 1; i <= 100; i++)
	{
	cout << "Can nang: ";
	cin >> W;
	
	cout << "Chieu cao: ";
	cin >> H;
	
	a = W/(H*H);
	
	if (a > 40)
		cout << "Rat beo - can giam can ngay!!!" << endl;
	else if (a > 30)
		cout << "Beo - nen giam can" << endl;
	else if (a > 25)
		cout << "Thua can" << endl;
	else if (a > 18.5)
		cout << "Chuan" << endl;
	else if (a > 0)
		cout << "Duoi chuan" << endl;
	}
	
	return 0;
}
