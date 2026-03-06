unit Empreendimento.Repository.Interfacee;

interface

uses
  System.Generics.Collections,
  Empreendimento.Model;

type
  IEmpreendimentoRepository = interface
    ['{D4B6B4C3-7C1A-4A1A-8C8B-9A4F7A1E9F01}']

    function Listar: TObjectList<TEmpreendimento>;
    function ObterPorId(AId: Integer): TEmpreendimento;
    procedure Inserir(AEmpreendimento: TEmpreendimento);
    procedure Atualizar(AEmpreendimento: TEmpreendimento);
    procedure Excluir(AId: Integer);
  end;

implementation

end.
