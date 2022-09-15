-- RELATORIO DEPARTAMENTO
-- -----------------
select sigla,nome from departamento order by nome;
-- -----------------
-- -----------------
-- RELATORIO DEPENDENTES
-- -----------------
select colaborador.nome as 'nome_colaborador', dependente.nome, dependente.data_nascimento, dependente.parentesco from dependente 
inner join colaborador 
on dependente.colaborador = colaborador.matricula
order by colaborador.nome, dependente.nome;
-- -----------------
-- -----------------
-- INSERIR NOVO COLABORADOR
-- -----------------
insert into papel 
	(nome) 
values 
	('Especialista de Negócios');
insert into colaborador 
	(matricula, nome, cpf, email_pessoal, email_corporativo, salario, departamento, cep, complemento_endereco)
values 
	('A234', 'Fulano de Tal', '111.111.111-11', 'fulano@email.com','fulano@corp.com','7500','DEPTI','71222-300', 'Casa 13');
insert into telefone_colaborador 
	(colaborador, numero, tipo)
values
	('A234', '(61) 9999-9999', 'M');
insert into projeto 
	(nome, responsavel, inicio, fim)
values 
	('BI', 'A234', '2022-05-01', null);
insert into atribuicao 
	(projeto, colaborador, papel)
values 
	(5, 'A234', 8);
-- -----------------
-- -----------------
-- EXLUINDO SECAP
SET SQL_SAFE_UPDATES = 0;
-- DELETANDO A OS DEPENDENTES DOS COLABORADORES DO SECAP
delete t1.* from dependente as t1 inner join colaborador as t2 on t1.colaborador = t2.matricula where t2.departamento='SECAP';
-- -----------------
-- DELETANDO OS TELEFONES DOS COLABORADORES DO SECAP
delete t1.* from telefone_colaborador as t1 inner join colaborador as t2 on t1.colaborador = t2.matricula where t2.departamento='SECAP';
-- -----------------
-- ATUALIZANDO OS PROJETOS ANTES DO SECAP
update projeto inner join colaborador on (colaborador.matricula = projeto.responsavel and colaborador.departamento = 'SECAP') set responsavel = 'A123';
-- -----------------
-- DELETANDO AS ATRIBUICOES DOS COLABORADORES DO SECAP
delete t1.* from atribuicao as t1 inner join colaborador as t2 on t1.colaborador = t2.matricula where t2.departamento='SECAP';
-- -----------------
-- ATUALIZANDO DE FORMA TEMPORARIA O CHEFE DO SECAP PARA ELIMINAR O AUTO-RELACIONAMENTO
update departamento as d1 inner join departamento as d2 on (d1.sigla='SECAP' and d1.departamento_superior = d2.sigla) set d1.chefe = d2.chefe;
-- -----------------
-- DELETANDO TODOS OS REGISTROS DE COLABORADORES DO SECAP
delete from colaborador where departamento='SECAP';
-- -----------------
-- DELETANDO O SECAP
delete from departamento where sigla = 'SECAP';
-- -----------------
SET SQL_SAFE_UPDATES = 1;
select * from departamento;