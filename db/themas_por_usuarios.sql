update tiki_preferences set value = 'y' where name = 'change_theme';
replace into tiki_preferences (name,value) values('available_styles','a:2:{i:0;s:16:\"estudiolivre.css\";i:1;s:21:\"estudiolivre_orig.css\";}');
