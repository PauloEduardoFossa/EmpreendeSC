unit App.Constants;

interface

const
  FILTRO_VALOR = 'valor';

  //EMPREENDIMENTO
  CONSULTA_EMPREENDIMENTO =
      'SELECT ' +
      ' id, ' +
      ' nome, ' +
      ' nome_empreendedor, ' +
      ' municipio, ' +
      ' segmento, ' +
      ' email, ' +
      ' status ' +
      'FROM empreendimento ';
  FILTRO_EMPREENDIMENTO = ' WHERE id = :id ';
  INSERT_EMPREENDIMENTO =
      'INSERT INTO empreendimento ' +
      '(data_cadastro, nome, nome_empreendedor, municipio, segmento, email, status) ' +
      'VALUES (:data, :nome, :nomeResp, :municipio, :segmento, :email, :status)';
  UPDATE_EMPREENDIMENTO =
      'UPDATE empreendimento ' +
      'SET nome = :nome, ' +
      '    nome_empreendedor = :nome_empreendedor, ' +
      '    segmento = :segmento, ' +
      '    municipio = :municipio, ' +
      '    email = :email, ' +
      '    status = :status ' +
      'WHERE id = :id';
  DELETE_EMPREENDIMENTO =
    'DELETE FROM empreendimento WHERE id = :id';
  BUSCAR_EMPREENDIMENTO =
    'nome LIKE ''%valor%'' OR ' +
    'nome_empreendedor LIKE ''%valor%'' OR ' +
    'municipio LIKE ''%valor%''';

implementation

end.
