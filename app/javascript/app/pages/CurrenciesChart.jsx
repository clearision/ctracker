import React, { Component } from 'react'
import Chart from 'chart.js'

class CurrenciesChart extends Component {
  componentDidUpdate() {
    var ctx = document.getElementById('currenciesChart').getContext('2d')
    new Chart(ctx, {
      type: 'line',
      data: {
          labels: this.props.labels,
          datasets: [{
              label: 'Collected currencies',
              data: this.props.data,
              borderWidth: 1
          }]
      },
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: true
                  }
              }]
          }
      }
    })
  }

  render() {
    return (
      <canvas id="currenciesChart" />
    )
  }
}

export default CurrenciesChart
