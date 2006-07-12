{if $arquivo.duracao || (!$arquivo.duracao && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Duração{/tr}:</div> {ajax_input permission=$permission value=$arquivo.duracao id="duracao" default="" display="inline"} {tr}segundos{/tr}</div>
{/if}

{if $arquivo.tipoDoAudio || (!$arquivo.tipoDoAudio && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tipo do audio{/tr}:</div> {ajax_input permission=$permission value=$arquivo.tipoDoAudio id="tipoDoAudio" default="" display="inline"}</div>
{/if}

{if $arquivo.bpm || (!$arquivo.bpm && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}bpm{/tr}:</div> {ajax_input permission=$permission value=$arquivo.bpm id="bpm" default="" display="inline"}</div>
{/if}

{if $arquivo.sampleRate || (!$arquivo.sampleRate && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Sample Rate{/tr}:</div> {ajax_input permission=$permission value=$arquivo.sampleRate id="sampleRate" default="" display="inline"} {tr}hertz{/tr}</div>
{/if}

{if $arquivo.bitRate || (!$arquivo.bitRate && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Bit Rate{/tr}:</div> {ajax_input permission=$permission value=$arquivo.bitRate id="bitRate" default="" display="inline"} {tr}bits{/tr}</div>
{/if}

{if $arquivo.genero || (!$arquivo.genero && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Gênero{/tr}:</div> {ajax_input permission=$permission value=$arquivo.genero id="genero" default="" display="inline"}</div>
{/if}

{if $arquivo.album || (!$arquivo.album && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Álbum{/tr}:</div> {ajax_input permission=$permission value=$arquivo.album id="album" default="" display="inline"}</div>
{/if}

{if $arquivo.letra || (!$arquivo.letra && $permission) }
<div class="gUpMoreOptionsItemSingle"><div class="gUpMoreOptionsName">{tr}Letra{/tr}:</div></div>
{ajax_textarea permission=$permission value=$arquivo.letra id="letra" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" wikiParsed=1}<br/>
{/if}

{if $arquivo.fichaTecnica || (!$arquivo.fichaTecnica && $permission) }
<div class="gUpMoreOptionsItemSingle"><div class="gUpMoreOptionsName">{tr}Ficha Técnica{/tr}:</div></div>
{ajax_textarea permission=$permission value=$arquivo.fichaTecnica id="fichaTecnica" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" wikiParsed=1}<br/>
{/if}