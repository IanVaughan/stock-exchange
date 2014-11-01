$(function () {
  $('#container').highcharts('StockChart', {

    rangeSelector : {
      selected : 1
    },

    title : {
      text : 'Test Stock Chart'
    },

    xAxis: {
      type: 'datetime',
      tickInterval: 3600 * 1000,
    },

    series : [{
      name : 'SE5E',
      pointInterval:  3600 * 1000,
      data : $('#container').data('points'),
      tooltip: {
        valueDecimals: 1
      },
      id : 'dataseries'
    }, {
      type : 'flags',
      data : $('#container').data('collections'),
      onSeries : 'dataseries',
      shape : 'squarepin',
      width : 16
    }]
  });
});
