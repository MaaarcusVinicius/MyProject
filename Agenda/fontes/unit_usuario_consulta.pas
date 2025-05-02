unit unit_usuario_consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  unit_usuario_cadastro, unit_dados, unit_funcoes;

type
  Tform_usuario_consulta = class(TForm)
    pnl_fundo: TPanel;
    lbl_obsProfissional: TLabel;
    lbl_logoTipo: TLabel;
    img_logoSiacAgenda: TImage;
    lbl_aviso: TLabel;
    lbl_aviso2: TLabel;
    lbl_pesParte1: TLabel;
    edt_consulta: TEdit;
    pnl_linhaTop: TPanel;
    dbgrd_consultaUsuario: TDBGrid;
    pnl_linhaEsquerda: TPanel;
    pnl_linhaDireita: TPanel;
    pnl_linhaCima: TPanel;
    pnl_linhaBaixo: TPanel;
    pnl_novoUsuário: TPanel;
    pnl_11: TPanel;
    btn_1: TSpeedButton;
    ds_consulta: TDataSource;
    pnl_cancelar: TPanel;
    btn_cancelar: TSpeedButton;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure edt_consultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrd_consultaUsuarioDblClick(Sender: TObject);
    procedure dbgrd_consultaUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_usuario_consulta: Tform_usuario_consulta;

implementation

{$R *.dfm}

procedure Tform_usuario_consulta.btn_1Click(Sender: TObject);
begin
  try

    form_usuario_consulta.Visible:= False;

    form_usuario_cadastro := Tform_usuario_cadastro.Create( Self );
    form_usuario_cadastro.ShowModal;

  finally

    form_usuario_cadastro.Free;
    form_usuario_consulta.Visible:= true;

  end;
end;

procedure Tform_usuario_consulta.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tform_usuario_consulta.dbgrd_consultaUsuarioDblClick(Sender: TObject);
begin
  if not ( dbgrd_consultaUsuario.DataSource.DataSet.IsEmpty ) then
    begin

      form_usuario_consulta.Visible := False;

      try
        form_usuario_cadastro := Tform_usuario_cadastro.Create( Self );
        form_usuario_cadastro.edt_nomeUsuario.Text   := dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('ds_usuario').AsString;
        form_usuario_cadastro.edt_nomeLogin.Text     := dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('ds_login').AsString;
        form_usuario_cadastro.edt_senha.Text         := dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('ds_senha').AsString;
        form_usuario_cadastro.edt_senhaConfirma.Text := dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('ds_senha').AsString;

        form_dados.Usuarios.id_usuarios := dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('id_usuarios').AsInteger;

        form_usuario_cadastro.senha_original := dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('ds_senha').AsString;

        form_usuario_cadastro.ShowModal;

      finally

        form_usuario_cadastro.Free;
        form_usuario_consulta.Visible := True;

      end;
    end;




end;

procedure Tform_usuario_consulta.dbgrd_consultaUsuarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sErro : string;

begin
  if ( not ( dbgrd_consultaUsuario.DataSource.DataSet.IsEmpty ) ) and ( Key = VK_DELETE )
  and  ( fnc_criar_menssagem('CONFIRMAÇÃO',
                             'EXCLUIR USUÁRIO',
                             'DESEJA REALMENTE EXCLUIR ESTE USUÁRIO',
                             ExtractFilePath(Application.ExeName ) + '\icones\HumanoAviso.png',
                             'CONFIRMA') )
  then

  begin
    if not ( form_dados.Usuarios.fnc_operacoes_crud('EXCLUIR',
     dbgrd_consultaUsuario.DataSource.DataSet.FieldByName('id_usuarios').AsString , sErro) ) then
      begin
               fnc_criar_menssagem('EXCLUIR USUÁRIO',
                                   'ERRO AO EXCLUIR USUÁRIO',
                                   sErro,
                                   ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                                   'ERRO')  ;
      end;
  end;

end;

procedure Tform_usuario_consulta.edt_consultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sErro: string;

begin

  if key = VK_RETURN then
  begin
    if form_dados.Usuarios.fnc_operacoes_crud('CONSULTAR',edt_consulta.Text, sErro) then
      begin
        ds_consulta.DataSet := form_dados.Usuarios.qryConsulta;
      end
    else
      begin

        fnc_criar_menssagem('CONSULTAR USUÁRIO',
                           'ERRO AO CONSULTAR USUÁRIO',
                           sErro,
                           ExtractFilePath(Application.ExeName ) + '\icones\HumanoDelete.png',
                           'OK')  ;
        edt_consulta.SetFocus;
      end;

  end;


end;

end.
