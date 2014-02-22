exports.data = function (req, res) {
    res.set('Content-Type', 'application/json');

    var mysql = require('mysql');
    var connection = mysql.createConnection({
        host: '10.29.9.2',
        user: 'qianliyan',
        password: 'qianliyan',
        database: 'gov_stats'
    });

    connection.connect(function (err) {
        connection.query("select * from data where decode='hgydks' and `index`='A200204' order by date limit 100", function (err, result) {
            var json = JSON.stringify(result);
            return res.end(json);
        });
    });

};