unit LoginUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, IniFiles;

type
  TLoginFrm = class(TForm)
    UsuarioEdt: TEdit;
    UsuarioLbl: TLabel;
    SenhaEdt: TEdit;
    SenhaLbl: TLabel;
    BancoDadosEdt: TEdit;
    BancoDadosLbl: TLabel;
    LoginImg: TImage;
    EntrarBtn: TButton;
    CancelarBtn: TButton;
    procedure CancelarBtnClick(Sender: TObject);
    procedure EntrarBtnClick(Sender: TObject);
    procedure BancoDadosEdtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginFrm: TLoginFrm;

implementation
uses
  LimpaBaseUnt, BancoDadosUnt, MensagensUnt;
{$R *.dfm}



procedure TLoginFrm.BancoDadosEdtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      EntrarBtn.Click;
    end;

end;

procedure TLoginFrm.CancelarBtnClick(Sender: TObject);
{Finaliza a aplicação.}
begin
  Application.Terminate;
end;

procedure TLoginFrm.EntrarBtnClick(Sender: TObject);
{Conecta ao banco de dados, executa as consultas iniciais e de relacionamento,
  Cria as páginas das tabelas no LimpaBaseFrm.}
var
  Usuario: String;
  Senha: String;
  BancoDados: String;
  BarraSts: String;
  TabUtilizadas: Integer;
begin
  Usuario:= UsuarioEdt.Text;
  Senha:= SenhaEdt.Text;
  BancoDados:= BancoDadosEdt.Text;
  BarraSts:= '';
  if BancoDadosDtMdl.Conectar(Usuario, Senha, BancoDados) then
    begin
      Close;
      BarraSts:= 'Conectado: ' + Usuario + '@' + BancoDados;
      LimpaBaseFrm.SetBarraSts(0, BarraSts);
      LimpaBaseFrm.Show;
      BancoDadosDtMdl.AposConectar;
      TabUtilizadas:= BancoDadosDtMdl.GetTabUtilizadas;
      BarraSts:= 'Tabelas Utilizadas: ' + inttostr(TabUtilizadas);
      LimpaBaseFrm.SetBarraSts(2, BarraSts);
      LimpaBaseFrm.CriarPaginas;
    end
  else
    begin
      SenhaEdt.Text:='';
      UsuarioEdt.SetFocus;
    end;
end;

procedure TLoginFrm.FormCreate(Sender: TObject);
{Mostra LoginFrm e cria LimpaFrm deixando-o como MainForm.}
begin
  Show;
  Application.CreateForm(TLimpaBaseFrm, LimpaBaseFrm);
end;


procedure TLoginFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{Passa foco simulando TAB.}
begin
  if Key = VK_RETURN then
    begin
      PERFORM(WM_NEXTDLGCTL,0,0);
    end;
end;

end.
