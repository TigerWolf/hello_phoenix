# Fitness Challenge

Fitness Challenge app for the Uni of Adelaide. Teams can track points as teams.

# TODO

  * Fix captains relationship - many teams?
  * find out if you can preload a model in your model? Instead of everywhere in your controller
  * Relationships for models
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
