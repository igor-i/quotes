import React from 'react';
import ReactDOM from 'react-dom';
import { ActionCableProvider } from 'react-actioncable-provider';
import { API_WS_ROOT } from '../constants';
import Rate from '../components/Rate';

document.addEventListener('DOMContentLoaded', () => {
  const cable = ActionCable.createConsumer(API_WS_ROOT);

  ReactDOM.render(
    <ActionCableProvider cable={cable}>
      <Rate />
    </ActionCableProvider>,
    document.getElementById('rate')
  )
})
