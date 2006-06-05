insert into users_permissions values ('el_p_upload_files','Subir arquivos na galeria','basic','estudiolivre');
insert into users_permissions values ('el_p_admin_gallery','Administrar a galeria','admin','estudiolivre');
insert into users_permissions values ('el_p_vote','Votar em arquivos na galeria','basic','estudiolivre');
insert into users_grouppermissions values ('Registered','el_p_upload_files','y');
insert into users_grouppermissions values ('Admins','el_p_admin_gallery','y');
insert into users_grouppermissions values ('Registered','el_p_vote','y');

insert into users_grouppermissions values ('Anonymous','tiki_p_view_freetags','y');
insert into users_grouppermissions values ('Registered','tiki_p_freetags_tag','y');

