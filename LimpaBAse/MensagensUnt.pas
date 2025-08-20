unit MensagensUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TMensagensFrm = class(TForm)
    FecharImg: TImage;
    SalvarImg: TImage;
    MensagensMmo: TMemo;
    SalvarDlg: TSaveDialog;
    procedure FecharImgClick(Sender: TObject);
    procedure SalvarImgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function MsgBox(MsgPadrao: Integer; MsgAdic:String): Integer;
    procedure Salvar;
  end;

const
  ERRO_ACESSO_BD = 1;
  ERRO_CONSULTA_BD = 2;
  ERRO_VALIDAR_DATA = 3;
  ERRO_VALIDAR_PERIODO = 4;
  ERRO_VALIDAR_SELECAO = 5;
  ERRO_CRIAR_FUNCAO = 6;
  ATENCAO_ALT_F4 = 7;
  ERRO_SALVAR_ARQUIVO = 8;
  INF_ARQUIVO_SALVO = 9;
  ERRO_HAB_DESAB_TRIGGERS = 10;
  ERRO_ALTERAR_FK = 11;
  ERRO_DELETAR_REGISTROS = 12;
  QUESTAO_DELETAR_REGISTROS = 13;
  ERRO_HAB_DESAB_FK = 14;
  ERRO_TROCA_EMPRESA = 15;
  INF_PROC_CONCLUIDO = 16;
  QUESTAO_LIMPAR_SELECOES = 17;
  ATENCAO_QUESTAO_DIVERSA = 18;
  ERRO_VALIDAR_CAMPO = 19;
  ERRO_EXCLUIR_SEQUENCIAL = 20;
  ERRO_CRIAR_SEQUENCIAL = 21;
var
  MensagensFrm: TMensagensFrm;

implementation

{$R *.dfm}
procedure TMensagensFrm.FecharImgClick(Sender: TObject);
begin
  Close;
end;

procedure TMensagensFrm.FormCreate(Sender: TObject);
{Configura diretório inicial para SalvarDlg ao criar formulário.}
begin
  SalvarDlg.InitialDir:= ExtractFilePath(Application.Name);
end;

