{tikimodule title="{tr}Acervo{/tr}" name='el_gallery' flip=$module_params.flip}
	    <div class="modCenterContent">
	    	{tooltip text="Veja os arquivos que você publicou"}<a href="el-user.php?view_user={$user}#gallery">{tr}Meus arquivos{/tr}</a>{/tooltip}<br>
	    	{tooltip text="Publique <b>sua obra</b> no Estúdio Livre!"}<a href="el-gallery_upload.php">{tr}Publicar{/tr}</a>{/tooltip}
	    </div>
	   {if $current_location neq "el-gallery_upload.php" && sizeof($pendingUploadFiles)>0}
  	    <hr>
	 		<span style="text-align:left">{tr}Arquivos não publicados{/tr}:</span><br/>
			{foreach from=$pendingUploadFiles item=pendente}
				<span id="pendente-{$pendente.arquivoId}">
					<span id="pendente-{$pendente.arquivoId}" class="pointer" onClick="xajax_delete_file({$pendente.arquivoId})"><img src="styles/estudiolivre/iDelete.png"></span>
					{tooltip text="Clique para continuar o envio desse arquivo"}
						<span class="pointer" onClick="document.location='el-gallery_upload.php?restore={$pendente.arquivoId}'">
							{$pendente.titulo|default:$pendente.arquivo|default:$pendente.arquivoId}
						</span>
					{/tooltip}
				</span>
				<br/>
			{/foreach}
		 {/if}
{/tikimodule}