{if $arquivo.duracao || (!$arquivo.duracao && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Duração:</div> {ajax_input permission=$permission value=$arquivo.duracao id="duracao" default="" display="inline"} s</div>
{/if}

{if $arquivo.tamanhoImagemX || (!$arquivo.tamanhoImagemX && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Largura:</div> {ajax_input permission=$permission id="tamanhoImagemX" value=$arquivo.tamanhoImagemX default="" display="inline"} px</div>
{/if}

{if $arquivo.tamanhoImagemY || (!$arquivo.tamanhoImagemY && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Altura:</div> {ajax_input permission=$permission id="tamanhoImagemY" value=$arquivo.tamanhoImagemY default="" display="inline"} px</div>
{/if}

{if $arquivo.temAudio || (!$arquivo.temAudio && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission id="temAudio" value=$arquivo.temAudio}</div> Tem audio</div>
{/if}

{if $arquivo.temCor || (!$arquivo.temCor && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission id="temCor" value=$arquivo.temCor}</div> Tem cor</div>
{/if}

{if $arquivo.idioma || (!$arquivo.idioma && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Idioma do Vídeo:</div> {ajax_input permission=$permission value=$arquivo.idioma id="idioma" default="" display="inline"}</div>
{/if}

{if $arquivo.legendas || (!$arquivo.legendas && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName" onClick="flip('aLegenda')">{ajax_checkbox permission=$permission id="legendas" value=$arquivo.legendas}</div> Tem legenda</div>
{/if}

{if $arquivo.idiomaLegenda || (!$arquivo.idiomaLegenda && $permission) }
<div id="aLegenda" class="gUpMoreOptionsItem" style="display:{if $arquivo.legendas}block{else}none{/if};"><div class="gUpMoreOptionsName">Idioma da Legenda:</div> {ajax_input permission=$permission value=$arquivo.idiomaLegenda id="idiomaLegenda" default="" display="inline"}</div>
<br/>
{/if}

{if $arquivo.fichaTecnica || (!$arquivo.fichaTecnica && $permission) }
<div class="gUpMoreOptionsItem">Ficha Técnica:</div>
{ajax_textarea permission=$permission value=$arquivo.fichaTecnica id="fichaTecnica" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" wikiParsed=1}
{/if}