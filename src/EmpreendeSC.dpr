program EmpreendeSC;

uses
  Vcl.Forms,
  MenuPrincipal.View in 'view\MenuPrincipal.View.pas' {MenuPrincipalView},
  Empreendimento.Model in 'model\Empreendimento.Model.pas',
  Empreendimento.Repository.Interfacee in 'repository\Empreendimento.Repository.Interfacee.pas',
  Empreendimento.Repository in 'repository\Empreendimento.Repository.pas',
  Database.Connection in 'infra\Database.Connection.pas',
  dmDataBase in 'infra\dmDataBase.pas' {DM: TDataModule},
  Empreendimento.View in 'view\Empreendimento.View.pas' {EmpreendimentoView},
  Empreendimento.Enums in 'model\Empreendimento.Enums.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TDM, DM);
  TDatabaseInitializer.InitializeDatabase(DM.Con);

  Application.CreateForm(TMenuPrincipalView, MenuPrincipalView);

  Application.Run;
end.
