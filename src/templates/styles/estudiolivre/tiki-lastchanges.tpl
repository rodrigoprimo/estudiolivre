<div id="listLastChanges">
	<h1>
		{if $findwhat != ""}
				Busca nas últimas alterações
		{else} 
			{tr}Last Changes{/tr}
		{/if}
	</h1>
	
	<h5>
		Busca <img class="pointer" onclick="javascript:flip('lastChangesOptions');this.toggleImage('iArrowGreyDown.png')" src="styles/estudiolivre/iArrowGreyLeft.png">
		<div id="lastChangesOptions" style="display:none">
			<form method="get" action="tiki-lastchanges.php">
				Modificações com texto: <br/>
				{tooltip text="Dica: não escreva nada se quiser listar <b>todas</b> as modificções"}<input name="find" value="" type="text" class="input">{/tooltip}<br>
			    <b>Ou</b> nos últimos: {tooltip text="Dica: coloque <b>0</b> para buscar em todos os dias"}<input name="days" value="0" size="2" type="text" class="input">{/tooltip} dias<br>
			    <input value="buscar" name="search" type="submit">
			    <input name="sort_mode" value="lastModif_desc" type="hidden">
		    </form>
		</div>
	</h5>
	
	{if $findwhat!=""}
		<h5>
			{$cant_records} resultados{if $cant_users > 1}s{/if} para "<b>{$findwhat}</b>"<br>
			<a href="tiki-lastchanges.php?days=0">Veja todas as alterações</a>
		</h5>
	{elseif $days > 0}
		<h4>
			<b>Atenção:</b> listando somente as modificações feitas no{if $days > 1}s{/if} último{if $days > 1}s{/if} <b>{$days}</b> dia{if $days > 1}s{/if}.<br>
			<a href="tiki-lastchanges.php?days=0">Veja as alterações feitas em qualquer dia</a>
		</h4>
	{/if}		
		
	<div>
		<table class="normal">
			<tr>
				<td class="heading">
					<a class="tableheading" href="tiki-lastchanges.php?days={$days}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'lastModif_desc'}lastModif_asc{else}lastModif_desc{/if}">
						<img src="styles/estudiolivre/sort{if $sort_mode eq 'lastModif_desc'}ArrowUp{elseif $sort_mode eq 'lastModif_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
					</a>{tr}Date{/tr}
				</td>
				<td class="heading">
					<a class="tableheading" href="tiki-lastchanges.php?days={$days}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'pageName_desc'}pageName_asc{else}pageName_desc{/if}">
						<img src="styles/estudiolivre/sort{if $sort_mode eq 'pageName_desc'}ArrowUp{elseif $sort_mode eq 'pageName_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
					</a>{tr}Page{/tr}
				</td>
				{*
				<td class="heading">
					<a class="tableheading" href="tiki-lastchanges.php?days={$days}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'action_desc'} action_asc{else}action_desc{/if}">
						<img src="styles/estudiolivre/sort{if $sort_mode eq 'action_desc'}ArrowUp{elseif $sort_mode eq 'action_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
					</a>{tr}Action{/tr}
				</td>
				*}
				<td class="heading">
					<a class="tableheading" href="tiki-lastchanges.php?days={$days}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'user_desc'}user_asc{else}user_desc{/if}">
						<img src="styles/estudiolivre/sort{if $sort_mode eq 'user_desc'}ArrowUp{elseif $sort_mode eq 'user_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
					</a>{tr}User{/tr}
				</td>
				{*
				<td class="heading">
					<a class="tableheading" href="tiki-lastchanges.php?days={$days}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'ip_desc'}ip_asc{else}ip_desc{/if}">
						<img src="styles/estudiolivre/sort{if $sort_mode eq 'ip_desc'}ArrowUp{elseif $sort_mode eq 'ip_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
					</a>{tr}Ip{/tr}
				</td>
				*}
				<td class="heading">
					<a class="tableheading" href="tiki-lastchanges.php?days={$days}&amp;offset={$offset}&amp;sort_mode={if $sort_mode eq 'comment_desc'}comment_asc{else}comment_desc{/if}">
						<img src="styles/estudiolivre/sort{if $sort_mode eq 'comment_desc'}ArrowUp{elseif $sort_mode eq 'comment_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
					</a>{tr}Comment{/tr}
				</td>
			</tr>
			
			{cycle values="odd,even" print=false}
			{section name=changes loop=$lastchanges}
				<tr class="{cycle}">
					<td>
						{$lastchanges[changes].lastModif|date_format:"%H:%M:%S de %d/%m"}
					</td>
					
					<td>
						{tooltip text="Ação realizada nessa modificação: "|cat:{tr}$lastchanges[changes].action{/tr}}
							<a href="tiki-index.php?page={$lastchanges[changes].pageName|escape:"url"}" class="tablename">
								{$lastchanges[changes].pageName|truncate:18:"(...)":true}
							</a> <br>
						{/tooltip}
					{if $lastchanges[changes].version}
					(<a class="link" href="tiki-pagehistory.php?page={$lastchanges[changes].pageName|escape:"url"}">{tr}hist{/tr}</a> {tr}v{/tr}{$lastchanges[changes].version}</span>)
					&nbsp;<a class="link" href="tiki-pagehistory.php?page={$lastchanges[changes].pageName|escape:"url"}&amp;preview={$lastchanges[changes].version}"
					 title="{tr}view{/tr}">v</a>&nbsp;

					{if $tiki_p_rollback eq 'y'}
						<a class="link" href="tiki-rollback.php?page={$lastchanges[changes].pageName|escape:"url"}&amp;version={$lastchanges[changes].version}" title="{tr}rollback{/tr}">
						b</a>&nbsp;
					{/if}
					<a class="link" href="tiki-pagehistory.php?page={$lastchanges[changes].pageName|escape:"url"}&amp;diff={$lastchanges[changes].version}" title="{tr}compare{/tr}">
					c</a>&nbsp;
					<a class="link" href="tiki-pagehistory.php?page={$lastchanges[changes].pageName|escape:"url"}&amp;diff2={$lastchanges[changes].version}" title="{tr}diff{/tr}">
					d</a>&nbsp;
					<a class="link" href="tiki-pagehistory.php?page={$lastchanges[changes].pageName|escape:"url"}&amp;source={$lastchanges[changes].version}" title="{tr}source{/tr}">
					s</a>
	
					{elseif $lastchanges[changes].versionlast}
						(<a class="link" href="tiki-pagehistory.php?page={$lastchanges[changes].pageName|escape:"url"}">{tr}hist{/tr}</a>)
					{/if}
					
					</td>
					<td>
						{$lastchanges[changes].user}
					</td>
					{*<td>
						{$lastchanges[changes].ip}
					</td>*}
					<td>
						{$lastchanges[changes].comment}
					</td>
				</tr>
			{sectionelse}
				<tr><td class="even" colspan="6">
				<b>{tr}No records found{/tr}</b>
				</td>
				</tr>
			{/section}
		</table>
		
		<div class="paginacao">
			{if $prev_offset >= 0}
				<a class="prevnext" href="tiki-lastchanges.php?find={$find}&amp;days={$days}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">
					<img src="styles/estudiolivre/iArrowGreyLeft.png">
				</a>
			{/if}
			
			{tr}Page{/tr} {$actual_page} de {$cant_pages}
			
			{if $next_offset >= 0}
				<a class="prevnext" href="tiki-lastchanges.php?find={$find}&amp;days={$days}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">
					<img src="styles/estudiolivre/iArrowGreyRight.png">
				</a>
			{/if}
			{if $direct_pagination eq 'y'}
				<br />
				{section loop=$cant_pages name=foo}
					{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
						<a class="prevnext" href="tiki-lastchanges.php?find={$find}&amp;days={$days}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
					{$smarty.section.foo.index_next}</a>
				{/section}
			{/if}
		</div>
	
	</div>

</div>