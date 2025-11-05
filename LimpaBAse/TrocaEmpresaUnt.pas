unit TrocaEmpresaUnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.DBCtrls, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TTrocaEmpresaFrm = class(TForm)
    EmpresaLkpCmbx: TDBLookupComboBox;
    EmpresasDtSrc: TDataSource;
    EmpresaLbl: TLabel;
    EmpresaNovaLbl: TLabel;
    EmpresaNovaMskEdt: TMaskEdit;
    OkImg: TImage;
    CancelarImg: TImage;
    EmpresasQry: TFDQuery;
    procedure CancelarImgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkImgClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TrocaEmpresaFrm: TTrocaEmpresaFrm;

implementation

{$R *.dfm}
uses
  BancoDadosUnt, MensagensUnt, LimpaBaseUnt, ConectadosUnt;
procedure TTrocaEmpresaFrm.CancelarImgClick(Sender: TObject);
{Executa Close.}
begin
  Close;
end;

procedure TTrocaEmpresaFrm.FormCreate(Sender: TObject);
{Carrega lista de empresas ao criar formulário.}
begin
  EmpresasQry.Open();
end;

procedure TTrocaEmpresaFrm.OkImgClick(Sender: TObject);
{Verifica se os campos estão preenchidos, confirma alteração
  e executa TrocaEmpresa.}
var
  ConectadosFrm: TConectadosFrm;
begin
  if EmpresaLkpCmbx.KeyValue <> null then
    begin
        if EmpresaNovaMskEdt.Text <> '  .   .   /    -  ' then
          begin
            ConectadosFrm:= TConectadosFrm.Create(Application);
            if BancoDadosDtMdl.UsuariosConectados then
              begin
                ConectadosFrm.ShowModal;
              end
            else
              begin
                ConectadosFrm.SetConfirmado(True);
              end;
            if ConectadosFrm.GetConfirmado then
              begin
                if MensagensFrm.MsgBox(ATENCAO_QUESTAO_DIVERSA, 'Deseja realmente '
                  + 'trocar a empresa ' + EmpresaLkpCmbx.KeyValue
                  + ' pela empresa ' + EmpresaNovaMskEdt.Text + '?') = ID_YES then
                  begin
                    Close;
                    Hide;
                    BancoDadosDtMdl.TrocaEmpresa(EmpresaLkpCmbx.KeyValue,
                                              EmpresaNovaMskEdt.Text);
                    LimpaBaseFrm.EmpresaLkpCmbx.KeyValue:= null;
                    MensagensFrm.MsgBox(INF_PROC_CONCLUIDO, 'Empresa '
                               + EmpresaLkpCmbx.KeyValue + ' foi trocada pela '
                               + 'empresa ' + EmpresaNovaMskEdt.Text);
                  end;
              end;
          ConectadosFrm.FreeOnRelease;
          end
        else
          begin
            MensagensFrm.MsgBox(ERRO_VALIDAR_CAMPO, 'Digite uma chave para a'
                                +' empresa nova!');
            EmpresaNovaMskEdt.SetFocus;
          end;
    end
  else
    begin
      MensagensFrm.MsgBox(ERRO_VALIDAR_CAMPO, 'Selecione a empresa antiga!');
      EmpresaLkpCmbx.SetFocus;
    end;
end;

end.
