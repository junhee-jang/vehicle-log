-- PIN 인증 날짜를 사용자 전체가 아닌 브라우저/기기별로 저장한다.
create table if not exists public.user_pin_device_verifications (
  user_id uuid not null references auth.users(id) on delete cascade,
  device_id text not null,
  device_type text not null default 'unknown'
    check (device_type in ('mobile', 'pc', 'unknown')),
  last_verified_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, device_id)
);

alter table public.user_pin_device_verifications enable row level security;
revoke all on table public.user_pin_device_verifications from anon, authenticated, public;
grant all on table public.user_pin_device_verifications to service_role;
