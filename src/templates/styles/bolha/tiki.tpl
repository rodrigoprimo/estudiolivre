<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html 
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
	xml:lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}"
	lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}"
	{if !empty($page_id)} id="page_{$page_id}"{/if}>

	<head>{include file="header.tpl"}</head>
  
	{include file="body.tpl"}
	{* ---- END ---- *}
</html>