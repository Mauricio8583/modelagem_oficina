Create database if not exists bd_oficina;
use bd_oficina;
Create table if not exists cliente(
id_cliente int auto_increment primary key,
Nome varchar(100),
Email varchar(200)
);

Create table if not exists equipe(
id_equipe int auto_increment primary key,
Qnt_integrantes int
);

Create table if not exists veiculo(
id_veiculo int auto_increment primary key,
Modelo varchar(45),
Ano int,
cliente_id int,
equipe_id int,
constraint fk_cliente_id foreign key (cliente_id) references cliente(id_cliente),
constraint fk_equipe_id foreign key (equipe_id) references equipe(id_equipe)
);

Create table if not exists mecanico(
id_mecanico int auto_increment primary key,
Nome varchar(100),
Endereco varchar(45),
Especialidade varchar(45),
equipe_id int,
constraint fk_equipe_mecanico foreign key (equipe_id) references equipe(id_equipe)
);

Create table if not exists servico(
id_servico int auto_increment primary key,
Valor_servico float,
equipe_id int,
constraint fk_equipe_servico foreign key (equipe_id) references equipe(id_equipe)
);

Create table if not exists mao_de_obra(
id_mao_de_obra int auto_increment primary key,
Referencia float
);

Create table if not exists peca(
id_peca int auto_increment primary key,
Valor_peca float
);

Create table if not exists ordem_de_servico(
id_ordem_de_servico int auto_increment primary key,
Data_entrega date,
Valor_os float,
Data_emissao date,
mao_de_obra_id int,
constraint fk_mao_de_obra_os foreign key (mao_de_obra_id) references mao_de_obra(id_mao_de_obra)
);

Create table if not exists peca_por_os(
peca_id int,
os_id int,
constraint fk_peca_os foreign key (peca_id) references peca(id_peca),
constraint fk_os_peca foreign key (os_id) references ordem_de_servico(id_ordem_de_servico)
);

Create table if not exists servico_por_os(
servico_id int,
os_id int,
constraint fk_servico_os foreign key (servico_id) references servico(id_servico),
constraint fk_os_servico foreign key (os_id) references ordem_de_servico(id_ordem_de_servico)
);

-- Create index index_hash_modelo on veiculo(Modelo) using hash
-- Create index index_especialidade_mecanico on mecanico(Especialidade) using hash

delimiter \\
Create procedure insere_veiculo(
in modelo varchar(45),
in ano int,
in cliente int,
in equipe int
)
begin 
    Insert into veiculo(Modelo, Ano, cliente_id, equipe_id) values (modelo, ano, cliente, equipe);
    Select * from veiculo;

end \\
delimiter ;

call insere_veiculo('Palio', 2006, 1, 1);