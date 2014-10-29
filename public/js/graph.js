$(function () {
  $('#container').highcharts('StockChart', {

    rangeSelector : {
      selected : 1
    },

    title : {
      text : 'Test Stock Chart'
    },

    series : [{
      name : 'SE5E',
      data : $('#container').data('points'),
      tooltip: {
        valueDecimals: 1
      }
    }]
  });
});
