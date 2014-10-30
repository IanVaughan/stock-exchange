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
      data : $('#container').data('tops'),
      // [{
      //   x : Date.UTC(2011, 3, 25),
      //   title : 'H',
      //   text : 'Euro Contained by Channel Resistance'
      // }, {
      //   x : Date.UTC(2011, 3, 28),
      //   title : 'G',
      //   text : 'EURUSD: Bulls Clear Path to 1.50 Figure'
      // }],
      onSeries : 'dataseries',
      shape : 'circlepin',
      width : 16
    }]
  });
});
