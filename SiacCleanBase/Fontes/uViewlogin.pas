unit uViewlogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Buttons, ACBrBase,
  ACBrEnterTab, Vcl.Imaging.pngimage, unit_containerLogin, Api.Base, System.JSON;

type
  Tform_login = class(TForm)
    pnl_fundo: TPanel;
    img_login: TImage;
    pnl_uLogin: TPanel;
    pnl_userName: TPanel;
    lbl_userName: TLabel;
    img_user: TImage;
    pnl_linhaUserName: TPanel;
    edt_userName: TEdit;
    pnl_userSenha: TPanel;
    lbl__userSenha: TLabel;
    img_password: TImage;
    pnl_linhaUserSenha: TPanel;
    edt_userSenha: TEdit;
    pnl_botaoLogin: TPanel;
    btn_confirmaLogin: TSpeedButton;
    btn_fechar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GerarListaUsuarios;
    procedure btn_confirmaLoginClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_userSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    FListaUsuarios: TStringList;
  public
    function GetFListaUsuarios: TStringList;
    function UsuarioAutorizado(const NomeUsuario: string): Boolean;
  end;

var
  form_login: Tform_login;

implementation

uses
  uViewMain, Classe.funcoes;

{$R *.dfm}

procedure Tform_login.FormCreate(Sender: TObject);
begin
  FListaUsuarios := TStringList.Create;
  GerarListaUsuarios;

  if not Assigned(vGbl_FListaUsuarios) then
    vGbl_FListaUsuarios := TStringList.Create;

  vGbl_FListaUsuarios.Assign(FListaUsuarios);
end;

procedure Tform_login.FormDestroy(Sender: TObject);
begin
  FListaUsuarios.Free;
end;

procedure Tform_login.GerarListaUsuarios;
begin
  // Se a Lista não estiver criada por algum motivo, forço a criação.
  if not Assigned(FListaUsuarios) then
    FListaUsuarios := TStringList.Create
  else
  // Limpa a Lista
  FListaUsuarios.Clear;

  // Lista base — Todos os Usuários autorizados
  FListaUsuarios.Add('marcus');          // Analista de Sistemas
  FListaUsuarios.Add('wandersonb');      // Analista Implantação
  FListaUsuarios.Add('FILEMON');         // Analista Implantação
  FListaUsuarios.Add('ricardogomes');    // Analista Implantação
  FListaUsuarios.Add('LUCASARAUJO');     // Analista Suporte
  FListaUsuarios.Add('fabriciojs212');   // Analista Suporte
  FListaUsuarios.Add('victor');          // Gerente de Suporte
  FListaUsuarios.Add('KLEYSON');         // Gerente de Implantação
end;

function Tform_login.UsuarioAutorizado(const NomeUsuario: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to GetFListaUsuarios.Count - 1 do
  begin
    if SameText(GetFListaUsuarios[i], Trim(NomeUsuario)) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


procedure Tform_login.btn_confirmaLoginClick(Sender: TObject);
var
  Api: TApi;
  XMLRequest: string;
  Resposta: Boolean;
  vSenhaEncriptada: string;
begin
  // 🔹 Validação inicial
  if Trim(edt_userName.Text) = '' then
    Exit;

  // 🔹 Validação básica de campos obrigatórios
  if (Trim(edt_userName.Text) = '') or (Trim(edt_userSenha.Text) = '') then
  begin
    ShowMessage('Informe o usuário e a senha.');
    Exit;
  end;

  // 🔹 Criptografa a senha conforme padrão SIAC
  vSenhaEncriptada := SIAC_CriptografarSenha(edt_userSenha.Text);
  // ShowMessage(vSenhaEncriptada); // debug opcional

  Api := TApi.Create(nil);
  try
    Api.URL := 'https://host.siacsistemas.com.br/WsSiacSistemas/WebServiceSS.asmx';
    Api.Authorization := ''; // SOAP não usa Bearer Token

    // 🔹 Monta o XML SOAP com senha criptografada
    XMLRequest :=
      '<?xml version="1.0" encoding="utf-8"?>' +
      '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
      'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
      'xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
      '<soap12:Body>' +
      '  <LoginTecnicoArqBase xmlns="http://tempuri.org">' +
      '    <Login>' + Trim(edt_userName.Text) + '</Login>' +
      '    <Senha>' + vSenhaEncriptada + '</Senha>' +
      '  </LoginTecnicoArqBase>' +
      '</soap12:Body>' +
      '</soap12:Envelope>';

    // 🔹 Envia a requisição SOAP
    Resposta := Api.Post(XMLRequest);

    // 🔹 Validação do retorno
    if not Resposta then
    begin
      ShowMessage('Usuário ou senha inválidos. Verifique as credenciais e tente novamente.');
      Exit;
    end;

    // Alimenta o nome do User Login do sistema
    vGbl_UserLogin :=  Trim(edt_userName.Text);

    // 🔹 Fecha o formulário com sucesso
    ModalResult := mrOk;

    if Resposta then
      begin
        // Atualiza tela principal com dados do usuário logado
        if Assigned(ViewMain) then
        begin
          ViewMain.AplicarPermissoesUsuario(Trim(edt_userName.Text));
        end;
      end;
  except
    on E: Exception do
      ShowMessage('Erro ao validar login via WebService: ' + E.Message);
  end;

  Api.Free;
end;


procedure Tform_login.btn_fecharClick(Sender: TObject);
begin
  Application.Terminate;
end;


procedure Tform_login.edt_userSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_confirmaLoginClick(Self);
end;

procedure Tform_login.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = Vk_Return then
    Perform(40, 0, 0);

  if Key = VK_ESCAPE then
    Application.Terminate;

  // Verifica se o usuário pressionou ALT + F4
  if (Key = VK_F4) and (ssAlt in Shift) then
  begin
    Application.Terminate;
  end;
end;

function Tform_login.GetFListaUsuarios: TStringList;
begin
  Result := FListaUsuarios;
end;

end.

