# HelloPhoenix

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

# TODO

  * Relationships for models
  * Basic auth for api (partial - use user model auth)
  * Many-to-many for team to user
  * Add API for teams and logs

```
  +----------+       +----------+        +----------+
  | event    +-------+ team     +--------+ user     |
  |          |       |          |        |          |
  +------+---+       +----------+        +-+--------+
         |                                 |         
         |                                 |         
         +--+                              |         
           +----------+             +------+---+     
           | activity +-------------+ log      |     
           |          |             |          |     
           +----------+             +----------+     
```
event
---
name
dates

team
---
name

activity_log
---
activity_id
amount
user_id
