class @Item
  @COUNT: 0
  constructor: () ->
    @input = $('<input class="item" type="text"/>')
    @input.attr('id', "item-#{Item.COUNT++}")
    $(".list").append(@input)

  content: ->
    $(this.input).val()
