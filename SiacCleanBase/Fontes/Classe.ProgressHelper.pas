unit Classe.ProgressHelper;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms,
  uViewProgressBar; // usa o form já criado

type
  TProgressHelper = class
  private
    FProgressForm: TfrmProgressBar;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(AMax: Integer; const ACaption: string = '');
    procedure Step(const AMessage: string = '');
    procedure Finish;
    procedure UpdateCaption(const ACaption: string);
  end;

implementation

{ TProgressHelper }

constructor TProgressHelper.Create;
begin
  FProgressForm := TfrmProgressBar.Create(nil);
end;

destructor TProgressHelper.Destroy;
begin
  FProgressForm.Free;
  inherited;
end;

procedure TProgressHelper.Start(AMax: Integer; const ACaption: string);
begin
  if ACaption <> '' then
    FProgressForm.Caption := ACaption;

  FProgressForm.ProgressBar1.Min := 0;
  FProgressForm.ProgressBar1.Max := AMax;
  FProgressForm.ProgressBar1.Position := 0;

  //FProgressForm.lblStatus.Caption := '';
  FProgressForm.lbl_statusProcesso.Caption := '';

  FProgressForm.Show;
  FProgressForm.Update;
end;

procedure TProgressHelper.Step(const AMessage: string);
begin
  FProgressForm.ProgressBar1.StepBy(1);
  if AMessage <> '' then
    FProgressForm.lbl_statusProcesso.Caption := AMessage;

  FProgressForm.lbl_statusProcesso.Update;
end;

procedure TProgressHelper.Finish;
begin
  FProgressForm.Hide;
end;

procedure TProgressHelper.UpdateCaption(const ACaption: string);
begin
  if Assigned(FProgressForm) then
  begin
    FProgressForm.Caption := ACaption;
    FProgressForm.Update;
  end;
end;


end.

