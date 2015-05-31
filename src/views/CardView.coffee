class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src=<%= imgPath %>>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('img').attr 'src', 'img/card-back.png' unless @model.get 'revealed'
    if !@model.get 'animated'
      @$('img').css('-webkit-animation', 'reveal 2s') 
      @model.set 'animated', true