function TMensagensFrm.MsgBox(MsgPadrao: Integer; MsgAdic: String): Integer;
{Chama Application.MessageBox conforme parametros informados.}
var
  Mensagem: String;
  BotaoIcone: Integer;
  Titulo: String;
  Retorno: String;
  begin
    Mensagem:= '';
    Titulo:= '';
    Retorno:= '';
    BotaoIcone:= MB_OK;
    case MsgPadrao of
       ERRO_ACESSO_BD: begin
            Mensagem:= 'Erro ao acessar banco de dados, verifique os parametros'
                        + ' informados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_CONSULTA_BD: begin
            Mensagem:= 'Erro ao consultar banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_VALIDAR_DATA: begin
            Mensagem:= 'Erro ao validar data!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_VALIDAR_PERIODO: begin
            Mensagem:= 'Erro ao validar período!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_VALIDAR_SELECAO: begin
            Mensagem:= 'Erro ao validar seleção de registros!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_CRIAR_FUNCAO: begin
            Mensagem:= 'Erro ao criar/atualizar função no banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ATENCAO_ALT_F4: begin
            Mensagem:= 'Atenção ALT+F4 fechará toda a aplicação e isso poderá'
                        + ' deixar triggers e chaves estrangeiras desabilitadas'
                        + ' ou alteradas para deletar em cascata dependendo do'
                        + ' status do processo atual. Deseja'
                        + ' finalizar o sistema mesmo assim?';
            BotaoIcone:= MB_ICONWARNING + MB_YESNO + MB_DEFBUTTON2;
            Titulo:= 'Atenção'
          end;
       ERRO_SALVAR_ARQUIVO: begin
            Mensagem:= 'Erro ao salvar arquivo!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       INF_ARQUIVO_SALVO: begin
            Mensagem:= 'Arquivo salvo com sucesso!';
            BotaoIcone:= MB_ICONASTERISK + MB_OK;
            Titulo:= 'Informação'
          end;
       ERRO_HAB_DESAB_TRIGGERS: begin
            Mensagem:= 'Erro ao habilitar/desabilitar triggers do banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_ALTERAR_FK: begin
            Mensagem:= 'Erro ao alterar chave estrangeira do banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       ERRO_DELETAR_REGISTROS: begin
            Mensagem:= 'Erro ao deletar registros do banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
       QUESTAO_DELETAR_REGISTROS: begin
            Mensagem:= 'Deseja realmente deletar os registros selecionados?';
            BotaoIcone:= MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2;
            Titulo:= 'Questão'
          end;
        ERRO_HAB_DESAB_FK: begin
            Mensagem:= 'Erro ao habilitar/desabilitar chave estrangeira do'
                        + ' banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
        ERRO_TROCA_EMPRESA: begin
            Mensagem:= 'Erro ao trocar empresa do banco de dados!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
        INF_PROC_CONCLUIDO: begin
            Mensagem:= 'Procedimento concluído com exito!';
            BotaoIcone:= MB_ICONINFORMATION + MB_OK;
            Titulo:= 'Informação'
          end;
        QUESTAO_LIMPAR_SELECOES: begin
            Mensagem:= 'Deseja realmente limpar as seleções?';
            BotaoIcone:= MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2;
            Titulo:= 'Questão'
        end;
        ATENCAO_QUESTAO_DIVERSA: begin
            Mensagem:= '';
            BotaoIcone:= MB_ICONWARNING + MB_YESNO + MB_DEFBUTTON2;
            Titulo:= 'Atenção'
          end;
        ERRO_VALIDAR_CAMPO: begin
            Mensagem:= 'Erro ao validar campo!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
        ERRO_EXCLUIR_SEQUENCIAL: begin
            Mensagem:= 'Erro ao excluir sequencial!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
        ERRO_CRIAR_SEQUENCIAL: begin
            Mensagem:= 'Erro ao criar sequencial!';
            BotaoIcone:= MB_ICONERROR + MB_OK;
            Titulo:= 'Erro'
          end;
    end;
    Titulo:= '[' + inttostr(MsgPadrao) + '] '+ Titulo;
    if MsgAdic <> '' then
      Mensagem:= Mensagem + sLineBreak + MsgAdic;
    Result:= Application.MessageBox(PChar(Mensagem),PChar(Titulo), BotaoIcone);
    MensagensMmo.Lines.Add('[' + TimeToStr(Now) + '] ' + Titulo + ' - '
                            + Mensagem + sLineBreak);
    case Result of
      ID_OK: begin
        MensagensMmo.Lines.Add('[' + TimeToStr(Now) + '] ' + Titulo + ': OK'
                                + sLineBreak);
      end;
      ID_YES: begin
        MensagensMmo.Lines.Add('[' + TimeToStr(Now) + ']: Sim' + sLineBreak);
      end;
      ID_NO: begin
        MensagensMmo.Lines.Add('[' + TimeToStr(Now) + ']: Não' + sLineBreak);
      end;
    end;
  end;
procedure TMensagensFrm.Salvar;
{Salvar histórico das mensagem no local indicado.}
begin
  try
    if SalvarDlg.Execute then
      begin
        MensagensMmo.Lines.SaveToFile(SalvarDlg.Files[0]);
        MensagensFrm.MsgBox(INF_ARQUIVO_SALVO, SalvarDlg.Files[0]);
      end;
  except
    on E : Exception do
      MensagensFrm.MsgBox(ERRO_SALVAR_ARQUIVO, SalvarDlg.Files[0] + sLineBreak
                          + E.Message);
  end;
end;

procedure TMensagensFrm.SalvarImgClick(Sender: TObject);
{Executa Salvar e Close.}
begin
  Salvar;
  Close;
end;
end.
