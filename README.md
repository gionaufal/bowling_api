# BowlingApi

This is a Phoenix API to keep track of Bowling games, according to the
traditional [10 pin bowling score
rules](https://en.wikipedia.org/wiki/Ten-pin_bowling#Scoring).

The API has 3 endpoints:

- `POST /games/`

Creates a new game, returning it's unique UUID and inserted_at time
To start your Phoenix server:

```
$ http post localhost:4000/games/                                                                                               ruby-2.6.3 master d6d9201 +

HTTP/1.1 201 Created
content-type: application/json; charset=utf-8

{
    "game": {
        "id": "685cada1-49dd-402b-99bd-f5e5f952dfde",
        "inserted_at": "2021-03-12T17:38:12"
    },
    "message": "Game created!"
}
```

- `POST /games/id/new_throw pins={number of pins}`

Creates a new throw (ball) in the current game. It creates a new frame if
needed, or adds the throw to the current frame. Returns a confirmation that the
throw was created.

```
$ http post localhost:4000/games/685cada1-49dd-402b-99bd-f5e5f952dfde/new_throw pins=10                                         ruby-2.6.3 master d6d9201 +

HTTP/1.1 201 Created
content-type: application/json; charset=utf-8

{
    "message": "Throw recorded!",
    "throw": {
        "id": "0bc13381-669b-4753-91c9-cd8e95591a45",
        "inserted_at": "2021-03-12T17:44:19",
        "pins": 10
    }
}
```

- `GET /games/id`

Gets the current state of the game, with it's frames and respective throws,
score for each frame and total score of the game.

```
 ➤ http get localhost:4000/games/685cada1-49dd-402b-99bd-f5e5f952dfde                                                                                                                                                                                 ruby-2.6.3 master d6d9201 +

HTTP/1.1 200 OK
content-type: application/json; charset=utf-8

{
   "frames":[
      {
         "frame_id":"4048c5cd-476f-40b2-93b6-1a94cc73ffb2",
         "inserted_at":"2021-03-12T17:44:19",
         "score":30,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:44:19",
               "pins":10,
               "throw_id":"0bc13381-669b-4753-91c9-cd8e95591a45"
            }
         ]
      },
      {
         "frame_id":"668bd5d4-08fd-4716-a7fb-636ba41123f2",
         "inserted_at":"2021-03-12T17:47:22",
         "score":25,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:22",
               "pins":10,
               "throw_id":"215c22dc-1122-44e1-8f6b-09f74b7e5241"
            }
         ]
      },
      {
         "frame_id":"9448c0ca-5734-4951-a79e-ee82a658e20e",
         "inserted_at":"2021-03-12T17:47:25",
         "score":20,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:25",
               "pins":10,
               "throw_id":"67062e9d-b845-48b7-8b65-b7c4648b690f"
            }
         ]
      },
      {
         "frame_id":"6c2fd65f-4605-43d3-b4b9-17feb33adce1",
         "inserted_at":"2021-03-12T17:47:28",
         "score":14,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:28",
               "pins":5,
               "throw_id":"ae696213-aa7f-4a93-bc6f-e100da1fa313"
            },
            {
               "inserted_at":"2021-03-12T17:47:30",
               "pins":5,
               "throw_id":"b0df2908-c97f-4418-82b4-038779feee3a"
            }
         ]
      },
      {
         "frame_id":"1dd7334c-65a2-46c7-b92b-bbf76a4ddcee",
         "inserted_at":"2021-03-12T17:47:34",
         "score":7,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:34",
               "pins":4,
               "throw_id":"53b6502a-c0ef-432b-a217-ad79c4ccb760"
            },
            {
               "inserted_at":"2021-03-12T17:47:39",
               "pins":3,
               "throw_id":"fbd0049d-72af-4c9b-921f-e8ffaecacb5c"
            }
         ]
      },
      {
         "frame_id":"8656e3e6-9496-4cd9-a2e2-0f774e561e6a",
         "inserted_at":"2021-03-12T17:47:42",
         "score":30,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:42",
               "pins":10,
               "throw_id":"592f6dfc-d85f-4a54-93c4-984f7d0c7ebe"
            }
         ]
      },
      {
         "frame_id":"b5b6bac0-f104-4e49-abc3-f51641bf7c00",
         "inserted_at":"2021-03-12T17:47:45",
         "score":30,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:45",
               "pins":10,
               "throw_id":"97034c6f-0ae5-4979-8a51-0cab7b977f18"
            }
         ]
      },
      {
         "frame_id":"6ed49f87-283e-4130-8bef-2dff245eace7",
         "inserted_at":"2021-03-12T17:47:46",
         "score":30,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:46",
               "pins":10,
               "throw_id":"7eceb5af-0a8e-439f-b64b-ef6dfba558ed"
            }
         ]
      },
      {
         "frame_id":"57b17148-30a0-45f7-aaae-3eb545b48610",
         "inserted_at":"2021-03-12T17:47:48",
         "score":30,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:48",
               "pins":10,
               "throw_id":"7b9a9209-9adc-48d4-86fb-c7e355ff1035"
            }
         ]
      },
      {
         "frame_id":"d4975137-5178-4186-9b0b-202f391ed4e9",
         "inserted_at":"2021-03-12T17:47:50",
         "score":30,
         "throws":[
            {
               "inserted_at":"2021-03-12T17:47:50",
               "pins":10,
               "throw_id":"8712736d-7d2b-415c-9988-6407aeb9270f"
            },
            {
               "inserted_at":"2021-03-12T17:47:52",
               "pins":10,
               "throw_id":"a54df033-b7c6-4dc2-8901-b43d291ccc8c"
            },
            {
               "inserted_at":"2021-03-12T17:47:54",
               "pins":10,
               "throw_id":"6c2e61f3-5ce6-4e10-b58c-223d1777e535"
            }
         ]
      }
   ],
   "id":"685cada1-49dd-402b-99bd-f5e5f952dfde",
   "inserted_at":"2021-03-12T17:38:12",
   "total_score":246
}
```

## How to run the project

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server`

Now you can interact with the API via [`localhost:4000`](http://localhost:4000),
using `curl`, `httpie` any other tool.
