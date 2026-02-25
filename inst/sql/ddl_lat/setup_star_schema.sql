--DROP TABLE employer 
CREATE TABLE employer(
  id INTEGER,
  local VARCHAR,
  industry VARCHAR,
  employer VARCHAR,
  internal_id integer default nextval('employer_id'),
  primary key (internal_id)
);

create table fact_lat (
  strikeOrProtest_id integer,
  trade_union_id integer,
  employer_id integer,
  foreign key (strikeOrProtest_id) references strikeOrProtest(id),
  foreign key (trade_union_id) references trade_union(internal_id),
  foreign key (employer_id) references employer(internal_id)
);


