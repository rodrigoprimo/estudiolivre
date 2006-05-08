CREATE TABLE `el_tipos_arquivo` (`tipoId` int(11) NOT NULL auto_increment, `nome` varchar(64) default NULL, `descricao` text,  PRIMARY KEY  (`tipoId`)) ENGINE=MyISAM;

INSERT INTO `el_tipos_arquivo` VALUES (1,'Video',NULL),(2,'Audio',NULL),(3,'Imagem',NULL),(4,'Texto',NULL);

INSERT INTO `users_grouppermissions` VALUES ('Registered','el_p_uload_files','');

INSERT INTO `users_permissions` VALUES ('el_p_upload_files','Subir arquivos na galeria do Estúdio Livre','basic','estudiolivre');

create table el_ponto_de_cultura (pontoId int4 primary key, nome char(255));

insert into users_permissions values('el_p_upload_files','Subir arquivos na galeria do Estdio Livre','basic','estudiolivre');

# fmathias - 4/11 - seguindo o RFC =P

# assumindo que ainda n� entrou em produ�o
create table `el_arquivo` (
       arquivoId int4 primary key auto_increment,
       tipo char(10) not null, key(tipo),
       user char(40) not null, key(user),
       licencaId int4 not null, key(licencaId),
       pontoId int4 not null, key(pontoId),
       publicado bool not null default 0, key(publicado),
       data_publicacao date not null, key(data_publicacao),
       titulo char(255) not null, key(titulo),
       arquivo char(32) not null, key(arquivo),
       formato char(7) not null, key(formato), 
       tamanho int(40), key(tamanho),
       anoProducao int not null, key(anoProducao),
       descricao varchar(255),
       produtora varchar(100), key(produtora),
       contato varchar(100), key(contato),
       iSampled varchar(255), key(iSampled),
       sampledMe varchar(255), key(sampledMe),
       siteRelacionado varchar(255), key(siteRelacionado),
       comentarios varchar(255),
       rating int1,
       palavrasChave varchar(100), key(palavrasChave)

);

create table `el_arquivo_audio` ( 
        arquivoId int4 primary key, 
        duracao int not null, key(duracao),
        tipoDoAudio varchar(8) not null, key(tipoDoAudio), 
        bpm int not null, key(bpm), 
        sampleRate int not null, key(sampleRate),
        bitRate int not null, key(bitRate),
        genero varchar(50), key(genero), 
        letra varchar(255),
        fichaTecnica text
);

create table `el_arquivo_video` (
       arquivoId int4 primary key,
       duracao int not null, key(duracao),
       tamanhoImagemX int not null, key(tamanhoImagemX),
       tamanhoImagemY int not null, key(tamanhoImagemY),
       temAudio bool not null default 1, key(temAudio),
       temCor bool not null default 1, key(temCor),
       idiomaVideo varchar(20), key(idiomaVideo),
       legendas bool not null default 0, key(legendas),
       idiomaLegenda varchar(20), key(idiomaLegenda),
       thumbnail blob
);

create table `el_arquivo_imagem` (
       arquivoId int4 primary key,
       tamanhoImagemX int not null, key(tamanhoImagemX),
       tamanhoImagemY int not null, key(tamanhoImagemY),
       dpi int not null, key(dpi),
       thumbnail blob
);

#novos campos na tabela el_arquivo
alter table el_arquivo add column autor varchar(32) after titulo;
alter table el_arquivo add column donoCopyright varchar(32) after autor;
alter table el_arquivo add column ciente varchar(1) after palavrasChave;
alter table el_arquivo change column formato formato varchar(32);
alter table el_arquivo change column anoProducao anoProducao int4 null;

#alteração tabela de licenças
create table `el_licenca` (
	licencaId int4 primary key auto_increment,
	tipo varchar(64) not null, key(tipo),
	subTipo varchar(96) null, key(subTipo),
	descricao text null
);

