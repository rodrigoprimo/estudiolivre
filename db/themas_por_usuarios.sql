update tiki_preferences set value = 'y' where name = 'change_theme';
replace into tiki_preferences (name,value) values('available_styles','a:3:{i:0;s:9:\"bolha.css\";i:1;s:12:\"original.css\";i:2;s:10:\"obscur.css\";}');
update tiki_preferences set value = 'bolha.css' where name='style';
update tiki_user_preferences set value='bolha.css' where value='estudiolivre.css';
update tiki_user_preferences set value='original.css' where value='estudiolivre_orig.css';