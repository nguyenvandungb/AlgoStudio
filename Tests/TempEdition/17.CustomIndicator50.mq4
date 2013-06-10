//--------------------------------------------------------------------
// userindicator.mq4 
// ������������ ��� ������������� � �������� ������� � �������� MQL4.
//--------------------------------------------------------------------
#property indicator_chart_window    // �����. �������� � �������� ����
#property indicator_buffers 2       // ���������� �������
#property indicator_color1 Blue     // ���� ������ �����
#property indicator_color2 Red      // ���� ������ �����
 
double Buf_0[],Buf_1[];             // ���������� �������� (��� ������ ����������)
//--------------------------------------------------------------------
int start()                         // ����������� ������� start()
  {
      for(int j=0; j<50;j++){
  int i,                           // ������ ����
       Counted_bars;                // ���������� ������������ ����� 
   double indicator=iMA(Symbol(),0,0,0,30,PRICE_CLOSE,0);
//--------------------------------------------------------------------   
   SetIndexBuffer(2,Buf_0);         // ���������� ������� ������
   SetIndexStyle (2,DRAW_LINE,STYLE_SOLID,2);// ����� �����
   SetIndexBuffer(1,Buf_1);         // ���������� ������� ������
   SetIndexStyle (1,DRAW_ARROW);	// ����� �����
   SetIndexArrow(0,217);			//���������� ������ ��� ����� �����������, ������� ����� DRAW_ARROW.
//--------------------------------------------------------------------
	IndicatorBuffers(3);			//������������ ������ ��� �������, ������������ ��� ���������� ����������������� ����������.2 �������������� ������, ������������ ��� �������.
	IndicatorDigits(7);				//��������� ������� �������� (���������� ������ ����� ���������� �����) ��� ������������ �������� ����������. 
	IndicatorShortName("0_o");		//��������� "���������" ����� ����������������� ���������� ��� ����������� � ������� ���������� � � ���� DataWindow.
	SetIndexDrawBegin(0, indicator);
	SetIndexEmptyValue(1,0.0);		//������������� �������� ������ �������� ��� ����� ����������. �� ��������, ��������.
	SetIndexLabel(0,"HJK");			//��������� ����� ����� ���������� ��� ����������� ���������� � ���� DataWindow � ����������� ���������
	SetIndexLabel(1,"Tenkan");		//��������� ����� ����� ���������� ��� ����������� ���������� � ���� DataWindow � ����������� ���������
	SetIndexShift(0, 0);			//��������� �������� ����� ���������� ������������ ������ �������.
//	void SetLevelStyle(	int draw_style, int line_width, color clr=CLR_NONE) �� ��������� ����
//	void SetLevelValue(	int level, double value)���� ���� �� �����
//--------------------------------------------------------------------
   Counted_bars=IndicatorCounted(); // ���������� ������������ �����. ������� ���������� ���������� �����, �� ���������� ����� ���������� ������ ����������.
   i=Bars-Counted_bars-1;           // ������ ������� ��������������
   while(i>=0)                      // ���� �� ������������� �����
     {
      Buf_0[i]=Close[i];             // �������� 0 ������ �� i-�� ����
      Buf_1[i]=Close[i]-1;
      i--;                          // ������ ������� ���������� ����
     }
     }
//--------------------------------------------------------------------
   return;                          // ����� �� ����. �-�� start()
  }
//--------------------------------------------------------------------