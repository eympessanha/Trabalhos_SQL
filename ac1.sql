drop database if exists locadora;
create database if not exists locadora;
use locadora;

create table if not exists locadora.classificacao(
  cod int not null,
  nome varchar (50) not null,
  preco float not null,
  constraint pk_classificacao primary key (cod)
);

create table if not exists locadora.filme(
  num_filme int not null,
  titulo_original varchar (50) not null,
  titulo_pt varchar (50) not null,
  duracao int not null,
  data_lancamento date not null,
  direcao varchar (250) not null,
  categoria varchar (50),
  fk_classificacao int not null,
  constraint pk_filme primary key (num_filme),
  constraint fk_filme_classificacao foreign key (fk_classificacao)
    references locadora.classificacao (cod) on delete cascade on update cascade
);


create table if not exists locadora.ator(
  cod int not null,
  data_nascimento date not null,
  nacionalidade varchar (50),
  nome_real varchar (50),
  nome_artistico varchar (50),
  constraint pk_ator primary key (cod)
);

create table if not exists locadora.estrela(
  fk_num_filme int not null,
  fk_cod_ator int not null,
  constraint pk_estrela primary key (fk_num_filme, fk_cod_ator),
  constraint fk_estrela_filme foreign key (fk_num_filme)
    references locadora.filme (num_filme) on delete cascade on update cascade,
  constraint fk_estrela_ator foreign key (fk_cod_ator)
    references locadora.ator (cod) on delete cascade on update cascade
);  

create table if not exists locadora.cliente(
  num_cliente int not null,
  nome varchar (50) not null,
  enderco varchar (50) not null,
  telefone_residencial varchar (50) not null,
  telefone_celular varchar (50) not null,
  constraint pk_cliente primary key (num_cliente)
);

create table if not exists locadora.midia(
  fk_num_filme int not null,
  numero int not null,
  tipo varchar (50) not null,
  constraint pk_midia primary key (fk_num_filme, numero, tipo),
  constraint fk_midia_filme foreign key (fk_num_filme)
    references locadora.filme (num_filme) on delete cascade on update cascade
);

create table if not exists locadora.emprestimo(
  fk_num_filme int not null,
  fk_numero int not null,
  fk_tipo varchar (50) not null,
  fk_cliente int not null,
  data_retirada date not null,
  data_devolucao date not null,
  valor_pago float not null,
  constraint pk_emprestimo primary key (fk_num_filme, fk_numero, fk_tipo, fk_cliente),
  constraint fk_emprestimo_cliente foreign key (fk_cliente)
    references locadora.cliente (num_cliente) on delete cascade on update cascade,
  constraint fk_emprestimo_midia_filme foreign key (fk_num_filme)
    references locadora.midia (fk_num_filme) on delete cascade on update cascade,
  constraint fk_emprestimo_midia_numero foreign key (fk_numero)
    references locadora.midia (numero) on delete cascade on update cascade,
  constraint fk_emprestimo_midia_tipo foreign key (fk_tipo)
    references locadora.midia (tipo) on delete cascade on update cascade
);
