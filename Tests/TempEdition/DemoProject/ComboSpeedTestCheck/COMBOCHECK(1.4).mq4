//��� ����������� ����������� ������� � �������� ���� ������ �� �� �� ������ ������������.

/*��� ���������� ����� �������� ���� ����� ���� � ������� ���� ����� �����������
1) �������� ����������� � ����� string separators()
*/



#include <WinUser32.mqh>
extern bool FirstChackBox, SecondChackBox, ThirdChackBox=1;

//������������ ���������� ��� ����������-----------------------
bool One_Chose=true;
int Quoute_counter=0;
double Start_time,Stop_Time,Passed_sec,QuotesPerSec,MksPerSec;	
//-------------------------------------------------------------
int file;

//Tests method-------------------------------------------------------------
void FirstTest(){
    for(int n=0; n<1; n++)
     {
	     int s1=45+123;
	     int s2=4561-2541;
	     int s3=14*86;
	     int s4=4564/153;
     	}
    return;
    }
void SecondTest(){
	for(int n=0; n<1; n++)
     {
	     int s1=45+123;
	     int s2=4561-2541;
	     int s3=14*86;
	     int s4=4564/153;
     	}
    return;
    }
void ThirTest(){
	for(int n=0; n<1; n++)
     {
	     int s1=45+123;
	     int s2=4561-2541;
	     int s3=14*86;
	     int s4=4564/153;
     	}
    return;
    }
    
//���������� ��� ������
string separators(){
	string ModuleSeparator;
	if(FirstChackBox==1){ModuleSeparator=";";}
	if(SecondChackBox==1) ModuleSeparator=";;;";
	if(ThirdChackBox==1) ModuleSeparator=";;;";
	return(ModuleSeparator);
	}
int init()
{	
    //�������� �� ���������� ����������� ���������, � ������ ���� �� ������ ��� ������ 1, �� ������� ������ � ������ �� ������������.
    int ChackBoxSum=FirstChackBox+SecondChackBox+ThirdChackBox;
	if(ChackBoxSum>1){
    	int FirstMessage=MessageBox("�� ������� ����� ��� ���� ����� ��� ������, ��������� ������� ������ ", "Question", MB_OK|MB_ICONQUESTION);	
    	One_Chose=false;
    	return(0);
    	}
	if(ChackBoxSum<1){
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
    if (FirstChackBox==true) FirstTest();
    if (SecondChackBox==true) SecondTest();
    if (ThirdChackBox==true) ThirTest();
  return(0);
}


int deinit()
{	
	//���� ��������� ���� ��� ����� ����� ������� ������� �� �����. ----------------------------------------------
	if(Quoute_counter<40000){
    	int answer1=MessageBox("������� ���� ����, ������ ����� ��������, �������� ������� ���� ����� ��� ������� ����", "Question", MB_OK|MB_ICONQUESTION);	
    	return(0);
		}
	if(Quoute_counter>10000000){		//������� �� 100000 �� ��������� �����
		int answer2=MessageBox("������� ����� ����, ������ ����� ��������, �������� ������� ���� �����", "Question", MB_OK|MB_ICONQUESTION);	
    	return(0);
		}
		
	//-------------------------------------------------------------------------------------------
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
		int CycleNumber;		//������ ��������� 
		if (SizeFile==0){	//���� ������ ����� 0 �� ������ �����
			CycleNumber=1;			//������ ��� ������� ����� ��������
			string SecRowTemplate=("N;Date/Time;Quote/sec;#Quotes;mks/1K Quotes;testing Time;;");
			int WriteFileHeader=FileWrite(file, CycleNumber,"\n;FrstTest;;;;;;;;SecondTest;;;;;;;;ThirdTest;;;;;;;;\n",SecRowTemplate,SecRowTemplate,SecRowTemplate);	//���������� ����� �������
			FileFlush(file);		//���������� ����� ����� � ����� �� ���������� �������� ������.
			}
		//---------------------------------------------------------------------------------------------
		//�������� ������ �����, ���� ������ ��������.
		else {
			int CurrentCounter=StrToInteger(FileReadString(file));
			if (FirstChackBox==1){
				CycleNumber=CurrentCounter+1;
				bool SeekToStart=FileSeek(file, 0, SEEK_SET);	//������ ������ � ������ ����� ��� ���������� ��������. ����� �� ������� ��������������� � ����������� �������� ����� ����
				int WriteFileCounter=FileWrite(file,CycleNumber);
				bool SeekToEnd=FileSeek(file, 0, SEEK_END);
				FileFlush(file);
				}
			else CycleNumber=CurrentCounter;
			}
		//---------------------------------------------------------------------------------------------
				//���������� ������ �� ��������� ������ ����� ������� � ����� ������ ������.
				if(FirstChackBox!=1){
					bool GoToEnd=FileSeek(file,-2,SEEK_END);
					}
				string time=TimeToStr(TimeCurrent());	//���������� ������� �����
				int WriteFileBody=FileWrite(file,separators()+CycleNumber+";"+time+";"+CalculationResult);	//���������� ������ � ������������ �����
		//������ � ����
		if(GetLastError()!=0)Print(GetLastError());
		//�������� �����, ����� ��������� �������� FileOpen().
	    FileClose(file);
	    if(GetLastError()!=0)Print(GetLastError());
	    
	    //���� 
  return(0);
}


