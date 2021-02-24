install.packages("mongolite")
library(mongolite)
library(jsonlite)


conn <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://andyAH:fuJIN42kAiUlGilz@cluster0.alxih.mongodb.net/test",
  verbose = FALSE,
  options = ssl_options()
)

conn$count()

conn$aggregate('[{"$group":
                    {"_id":"null", 
                    "conteo": {"$sum":1}
                    }
               }]')



consulta <- conn$aggregate('[
  {
    "$match": {
      "HomeTeam": "Real Madrid"
    }
  }, {
    "$project": {
      "Año": {
        "$year": "$Date"
      }, 
      "Mes": {
        "$month": "$Date"
      }
    }
  }, {
    "$match": {
      "Mes": {
        "$eq": 12
      }
    }
  }, {
    "$project": {
      "_id": 1, 
      "Año": 1, 
      "Mes": 1, 
      "HomeTeam": 1
    }
  }
]')

consulta1 <- conn$aggregate('[
  {
    "$match": {
      "AwayTeam": "Real Madrid"
    }
  }, {
    "$project": {
      "Año": {
        "$year": "$Date"
      }, 
      "Mes": {
        "$month": "$Date"
      }
    }
  }, {
    "$match": {
      "Mes": {
        "$eq": 12
      }
    }
  }, {
    "$project": {
      "_id": 1, 
      "Año": 1, 
      "Mes": 1, 
      "HomeTeam": 1
    }
  }
]')

conn$disconnect()
rm(conn)
