#include<iostream>
using namespace std;

int main() 
{
	int A, B, C, sum = 0, sl = 0, khl = 0;
	
	cin >> A >> B;
	
	do
	{
		cout << "Nhap vao mot so bat ki: ";
		cin >> C;
		
		if (A < C && C < B)
		{
			sum += C;
			sl++;
		}
		else
			khl++;
	}
	while(C != -1);
	
	cout << "trung binh cong = " << sum/sl << endl;
	cout << "so luong khong hop le = " << khl;
	
	return 0;
	
}
