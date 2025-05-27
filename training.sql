create table if not exists plan
(
    id bigserial not null
        constraint plan_pkey
        primary key,
    title varchar(255) not null
);

alter table plan owner to postgres;

create table if not exists course
(
    id bigserial not null
        constraint course_pkey
        primary key,
    finish date,
    start_date date,
    title varchar(255),
    plan_id bigint not null
        constraint course_plan_id_fkey
        references plan
        on delete cascade
);

alter table course owner to postgres;

create index if not exists idx_course_plan_id on course (plan_id);

create table if not exists task
(
    id bigserial not null
        constraint task_pkey
        primary key,
    created date not null,
    title varchar(255),
    updated date,
    course_id bigint not null
        constraint task_course_id_fkey
        references course
        on delete cascade
);

alter table task owner to postgres;

create index if not exists idx_task_course_id on task (course_id);

create table if not exists roles
(
    id bigserial not null
        constraint roles_pk
        primary key,
    name varchar(50) not null
);

alter table roles owner to postgres;

create unique index if not exists roles_id_uindex on roles (id);

create table if not exists users
(
    id bigserial not null
        constraint users_pkey
        primary key,
    email varchar(255) not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    password varchar(255) not null,
    role_id bigint not null
        constraint users_roles_id_fk
        references roles
        on delete cascade
);

alter table users owner to postgres;

create index if not exists idx_users_role_id on users (role_id);

create table if not exists plan_user
(
    plan_id bigint not null
        constraint plan_user_plan_id_fkey
        references plan
        on delete cascade,
    user_id bigint not null
        constraint plan_user_user_id_fkey
        references users
        on delete cascade,
    constraint plan_user_pk primary key (plan_id, user_id)
);

alter table plan_user owner to postgres;

create table if not exists progress
(
    id bigserial not null
        constraint progress_pkey
        primary key,
    started date,
    status varchar(255) not null,
    updated date,
    task_id bigint not null
        constraint progress_task_id_fkey
        references task
        on delete cascade,
    trainee_id bigint not null
        constraint progress_trainee_id_fkey
        references users
        on delete cascade,
    constraint unique_task_trainee unique (task_id, trainee_id)
);

alter table progress owner to postgres;

create index if not exists idx_progress_task_id on progress (task_id);
create index if not exists idx_progress_trainee_id on progress (trainee_id);
