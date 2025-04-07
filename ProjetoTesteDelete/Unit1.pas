unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,   unitFuncoes;

type
  TForm1 = class(TForm)
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtDescricao: TEdit;
    medtData: TMaskEdit;
    cmbCategoria: TComboBox;
    lbl_1: TLabel;
    lbl_2: TLabel;
    lbl_3: TLabel;
    lbl_4: TLabel;
    btn_Cancela: TButton;
    btn_confirma: TButton;
    lbl_5: TLabel;
    procedure btn_CancelaClick(Sender: TObject);
    procedure btn_confirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.btn_CancelaClick(Sender: TObject);
begin
    Close;
end;

procedure TForm1.btn_confirmaClick(Sender: TObject);
begin

   edtNome.text := TrocaCaracterEspecial(edtNome.text, true)  ;
   ShowMessage(edtNome.text)  ;

   prcValidarCamposObrigatorios(Form1) ;

   ShowMessage('Tudo OK ! ');

end;

end.
