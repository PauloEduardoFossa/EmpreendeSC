unit MenuPrincipal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMenuPrincipalView = class(TForm)
    btnEmpreendimento: TButton;
    procedure btnEmpreendimentoClick(Sender: TObject);
  private

  public

  end;

var
  MenuPrincipalView: TMenuPrincipalView;

implementation

uses
  Database.Connection,
  Empreendimento.View;

{$R *.dfm}

procedure TMenuPrincipalView.btnEmpreendimentoClick(Sender: TObject);
var
  LEmp: TEmpreendimentoView;
begin
  LEmp := TEmpreendimentoView.Create(nil);

  try
    LEmp.ShowModal;

  finally
    LEmp.Destroy;
  end;
end;

end.
