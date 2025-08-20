unit TabelaUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons, StdCtrls, ComCtrls, xmldom;

type
  TTabelaFrm = class(TFrame)
    RelacoesGrpBx: TGroupBox;
    SelecaoGrpBx: TGroupBox;
    RelacoesTrVw: TTreeView;
    SelecaoMmo: TMemo;
    SelecionarSpdBtn: TSpeedButton;
    StatusSelecaoLbl: TLabel;
    procedure SelecionarSpdBtnClick(Sender: TObject);
    procedure SelecaoMmoChange(Sender: TObject);
  private
    { Private declarations }
    NomeTabela: String;
    PrimaryKey: String;
    CampoEmpresa: String;
    CampoData: String;
    ReferenciasCasc: TStringList;
  public
    { Public declarations }
    function GetNomeTabela: String;
    procedure SetNomeTabela(Nome: String);
    function GetPrimaryKey:String;
    procedure SetPrimaryKey(Keys: String);
    function GetCampoEmpresa:String;
    procedure SetCampoEmpresa(Campo: String);
    function GetCampoData:String;
    procedure SetCampoData(Campo: String);
    procedure CarregarRelacoesTrVw(iNode: IDOMNode);
    function RelacoesCount: Integer;
    procedure SetReferenciasCasc(Tabela: String; Adiciona: Boolean);
    function GetReferenciasCasc: TStringList;
  end;

const
  CAPTION_SELECIONAR = 'Selecionar [tabela]' + sLineBreak + 'para exclusão!';
  HINT_SELECAO = 'Seleção deve retornar a(s) seguinte(s) coluna(s): [primarykey]';
  MSG_ERRO_SELECAO = 'Status: Erro na validação da seleção!';

implementation
uses
  LimpaBaseUnt;

{$R *.dfm}

{ TTabelaFrm }

function TTabelaFrm.GetNomeTabela: String;
{Retorna a string NomeTabela}
begin
  Result:= NomeTabela;
end;

procedure TTabelaFrm.SelecaoMmoChange(Sender: TObject);
{Ao editar texto do componente SelecaoMmo desmarca SelecionarSpdBtn e executa
  LimpaBaseFrm.SetSelecoes para remover tabela da lista de seleções}
begin
  SelecionarSpdBtn.Down:= False;
  LimpaBaseFrm.SetSelecoes(NomeTabela,SelecaoMmo.Text,SelecionarSpdBtn.Down);
end;

procedure TTabelaFrm.SelecionarSpdBtnClick(Sender: TObject);
{Ao clicar verifica se texto de SelecaoMmo está em branco gera a seleção padrão.
  Caso este ja marcando a tabela para excluir valida a seleção e inclui na lista
  de seleções, caso contrário retira a tabela da lista de seleções.}
var
  C: Integer;
begin
  if SelecionarSpdBtn.Down then
    begin
      if SelecaoMmo.Text = '' then
        begin
          SelecaoMmo.Text:= LimpaBaseFrm.GerarSelecaoPadrao(NomeTabela,
                                          PrimaryKey, CampoEmpresa, CampoData);
          SelecionarSpdBtn.Down:= True;
        end;
      C:= LimpaBaseFrm.ValidarSelecao(NomeTabela, PrimaryKey, SelecaoMmo.Text);
      if C = -1 then
        begin
          SelecionarSpdBtn.Down:= False;
          StatusSelecaoLbl.Caption:= MSG_ERRO_SELECAO;
        end
      else
        begin
          SelecionarSpdBtn.Down:= True;
          StatusSelecaoLbl.Caption:= 'Status: ' + IntToStr(C) + ' registro(s)'
            + ' selecionado(s)!';
        end;
    end
  else
    begin
      SelecaoMmo.Clear;
      StatusSelecaoLbl.Caption:= 'Status:'
    end;
  LimpaBaseFrm.SetSelecoes(NomeTabela,SelecaoMmo.Text,SelecionarSpdBtn.Down);
end;

