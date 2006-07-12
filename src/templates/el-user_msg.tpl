{foreach from=$userMessages.data item='msg'}
	<div class="uMsgItem">
    	<div class="uMsgAvatar">
        	<img alt="" title="" src="tiki-show_user_avatar.php?user={$msg.user_from}">
        </div>
	<div class="uMsgTxt">
		<div class="uMsgDel">
        	{if $permission || $user eq $msg.user_from}<a onClick="xajax_delMsg('{$msg.user_from}', {$msg.msgId})"><img alt="" title="{tr}Deletar Mensagem{/tr}" src="styles/estudiolivre/iDelete.png"></a>{/if}
        </div>
        	<div class="uMsgDate">
              {$msg.date|date_format:"%H:%M"}<br />
              {$msg.date|date_format:"%d/%m/%Y"}
            </div>
            <a href="el-user.php?view_user={$msg.user_from}">{$msg.user_from}</a>: {$msg.body}
        </div>
	</div>
{foreachelse}
{tr}Seja @ primeir@ a enviar uma mensagem para esse(a) usuári@!{/tr}<br/>
{/foreach}

<div id="uMsgSend">
{if $user}
	<form onSubmit="sendMsg(); return false;">
		<input type="submit" name="" value="{tr}enviar{/tr}" label="enviar" id="uMsgSendSubmit" onClick="sendMsg()">
	   	<input type="text" id="uMsgSendInput">
	</form>
{else}
	{tr}Você não pode enviar recados pois não está logado no site{/tr}.
{/if}
</div>