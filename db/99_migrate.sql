insert into publication (id,licenseId,user,publishDate,author,title,description,thumbnail,copyrightOwner,producer,contact,site,rating) select arquivoId,licencaId,user,data_publicacao,autor,titulo,descricao,thumbnail,donoCopyright,produtora,contato,siteRelacionado,rating from el_arquivo;
insert into filereference (publicationId,fileName,thumbnail,mimeType,size,downloads,streams) select arquivoId,arquivo,thumbnail,formato,tamanho,hits,streamHits from el_arquivo; 
insert into audiopublication select arquivoId,tipoDoAudio,genero,letra,fichaTecnica from el_arquivo_audio; 
insert into videopublication select arquivoId,idioma,legendas,idiomaLegenda,fichaTecnica from el_arquivo_video; 
insert into imagepublication (id) select arquivoId from el_arquivo_imagem; 
