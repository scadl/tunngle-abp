unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Label6: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ind:byte;

implementation

{$R *.dfm}

procedure AdFound(wdt,hgt:integer; winrect:trect; target:tlabel; ad:hwnd);
begin
     if (winrect.Right-winrect.Left=wdt)and(winrect.Bottom-winrect.Top=hgt)
     then
      begin
      target.Font.Color:=clGreen;
      target.Caption:='Скрыто';
      ShowWindow(ad,SW_HIDE);
      ind:=ind+1;
      end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var mwnd, adv1, adv2, adv3, adv4:hwnd; wndr:trect;
begin
mwnd:=FindWindow('TFormMain','Tunngle');
if mwnd<>0 then
  begin label1.Font.Color:=clGreen; label1.Caption:='Найдено'; ind:=ind+1; end;

adv1:=FindWindowEx(mwnd,0,'TspSkinPanel','');
repeat
  adv2:=FindWindowEx(adv1,0,'TspSkinPanel','');
  repeat
    adv3:=FindWindowEx(adv2,0,'TspSkinPanel','');
    repeat
      {adv4:=FindWindowEx(adv3,0,'TspSkinPanel','');
      repeat
        memo1.Lines.Add('>>>'+inttostr(adv4));
        //GetWindowRect(adv4,wndr);
        //AdFound(840,72,wndr,form1.label4,adv3);
        adv4:=GetWindow(adv4,GW_HWNDNEXT);
      until adv4=0;}
      memo1.Lines.Add('>>'+inttostr(adv3));
      GetWindowRect(adv3,wndr);
      AdFound(840,72,wndr,form1.label4,adv3);
      adv3:=GetWindow(adv3,GW_HWNDNEXT);
    until adv3=0;
     adv2:=GetWindow(adv2,GW_HWNDNEXT);
     memo1.Lines.Add('>'+inttostr(adv2));
     GetWindowRect(adv2,wndr);
     AdFound (845,101,wndr,form1.label2,adv2);
  until adv2=0;

  memo1.Lines.Add(inttostr(adv1));
  GetWindowRect(adv1,wndr);
  AdFound (170,641,wndr,form1.label3,adv1);

    if (wndr.Right-wndr.Left=845)and(wndr.Bottom-wndr.Top=641)
     then
      begin
      label6.Font.Color:=clGreen;
      label6.Caption:='Изменено';
      //ShowWindow(ad,SW_HIDE);
      SetWindowPos(adv1,0,0,0,845,641,SWP_SHOWWINDOW);
      ind:=ind+1;
      end;

  adv1:=GetWindow(adv1,GW_HWNDNEXT);
until adv1=0;

if ind=6 then
begin
     BitBtn1.Kind:=bkOK;
     BitBtn1.Caption:='Выполнено!';
end else begin
     BitBtn1.Kind:=bkNo;
     BitBtn1.Caption:='Ошибка, запустите Tunngle!';
end;
{ShowWindow(adv1,SW_SHOW); Form1.Caption:=IntToStr(ind); }
end;



end.
