var dataSet = [
    { key: 0, value: 5 },
    { key: 1, value: 10 },
   { key: 2, value: 13 },
   { key: 3, value: 19 },
   { key: 4, value: 21 },
   { key: 5, value: 25 },
   { key: 6, value: 22 },
   { key: 7, value: 18 },
   { key: 8, value: 15 },
   { key: 9, value: 13 },
   { key: 10, value: 11 },
   { key: 11, value: 12 },
   { key: 12, value: 15 },
   { key: 13, value: 20 },
   { key: 14, value: 18 },
   { key: 15, value: 17 },
   { key: 16, value: 16 },
   { key: 17, value: 18 },
   { key: 18, value: 23 },
   { key: 19, value: 25 }
];

var height = 200;
var width = 1000;

var yScale = d3.scale.linear()
    .domain(
        [0, d3.max(dataSet,
            function (d) {
                return d.value;
            })
        ]
    ).
    range([0, height]);

var xScale = d3.scale.linear()
    .domain(
        [0, d3.max(dataSet,
            function (d) {
                return d.key + 1;
            })
        ]
    ).
    range([0, width]);

var key = function (data) {
    return data.key;
};

d3.select('body')
    .append('svg')
    .attr('height', height)
    .attr('width', width)
    .selectAll('rect')
    .data(dataSet, key)
    .enter()
    .append('rect')
    .attr('class', 'bar')
    .attr('x', function (data, i) {
        return xScale(data.key);
    })
    .attr('y', function (data) {
        return height - yScale(data.value);
    })
    .attr('width', function (data) {
        return width / dataSet.length - 10;
    })
    .attr('height', function (data) {
        return yScale(data.value);
    })
    .attr('fill', 'green');


var max = 25;
var length = dataSet.length;

var refresh = function(selection) {
    xScale.domain([d3.min(dataSet, function (data) {
        return data.key;
    }), d3.max(dataSet, function (data) {
        return data.key + 1;
    })]);
    yScale.domain([0, d3.max(dataSet, function (data) {
        return data.value;
    })]);

    selection.transition()
        .duration(500)
        .attr('x', function (data) {
            return xScale(data.key);
        })
        .attr('y', function (data) {
            return height - yScale(data.value);
        })
        .attr('width', function (data) {
            return width / dataSet.length - 10;
        })
        .attr('height', function (data) {
            return yScale(data.value);
        })
};

var getBars = function(){
    return d3.select('svg').selectAll('rect').data(dataSet, key);
}

d3.select('.add').on('click', function () {
    max += 5;
    dataSet.push({key: length++, value: max});
    var bars = getBars();
    bars.enter()
        .append('rect')
        .attr('class', 'bar')
        .attr('x', function (data, i) {
            return width;
        })
        .attr('y', function (data) {
            return height - yScale(data.value);
        })
        .attr('width', function (data) {
            return width / dataSet.length - 10;
        })
        .attr('height', function (data) {
            return yScale(data.value);
        })
        .attr('fill', 'green');
    refresh(bars);
});


d3.select('.remove').on('click', function () {
    dataSet.splice(0,1);
    var bars = getBars();
    bars.exit()
        .transition()
        .duration(500)
        .attr('x', 1000)
        .remove();
    refresh(bars);
})

