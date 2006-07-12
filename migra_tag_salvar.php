<?

if (false && __FILE__ !== '/noe/data/vhost/estudiolivre.org/htdocs/migra_tag_salvar.php') {
    echo "tentando rodar no lugar errado: " . __FILE__ . "\n";
    exit;
}

require_once("tiki-setup.php");
require_once("lib/freetag/freetaglib.php");

system("mkdir repo");

$tagId = 35; // id da tag salvar

$query = "select tko.itemId, tko.type, tko.objectId from estudiolivre_teste.tiki_freetagged_objects tfo, estudiolivre_teste.tiki_objects tko where tko.objectId=tfo.objectId and tfo.tagId=? order by tko.type";

$result = $tikilib->query($query, array($tagId));

while ($row = $result->fetchRow()) {
    $itemId = $row['itemId'];
    $type = $row['type'];
    $objId = $row['objectId'];

    if ($type == 'gallery') {
	migra_acervo($itemId, $objId);
    } elseif ($type == 'wiki page') {
	migra_wiki($itemId, $objId);
    }
}

function migra_wiki($pageName, $objId_from) {

    global $tikilib, $freetaglib;

    $query = "select * from estudiolivre_teste.tiki_pages where pageName=?";
    $result = $tikilib->query($query, array($pageName));
    $page = $result->fetchRow();

    if ($tikilib->page_exists($pageName)) {
	$tikilib->update_page($pageName, 
			      $page['data'],
			      $page['comment'],
			      $page['user'],
			      $page['ip'],
			      $page['description']);
    } else {
	$tikilib->create_page($pageName,
			      $page['hits'],
			      $page['data'],
			      $page['lastModif'],
			      $page['comment'],
			      $page['user'],
			      $page['ip'],
			      $page['description']);
    }

    $cat_type='wiki page';
    $cat_desc = substr($page["description"],0,200);
    $cat_name = $pageName;
    $cat_href="tiki-index.php?page=".urlencode($pageName);

    $freetaglib->add_object($cat_type, $pageName, $cat_desc, $cat_name, $cat_href);

    $query = "select tf.tag as tag from estudiolivre_teste.tiki_freetagged_objects tfo, estudiolivre_teste.tiki_freetags tf where tfo.tagId=tf.tagId and tfo.objectId=?";
    $result = $tikilib->query($query, array($objId_from));
    while ($row = $result->fetchRow()) {
	if ($row['tag'] != 'salvar') {
	    $freetaglib->safe_tag($page['user'], $pageName, $cat_type, $row['tag']);
	}
    }
}

function migra_acervo($arquivoId, $objId_from) {
    global $tikilib, $freetaglib;

    $bindvals = array($arquivoId);

    $query = "select * from estudiolivre_teste.el_arquivo where arquivoId=?";
    $result = $tikilib->query($query, $bindvals);
    $arquivo = $result->fetchRow();

    $tipo = strtolower($arquivo['tipo']);

    $query = "insert into el_arquivo select * from estudiolivre_teste.el_arquivo where arquivoId=?";
    $tikilib->query($query, $bindvals);

    if ($tipo != 'texto') {
	$query = "insert into el_arquivo_$tipo select * from estudiolivre_teste.el_arquivo_$tipo where arquivoId=?";
	$tikilib->query($query, $bindvals);
    }
    
    $query = "insert into el_arquivo_rating select * from estudiolivre_teste.el_arquivo_rating where arquivoId=?";
    $tikilib->query($query, $bindvals);

    $href = "el-gallery_view.php?arquivoId=$arquivoId";
    $freetaglib->add_object('gallery', $arquivoId, $arquivo['descricao'], $arquivo['titulo'], $href);

    $query = "select tf.tag as tag from estudiolivre_teste.tiki_freetagged_objects tfo, estudiolivre_teste.tiki_freetags tf where tfo.tagId=tf.tagId and tfo.objectId=?";
    $result = $tikilib->query($query, array($objId_from));
    while ($row = $result->fetchRow()) {
	if ($row['tag'] != 'salvar') {
	    $freetaglib->safe_tag($arquivo['user'], $arquivoId, 'gallery', $row['tag']);
	}
    }

    $arq = preg_replace("/ /","\ ",$arquivo['arquivo']);
    $thumbnail = preg_replace("/ /","\ ",$arquivo['thumbnail']);
 
    if (!empty($arq))
	system("mv /noe/data/vhost/teste.estudiolivre.org/htdocs/repo/$arq /noe/data/vhost/estudiolivre.org/htdocs/repo");
    if (!empty($thumbnail))
	system("mv /noe/data/vhost/teste.estudiolivre.org/htdocs/repo/$thumbnail /noe/data/vhost/estudiolivre.org/htdocs/repo");
    
}

?>
