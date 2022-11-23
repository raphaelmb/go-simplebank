create table accounts (
  id bigserial primary key,
  owner varchar not null,
  balance bigint not null,
  currency varchar not null,
  created_at timestamptz not null default (now())
);

create table entries (
  id bigserial primary key,
  account_id bigint not null references accounts,
  amount bigint not null,
  created_at timestamptz not null default (now())
);

create table transfers (
  id bigserial primary key,
  from_account_id bigint not null references accounts,
  to_account_id bigint not null references accounts,
  amount bigint not null check(amount > 0),
  created_at timestamptz not null default (now())
);

create index on accounts (owner);
create index on entries (account_id);
create index on transfers (from_account_id);
create index on transfers (to_account_id);
create index on transfers (from_account_id, to_account_id);