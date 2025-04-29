unit unit_mensagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  Tform_menssagens = class(TForm)
    pnl_fundo: TPanel;
    shp_fundo: TShape;
    pnl_linhaCabecario: TPanel;
    lbl_titulo_janela: TLabel;
    img_icone: TImage;
    lbl_titulo_menssagem: TLabel;
    lbl_msg: TLabel;
    pnl_botoes: TPanel;
    pnl_nao: TPanel;
    btn_nao: TSpeedButton;
    pnl_sim: TPanel;
    btn_sim: TSpeedButton;
    procedure btn_naoClick(Sender: TObject);
    procedure btn_simClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    sTituloJanela, sTituloMSG, sMSG, sCaminhoIcone, STipo : String;
    bRespostaMSG : Boolean;
  end;

var
  form_menssagens: Tform_menssagens;

implementation

{$R *.dfm}

procedure Tform_menssagens.btn_naoClick(Sender: TObject);
begin
  bRespostaMSG := False;
  close;
end;

procedure Tform_menssagens.btn_simClick(Sender: TObject);
begin
  bRespostaMSG := True;
  close;
end;

procedure Tform_menssagens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure Tform_menssagens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = VK_RETURN then
    btn_simClick( Self )
  else
  if key = VK_ESCAPE then
    btn_naoClick( Self );

end;

procedure Tform_menssagens.FormShow(Sender: TObject);
begin
  bRespostaMSG := False;

  lbl_titulo_janela.Caption    := sTituloJanela;
  lbl_titulo_menssagem.Caption := sTituloMSG;
  lbl_msg.Caption              := sMSG;
  img_icone.Picture.LoadFromFile( sCaminhoIcone  );

  if Stipo = 'OK' then
  begin
    pnl_nao.Visible := False;
    btn_sim.Caption := 'OK (Enter)' ;
  end;
end;

end.
