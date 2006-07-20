# name             | position | ord  | type | title | cache_time | rows | params | groups
delete from tiki_modules;
replace into tiki_modules values('login_box', 'r', 1, '', '', 0, 10, 'noClose=y', 'a:1:{i:0;s:9:"Anonymous";}');
replace into tiki_modules values('admin_menu', 'r', 2, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');
replace into tiki_modules values('switch_lang', 'r', 3, '', '', 0, 10, 'flip=y', 'a:2:{i:0;s:9:"Anonymous";i:1;s:10:"Registered";}');
replace into tiki_modules values('last_modif_pages', 'r', 4, '', '', 0, 10, 'flip=y', 'a:2:{i:0;s:9:"Anonymous";i:1;s:10:"Registered";}');
replace into tiki_modules values('el_gallery', 'r', 5, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');
replace into tiki_modules values('breadcrumb', 'r', 6, '', '', 0, 10, 'flip=y', 'a:2:{i:0;s:9:"Anonymous";i:1;s:10:"Registered";}');
replace into tiki_modules values('who_is_there', 'r', 7, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');
replace into tiki_modules values('user_blogs', 'r', 8, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');

replace into tiki_modules values('el_msgs', 'r', 9, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');
# replace into tiki_modules values('shoutbox', 'r', 10, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');
replace into tiki_modules values('switch_theme', 'r', 11, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');
# replace into tiki_modules values('wiki_last_comments', 'r', 12, '', '', 0, 10, 'flip=y', 'a:1:{i:0;s:10:"Registered";}');