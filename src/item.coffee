class @Item
  constructor: (input) ->
    @input = input

  content: ->
    $(this.input).val()
