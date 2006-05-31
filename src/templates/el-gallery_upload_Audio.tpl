<div class="gUpMoreOptionsName">Duração:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.duracao id="duracao" default="??" display="inline"} s<br/>
<div class="gUpMoreOptionsName">Tipo do audio:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.tipoDoAudio id="tipoDoAudio" default="" display="inline"}<br/>
<div class="gUpMoreOptionsName">bpm:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.bpm id="bpm" default="??" display="inline"}<br/>
<div class="gUpMoreOptionsName">Sample Rate:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.sampleRate id="sampleRate" default="??" display="inline"} hz<br/>
<div class="gUpMoreOptionsName">Bit Rate:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.bitRate id="bitRate" default="??" display="inline"} bits<br/>
<div class="gUpMoreOptionsName">Gênero:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.genero id="genero" default="" display="inline"}<br/>
<div class="gUpMoreOptionsName">Álbum:</div> {ajax_input permission=$permission class="gUpMoreOptionsInput" value=$arquivo.album id="album" default="" display="inline"}<br/>

<span style="vertical-align:top">Letra:</span>
{ajax_textarea permission=$permission value=$arquivo.letra id="letra" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" class="gUpEdit"}<br/>
<span style="vertical-align:top">Ficha Técnica:</span>
{ajax_textarea permission=$permission value=$arquivo.fichaTecnica id="fichaTecnica" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" class="gUpEdit"}<br/>