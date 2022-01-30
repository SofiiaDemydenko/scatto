create table user_subscriptions(
    subscriber_id int8 not null references usr,
    channel_id int8 not null references usr,
    primary key(subscriber_id, channel_id)
);

-- references usr (foreign key for usr table).