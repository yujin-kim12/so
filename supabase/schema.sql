-- 항암치료 데일리 기록 앱: 사용자별 기록 한 묶음을 저장합니다.
-- Supabase SQL Editor에서 한 번 실행하세요.
create table if not exists public.user_app_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"records":{},"meds":[],"phone":""}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.user_app_data enable row level security;
revoke all on public.user_app_data from anon;
grant select, insert, update, delete on public.user_app_data to authenticated;

drop policy if exists "Users can read their own app data" on public.user_app_data;
drop policy if exists "Users can insert their own app data" on public.user_app_data;
drop policy if exists "Users can update their own app data" on public.user_app_data;
drop policy if exists "Users can delete their own app data" on public.user_app_data;

create policy "Users can read their own app data"
  on public.user_app_data for select to authenticated
  using (auth.uid() = user_id);
create policy "Users can insert their own app data"
  on public.user_app_data for insert to authenticated
  with check (auth.uid() = user_id);
create policy "Users can update their own app data"
  on public.user_app_data for update to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
create policy "Users can delete their own app data"
  on public.user_app_data for delete to authenticated
  using (auth.uid() = user_id);

create or replace function public.touch_user_app_data_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
drop trigger if exists user_app_data_updated_at on public.user_app_data;
create trigger user_app_data_updated_at
  before update on public.user_app_data
  for each row execute function public.touch_user_app_data_updated_at();
