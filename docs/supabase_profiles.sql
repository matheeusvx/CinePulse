-- Execute uma vez no SQL Editor do projeto Supabase.
-- Somente dados de perfil; nenhuma tabela de catálogo/avaliação nesta etapa.

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text,
  username text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists profiles_username_unique
  on public.profiles (lower(username)) where username is not null;

alter table public.profiles enable row level security;

grant select, update on public.profiles to authenticated;

create policy "Usuário lê seu perfil"
  on public.profiles for select to authenticated
  using ((select auth.uid()) = id);

create policy "Usuário edita seu perfil"
  on public.profiles for update to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

create or replace function public.set_profile_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger set_profile_updated_at
  before update on public.profiles
  for each row execute function public.set_profile_updated_at();

create or replace function public.create_profile_for_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  insert into public.profiles (id) values (new.id);
  return new;
end;
$$;

create trigger create_profile_for_new_user
  after insert on auth.users
  for each row execute function public.create_profile_for_new_user();

-- Caso já existam usuários no projeto antes desta migração:
insert into public.profiles (id)
select id from auth.users
on conflict (id) do nothing;
