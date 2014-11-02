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
      name : 'high',
      data : $('#container').data('high'),
      id : 'dataseries'
    }, {
      name : 'open',
      data :  $('#container').data('open'),
    }, {
      name : 'close',
      data :  $('#container').data('close'),
    }, {
      name : 'low',
      data :  $('#container').data('low'),
    }, {
      name : '20 Day',
      data :  $('#container').data('avg20d'),
    }, {
      name : '50 Day',
      data :  $('#container').data('avg50d'),
    }, {
      type : 'flags',
      data : $('#container').data('collections'),
      onSeries : 'dataseries',
      shape : 'squarepin',
      width : 16
    }]
  });
});
