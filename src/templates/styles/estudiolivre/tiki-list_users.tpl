{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/estudiolivre/tiki-list_users.tpl,v 1.3 2006-06-19 04:04:27 rhwinter Exp $ *}
<div id="users">
<h1>
	{if !$find}
		{tr}User List{/tr}
	{else}
		Busca de usuários	
	{/if}
</h1>
{*================
	{if $feature_help eq 'y'}
		<a href="{$helpurl}UserList" target="tikihelp" class="tikihelp" title="{tr}User List{/tr}">
			<img src="img/icons/help.gif" border="0" height="16" width="16" alt='{tr}help{/tr}' />
		</a>
	{/if}
==================*}
<h5>
	{$cant_users}
		{if !$find}
			{tr}users registered{/tr}
		{else}
			resultado{if $cant_users > 1}s{/if} para "{$find}"<br>
			Veja <a href="tiki-list_users.php">a lista de todos os usuários</a>.
		{/if}
</h5>

{*===============
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
   <td class="findtable">
   <form method="get" action="tiki-list_users.php">
     <input type="text" name="find" value="{$find|escape}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
   </form>
   </td>
</tr>
</table>
==================*}
{*debug*}
<table width="100%">
	<tr>
		<td class="heading">
			{tooltip text="Clique para que a listagem seja por <b>ordem alfabética</b> de nome de usuário"}
			<a href="tiki-list_users.php?{if $find}find={$find}&amp;{/if}offset={$offset}&amp;sort_mode={if $sort_mode eq 'login_desc'}login_asc{else}login_desc{/if}" class="userlistheading">
				<img src="styles/estudiolivre/sort{if $sort_mode eq 'login_desc'}ArrowUp{elseif $sort_mode eq 'login_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
			</a>
			{/tooltip}
			{tr}User{/tr}
		</td>
		<td class="heading">
			{tooltip text="Clique para que a listagem seja por <b>ordem alfabética</b> de nome completo"}
			<a class="userlistheading" href="tiki-list_users.php?{if $find}find={$find}&amp;{/if}offset={$offset}&amp;sort_mode={if $sort_mode eq 'realName_desc'}realName_asc{else}realName_desc{/if}">
				<img src="styles/estudiolivre/sort{if $sort_mode eq 'realName_desc'}ArrowUp{elseif $sort_mode eq 'realName_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
			</a>
			{/tooltip}
			{tr}Real Name{/tr}
		</td>
		{*================
		<td class="heading">
			Email
		</td>
		<td class="heading">
			Site
		</td>
		====================*}
		<td class="heading">
			{tooltip text="Clique para que a listagem seja por <b>ordem alfabética</b> de localização"}
			<a class="userlistheading" href="tiki-list_users.php?{if $find}find={$find}&amp;{/if}offset={$offset}&amp;sort_mode={if $sort_mode eq 'country_desc'}country_asc{else}country_desc{/if}">
				<img src="styles/estudiolivre/sort{if $sort_mode eq 'country_desc'}ArrowUp{elseif $sort_mode eq 'country_asc'}ArrowDown{else}GreyArrowDown{/if}.png">
			</a>
			{/tooltip}
			Localização
		</td>
{if $feature_score eq 'y'}
  <td class="heading"><a class="userlistheading" href="tiki-list_users.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'score_desc'}score_asc{else}score_desc{/if}">{tr}Score{/tr}</a>&nbsp;</td>
{/if}

{*==============
  <td class="heading">{tr}Country{/tr}&nbsp;</td>
  <td class="heading">{tr}Distance (km){/tr}&nbsp;</td>
===============*}
	</tr>
	{section name=changes loop=$listusers}
	{cycle values="odd,even" assign="currentClass" print=false}
		<tr class="{$currentClass}">
			<td>
				<a href="el-user.php?view_user={$listusers[changes].login}">
					{$listusers[changes].login}
				</a>
			</td>
			
			<td>
				{$listusers[changes].realName}
			</td>
			
			{if $feature_score eq 'y'}
			   <td class="odd">&nbsp;{$listusers[changes].score}&nbsp;</td>
			{/if}
			
			{*===============
			<td>
				{tr}{$listusers[changes].email}{/tr}
			</td>
			
			<td>
				{tr}{$listusers[changes].site}{/tr}
			</td>
			================*}
			
			<td>
				{tr}{$listuserscountry[changes]}{/tr}
			</td>
  			
  			{*===========================
				  {if $listuserscountry[changes] == "None" || $listuserscountry[changes] == "Other" || $listuserscountry[changes] == ""}
				  {html_image file='img/flags/Other.gif' border='0' hspace='4' vspace='1' alt='{tr}flag{/tr}' title='{tr}flag{/tr}'}
				  {else}
				  {html_image file="img/flags/$listuserscountry[changes].gif" hspace='4' vspace='1' alt='{tr}flag{/tr}' title='{tr}flag{/tr}'}
				  &nbsp;{tr}{$listuserscountry[changes]}{/tr}
			      {/if}    
				  &nbsp;</td>
				  <td>&nbsp;{$listdistance[changes]}&nbsp;</td>
			 =========================*}
		</tr>
	{sectionelse}
		<tr>
			<td colspan="6">
				<b>{tr}No records found{/tr}</b>
			</td>
		</tr>
	{/section}
</table>
<br />
<div class="paginacao">
	{if $prev_offset >= 0}
		<a class="userprevnext" href="tiki-list_users.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">
			<img src="styles/estudiolivre/iArrowGreyLeft.png">
		</a>
	{/if}
	
	{tr}Page{/tr} {$actual_page} de {$cant_pages}
	
	{if $next_offset >= 0}
		<a class="userprevnext" href="tiki-list_users.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">
			<img src="styles/estudiolivre/iArrowGreyRight.png">
		</a>
	{/if}
	{if $direct_pagination eq 'y'}
		<br />
		{section loop=$cant_pages name=foo}
			{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
				<a class="prevnext" href="tiki-list_users.php?find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
			{$smarty.section.foo.index_next}</a>
		{/section}
	{/if}
</div>
</div>