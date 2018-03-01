// Require a chart variable
// Args
//    value: Value that will be pushed in the chart
//    length: The actual length of the dataset array
//    max: The max amount of value allowed in the dataset

function addRefresh(value, length=30, max=30) {
  var label = moment().format('h:mm:ss')
  // When the max amount is reached start to shift the data
  if (length > max) {
    chart.data.labels.shift();
    chart.data.datasets[0].data.shift();
  }
  // Updates the chart and label
    chart.data.labels.push(label);
    chart.data.datasets[0].data.push(value);
    chart.update();
}

//Function initChart
//  initiate a new chart object
//Args
//  canvasId: identifier of the canvas html objet where the chart will be drew
//  chartData: An array with the initials values
//  datasetLabel: Name of the dataset and legend
//  lineColor: Color eg.: 'rgba(0,0,132,1)'
function initLineChart(
  canvasId, 
  chartData, 
  datasetLabel, 
  dates_array, 
  goalData,
  min_y,
  max_y,
  lineColor = 'rgba(0,0,132,1)'){

  var ctx = document.getElementById(canvasId);
  var new_chart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: dates_array,
        datasets: [{
          label: datasetLabel,
          data: chartData,
          fill: false,
          borderColor: lineColor,
          borderWidth: 2,
          pointStyle: 'rect',
          pointBackgroundColor: lineColor
        }, {
          label: 'Goal',
          data: goalData,
          borderColor: 'red',
          borderWidth: 1,
          borderDash: [ 5, 10 ],
          fill: false
        }]
    },
    options: {
      tooltips: {
        intersect: false
      },
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: false,
            min: min_y,
            max: max_y
          }
        }],
        xAxes: [{
          gridLines: {
            display: false
          },
          ticks: {
            autoSkip: true,
            maxTicksLimit: 7
          }
        }]
      },
      responsive: true,
      legend: {
        display: false
      },
      title: {
        display: true,
        text: "Diet Progress"
      }
    }
  });

  return new_chart;
}
// Fcuntion setAnotationPlugin
//    Initiate the label anotation plugin
// Args:
//    showAll: it determines whether to show or not label in every point.
function setAnotationPlugin(showAll = false) {
  Chart.plugins.register({
  afterDatasetsDraw: function(chart, easing) {
    // To only draw at the end of animation, check for easing === 1
    var ctx = chart.ctx;

    chart.data.datasets.forEach(function (dataset, i) {
      var meta = chart.getDatasetMeta(i);

      if (!meta.hidden) {
      meta.data.forEach(function(element, index) {
          // Draw the text in black, with the specified font
          ctx.fillStyle = 'rgb(0, 0, 0)';

          var fontSize = 16;
          var fontStyle = 'normal';
          var fontFamily = 'Helvetica Neue';
          ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily);

        if (showAll || dataset.data.length -1 == index) {
          // Just naively convert to string for now
          // Can transform the datastring here. Eg.: Set a Currency symbol
          var dataString = dataset.data[index].toString();

          // Make sure alignment settings are correct
          ctx.textAlign = 'center';
          ctx.textBaseline = 'middle';

          var padding = 20;
          var position = element.tooltipPosition();
          // Can use padding to adjust position of the label relatively to
          // chart point
          ctx.fillText(
            dataString, position.x - padding, position.y - (fontSize / 2));
        }
            //End if
        });
      }
    });
  }
  });
}
