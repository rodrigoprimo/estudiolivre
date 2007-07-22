{if $file->typeOfAudio || (!$file->typeOfAudio && $permission) }
	<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tipo do audio{/tr}:</div> {ajax_input permission=$permission value=$file->typeOfAudio id="typeOfAudio" default="" display="inline"}</div>
{/if}

{if $file->genre || (!$file->genre && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Gênero{/tr}:</div> {ajax_input permission=$permission value=$file->genre id="genre" default="" display="inline"}</div>
{/if}

{if $file->album || (!$file->album && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Álbum{/tr}:</div> {ajax_input permission=$permission value=$file->album id="album" default="" display="inline"}</div>
{/if}

{if $file->lyrics || (!$file->lyrics && $permission) }
<div class="gUpMoreOptionsItemSingle"><div class="gUpMoreOptionsName">{tr}lyrics{/tr}:</div></div>
{ajax_textarea permission=$permission value=$file->lyrics id="lyrics" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" wikiParsed=1}<br/>
{/if}

{if $file->details || (!$file->details && $permission) }
<div class="gUpMoreOptionsItemSingle"><div class="gUpMoreOptionsName">{tr}Ficha Técnica{/tr}:</div></div>
{ajax_textarea permission=$permission value=$file->details id="details" default="" display="block" style="width: 235px; height:125px; border: 1px inset rgb(233, 233, 174);padding: 3px;font-size: 12px; font-family: Arial, Verdana, Helvetica, Lucida, Sans-Serif;background-color: #f1f1f1;margin-bottom: 5px;" wikiParsed=1}<br/>
{/if}









{if $file->duracao || (!$file->duration && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Duração{/tr}:</div> {ajax_input permission=$permission value=$file->duration id="duration" default="" display="inline"} s</div>
{/if}

{if $file->bpm || (!$file->bpm && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}bpm{/tr}:</div> {ajax_input permission=$permission value=$file->bpm id="bpm" default="" display="inline"}</div>
{/if}

{if $file->sampleRate || (!$file->sampleRate && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Sample Rate{/tr}:</div> {ajax_input permission=$permission value=$file->sampleRate id="sampleRate" default="" display="inline"} hz</div>
{/if}

{if $file->bitRate || (!$file->bitRate && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Bit Rate{/tr}:</div> {ajax_input permission=$permission value=$file->bitRate id="bitRate" default="" display="inline"} {tr}bits{/tr}</div>
{/if}

