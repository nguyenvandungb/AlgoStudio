//��� ����������� ����������� ������� � �������� ���� ������ �� �� �� ������ ������������.



#include <WinUser32.mqh>
extern bool first, second, third;

//������������ ���������� ��� ����������-----------------------
bool One_Chose=true;
int Quoute_counter=0;
double Start_time,Stop_Time,Passed_sec,QuotesPerSec,MksPerSec;	
//-------------------------------------------------------------
int file;

//Tests method-------------------------------------------------------------
void fir(){//���������� ���������� ������ 1000
    for(int n=0; n<1; n++)
     {
	     int s1=45+123;
	     int s2=4561-2541;
	     int s3=14*86;
	     int s4=4564/153;
     	}
    return;
    }
void sec(){//���������� ���������� ������ 10000
	for(int n=0; n<1; n++)
     {
	     int s1=45+123;
	     int s2=4561-2541;
	     int s3=14*86;
	     int s4=4564/153;
     	}
    return;
    }

void thid(){//���������� ���������� ������ 100000(�����)
	for(int n=0; n<1; n++)
     {
	     int s1=45+123;
	     int s2=4561-2541;
	     int s3=14*86;
	     int s4=4564/153;
     	}
    return;
    }
int init()
{	
    //�������� �� ���������� ����������� ���������, � ������ ���� �� ������ ��� ������ 1, �� ������� ������ � ������ �� ������������.
    int sum=first+second+third;
	if(sum>1){
    	int FirstMessage=MessageBox("�� ������� ����� ��� ���� ����� ��� ������, ��������� ������� ������ ", "Question", MB_OK|MB_ICONQUESTION);
    	One_Chose=false;
    	return(0);
    	}
	if(sum<1){
    	int SecondMessage=MessageBox("�� �� ������� �� ������ ��������, ��������� ������� ������ ", "Question", MB_OK|MB_ICONQUESTION);
    	One_Chose=false;
    	return(0);
    	}
    //�������� �����
   	file= FileOpen("D:\\report.csv",FILE_CSV|FILE_WRITE|FILE_READ,';');
	if(file==-1)Print(GetLastError());
	Start_time =GetTickCount();		//����� ������ ��
  return(0);
}


int start()
{
    Quoute_counter++;
    if (One_Chose==false) return(0);	//��������� �������� � �����
    if (first==true) fir();
    if (second==true) sec();
  return(0);
}


int deinit()
{
    //���� ������� �������������� ������--------------------------------------------------------
	Stop_Time= GetTickCount();		//����� ��������� ��
	Passed_sec =(Stop_Time-Start_time )/1000; 		//����� ������� �������� ��������� (����� �� 1000 ������ ��� � ������������, �������� � ��������)
	QuotesPerSec=NormalizeDouble((Quoute_counter)/Passed_sec,0);//���� � �������.
	MksPerSec=Passed_sec*1000000/Quoute_counter;				//���������� ����������� ����������� �� 1 �����
	Print ("Quote/sec: ",QuotesPerSec,"   #Quotes: ",Quoute_counter,"   mks/1K Quotes: ",MksPerSec,"   testing Time: ",Passed_sec); //������� ��� ��������, ����� ���� �������
	string CalculationResult=(QuotesPerSec+";"+Quoute_counter+";"+MksPerSec+";"+Passed_sec);		//���������� ���������
	//---------------------------------------------------------------------------------------------
	
		//������ � �������----------------------------------------------------------------------------------------
		
		//��� ������ �������� ���� �� � ����� ��� ������.���� ��� �� ����� �����
		int SizeFile=FileSize(file);
		int CycleNumber;
		if (SizeFile==0){	//���� ������ ����� 0 �� ������ �����
			CycleNumber=1;			//������ ��� ������� ����� ��������
			string SecRowTemplate=("N;Date/Time;Quote/sec;#Quotes;mks/1K Quotes;testing Time;;");
			int WriteFileHeader=FileWrite(file, CycleNumber,"\n;FrstTest;;;;;;;;SecondTest;;;;;;;;ThirdTest;;;;;;;;\n",SecRowTemplate,SecRowTemplate,SecRowTemplate);	//���������� ����� �������
			FileFlush(file);		//���������� ����� ����� � ����� �� ���������� �������� ������.
			}
		//---------------------------------------------------------------------------------------------
		//�������� ������ ������, ���� ������ ��������.
		else {
			string ReadCounter=FileReadString(file);
			CycleNumber=StrToInteger(ReadCounter)+1;
			bool SeekToStart=FileSeek(file, 0, SEEK_SET);	//������ ������ � ������ ����� ��� ���������� ��������. ����� �� ������� ��������������� � ����������� �������� ����� ����
			int WriteFileCounter=FileWrite(file,CycleNumber);
			FileFlush(file);
			}
		//---------------------------------------------------------------------------------------------
				//���������� ������ �� ��������� ������ ����� ������� � ����� ������ ������.
				bool GoToEnd=FileSeek(file, 0, SEEK_END);
				string time=TimeToStr(TimeCurrent());
				int WriteFileBody=FileWrite(file,";"+CycleNumber+";"+time+";"+CalculationResult);	//���������� ������ � ������������ �����
		//������ � ����
		if(GetLastError()!=0)Print(GetLastError());
		//�������� �����, ����� ��������� �������� FileOpen().
	    FileClose(file);
	    if(GetLastError()!=0)Print(GetLastError());
  return(0);
}


