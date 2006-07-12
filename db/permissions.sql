insert into users_permissions values ('el_p_upload_files','Subir arquivos na galeria','basic','estudiolivre');
insert into users_permissions values ('el_p_admin_gallery','Administrar a galeria','admin','estudiolivre');
insert into users_permissions values ('el_p_vote','Votar em arquivos na galeria','basic','estudiolivre');
insert into users_permissions values ('el_p_view','Ver arquivos da galeria','basic','estudiolivre');
insert into users_grouppermissions values ('Registered','el_p_upload_files','y');
insert into users_grouppermissions values ('Registered','el_p_vote','y');
insert into users_grouppermissions values ('Anonymous','el_p_view','y');

insert into users_grouppermissions values ('Anonymous','tiki_p_view_freetags','y');
insert into users_grouppermissions values ('Registered','tiki_p_freetags_tag','y');

delete from users_grouppermissions where permName = 'tiki_p_vote_poll';
insert into users_grouppermissions values ('Registered','tiki_p_vote_poll','y');

delete from users_grouppermissions where permName = 'el_p_admin_gallery';
insert into users_groups values('Moderadores do acervo', 'Colaboradores na moderação dos arquivos enviados ao acervo', '', 'n', null, null, null, null);
insert into users_grouppermissions values ('Moderadores do acervo', 'el_p_admin_gallery', 'y');
insert into users_usergroups values (4, 'Moderadores do acervo'), (24, 'Moderadores do acervo'), (36, 'Moderadores do acervo'), (153, 'Moderadores do acervo'), (393, 'Moderadores do acervo'), (678, 'Moderadores do acervo');
