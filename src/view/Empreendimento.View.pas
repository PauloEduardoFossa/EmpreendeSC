unit Empreendimento.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  Empreendimento.Enums,
  Empreendimento.Repository;

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
    btnEditar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExluirClick(Sender: TObject);
    procedure grdEmpreendimentosCellClick(Column: TColumn);
    procedure btrnBuscarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    FRepository : TEmpreendimentoRepository;
    FIDSelecionado : Integer;

    procedure CarregarEmpreendimentos;
    procedure ControlarCampos(AStatus: Boolean);
    procedure Filtrar(ATexto: string);
    procedure LimparCampos;
    procedure PreencherCombos;
  public

  end;

var
  EmpreendimentoView: TEmpreendimentoView;

implementation

uses
  App.Constants,
  dmDataBase,
  Empreendimento.Model,
  System.SysUtils;

{$R *.dfm}

{ TEmpreendimentoView }

procedure TEmpreendimentoView.btnEditarClick(Sender: TObject);
begin
  if FIDSelecionado = 0 then
    Exit;

  ControlarCampos(True);
  edtNome.SetFocus;
end;

procedure TEmpreendimentoView.btnExluirClick(Sender: TObject);
begin
  if FIDSelecionado = 0 then
    Exit;

  if MessageDlg('Excluir empreendimento?', mtConfirmation,[mbYes,mbNo],0) = mrNo then
     Exit;

  FRepository.Excluir(FIDSelecionado);

  CarregarEmpreendimentos;

  LimparCampos;

  ControlarCampos(False);
  edtBuscar.SetFocus;
end;

procedure TEmpreendimentoView.btnNovoClick(Sender: TObject);
begin
  FIDSelecionado := 0;

  LimparCampos;
  ControlarCampos(True);
  edtNome.SetFocus;
end;

procedure TEmpreendimentoView.btnSalvarClick(Sender: TObject);
var
  LEmp : TEmpreendimento;
begin
  LEmp := TEmpreendimento.Create;

  try
    LEmp.ID := FIDSelecionado;
    LEmp.Nome := edtNome.Text;
    LEmp.NomeEmpreendedor := edtEmpreendedor.Text;
    LEmp.Municipio := edtMunicipio.Text;
    LEmp.Email := edtEmail.Text;

    LEmp.Segmento := StringToSegmento(cboSegmento.ItemIndex);

    LEmp.Status := StringToStatus(cboStatus.ItemIndex);

    if LEmp.ID = 0 then
      FRepository.Inserir(LEmp)
    else
      FRepository.Atualizar(LEmp);

    CarregarEmpreendimentos;

    LimparCampos;
    ControlarCampos(False);
    edtBuscar.SetFocus;
  finally
    LEmp.Free;
  end;
end;

procedure TEmpreendimentoView.btrnBuscarClick(Sender: TObject);
begin
  CarregarEmpreendimentos
end;

procedure TEmpreendimentoView.CarregarEmpreendimentos;
var
  LLista : TObjectList<TEmpreendimento>;
  LEmp : TEmpreendimento;
begin
  memEmpreendimento.EmptyDataSet;
  memEmpreendimento.Filtered := False;

  LLista := FRepository.Listar;

  try
    for LEmp in LLista do
    begin
      memEmpreendimento.Insert;

      memEmpreendimento.FieldByName('id').AsInteger := LEmp.ID;
      memEmpreendimento.FieldByName('nome').AsString := LEmp.Nome;
      memEmpreendimento.FieldByName('nome_empreendedor').AsString := LEmp.NomeEmpreendedor;
      memEmpreendimento.FieldByName('municipio').AsString := LEmp.Municipio;
      memEmpreendimento.FieldByName('segmento').AsInteger := Ord(LEmp.Segmento);
      memEmpreendimento.FieldByName('nome_segmento').AsString := SegmentoToString(LEmp.Segmento);
      memEmpreendimento.FieldByName('status').AsInteger := Ord(LEmp.Status);
      memEmpreendimento.FieldByName('nome_status').AsString := StatusToString(LEmp.Status);

      memEmpreendimento.Post;
    end;

    if memEmpreendimento.RecordCount > 0 then
    begin
      memEmpreendimento.First;
      Filtrar(edtBuscar.Text);
    end;
  finally
    LLista.Free;
  end;
end;

procedure TEmpreendimentoView.ControlarCampos(AStatus: Boolean);
begin
  edtNome.Enabled := AStatus;
  edtEmpreendedor.Enabled := AStatus;
  edtMunicipio.Enabled := AStatus;
  edtEmail.Enabled := AStatus;
  cboSegmento.Enabled := AStatus;
  cboStatus.Enabled := AStatus;

  btnNovo.Enabled := not AStatus;
  btnExluir.Enabled := not AStatus;
  btnEditar.Enabled := not AStatus;
  btnSalvar.Enabled := AStatus;
end;

procedure TEmpreendimentoView.Filtrar(ATexto: string);
begin
  memEmpreendimento.Filtered := False;

  if ATexto.Trim = '' then
    Exit;

  memEmpreendimento.Filter := StringReplace(BUSCAR_EMPREENDIMENTO, FILTRO_VALOR, ATexto, [rfReplaceAll]);

  memEmpreendimento.Filtered := True;
end;

procedure TEmpreendimentoView.FormCreate(Sender: TObject);
begin
  FRepository := TEmpreendimentoRepository.Create(DM.Con);

  memEmpreendimento.FieldDefs.Add('id', ftInteger);
  memEmpreendimento.FieldDefs.Add('nome', ftString, 200);
  memEmpreendimento.FieldDefs.Add('nome_empreendedor', ftString, 200);
  memEmpreendimento.FieldDefs.Add('municipio', ftString, 200);
  memEmpreendimento.FieldDefs.Add('segmento', ftString, 50);
  memEmpreendimento.FieldDefs.Add('nome_segmento', ftString, 50);
  memEmpreendimento.FieldDefs.Add('status', ftString, 20);
  memEmpreendimento.FieldDefs.Add('nome_status', ftString, 20);

  memEmpreendimento.CreateDataSet;

  PreencherCombos;

  CarregarEmpreendimentos;
  ControlarCampos(False);
end;

procedure TEmpreendimentoView.grdEmpreendimentosCellClick(Column: TColumn);
var
  LEmp: TEmpreendimento;
begin

  FIDSelecionado := memEmpreendimento.FieldByName('id').AsInteger;

  LEmp := FRepository.ObterPorId(FIDSelecionado);

  try

    if Assigned(LEmp) then
    begin
      edtNome.Text := LEmp.Nome;
      edtEmpreendedor.Text := LEmp.NomeEmpreendedor;
      edtMunicipio.Text := LEmp.Municipio;
      edtEmail.Text := LEmp.Email;
      cboSegmento.ItemIndex := Ord(LEmp.Segmento);
      cboStatus.ItemIndex := Ord(LEmp.Status);
    end;

  finally
    LEmp.Free;
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
