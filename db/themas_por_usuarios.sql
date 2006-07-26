update tiki_preferences set value = 'y' where name = 'change_theme';
replace into tiki_preferences (name,value) values('available_styles','a:3:{i:0;s:16:\"estudiolivre.css\";i:1;s:21:\"estudiolivre_orig.css\";i:2;s:10:\"obscur.css\";}');
