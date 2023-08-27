#include <iostream>
using namespace std;

int main()
{
	string r;
	double B, A1, A2, A3, A4, A5, cannang, cotay, eo, hong, canhtay, luongmo, phantramluongmo;
	
	
	
	for (int i = 1; i <= 100; i++)
	{
		cout << "Nam/Nu: ";
		cin >> r;
		
		if (r != "nam" && r != "nu")
		{
			cout << "Nhap lai cho dung gioi tinh" << endl;
			break;
		}
		
		cout << "Can nang: ";
		cin >> cannang;
	
		cout << "Kich thuoc co tay: ";
		cin >> cotay;
	
		cout << "Kich thuoc eo: ";
		cin >> eo;
	
		cout << "Kich thuoc hong: ";
		cin >> hong;
	
		cout << "Kich thuoc canh tay: ";
		cin >> canhtay;
		
		if (r == "nam")
		{
			A1 = (cannang*1.082) + 94.42;
			A2 = cotay*4.15;
			B = A1 - A2;
			luongmo = cannang - B;
			phantramluongmo = luongmo*100/cannang;
			
			cout << "Luong mo: " << luongmo << endl;
			cout << "Phan tram luong mo: " << phantramluongmo << " %" << endl;
		}
		else if (r == "nu")
		{
			A1 = (cannang*0.732) + 8.987;
			A2 = cotay/3.14;
			A3 = eo*0.157;
			A4 = hong*0.249;
			A5 = canhtay*0.434;
			B = A1 + A2 - A3 - A4 + A5;
			luongmo = cannang - B;
			phantramluongmo = luongmo*100/cannang;
			
			cout << "Luong mo: " << luongmo << endl;
			cout << "Phan tram luong mo: " << phantramluongmo << " %" << endl;
		}		
	}
	
	return 0;
}
