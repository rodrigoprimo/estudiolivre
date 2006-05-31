CREATE TABLE `el_tipos_arquivo` (
	`tipoId` int(11) NOT NULL auto_increment,
	`nome` varchar(64) default NULL,
	`descricao` text,
	PRIMARY KEY  (`tipoId`)) ENGINE=MyISAM;

INSERT INTO `el_tipos_arquivo` VALUES (1,'Video',NULL),(2,'Audio',NULL),(3,'Imagem',NULL),(4,'Texto',NULL);

create table `el_arquivo` (
       arquivoId int4 primary key auto_increment,
       idFisico varchar(150), key(idFisico),
       tipo varchar(10) not null, key(tipo),
       user varchar(40) not null, key(user),
       licencaId int4 not null, key(licencaId),
       publicado bool not null default 0, key(publicado),
       data_publicacao int4 not null, key(data_publicacao),
       titulo varchar(255) not null, key(titulo),
       autor varchar(32) not null, key(autor),
       donoCopyright varchar(32) not null, key(donoCopyright),
       arquivo varchar(150) not null, key(arquivo),
       formato varchar(32) not null, key(formato), 
       tamanho int(40), key(tamanho),
       descricao text, fulltext key(descricao),
       produtora varchar(100), key(produtora),
       contato varchar(100), key(contato),
       iSampled varchar(255), key(iSampled),
       sampledMe varchar(255), key(sampledMe),
       siteRelacionado varchar(255), key(siteRelacionado),
       rating tinyint not null, key(rating),
       hits int4 not null,
       streamHits int4 not null,
       thumbnail varchar(255) not null,
       editCache blob not null
);

create table `el_arquivo_audio` ( 
        arquivoId int4 primary key, 
        duracao int not null, key(duracao),
        tipoDoAudio varchar(8) not null, key(tipoDoAudio), 
        bpm int not null, key(bpm), 
        sampleRate int not null, key(sampleRate),
        bitRate int not null, key(bitRate),
        genero varchar(50), key(genero), 
        letra text, fulltext key(letra),
        fichaTecnica text, fulltext key(fichaTecnica),
        album varchar(64) null
);

create table `el_arquivo_video` (
       arquivoId int4 primary key,
       duracao int not null, key(duracao),
       tamanhoImagemX int not null, key(tamanhoImagemX),
       tamanhoImagemY int not null, key(tamanhoImagemY),
       temAudio bool not null default 1, key(temAudio),
       temCor bool not null default 1, key(temCor),
       idioma varchar(20), key(idioma),
       legendas bool not null default 0, key(legendas),
       idiomaLegenda varchar(20), key(idiomaLegenda),
       fichaTecnica text, fulltext key(fichaTecnica)
);

create table `el_arquivo_imagem` (
       arquivoId int4 primary key,
       tamanhoImagemX int not null, key(tamanhoImagemX),
       tamanhoImagemY int not null, key(tamanhoImagemY),
       dpi int not null, key(dpi)
);

create table `el_licenca` (
	licencaId int4 primary key auto_increment,
	tipo varchar(64) not null, key(tipo),
	subTipo varchar(96) null, key(subTipo),
	descricao text null,
	linkImagem varchar(150),
	linkHumanReadable varchar(150)
);

# Exclusão de Domínio Público - atualização de licenças
insert into el_licenca (tipo, subTipo) values("Sampling","Sampling"),("Sampling","Sampling Plus"),("Sampling","Sampling Plus Non-Comercial"),("Atribution","Atribution"),("Atribution","Atribution Non-Comercial"),("Atribution","Atribution Non-Comercial No Derivatives"),("Atribution","Atribution Non-Comercial Share-Alike"),("Atribution","Atribution No Derivatives"),("Atribution","Atribution Share-Alike");

#nano: 24/11 -> campos adicinais na el_licenca
update el_licenca set linkImagem = 'iLicBy.png', linkHumanReadable = 'http://creativecommons.org/licenses/by/2.5/br/' where subtipo = 'Atribution';
update el_licenca set linkImagem = 'iLicByNc.png', linkHumanReadable = 'http://creativecommons.org/licenses/by-nc/2.5/br/' where subtipo = 'Atribution Non-Comercial';
update el_licenca set linkImagem = 'iLicByNcNd.png', linkHumanReadable = 'http://creativecommons.org/licenses/by-nc-nd/2.5/br/' where subtipo = 'Atribution Non-Comercial No Derivatives';
update el_licenca set linkImagem = 'iLicByNcSa.png', linkHumanReadable = 'http://creativecommons.org/licenses/by-nc-sa/2.5/br/' where subtipo = 'Atribution Non-Comercial Share-Alike';
update el_licenca set linkImagem = 'iLicBySa.png', linkHumanReadable = 'http://creativecommons.org/licenses/by-sa/2.5/br/' where subtipo = 'Atribution Share-Alike';
update el_licenca set linkImagem = 'iLicByNd.png', linkHumanReadable = 'http://creativecommons.org/licenses/by-nd/2.5/br/' where subtipo = 'Atribution No Derivatives';
update el_licenca set linkImagem = 'iLicSampling.png', linkHumanReadable = 'http://creativecommons.org/licenses/sampling/1.0/br/' where subtipo = 'Sampling';
update el_licenca set linkImagem = 'iLicSamplingPlus.png', linkHumanReadable = 'http://creativecommons.org/licenses/sampling+/1.0/br/' where subtipo = 'Sampling Plus';
update el_licenca set linkImagem = 'iLicSamplingPlusNc.png', linkHumanReadable = 'http://creativecommons.org/licenses/nc-sampling+/1.0/br/' where subtipo = 'Sampling Plus Non-Comercial';

#asa 23/02/2006 - tabela para guardar o rating de cada usuario pra cada arquivo
create table `el_arquivo_rating` (
	arquivoId int4 not null,
	user char(40) not null,
	rating tinyint(4) not null,
	primary key (arquivoId, user));

#nano 23/05/2006 - descricao das licencas
update el_licenca set descricao = 'Permite fazer uso comercial, copiar, distribuir, exibir, executar e criar obras derivadas, desde que seja dado crédito ao autor original.' where subtipo = 'Atribution';
update el_licenca set descricao = 'Não permite uso comercial. Você pode copiar, distribuir, exibir, executar e criar obras derivadas, desde que seja dado crédito ao autor original.' where subtipo = 'Atribution Non-Comercial';
update el_licenca set descricao = 'Não permite uso comercial, copiar, distribuir, exibir e executar a obra, desde que seja dado crédito ao autor original e que não seja criada outra obra com base nesta.' where subtipo = 'Atribution Non-Comercial No Derivatives';
update el_licenca set descricao = 'Não permite uso comercial, copiar, distribuir, exibir, executar e criar obras derivadas, desde que seja dado crédito ao autor original e compartilhe da mesma licença.' where subtipo = 'Atribution Non-Comercial Share-Alike';
update el_licenca set descricao = 'Permite uso comercial, copiar, distribuir, exibir, executar e criar obras derivadas, desde que seja dado crédito ao autor original e compartilhe da mesma licença.' where subtipo = 'Atribution Share-Alike';
update el_licenca set descricao = 'Permite uso comercial, copiar, distribuir, exibir e executar a obra, desde que seja dado crédito ao autor original e que não seja criada outra obra com base nesta.' where subtipo = 'Atribution No Derivatives';
update el_licenca set descricao = '' where subtipo = 'Sampling';
update el_licenca set descricao = '' where subtipo = 'Sampling Plus';
update el_licenca set descricao = '' where subtipo = 'Sampling Plus Non-Comercial';
