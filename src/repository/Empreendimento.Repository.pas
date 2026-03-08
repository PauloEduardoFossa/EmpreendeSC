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
  App.Constants,
  Data.DB,
  Empreendimento.Enums,
  FireDAC.Stan.Param;

{ TEmpreendimentoRepository }

procedure TEmpreendimentoRepository.Atualizar(AEmpreendimento: TEmpreendimento);
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := FConnection;

    LQry.SQL.Text := UPDATE_EMPREENDIMENTO;

    LQry.ParamByName('nome').AsString := AEmpreendimento.Nome;
    LQry.ParamByName('nome_empreendedor').AsString := AEmpreendimento.NomeEmpreendedor;
    LQry.ParamByName('segmento').AsInteger := Ord(AEmpreendimento.Segmento);
    LQry.ParamByName('municipio').AsString := AEmpreendimento.municipio;
    LQry.ParamByName('email').AsString := AEmpreendimento.Email;
    LQry.ParamByName('status').AsInteger := Ord(AEmpreendimento.Status);
    LQry.ParamByName('id').AsInteger := AEmpreendimento.Id;

    LQry.ExecSQL;
  finally
    LQry.Free;
  end;
end;

constructor TEmpreendimentoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TEmpreendimentoRepository.Excluir(AId: Integer);
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := FConnection;
    LQry.SQL.Text := DELETE_EMPREENDIMENTO;
    LQry.ParamByName('id').AsInteger := AId;
    LQry.ExecSQL;
  finally
    LQry.Free;
  end;
end;

procedure TEmpreendimentoRepository.Inserir(AEmpreendimento: TEmpreendimento);
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := FConnection;
    LQry.SQL.Text := INSERT_EMPREENDIMENTO;

    LQry.ParamByName('data').AsDateTime := AEmpreendimento.DataCadastro;
    LQry.ParamByName('nome').AsString := AEmpreendimento.Nome;
    LQry.ParamByName('nomeResp').AsString := AEmpreendimento.NomeEmpreendedor;
    LQry.ParamByName('municipio').AsString := AEmpreendimento.Municipio;
    LQry.ParamByName('segmento').AsInteger := Ord(AEmpreendimento.Segmento);
    LQry.ParamByName('email').AsString := AEmpreendimento.Email;
    LQry.ParamByName('status').AsInteger := Ord(AEmpreendimento.Status);

    LQry.ExecSQL;
  finally
    LQry.Free;
  end;
end;

function TEmpreendimentoRepository.Listar: TObjectList<TEmpreendimento>;
var
  LQry: TFDQuery;
  LEmp: TEmpreendimento;
begin

  Result := TObjectList<TEmpreendimento>.Create;

  LQry := TFDQuery.Create(nil);

  try

    LQry.Connection := FConnection;

    LQry.SQL.Text := CONSULTA_EMPREENDIMENTO;

    LQry.Open;

    while not LQry.Eof do
    begin

      LEmp := TEmpreendimento.Create;

      LEmp.ID :=
        LQry.FieldByName('id').AsInteger;

      LEmp.Nome :=
        LQry.FieldByName('nome').AsString;

      LEmp.NomeEmpreendedor :=
        LQry.FieldByName('nome_empreendedor').AsString;

      LEmp.Municipio :=
        LQry.FieldByName('municipio').AsString;

      LEmp.Email :=
        LQry.FieldByName('email').AsString;

      LEmp.Segmento :=
        StringToSegmento(LQry.FieldByName('segmento').AsInteger);

      LEmp.Status :=
        StringToStatus(LQry.FieldByName('status').AsInteger);

      Result.Add(LEmp);

      LQry.Next;

    end;

  finally
    LQry.Free;
  end;
end;

function TEmpreendimentoRepository.ObterPorId(AId: Integer): TEmpreendimento;
var
  LQry: TFDQuery;
begin
  Result := nil;

  LQry := TFDQuery.Create(nil);

  try
    LQry.Connection := FConnection;

    LQry.SQL.Text := CONSULTA_EMPREENDIMENTO + FILTRO_EMPREENDIMENTO;

    LQry.ParamByName('id').AsInteger := AID;

    LQry.Open;

    if not LQry.IsEmpty then
    begin
      Result := TEmpreendimento.Create;

      Result.ID := LQry.FieldByName('id').AsInteger;

      Result.Nome := LQry.FieldByName('nome').AsString;

      Result.NomeEmpreendedor := LQry.FieldByName('nome_empreendedor').AsString;

      Result.Municipio := LQry.FieldByName('municipio').AsString;

      Result.Email := LQry.FieldByName('email').AsString;

      Result.Segmento := StringToSegmento(LQry.FieldByName('segmento').AsInteger);

      Result.Status := StringToStatus(LQry.FieldByName('status').AsInteger);
    end;
  finally
    LQry.Free;
  end;
end;

end.
