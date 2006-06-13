update tiki_objects set type = 'gallery' where type = 'acervo';
update tiki_objects set href = concat('el-gallery_view.php',substring(href, 15)) where href regexp 'el-arquivo\.php';
