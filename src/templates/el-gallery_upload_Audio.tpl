Duração: {ajax_input permission=$permission class="" value=$arquivo.duracao id="duracao" default="??"} s<br/>
Tipo do audio: {ajax_input permission=$permission class="" value=$arquivo.tipoDoAudio id="tipoDoAudio" default=""}<br/>
bpm: {ajax_input permission=$permission class="" value=$arquivo.bpm id="bpm" default="??"}<br/>
Sample Rate: {ajax_input permission=$permission class="" value=$arquivo.sampleRate id="sampleRate" default="??"} hz<br/>
Bit Rate: {ajax_input permission=$permission class="" value=$arquivo.bitRate id="bitRate" default="??"} bits<br/>
Gênero: {ajax_input permission=$permission class="" value=$arquivo.genero id="genero" default=""}<br/>
Álbum: {ajax_input permission=$permission class="" value=$arquivo.album id="album" default=""}<br/>

<span style="vertical-align:top">Letra:</span>
{ajax_textarea permission=$permission class="" value=$arquivo.letra id="letra" default=""}<br/>
<span style="vertical-align:top">Ficha Técnica:</span>
{ajax_textarea permission=$permission class="" value=$arquivo.fichaTecnica id="fichaTecnica" default=""}<br/>
