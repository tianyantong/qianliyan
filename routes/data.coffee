exports.data = (req, res) ->
  res.set "Content-Type", "application/json"
  mysql = require "mysql"
  connection = mysql.createConnection
    host: "10.29.9.2"
    user: "qianliyan"
    password: "qianliyan"
    database: "gov_stats"

  connection.connect (err) ->
    connection.query "select * from data d, `index` i where decode='hgydks' and (`index`='A190110' or `index` = 'A190109') and i.id = d.`index` order by date", (err, result) ->
      json = JSON.stringify(result)
      res.end json
