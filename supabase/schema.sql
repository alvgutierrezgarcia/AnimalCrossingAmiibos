-- Álbum amiibo ACNH: favoritos e isla de cada usuario.
-- Ejecutar una vez en el editor SQL del proyecto de Supabase.

create table if not exists public.amiibo_album (
  user_id    uuid primary key default auth.uid() references auth.users on delete cascade,
  favs       int[] not null default '{}',   -- nº de tarjeta (1–400)
  island     int[] not null default '{}',   -- nº de tarjeta, 10 como máximo
  updated_at timestamptz not null default now(),  -- lo fija el cliente; gana el más reciente
  constraint island_max check (cardinality(island) <= 10)
);

alter table public.amiibo_album enable row level security;

-- Cada usuario solo ve y modifica su propia fila.
create policy "album: leer el propio" on public.amiibo_album
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "album: crear el propio" on public.amiibo_album
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "album: cambiar el propio" on public.amiibo_album
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

grant select, insert, update on public.amiibo_album to authenticated;
