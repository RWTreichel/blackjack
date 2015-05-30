# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerLost', false
    @set 'standButtonClicked', false
    @get('playerHand').on 'hit', =>
      #Get hand score
      score = @get('playerHand').scores()[0]
      #if hand score > 21
      @set('playerLost', true) if score > 21
    @get('playerHand').on 'stand', =>
      #score = @get('dealerHand').scores()[0]
      @get('dealerHand').hit() while @get('dealerHand').scores()[0] < 17