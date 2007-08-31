<applet code="com.fluendo.player.Cortado.class" 
        archive="lib/elgal/player/cortado-ovt.jar" 
		width="{$file->width}" height="{$file->height}">
	<param name="url" value="{$file->fullPath()}"/>
	<param name="video" value="true"/>
	<param name="local" value="false"/>
	<param name="keepAspect" value="true"/>
	<param name="audio" value="true"/>
	<param name="bufferSize" value="100"/>
</applet>

<br/><br/>

{if $file->duration || (!$file->duration && $permission) }
	<span class="fInfo">{tr}Duração{/tr}:</span> {ajax_input permission=$permission value=$file->duration id="duration" default="" display="inline" file=$viewFile} s
{/if}

{if $file->width || (!$file->width && $permission) }
	<span class="fInfo">{tr}Largura{/tr}:</span> {ajax_input permission=$permission id="width" value=$file->width default="" display="inline" file=$viewFile} {tr}px{/tr}
{/if}

{if $file->height || (!$file->height && $permission) }
	<span class="fInfo">{tr}Altura{/tr}:</span> {ajax_input permission=$permission id="height" value=$file->height default="" display="inline" file=$viewFile} {tr}px{/tr}
{/if}

<br/>

{if $permission }
	{ajax_checkbox permission=$permission id="hasAudio" value=$file->hasAudio file=$viewFile} <span class="fInfo">{tr}Tem audio{/tr}</span>
{elseif $file->hasAudio }
	<span class="fInfo">{tr}Tem audio{/tr}</span>
{/if}

{if $permission }
	{ajax_checkbox permission=$permission id="hasColor" value=$file->hasColor file=$viewFile} <span class="fInfo">{tr}Tem cor{/tr}</span>
{elseif $file->hasColor}
	<span class="fInfo">{tr}Tem cor{/tr}</span>
{/if}
