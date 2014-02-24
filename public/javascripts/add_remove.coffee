dataSet = [
  {
    key: 0
    value: 5
  }
  {
    key: 1
    value: 10
  }
  {
    key: 2
    value: 13
  }
  {
    key: 3
    value: 19
  }
  {
    key: 4
    value: 21
  }
  {
    key: 5
    value: 25
  }
  {
    key: 6
    value: 22
  }
  {
    key: 7
    value: 18
  }
  {
    key: 8
    value: 15
  }
  {
    key: 9
    value: 13
  }
  {
    key: 10
    value: 11
  }
  {
    key: 11
    value: 12
  }
  {
    key: 12
    value: 15
  }
  {
    key: 13
    value: 20
  }
  {
    key: 14
    value: 18
  }
  {
    key: 15
    value: 17
  }
  {
    key: 16
    value: 16
  }
  {
    key: 17
    value: 18
  }
  {
    key: 18
    value: 23
  }
  {
    key: 19
    value: 25
  }
]
height = 200
width = 1000
yScale = d3.scale.linear().domain([
  0
  d3.max(dataSet, (d) ->
    d.value
  )
]).range([
  0
  height
])
xScale = d3.scale.linear().domain([
  0
  d3.max(dataSet, (d) ->
    d.key + 1
  )
]).range([
  0
  width
])
key = (data) ->
  data.key

d3.select("body").append("svg").attr("height", height).attr("width", width).selectAll("rect").data(dataSet, key).enter().append("rect").attr("class", "bar").attr("x", (data, i) ->
  xScale data.key
).attr("y", (data) ->
  height - yScale(data.value)
).attr("width", (data) ->
  width / dataSet.length - 10
).attr("height", (data) ->
  yScale data.value
).attr "fill", "green"
max = 25
length = dataSet.length
refresh = (selection) ->
  xScale.domain [
    d3.min(dataSet, (data) ->
      data.key
    )
    d3.max(dataSet, (data) ->
      data.key + 1
    )
  ]
  yScale.domain [
    0
    d3.max(dataSet, (data) ->
      data.value
    )
  ]
  selection.transition().duration(500).attr("x", (data) ->
    xScale data.key
  ).attr("y", (data) ->
    height - yScale(data.value)
  ).attr("width", (data) ->
    width / dataSet.length - 10
  ).attr "height", (data) ->
    yScale data.value

  return

getBars = ->
  d3.select("svg").selectAll("rect").data dataSet, key

d3.select(".add").on "click", ->
  max += 5
  dataSet.push
    key: length++
    value: max

  bars = getBars()
  bars.enter().append("rect").attr("class", "bar").attr("x", (data, i) ->
    width
  ).attr("y", (data) ->
    height - yScale(data.value)
  ).attr("width", (data) ->
    width / dataSet.length - 10
  ).attr("height", (data) ->
    yScale data.value
  ).attr "fill", "green"
  refresh bars
  return

d3.select(".remove").on "click", ->
  dataSet.splice 0, 1
  bars = getBars()
  bars.exit().transition().duration(500).attr("x", 1000).remove()
  refresh bars
  return