procedure TTabelaFrm.SetNomeTabela(Nome: String);
{Atribui valor a string NomeTabela e altera a propriedade Caption do componente
  SelecionarSpdBtn}
begin
  NomeTabela:= Nome;
  SelecionarSpdBtn.Caption:= StringReplace(CAPTION_SELECIONAR, '[tabela]', Nome,
                                           [rfReplaceAll,rfIgnoreCase]);
end;

function TTabelaFrm.GetPrimaryKey;
{Retorna a string PrimaryKey}
begin
  Result:= PrimaryKey;
end;

function TTabelaFrm.GetReferenciasCasc: TStringList;
{Retorna referencias em cascata.}
begin
  Result:= ReferenciasCasc;
end;

function TTabelaFrm.RelacoesCount: Integer;
begin
  Result:= RelacoesTrVw.Items.Count;
end;

procedure TTabelaFrm.SetPrimaryKey(Keys: string);
{Atribui valor a string PrimaryKey e altera a propriedade Hint do componente
  SelecaoMmo}
begin
  PrimaryKey:= Keys;
  SelecaoMmo.Hint:= StringReplace(HINT_SELECAO, '[primarykey]', Keys,
                                  [rfReplaceAll,rfIgnoreCase]);
end;

procedure TTabelaFrm.SetReferenciasCasc(Tabela: String; Adiciona: Boolean);
{Atribui tabela para referencias em cascata.}
begin
  if ReferenciasCasc = nil then
    begin
      ReferenciasCasc:= TStringList.Create;
    end;
  if Adiciona then
    begin
      ReferenciasCasc.Add(Tabela);
    end
  else
    begin
      ReferenciasCasc.Delete(ReferenciasCasc.IndexOf(Tabela));
    end;
  case ReferenciasCasc.Count of
    0: begin
        StatusSelecaoLbl.Caption:= 'Status:';
        SelecaoMmo.Enabled:= True;
        SelecionarSpdBtn.Enabled:= True;
      end;
    1: begin
        StatusSelecaoLbl.Caption:= 'Status: Selecionada em cascata por '
                                    + ReferenciasCasc.Text;
        SelecaoMmo.Enabled:= False;
        SelecionarSpdBtn.Enabled:= False;
      end;
    else
      begin
        StatusSelecaoLbl.Caption:= 'Status: Selecionada em cascata por várias'
                                    + ' tabelas.';
        SelecaoMmo.Enabled:= False;
        SelecionarSpdBtn.Enabled:= False;
      end;
  end;
end;

function TTabelaFrm.GetCampoEmpresa;
{Retorna a string CampoEmpresa}
begin
  Result:= CampoEmpresa;
end;

procedure TTabelaFrm.SetCampoEmpresa(Campo: string);
{Atribui valor a string CampoEmpresa}
begin
  CampoEmpresa:= Campo;
end;

function TTabelaFrm.GetCampoData;
{Retorna a string CampoData}
begin
  Result:= CampoData;
end;

procedure TTabelaFrm.SetCampoData(Campo: string);
{Atribui valor a string CampoData}
begin
  CampoData:= Campo;
end;

procedure TTabelaFrm.CarregarRelacoesTrVw(iNode: IDOMNode);
{Carrega RelacoesTrVw com a ramificação do nó especificado}
  procedure ProcessNode(Node: IDOMNode; TreeNode: TTreeNode);
  {Procedure recursiva para percorrer toda ramificação do nó}
  var
    cNode: IDOMNode;
  begin
    if Node = nil then
      Exit;
    TreeNode := RelacoesTrVw.Items.AddChild(TreeNode, Node.nodeName);
    cNode := Node.FirstChild;
    while cNode <> nil do
    begin
      ProcessNode(cNode, TreeNode);
      cNode := cNode.NextSibling;
    end;
  end;
begin
  ProcessNode(iNode, nil);
  RelacoesTrVw.FullExpand;
  RelacoesTrVw.Select(RelacoesTrVw.Items[0]);
end;

end.
