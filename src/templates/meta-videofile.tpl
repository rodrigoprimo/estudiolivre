{if $file->duration || (!$file->duration && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Duração{/tr}:</div> {ajax_input permission=$permission value=$file->duration id="duration" default="" display="inline"} s</div>
{/if}

{if $file->width || (!$file->width && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Largura{/tr}:</div> {ajax_input permission=$permission id="width" value=$file->width default="" display="inline"} {tr}px{/tr}</div>
{/if}

{if $file->height || (!$file->height && $permission) }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Altura{/tr}:</div> {ajax_input permission=$permission id="height" value=$file->height default="" display="inline"} {tr}px{/tr}</div>
{/if}

{if $permission }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission id="hasAudio" value=$file->hasAudio}</div> {tr}Tem audio{/tr}</div>
{elseif $file->hasAudio }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tem audio{/tr}</div></div>
{/if}

{if $permission }
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{ajax_checkbox permission=$permission id="hasColor" value=$file->hasColor}</div> {tr}Tem cor{/tr}</div>
{elseif $file->hasColor}
<div class="gUpMoreOptionsItem"><div class="gUpMoreOptionsName">{tr}Tem cor{/tr}</div></div>
{/if}
