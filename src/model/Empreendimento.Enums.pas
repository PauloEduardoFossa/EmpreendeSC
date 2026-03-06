unit Empreendimento.Enums;

interface

type
  TStatus = (segAtivo, segInativo);

  TSegmento = (segTecnologia, segComercio, segIndustria, segServicos, segAgronegocio);

function StatusToString(AStatus: TStatus): Integer;
function StringToStatus(const AValue: Integer): TStatus;

function SegmentoToString(ASegmento: TSegmento): Integer;
function StringToSegmento(const AValue: Integer): TSegmento;

implementation

uses
  System.SysUtils;

function StatusToString(AStatus: TStatus): Integer;
begin
 case AStatus of

    segAtivo:
      Result := 0;

    segInativo:
      Result := 1;

  end;
end;

function StringToStatus(const AValue: Integer): TStatus;
begin
  case AValue of
    0: Result := segAtivo;
    1: Result := segInativo;
    else
      raise Exception.Create('Status inválido');
  end;
end;

function SegmentoToString(ASegmento: TSegmento): Integer;
begin

  case ASegmento of

    segTecnologia:
      Result := 0;

    segComercio:
      Result := 1;

    segIndustria:
      Result := 2;

    segServicos:
      Result := 3;

    segAgronegocio:
      Result := 4;

  end;
end;


function StringToSegmento(const AValue: Integer): TSegmento;
begin
  case AValue of
    0: Result := segTecnologia;
    1: Result := segComercio;
    2: Result := segIndustria;
    3: Result := segServicos;
    4: Result := segAgronegocio;
    else
      raise Exception.Create('Segmento inválido');
  end;
end;

end.
