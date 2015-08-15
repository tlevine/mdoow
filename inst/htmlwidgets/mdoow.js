
HTMLWidgets.widget({
  name: "mdoow",
  type: "output",
  renderValue: function(el, data) {
    $(el).sparkline(data.values, data.options);
  }
})
