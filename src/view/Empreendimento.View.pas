unit Empreendimento.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Empreendimento.Repository, Empreendimento.Enums;

type
  TEmpreendimentoView = class(TForm)
    pnlBuscar: TPanel;
    lblBuscar: TLabel;
    btrnBuscar: TButton;
    edtBuscar: TEdit;
    pnlCadastro: TPanel;
    pnlGrid: TPanel;
    grdEmpreendimentos: TDBGrid;
    lblNome: TLabel;
    edtNome: TEdit;
    lblEmpreendedor: TLabel;
    edtEmpreendedor: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    lblMunicipio: TLabel;
    edtMunicipio: TEdit;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblSegmento: TLabel;
    lblStatus: TLabel;
    cboSegmento: TComboBox;
    cboStatus: TComboBox;
    dsrEmpreendimento: TDataSource;
    memEmpreendimento: TFDMemTable;
    Panel1: TPanel;
    btnNovo: TButton;
    btnSalvar: TButton;
    btnExluir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExluirClick(Sender: TObject);
    procedure grdEmpreendimentosCellClick(Column: TColumn);
  private
    FRepository : TEmpreendimentoRepository;
    FIDSelecionado : Integer;

    procedure CarregarEmpreendimentos;
    procedure PreencherCombos;
    procedure LimparCampos;
  public

  end;

var
  EmpreendimentoView: TEmpreendimentoView;

implementation

uses
  dmDataBase, Empreendimento.Model, System.UITypes;

{$R *.dfm}

{ TEmpreendimentoView }

procedure TEmpreendimentoView.btnExluirClick(Sender: TObject);
begin
  if FIDSelecionado = 0 then
    Exit;

  if MessageDlg('Excluir empreendimento?', mtConfirmation,[mbYes,mbNo],0) = mrNo then
     Exit;

  FRepository.Excluir(FIDSelecionado);

  CarregarEmpreendimentos;

  LimparCampos;
end;

procedure TEmpreendimentoView.btnNovoClick(Sender: TObject);
begin
  FIDSelecionado := 0;

  LimparCampos;
end;

procedure TEmpreendimentoView.btnSalvarClick(Sender: TObject);
var
  Emp : TEmpreendimento;
begin
  Emp := TEmpreendimento.Create;

  try
    Emp.ID := FIDSelecionado;
    Emp.Nome := edtNome.Text;
    Emp.NomeEmpreendedor := edtEmpreendedor.Text;
    Emp.Municipio := edtMunicipio.Text;
    Emp.Email := edtEmail.Text;

    Emp.Segmento := StringToSegmento(cboSegmento.ItemIndex);

    Emp.Status := StringToStatus(cboStatus.ItemIndex);

    if Emp.ID = 0 then
      FRepository.Inserir(Emp)
    else
      FRepository.Atualizar(Emp);

    CarregarEmpreendimentos;

    LimparCampos;

  finally
    Emp.Free;
  end;
end;

procedure TEmpreendimentoView.CarregarEmpreendimentos;
var
  Lista : TObjectList<TEmpreendimento>;
  Emp : TEmpreendimento;
begin

  memEmpreendimento.EmptyDataSet;

  Lista := FRepository.Listar;

  try

    for Emp in Lista do
    begin

      memEmpreendimento.Append;

      memEmpreendimento.FieldByName('id').AsInteger := Emp.ID;
      memEmpreendimento.FieldByName('nome').AsString := Emp.Nome;
      memEmpreendimento.FieldByName('nome_empreendedor').AsString := Emp.NomeEmpreendedor;
      memEmpreendimento.FieldByName('municipio').AsString := Emp.Municipio;
      memEmpreendimento.FieldByName('segmento').AsInteger := SegmentoToString(Emp.Segmento);
      memEmpreendimento.FieldByName('status').AsInteger := StatusToString(Emp.Status);

      memEmpreendimento.Post;

    end;

  finally
    Lista.Free;
  end;
end;

procedure TEmpreendimentoView.FormCreate(Sender: TObject);
begin
  FRepository := TEmpreendimentoRepository.Create(DM.Con);

  memEmpreendimento.FieldDefs.Add('id', ftInteger);
  memEmpreendimento.FieldDefs.Add('nome', ftString, 200);
  memEmpreendimento.FieldDefs.Add('nome_empreendedor', ftString, 200);
  memEmpreendimento.FieldDefs.Add('municipio', ftString, 200);
  memEmpreendimento.FieldDefs.Add('segmento', ftString, 50);
  memEmpreendimento.FieldDefs.Add('status', ftString, 20);

  memEmpreendimento.CreateDataSet;

  PreencherCombos;

  CarregarEmpreendimentos;
end;

procedure TEmpreendimentoView.grdEmpreendimentosCellClick(Column: TColumn);
var
  Emp: TEmpreendimento;
begin

  FIDSelecionado := memEmpreendimento.FieldByName('id').AsInteger;

  Emp := FRepository.ObterPorId(FIDSelecionado);

  try

    if Assigned(Emp) then
    begin
      edtNome.Text := Emp.Nome;
      edtEmpreendedor.Text := Emp.NomeEmpreendedor;
      edtMunicipio.Text := Emp.Municipio;
      edtEmail.Text := Emp.Email;
      cboSegmento.ItemIndex := SegmentoToString(Emp.Segmento);
      cboStatus.ItemIndex := StatusToString(Emp.Status);
    end;

  finally
    Emp.Free;
  end;
end;

procedure TEmpreendimentoView.LimparCampos;
begin
  edtNome.Clear;
  edtEmpreendedor.Clear;
  edtMunicipio.Clear;
  edtEmail.Clear;
  cboSegmento.ItemIndex := -1;
  cboStatus.ItemIndex := -1;
end;

procedure TEmpreendimentoView.PreencherCombos;
begin
  cboSegmento.Items.Add('Tecnologia');
  cboSegmento.Items.Add('Comércio');
  cboSegmento.Items.Add('Indústria');
  cboSegmento.Items.Add('Serviços');
  cboSegmento.Items.Add('Agronegócio');

  cboStatus.Items.Add('Ativo');
  cboStatus.Items.Add('Inativo')
end;

end.
