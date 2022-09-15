-- RELATORIO DEPARTAMENTO
SELECT
    "A1"."SIGLA" "SIGLA",
    "A1"."NOME"  "NOME"
FROM
    "BRH"."DEPARTAMENTO" "A1"
ORDER BY
    "A1"."NOME";
-- --------------

-- RELATORIO DE DEPENDENTES
SELECT
    "A1"."QCSJ_C000000000300001_5" "NOME",
    "A1"."QCSJ_C000000000300000_0" "NOME",
    "A1"."DATA_NASCIMENTO_1"       "DATA_NASCIMENTO",
    "A1"."PARENTESCO_2"            "PARENTESCO"
FROM
    (
        SELECT
            "A3"."NOME"            "QCSJ_C000000000300000_0",
            "A3"."DATA_NASCIMENTO" "DATA_NASCIMENTO_1",
            "A3"."PARENTESCO"      "PARENTESCO_2",
            "A3"."COLABORADOR"     "COLABORADOR",
            "A2"."MATRICULA"       "MATRICULA",
            "A2"."NOME"            "QCSJ_C000000000300001_5"
        FROM
            "BRH"."DEPENDENTE"  "A3",
            "BRH"."COLABORADOR" "A2"
        WHERE
            "A3"."COLABORADOR" = "A2"."MATRICULA"
    ) "A1"
ORDER BY
    "A1"."QCSJ_C000000000300001_5",
    "A1"."QCSJ_C000000000300000_0";
-- ---------------

-- INSERIR NOVO COLABORADOR
INSERT INTO brh.papel (
    id,
    nome
) VALUES (
    8,
    'Especialista de Negócios'
);

INSERT INTO brh.colaborador (
    matricula,
    nome,
    cpf,
    email_pessoal,
    email_corporativo,
    salario,
    departamento,
    cep,
    complemento_endereco
) VALUES (
    'A234',
    'Fulano de Tal',
    '111.111.111-11',
    'fulano@email.com',
    'fulano@corp.com',
    '7500',
    'DEPTI',
    '71222-300',
    'Casa 13'
);

INSERT INTO brh.telefone_colaborador (
    colaborador,
    numero,
    tipo
) VALUES (
    'A234',
    '(61) 9999-9999',
    'M'
);

INSERT INTO brh.projeto (
    nome,
    responsavel,
    inicio,
    fim
) VALUES (
    'BI',
    'A234',
    TO_DATE('2022-05-01', 'yyyy-mm-dd'),
    NULL
);

INSERT INTO brh.atribuicao (
    projeto,
    colaborador,
    papel
) VALUES (
    5,
    'A234',
    8
);
-- ---------------
-- RELATORIOS DE CONTATOS
select 
    col.nome colaborador_nome,
    col.email_corporativo colaborador_email,
    tel.numero telefone
from 
    brh.colaborador col
    inner join brh.telefone_colaborador tel on col.matricula = tel.colaborador
-- ----------------
-- ----------------
-- RELATORIO ANALITICO DE EQUIPES
SELECT
    d.nome     nome_departamento,
    chefe.nome chefe,
    alocacao.nome,
    dep.nome   dependente,
    proj.projeto projeto,
    paper.nome papel,
    tel.numero telefone
FROM
         brh.departamento d
    INNER JOIN brh.colaborador chefe ON d.chefe = chefe.matricula
    INNER JOIN brh.colaborador alocacao ON d.sigla = alocacao.departamento
    LEFT JOIN brh.dependente  dep ON dep.colaborador = alocacao.matricula
    INNER JOIN brh.atribuicao proj ON proj.colaborador = alocacao.matricula
    INNER JOIN brh.papel paper ON paper.id = proj.papel
    INNER JOIN brh.telefone_colaborador tel on alocacao.matricula = tel.colaborador
ORDER BY
    d.nome,
    alocacao.nome;
-- ---------------------
-- ---------------------