# Exclusão de Domínio Público - atualização de licenças
insert into el_licenca (tipo, subTipo) values("Sampling","Sampling"),("Sampling","Sampling Plus"),("Sampling","Sampling Plus Non-Comercial"),("Atribution","Atribution"),("Atribution","Atribution Non-Comercial"),("Atribution","Atribution Non-Comercial No Derivatives"),("Atribution","Atribution Non-Comercial Share-Alike"),("Atribution","Atribution No Derivatives"),("Atribution","Atribution Share-Alike");

#nano: 12/09 -> mudar o tipo de ciente pra bool
alter table el_arquivo change column ciente ciente bool not null;

#nano: 16/09 -> adicionar campos na tabela el_arquivo
alter table el_arquivo add column hits int4 not null;
alter table el_arquivo add column thumbnail blob;
alter table el_arquivo_video drop column thumbnail;
alter table el_arquivo_imagem drop column thumbnail;
alter table el_arquivo drop column ciente;

#nano: 17/09 -> alguns campos que estavam faltando ou errados
alter table el_arquivo_audio add column album varchar(64) null;
alter table el_arquivo_audio change column letra letra text;
alter table el_arquivo change column descricao descricao text;
alter table el_arquivo_video add column fichaTecnica text;

#mya: 22/11 -> adição de novo campo na tabela el_arquivo para id fisico
alter table el_arquivo add column idFisico varchar(150);

#mya: 22/11 -> edição de campo de nome de arquivo
alter table el_arquivo change arquivo arquivo varchar(150);

#nano: 24/11 -> campos adicinais na el_licenca
alter table el_licenca add column link_imagem varchar(150);
alter table el_licenca add column link_human_readable varchar(150);
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-by.gif', link_human_readable = 'http://creativecommons.org/licenses/by/2.0/br/' where subtipo = 'Atribution';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-by-nc.gif', link_human_readable = 'http://creativecommons.org/licenses/by-nc/2.0/br/' where subtipo = 'Atribution Non-Comercial';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-by-nc-nd.gif', link_human_readable = 'http://creativecommons.org/licenses/by-nc-nd/2.0/br/' where subtipo = 'Atribution Non-Comercial No Derivatives';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-by-nc-sa.gif', link_human_readable = 'http://creativecommons.org/licenses/by-nc-sa/2.0/br/' where subtipo = 'Atribution Non-Comercial Share-Alike';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-by-sa.gif', link_human_readable = 'http://creativecommons.org/licenses/by-sa/2.0/br/' where subtipo = 'Atribution Share-Alike';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-by-nd.gif', link_human_readable = 'http://creativecommons.org/licenses/by-nd/2.0/br/' where subtipo = 'Atribution No Derivatives';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-sampling.gif', link_human_readable = 'http://creativecommons.org/licenses/sampling/1.0/br/' where subtipo = 'Sampling';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-sampling_plus.gif', link_human_readable = 'http://creativecommons.org/licenses/sampling+/1.0/br/' where subtipo = 'Sampling Plus';
update el_licenca set link_imagem = 'http://ccmixter.org/ccimages/lics/small-nc-sampling_plus.gif', link_human_readable = 'http://creativecommons.org/licenses/nc-sampling+/1.0/br/' where subtipo = 'Sampling Plus Non-Comercial';

#lfagundes 21/12/2005
insert into users_permissions values('el_p_view_pendent_files','Ver arquivos pendentes de outro usuario','editors','estudiolivre');

#nano 15/02/2006 - comentarios nao deveria existir...
alter table el_arquivo drop column comentarios;

#nano 16/02/2006 - almentando tamanho do thumbnail, 64k era ridiculo...
alter table el_arquivo change column thumbnail thumbnail mediumblob;

#asa 23/02/2006 - tabela para guardar o rating de cada usuario pra cada arquivo
create table el_arquivo_rating (arquivoId int4 not null, user char(40) not null, rating tinyint(4) not null, primary key (arquivoId, user));

alter table el_arquivo modify rating float;
alter table el_arquivo add key(rating);

# nao rolou
alter table el_arquivo modify rating tinyint not null;

#nano 08/03/2006 - mudar o tipo da datapublicacao pra int, se nao so pega dia...
alter table el_arquivo modify data_publicacao int4 not null;
