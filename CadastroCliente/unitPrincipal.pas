unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Unit_DM, Vcl.Buttons;

type
  TFrmPrincipal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Painel1: TPanel;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    ComboBox2: TComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    Label4: TLabel;
    Label12: TLabel;
    DBMemo2: TDBMemo;
    DBRadioGroup1: TDBRadioGroup;
    DBGrid1: TDBGrid;
    DBEdit6: TDBEdit;
    Label5: TLabel;
    DBRadioGroup2: TDBRadioGroup;
    Label13: TLabel;
    txtBusca: TEdit;
    DBNavigator1: TDBNavigator;
    DBText3: TDBText;
    Label14: TLabel;



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

// uses Unit_DM;




end.
