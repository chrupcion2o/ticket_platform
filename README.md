# README

TODO:
- pay
- reservation info





Sample requests:
`curl localhost:3000/event_info/1`

`curl localhost:3000/event_tickets/1`

`curl -d '{"ticket": {"quantity": 2, "id": 1 }}' -H "Content-Type: application/json" -X POST http://localhost:3000/reserve_ticket`