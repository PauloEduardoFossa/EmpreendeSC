unit Empreendimento.Repository;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Empreendimento.Model,
  Empreendimento.Repository.Interfacee;

type
  TEmpreendimentoRepository = class(TInterfacedObject, IEmpreendimentoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);

    function Listar: TObjectList<TEmpreendimento>;
    function ObterPorId(AId: Integer): TEmpreendimento;
    procedure Inserir(AEmpreendimento: TEmpreendimento);
    procedure Atualizar(AEmpreendimento: TEmpreendimento);
    procedure Excluir(AId: Integer);
  end;

implementation

uses
  Data.DB,
  Empreendimento.Enums,
  FireDAC.Stan.Param;

{ TEmpreendimentoRepository }

procedure TEmpreendimentoRepository.Atualizar(AEmpreendimento: TEmpreendimento);
begin

end;

constructor TEmpreendimentoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TEmpreendimentoRepository.Excluir(AId: Integer);
begin

end;

procedure TEmpreendimentoRepository.Inserir(AEmpreendimento: TEmpreendimento);
var
  EmpreendimentoQuery: TFDQuery;
begin
  EmpreendimentoQuery := TFDQuery.Create(nil);
  try
    EmpreendimentoQuery.Connection := FConnection;
    EmpreendimentoQuery.SQL.Text :=
      'INSERT INTO empreendimento ' +
      '(data_cadastro, nome, nome_empreendedor, municipio, segmento, email, status) ' +
      'VALUES (:data, :nome, :nomeResp, :municipio, :segmento, :email, :status)';

    EmpreendimentoQuery.ParamByName('data').AsDateTime := AEmpreendimento.DataCadastro;
    EmpreendimentoQuery.ParamByName('nome').AsString := AEmpreendimento.Nome;
    EmpreendimentoQuery.ParamByName('nomeResp').AsString := AEmpreendimento.NomeEmpreendedor;
    EmpreendimentoQuery.ParamByName('municipio').AsString := AEmpreendimento.Municipio;
    EmpreendimentoQuery.ParamByName('segmento').AsInteger := Ord(AEmpreendimento.Segmento);
    EmpreendimentoQuery.ParamByName('email').AsString := AEmpreendimento.Email;
    EmpreendimentoQuery.ParamByName('status').AsInteger := Ord(AEmpreendimento.Status);

    EmpreendimentoQuery.ExecSQL;
  finally
    EmpreendimentoQuery.Free;
  end;
end;

function TEmpreendimentoRepository.Listar: TObjectList<TEmpreendimento>;
var
  Query: TFDQuery;
  Empreendimento: TEmpreendimento;
begin

  Result := TObjectList<TEmpreendimento>.Create;

  Query := TFDQuery.Create(nil);

  try

    Query.Connection := FConnection;

    Query.SQL.Text :=
      'SELECT ' +
      ' id, ' +
      ' nome, ' +
      ' nome_empreendedor, ' +
      ' municipio, ' +
      ' segmento, ' +
      ' email, ' +
      ' status ' +
      'FROM empreendimento ' +
      'ORDER BY nome';

    Query.Open;

    while not Query.Eof do
    begin

      Empreendimento := TEmpreendimento.Create;

      Empreendimento.ID :=
        Query.FieldByName('id').AsInteger;

      Empreendimento.Nome :=
        Query.FieldByName('nome').AsString;

      Empreendimento.NomeEmpreendedor :=
        Query.FieldByName('nome_empreendedor').AsString;

      Empreendimento.Municipio :=
        Query.FieldByName('municipio').AsString;

      Empreendimento.Email :=
        Query.FieldByName('email').AsString;

      Empreendimento.Segmento :=
        StringToSegmento(Query.FieldByName('segmento').AsInteger);

      Empreendimento.Status :=
        StringToStatus(Query.FieldByName('status').AsInteger);

      Result.Add(Empreendimento);

      Query.Next;

    end;

  finally
    Query.Free;
  end;
end;

function TEmpreendimentoRepository.ObterPorId(AId: Integer): TEmpreendimento;
var
  Query: TFDQuery;
begin

  Result := nil;

  Query := TFDQuery.Create(nil);

  try

    Query.Connection := FConnection;

    Query.SQL.Text :=
      'SELECT ' +
      ' id, ' +
      ' nome, ' +
      ' nome_empreendedor, ' +
      ' municipio, ' +
      ' segmento, ' +
      ' email, ' +
      ' status ' +
      'FROM empreendimento ' +
      'WHERE id = :id';

    Query.ParamByName('id').AsInteger := AID;

    Query.Open;

    if not Query.IsEmpty then
    begin

      Result := TEmpreendimento.Create;

      Result.ID :=
        Query.FieldByName('id').AsInteger;

      Result.Nome :=
        Query.FieldByName('nome').AsString;

      Result.NomeEmpreendedor :=
        Query.FieldByName('nome_empreendedor').AsString;

      Result.Municipio :=
        Query.FieldByName('municipio').AsString;

      Result.Email :=
        Query.FieldByName('email').AsString;

      Result.Segmento :=
        StringToSegmento(Query.FieldByName('segmento').AsInteger);

      Result.Status :=
        StringToStatus(Query.FieldByName('status').AsInteger);

    end;

  finally
    Query.Free;
  end;
end;

end.
