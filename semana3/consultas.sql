-- UPDATE brh.projeto    SET id = id - 4; COMMIT;
-- drop user brh CASCADE;

-- RELATÓRIO DE DEPENDENTES
SELECT depen.nome "Nome Dependente", colab.nome "Nome Colaborador", depen.data_nascimento 
    FROM brh.dependente depen 
INNER JOIN brh.colaborador colab on depen.colaborador = colab.matricula 
WHERE ((EXTRACT(MONTH FROM TO_DATE(depen.data_nascimento)) > 03 
    and EXTRACT(MONTH FROM TO_DATE(depen.data_nascimento)) < 07) 
        or ((depen.nome LIKE '%h%') 
        or depen.nome LIKE '%H%'))
ORDER BY colab.nome, depen.nome;

-- COLABORADOR COM MAIOR SALÁRIO, POSSIVEL MELHORAR A CONSULTA
SELECT nome,salario FROM (SELECT * FROM brh.colaborador ORDER BY salario DESC) WHERE ROWNUM = 1;

-- RELATORIO DE SENIORIDADE
SELECT matricula, nome, salario, 
    CASE 
        WHEN salario <= 3000 THEN 'Júnior'
        WHEN salario > 3000 AND salario <= 6000 THEN 'Pleno' 
        WHEN salario > 6000 AND salario <= 20000 THEN 'Sênior' 
    ELSE 'Corpo Diretor' END senioridade
FROM brh.colaborador
ORDER BY senioridade, nome;

-- LISTAR COLABORADORES EM PROJETOS
SELECT  dept.nome nome_departamento, proj.nome nome_projeto, count(*) quantidade_colaboradores
    FROM brh.departamento dept
INNER JOIN brh.colaborador cola ON dept.sigla = cola.departamento
INNER JOIN brh.atribuicao atrib ON atrib.colaborador = cola.matricula
INNER JOIN brh.projeto proj ON proj.id = atrib.projeto 
GROUP BY dept.nome, proj.nome ORDER BY dept.nome, proj.nome;
    
-- LISTAR A FAIXA ETÁRIA DOS DEPENDENTES
SELECT colaborador, cpf, nome, data_nascimento, parentesco,
    nvl(floor((months_between(sysdate, data_nascimento) / 12)), 0) as idade, 
    CASE WHEN nvl(floor((months_between(sysdate, data_nascimento) / 12)), 0) < 18
        THEN 'MENOR DE IDADE' ELSE 'MAIOR DE IDADE' END 
    faixa_etaria FROM brh.dependente
ORDER BY colaborador, nome;

-- COLABORADORES COM MAIS DEPENDENTES
SELECT cola.nome colaborador, count(depen.colaborador) quantidade_dependentes 
    FROM brh.colaborador cola 
INNER JOIN brh.dependente depen ON cola.matricula = depen.colaborador 
    GROUP BY cola.nome
HAVING count(*) >= 2
ORDER BY count(depen.colaborador) DESC, cola.nome;

/*
SELECTS PARA CONSULTA
select * from brh.atribuicao;
select * from brh.colaborador;
select * from brh.departamento;
select * from brh.dependente;
select * from brh.endereco;
select * from brh.papel;
select * from brh.projeto;
select * from brh.telefone_colaborador;
*/

