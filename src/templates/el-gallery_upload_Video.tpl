<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Duração:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.duracao id="duracao" default="??" display="inline"} s</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Largura:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" id="tamanhoImagemX" value=$arquivo.tamanhoImagemX default="??" display="inline"} px</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Altura:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" id="tamanhoImagemY" value=$arquivo.tamanhoImagemY default="??" display="inline"} px</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission class="" id="temAudio" value=$arquivo.temAudio}</div> Tem audio</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission class="" id="temCor" value=$arquivo.temCor}</div> Tem cor</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Idioma do Vídeo:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.idioma id="idioma" default="" display="inline"}</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission class="" id="legendas" value=$arquivo.legendas}</div> Tem legenda</div>
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">Idioma da Legenda:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.idiomaLegenda id="idiomaLegenda" default="" display="inline"}</div>
<br/>
<div class="gUpMoreOptionsItem">Ficha Técnica:</div>
{ajax_textarea permission=$permission value=$arquivo.fichaTecnica id="fichaTecnica" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" class="gUpEdit"}
