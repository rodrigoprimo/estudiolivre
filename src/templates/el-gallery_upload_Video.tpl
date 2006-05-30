<div class="gUpMoreOptionsName">Duração:</div> {ajax_input permission=$permission class="" value=$arquivo.duracao id="duracao" default="??"} s<br/>
<div class="gUpMoreOptionsName">Largura:</div> {ajax_input permission=$permission class="" id="tamanhoImagemX" value=$arquivo.tamanhoImagemX default="??"} px<br/>
<div class="gUpMoreOptionsName">Altura:</div> {ajax_input permission=$permission class="" id="tamanhoImagemY" value=$arquivo.tamanhoImagemY default="??"} px<br/>
{ajax_checkbox permission=$permission class="" id="temAudio" value=$arquivo.temAudio} Tem audio <br/>
{ajax_checkbox permission=$permission class="" id="temCor" value=$arquivo.temCor} Tem cor <br/>
<div class="gUpMoreOptionsName">Idioma do Vídeo:</div> {ajax_input permission=$permission class="" value=$arquivo.idioma id="idioma" default=""} <br/>
{ajax_checkbox permission=$permission class="" id="legendas" value=$arquivo.legendas} Tem legenda <br/>
<div class="gUpMoreOptionsName">Idioma da Legenda:</div> {ajax_input permission=$permission class="" value=$arquivo.idiomaLegenda id="idiomaLegenda" default=""}/> <br/>
<span style="vertical-align:top">Ficha Técnica:</span>
{ajax_textarea permission=$permission class="" value=$arquivo.fichaTecnica id="fichaTecnica" default=""}
