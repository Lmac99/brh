-- CRIAÇÃO DO SCHEMA, CASO NAO EXISTA
create schema if not exists brh;

-- SELECAO DO SCHEMA
use brh;

-- CRIACAO DAS TABELAS
create table if not exists tb_atribuicao (
colaborador int not null,
projeto int not null,
papel int not null,
constraint pk_atribuicao primary key (colaborador, projeto, papel),
index (colaborador), index(projeto), index(papel)
);

create table if not exists tb_colaborador(
matricula int primary key not null,
cpf varchar(12) not null,
email_corporativo varchar(100) not null,
salario float not null,
departamento varchar(5),
index (cpf), index(departamento)
);

create table if not exists tb_departamento(
sigla varchar(5) primary key not null,
nome varchar(100) not null,
chefe int not null,
departamento_superior varchar(5) not null,
index (chefe), index(departamento_superior)
);

create table if not exists tb_dependente(
cpf varchar(12) primary key not null,
colaborador int not null,
nome varchar(100) not null,
data_nascimento date not null,
parentesco varchar(50),
index (colaborador)
);

create table if not exists tb_papel(
id int primary key not null auto_increment,
nome varchar(100) not null
);

create table if not exists tb_projeto(
id int primary key not null,
nome varchar(100) not null,
responsavel int not null,
inicio date not null,
fim date not null,
index (responsavel)
);

create table if not exists tb_contato(
telefone varchar(15) primary key not null,
matricula int not null,
index (matricula)
);

create table if not exists tb_pessoa(
cpf varchar(12) primary key not null,
nome varchar(100) not null,
email_pessoal varchar(100),
bairro varchar(100) not null, 
logradouro varchar(100) not null,
complemento varchar(50),
cep varchar(9) not null,
index (cep)
);

create table if not exists tb_cep(
cep varchar(9) primary key not null,
cidade varchar(50) not null,
estado char(2) not null
);
-- FIM DA CRIACAO

-- A PARTIR DE AGORA É A ADIÇÃO DAS CHAVES PRIMARIAS
alter table tb_atribuicao
add constraint fk_colaborador_matric
  foreign key (colaborador) references tb_colaborador(matricula),
add constraint fk_projeto_id
  foreign key (projeto) references tb_projeto(id),
add constraint fk_papel_id
  foreign key (papel) references tb_papel(id);

alter table tb_colaborador
add constraint fk_cpf_colaborador
 foreign key (cpf) references tb_pessoa(cpf),
add constraint fk_departamento_colaborador
 foreign key (departamento) references tb_departamento(sigla);

alter table tb_departamento
add constraint fk_colaborador_chefeDept
 foreign key (chefe) references tb_colaborador(matricula),
add constraint fk_departamento_superior
 foreign key (departamento_superior) references tb_departamento(sigla);

alter table tb_dependente
add constraint fk_colaborador_depende
 foreign key (colaborador) references tb_colaborador(matricula);

alter table tb_projeto
add constraint fk_colaborador_responsavel
 foreign key (responsavel) references tb_colaborador(matricula);

alter table tb_contato
add constraint fk_colaborador_contato
 foreign key (matricula) references tb_colaborador(matricula);

alter table tb_pessoa
add constraint fk_cep_pessoa
 foreign key (cep) references tb_cep(cep);
 -- FIM DA ADICAO