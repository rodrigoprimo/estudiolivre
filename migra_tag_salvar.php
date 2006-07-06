<?

require_once("tiki-setup.php");

if (basename(__FILE__) !== '/noe/data/vhost/teste.estudiolivre.org/htdocs/migra_tag_salvar.php') {
    echo "tentando rodar no lugar errado";
    exit;
}

$tagId = 35; // id da tag salvar

$query = "select tko.itemId, tko.type from tiki_freetagged_objects tfo, tiki_objects tko where tko.objectId=tfo.objectId and tfo.tagId=?";

?>
