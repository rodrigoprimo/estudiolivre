# name             | position | ord  | type | title | cache_time | rows | params | groups
delete from tiki_modules;
replace into tiki_modules values('login_box', 'r', 1, '', '', 0, 10, '', 'a:1:{i:0;s:9:"Anonymous";}');
replace into tiki_modules values('switch_lang', 'r', 2, '', '', 0, 10, '', 'a:2:{i:0;s:9:"Anonymous";i:1;s:10:"Registered";}');