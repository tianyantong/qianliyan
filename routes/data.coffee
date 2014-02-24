exports.data = (req, res) ->
  res.set "Content-Type", "application/json"
  mysql = require "mysql"
  connection = mysql.createConnection
    host: "10.29.9.2"
    user: "qianliyan"
    password: "qianliyan"
    database: "gov_stats"

  connection.connect (err) ->
    connection.query "select * from data where decode='hgydks' and `index`='A200204' order by date limit 100", (err, result) ->
      json = JSON.stringify(result)
      res.end json
