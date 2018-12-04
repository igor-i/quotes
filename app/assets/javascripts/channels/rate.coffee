App.rate = App.cable.subscriptions.create "RateChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (rate_data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#rate_data').append rate_data['rate_data']

