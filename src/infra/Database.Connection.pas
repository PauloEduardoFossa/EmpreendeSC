unit Database.Connection;

interface

uses
  FireDAC.Comp.Client;

type
  TDatabaseInitializer = class
  public
    class procedure InitializeDatabase(AConnection: TFDConnection);
  end;

implementation

uses
  System.SysUtils;

{ TDatabaseInitializer }

class procedure TDatabaseInitializer.InitializeDatabase(AConnection: TFDConnection);
var
  DBPath: string;
begin
  DBPath := ExtractFilePath(ParamStr(0)) + 'database\empreendimentos.db';

  if not FileExists(DBPath) then
  begin
    ForceDirectories(ExtractFilePath(DBPath));

    AConnection.Params.Database := DBPath;
    AConnection.Connected := True;

    AConnection.ExecSQL('CREATE TABLE empreendimento (' +
                            'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
                            'data_cadastro DATE,' +
                            'nome TEXT,' +
                            'nome_empreendedor TEXT,' +
                            'municipio TEXT,' +
                            'segmento INTEGER,' +
                            'email TEXT,' +
                            'status INTEGER)');
  end
  else
  begin
    AConnection.Params.Database := DBPath;
    AConnection.Connected := True;
  end;
end;

end.

