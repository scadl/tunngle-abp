unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, Vcl.Grids;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    btnShow: TButton;
    btnHide: TButton;
    btnSize: TButton;
    ListBox1: TListBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure btnHideClick(Sender: TObject);
    procedure btnSizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  wdt:array[1..4] of word;
  hgt:array[1..4] of word;
  ads:byte;

implementation

{$R *.dfm}

procedure AdFound(wdt,hgt:integer; winrect:trect; target:tlabel; ad:hwnd);
var wdttl:string;
begin
     //ShowMessage(inttostr(wdt)+' x '+inttostr(hgt)+' - '+inttostr(winrect.Width)+' x '+inttostr(winrect.Height));
     if (winrect.Width=wdt)and(winrect.Height=hgt)
     then
      begin
      if ads-2=0 then target.Font.Color:=clRed
      else target.Font.Color:=clGreen;
      target.Caption:='Найдено - '+inttostr(ads-3);
      ShowWindow(ad,SW_HIDE);
      ads:=ads+1;
      end;

      //GetWindowText(ad,pchar(wdttl),255);
      //ShowMessage(wdttl);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var mwnd, adv1, adv2, adv3, adv4, tmpwd :hwnd; wndr:trect;
begin

ads:=0;
ListBox1.Items.Clear;

{
tmpwd:=FindWindow('TspSkinPanel','spSkinPanelAdvRight2');
if tmpwd<>0
then ShowMessage('Found Adv2')
else ShowMessage('Adv2 not found');
}

mwnd:=FindWindow('TFormMain','Tunngle');
if mwnd<>0 then
  begin label1.Font.Color:=clGreen; label1.Caption:='Найдено'; ads:=ads+1; end;

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
      listbox1.Items.Add('adv3-'+inttostr(adv3));
      GetWindowRect(adv3,wndr);
      AdFound(wdt[1],hgt[1],wndr,form1.label2,adv3);
      adv3:=GetWindow(adv3,GW_HWNDNEXT);
    until adv3=0;
     adv2:=GetWindow(adv2,GW_HWNDNEXT);
     listbox1.Items.Add('adv2-'+inttostr(adv2));
     GetWindowRect(adv2,wndr);
     AdFound (wdt[2],hgt[2],wndr,form1.label2,adv2);
  until adv2=0;

  listbox1.Items.Add('adv1-'+inttostr(adv1));
  GetWindowRect(adv1,wndr);
  AdFound(wdt[3],hgt[3],wndr,form1.label2,adv1);

    if (wndr.Right-wndr.Left=wdt[2])and(wndr.Bottom-wndr.Top=hgt[3])
     then
      begin
      label6.Font.Color:=clGreen;
      label6.Caption:='Изменено';
      //ShowWindow(ad,SW_HIDE);
      SetWindowPos(adv1,0,0,0,845,641,SWP_SHOWWINDOW);
      ads:=ads+1;
      end;

  adv1:=GetWindow(adv1,GW_HWNDNEXT);
until adv1=0;

if ads>=5 then
begin
     BitBtn1.Kind:=bkOK;
     BitBtn1.Caption:='Выполнено!';
end else begin
     BitBtn1.Kind:=bkNo;
     BitBtn1.Caption:='Ошибка, что-то не так!';
end;
{ShowWindow(adv1,SW_SHOW); Form1.Caption:=IntToStr(ind) };
end;



procedure TForm1.btnHideClick(Sender: TObject);
var wdid:string;
begin
wdid:=ListBox1.Items.Strings[listbox1.ItemIndex];
Delete(wdid, 1, 5);
ShowWindow(strtoint(wdid), SW_HIDE);
end;

procedure TForm1.btnShowClick(Sender: TObject);
var wdid:string;
begin
wdid:=ListBox1.Items.Strings[listbox1.ItemIndex];
Delete(wdid, 1, 5);
ShowWindow(strtoint(wdid), SW_SHOW);
end;

procedure TForm1.btnSizeClick(Sender: TObject);
var wdttl:string; wndr2:trect; hwndtr:hwnd; wdid:string;
begin
wdid:=ListBox1.Items.Strings[listbox1.ItemIndex];
Delete(wdid, 1, 5);
//ShowMessage(wdid);
hwndtr:= strtoint(wdid);
GetWindowText(hwndtr, pchar(wdttl), 255);
GetWindowRect(hwndtr, wndr2);
ShowMessage('Title: '+wdttl+#13+
'ID: '+ inttostr(hwndtr) +#13+
'Sizes: '+ inttostr(wndr2.Width) + ' x ' + inttostr(wndr2.Height));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var ThemeINI: TCustomIniFile;
begin

ThemeINI:=TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
try
//ShowMessage(Themeini.ReadString('DefualtTheme', 'ThemeName', 'Not Found')+#13+inttostr(Themeini.ReadInteger('DefualtTheme', 'wdt_1', 0)));
//Themeini.WriteString('DefualtTheme', 'ThemeName', 'Not Found');

//ShowMessage(ComboBox1.Items.Strings[ComboBox1.ItemIndex]);
//ShowMessage(inttostr(Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'wdt_1', 0)));

  wdt[1]:=Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'wdt_1', 0);
  wdt[2]:=Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'wdt_2', 0);
  wdt[3]:=Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'wdt_3', 0);
  hgt[1]:=Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'hgt_1', 0);
  hgt[2]:=Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'hgt_2', 0);
  hgt[3]:=Themeini.ReadInteger(ComboBox1.Items.Strings[ComboBox1.ItemIndex], 'hgt_3', 0);
  {
  wdt[1]:=836;
  wdt[2]:=839;
  wdt[3]:=170;
  hgt[1]:=72;
  hgt[2]:=101;
  hgt[3]:=611;
  }
finally
ThemeINI.Free;
end;
//ShowMessage(Application.ExeName);

//Form1.Caption:=IntToStr(ComboBox1.ItemIndex);
BitBtn1.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
var ThemeINI: TCustomIniFile;
begin

ThemeINI:=TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
try
ThemeINI.ReadSections(ComboBox1.Items);
finally
ThemeINI.Free;
end;

end;

end.
