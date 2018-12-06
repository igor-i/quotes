import React from 'react';
import { ActionCable } from 'react-actioncable-provider';
import { API_ROOT } from '../constants';

class App extends React.Component {
  state = {
    rate_data: {
      currency_pair: null,
      state: null,
      current_rate: {
        rate: null,
        updated_at: null,
      },
    },
  };

  componentDidMount = () => {
    fetch(`${API_ROOT}/current_rate`)
      .then(res => res.json())
      .then(rate_data => this.setState({ rate_data }));
  };

  handleReceivedRate = ({ rate_data }) => {
    this.setState({ rate_data });
  };

  render = () => {
    console.log(JSON.stringify(this.state));
    const { rate_data: { currency_pair, state, current_rate: { rate, updated_at } } } = this.state;

    const cardStyle = {
      maxWidth: '25rem',
    };

    return (
      <div className='card bg-light mb-3' style={cardStyle}>
        <ActionCable
          channel={{ channel: 'RateChannel' }}
          onReceived={this.handleReceivedRate}
        />
	<div className='card-header'>{currency_pair}</div>
	<div className='card-body card-text display-1'>{rate}</div>
	<div className='card-footer'>
	  <small className='text-muted'>Last updated at: {updated_at}</small>
	  <br />
	  <small className='text-muted'>Current state: {state}</small>
        </div>
      </div>
    );
  };
}

export default App;
