{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/estudiolivre/modules/mod-login_box.tpl,v 1.1 2006-07-17 22:19:09 rhwinter Exp $ *}

{if !$user}
	{tikimodule name="{tr}Login{/tr}"}
		<form id="uLoginBox" action="tiki-login.php" method="post">
			{if $isIE}{tr}Usuário{/tr}: {/if}<input class="{if !$isIE}uText{/if}" type="text" name="user" id="login-user" size="12" {if $isIE}style="width:60%"{/if} value="{tr}user{/tr}" onFocus="if(this.value=='{tr}usuári@{/tr}')this.value=''"/>
			{if $isIE}{tr}Senha{/tr}: {/if}<input class="{if !$isIE}uText{/if}" type="{if $isIE}password{else}text{/if}" name="pass" id="login-pass" size="10"	{if $isIE}style="width:70%"{/if} value="{if !$isIE}{tr}senha{/tr}{/if}" onFocus="if(this.value=='{tr}senha{/tr}')this.value='';this.type='password'"/>
			{tooltip text="Clique aqui ou aperte <i>Enter</i> para efetuar o login"}<input type="image" name="login" src="styles/estudiolivre/iLogin.png" />{/tooltip}
		      
			<div id="uLoginOptions">
				<a href="tiki-remind_password.php">&raquo; {tr}recuperar senha{/tr}</a><br>
				<a href="tiki-register.php">&raquo; {tr}cadastrar-se{/tr}</a>
			</div>
		      
		</form>
	{/tikimodule}
{/if}