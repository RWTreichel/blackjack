# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerLost', false
    @set 'dealerLost', false
    @set 'standButtonClicked', false
    @get('playerHand').on 'hit', =>
      #Get hand score
      score = @get('playerHand').scores()[0]
      #if hand score > 21
      @set('playerLost', true) if score > 21
    @get('playerHand').on 'stand', =>
      @get('dealerHand').first().flip()
      @get('dealerHand').hit() while @get('dealerHand').scores()[0] < 17
      if @get('dealerHand').scores()[0] > 21
        @set('dealerLost', true) 
      else
        @set('playerLost', if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0] then true else false)
        @set('dealerLost', if @get('dealerHand').scores()[0] < @get('playerHand').scores()[0] then true else false)
