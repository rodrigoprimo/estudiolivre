update tiki_blogs set use_author = 'y' where use_author IS NULL;
update tiki_blogs set add_date = 'y' where add_date IS NULL;
update tiki_blogs set show_related = 'y' where show_related IS NULL;
