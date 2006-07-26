{* $Header: /home/rodrigo/devel/arca/estudiolivre/src/templates/styles/obscur/textareasize.tpl,v 1.1 2006-07-26 06:15:08 rhwinter Exp $ *}
{* \brief: the 4 buttoms to change a textarea size (only one per form)
  * \param: $area_name = the textarea id
  * \param: $formId = the form id
  * the form needs 2 hidden input named 'rows' and 'cols' to remember the settings for a preview
  *}
<div id="textareasize">
	{tooltip text="<b>Aumentar</b> a altura da caixa de edição de texto"}
	<a href="javascript:textareasize('{$area_name}', +10, 0, '{$formId}')">
		<img src="img/icons2/enlargeH.gif" border="0" />
	</a>
	{/tooltip}
	{tooltip text="<b>Diminuir</b> a altura da caixa de edição de texto"}
	<a href="javascript:textareasize('{$area_name}', -10, 0, '{$formId}')">
		<img src="img/icons2/reduceH.gif" border="0"/>
	</a>
	{/tooltip}
</div>
