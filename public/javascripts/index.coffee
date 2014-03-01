margin =
  top: 20
  right: 280
  bottom: 30
  left: 50

width = 1280 - margin.left - margin.right
height = 600 - margin.top - margin.bottom
parseDate = d3.time.format("%Y%m").parse
x = d3.time.scale().range([
  0
  width
])
y = d3.scale.linear().range([
  height
  0
])
color = d3.scale.category10()
xAxis = d3.svg.axis().scale(x).orient("bottom")
yAxis = d3.svg.axis().scale(y).orient("left")
line = d3.svg.line().interpolate("basis").x((d) ->
  x d.date
).y((d) ->
  y d.value
)
svg = d3.select("body").append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")
d3.json "data", (error, data) ->
  color.domain ['A190110','A190109']
  data.forEach (d) ->
    d.date = parseDate(d.date)
    return

  cities = color.domain().map((name) ->
    name: data.filter((d) -> d.index == name)[0].name,
    values: data.filter((d) -> d.index == name).map((d) ->
      date: d.date
      value: d.value
    )
  )
  x.domain d3.extent(data, (d) ->
    d.date
  )
  y.domain [
    d3.min(cities, (c) ->
      d3.min c.values, (v) ->
        v.value

    )
    d3.max(cities, (c) ->
      d3.max c.values, (v) ->
        v.value

    )
  ]
  svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call xAxis
  svg.append("g").attr("class", "y axis").call(yAxis).append("text").attr("transform", "rotate(-90)").attr("y", 6).attr("dy", ".71em").style("text-anchor", "end").text "Value"
  city = svg.selectAll(".city").data(cities).enter().append("g").attr("class", "city")
  city.append("path").attr("class", "line").attr("d", (d) ->
    line d.values
  ).style "stroke", (d) ->
    color d.name

  city.append("text").datum((d) ->
    name: d.name
    value: d.values[d.values.length - 1]
  ).attr("transform", (d) ->
    "translate(" + x(d.value.date) + "," + y(d.value.value) + ")"
  ).attr("x", 3).attr("dy", ".35em").text (d) ->
    d.name

  return
