unit Empreendimento.Enums;

interface

type
  TStatus = (segAtivo, segInativo);

  TSegmento = (segTecnologia, segComercio, segIndustria, segServicos, segAgronegocio);

function StatusToString(AStatus: TStatus): string;
function StringToStatus(const AValue: Integer): TStatus;

function SegmentoToString(ASegmento: TSegmento): string;
function StringToSegmento(const AValue: Integer): TSegmento;

implementation

uses
  System.SysUtils;

function StatusToString(AStatus: TStatus): string;
begin
 case AStatus of

    segAtivo:
      Result := 'Ativo';

    segInativo:
      Result := 'Inativo';

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

function SegmentoToString(ASegmento: TSegmento): string;
begin

  case ASegmento of

    segTecnologia:
      Result := 'Tecnologia';

    segComercio:
      Result := 'Comercio';

    segIndustria:
      Result := 'Indústria';

    segServicos:
      Result := 'Serviços';

    segAgronegocio:
      Result := 'Agronegócio';

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
