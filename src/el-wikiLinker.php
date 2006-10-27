<?php

if ($tiki_p_admin == 'y') {
	$amb = array('sobre', 'projeto', 'vídeo', 'áudio', 'Áudio', 'gráfico', 'tradução', 'tutoriais', 'texto', 'equipamentos', 'teste', 'sistema', 'colabore', 'contato', 'distribuição', 'links', 'se', 'performance', 'computadores', 'to', 'instalação', 'textos', 'rede', 'particular', 'minc', 'about', 'participantes', 'premio', 'homepage', 'bahia', 'recife', 'explorando', 'osasco', 'vassouras', 'bagulho', 'cameras', 'ficção', 'al', 'es', 'configure', 'ma', 'go', 'ac', 'cozinha', 'sp', 'rs', 'pa', 'pr', 'mg', 'rio', 'rn', 'ce', 'pe', 'kitchen', 'pós-produção', 'dev', 'hardware');
	
	$mayb = array('handbrake', 'navalha', 'dev', 'kitchen', 'não-linear', 'rn', 'ce', 'pe', 'relatoshabib', 'mg', 'pós-produção','pr','rio','sc','rs','pa','configure','al','es','ma','go','ac','sp','cozinha');
	
	$result = $tikilib->query('select pageName, data, ip, description from tiki_pages;');
	
	$pages = array();
	while ($row = $result->fetchrow()) {
		$pages[] = $row;
	}
	
	$links = 0;
	
	foreach ($pages as $page) {
		preg_match_all('/[^ ,.:\'\";&\n\/!?\-][^ ,.:\'\";&\n\/!?\-]+/', $page['data'], $matches);
		
		$modif = false;
		$data = $page['data'];
		$replaced = array();
		for ($i = 0; $i < count($matches[0]); $i++) {
			if (!in_array(strtolower($matches[0][$i]), $amb) &&
				strtolower($matches[0][$i]) != strtolower($page['pageName']) &&
				!in_array($matches[0][$i], $replaced)) {
				if ($tikilib->page_exists($matches[0][$i])) {
					$links++;
					print($matches[0][$i].'<br>');
					$replaced[] = $matches[0][$i];
					$modif = true;
					$data = preg_replace("/([^(])" . $matches[0][$i] ."/", "$1((" . $matches[0][$i] ."))", $data);
				}
			}
		}
		if($modif) {
			print($page['pageName'] . '<br><br>' . $page['data'] . '<br><br>' . $data); exit;
			$tikilib->update_page($page['pageName'], 
							      $page[$data],
							      $page['linkando conteúdo wiki'],
							      $page['robôDeLinks'],
							      $page['ip'],
							      $page['description']);
		}
	}
}

print("<br><center><h1>Pronto para fazer $links links</h1></center><br>");

exit;
?>