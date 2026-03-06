unit Empreendimento.Model;

interface

uses
  Empreendimento.Enums;

type
  TEmpreendimento = class;

  TEmpreendimento = class
  private
    FID: Integer;
    FDataCadastro: TDateTime;
    FNome: string;
    FNomeEmpreendedor: string;
    FMunicipio: string;
    FSegmento: TSegmento;
    FEmail: string;
    FStatus: TStatus;
  public
    property ID: Integer read FID write FID;
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
    property Nome: string read FNome write FNome;
    property NomeEmpreendedor: string read FNomeEmpreendedor write FNomeEmpreendedor;
    property Municipio: string read FMunicipio write FMunicipio;
    property Segmento: TSegmento read FSegmento write FSegmento;
    property Email: string read FEmail write FEmail;
    property Status: TStatus read FStatus write FStatus;
  end;

implementation

end.
