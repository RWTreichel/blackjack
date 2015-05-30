class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <div class="status"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit() if !@model.get('playerLost') and !@model.get('standButtonClicked')
    'click .stand-button': ->
      if !@model.get('playerLost') and !@model.get('dealerLost')
        @model.set('standButtonClicked', true)
        @model.get('playerHand').stand()

  initialize: ->
    @model.on 'change:playerLost change:dealerLost', =>
      @render()
    @render()
    @$('.status').text 'Ongoing'

  render: ->
    @$el.children().detach()
    @$el.html @template @model
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.status').text 'You lose' if @model.get('playerLost')
    @$('.status').text 'You win' if @model.get('dealerLost')