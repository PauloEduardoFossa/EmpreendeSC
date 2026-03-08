object EmpreendimentoView: TEmpreendimentoView
  Left = 0
  Top = 0
  Caption = 'Gerenciar Empreendimento'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlBuscar: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 57
    Align = alTop
    TabOrder = 0
    object lblBuscar: TLabel
      Left = 30
      Top = 25
      Width = 38
      Height = 15
      Caption = 'Buscar:'
    end
    object btrnBuscar: TButton
      Left = 205
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Buscar'
      TabOrder = 1
      OnClick = btrnBuscarClick
    end
    object edtBuscar: TEdit
      Left = 75
      Top = 22
      Width = 121
      Height = 23
      TabOrder = 0
    end
  end
  object pnlCadastro: TPanel
    Left = 0
    Top = 255
    Width = 624
    Height = 145
    Align = alBottom
    TabOrder = 2
    object lblNome: TLabel
      Left = 30
      Top = 25
      Width = 36
      Height = 15
      Caption = 'Nome:'
    end
    object lblEmpreendedor: TLabel
      Left = 30
      Top = 50
      Width = 81
      Height = 15
      Caption = 'Empreendedor:'
    end
    object lblMunicipio: TLabel
      Left = 335
      Top = 25
      Width = 57
      Height = 15
      Caption = 'Munic'#237'pio:'
    end
    object lblEmail: TLabel
      Left = 335
      Top = 50
      Width = 32
      Height = 15
      Caption = 'Email:'
    end
    object lblSegmento: TLabel
      Left = 30
      Top = 75
      Width = 57
      Height = 15
      Caption = 'Segmento:'
    end
    object lblStatus: TLabel
      Left = 335
      Top = 75
      Width = 35
      Height = 15
      Caption = 'Status:'
    end
    object edtNome: TEdit
      Left = 120
      Top = 22
      Width = 200
      Height = 23
      TabOrder = 0
      Text = 'edtNome'
    end
    object edtEmpreendedor: TEdit
      Left = 120
      Top = 47
      Width = 200
      Height = 23
      TabOrder = 1
    end
    object edtMunicipio: TEdit
      Left = 395
      Top = 22
      Width = 200
      Height = 23
      TabOrder = 2
    end
    object edtEmail: TEdit
      Left = 395
      Top = 47
      Width = 200
      Height = 23
      TabOrder = 3
    end
    object cboSegmento: TComboBox
      Left = 120
      Top = 72
      Width = 200
      Height = 23
      Style = csDropDownList
      TabOrder = 4
    end
    object cboStatus: TComboBox
      Left = 395
      Top = 72
      Width = 200
      Height = 23
      Style = csDropDownList
      TabOrder = 5
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 57
    Width = 624
    Height = 198
    Align = alClient
    TabOrder = 1
    object grdEmpreendimentos: TDBGrid
      Left = 1
      Top = 1
      Width = 622
      Height = 196
      Align = alClient
      DataSource = dsrEmpreendimento
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = grdEmpreendimentosCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome_empreendedor'
          Title.Caption = 'Empreendedor'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'municipio'
          Title.Caption = 'Munic'#237'pio'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'segmento'
          Title.Caption = 'Segmento'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Caption = 'Status'
          Width = 80
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 624
    Height = 41
    Align = alBottom
    TabOrder = 3
    object btnNovo: TButton
      Left = 30
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnSalvar: TButton
      Left = 115
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnExluir: TButton
      Left = 195
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExluirClick
    end
  end
  object dsrEmpreendimento: TDataSource
    DataSet = memEmpreendimento
    Left = 280
    Top = 192
  end
  object memEmpreendimento: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 416
    Top = 192
  end
end
