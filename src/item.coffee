class @Item
  @COUNT: 0

  constructor: (id, data) ->
    Item.COUNT++
    @input = $('<input class="item" type="text"/>')
    switch arguments.length
      when 0
        @input.attr('id', "item-#{Item.COUNT}")
        $(".list").append(@input)
      when 2
        @input.attr('id', "item-#{id}")
        @input.val(data)
        $(".list").append(@input)


  content: ->
    $(this.input).val()

  @init: ->
    $.get "item.php",
      all: "true"
    , (data) ->
      data = JSON.parse data
      for i, item of data
        console.log(item['id']+'-'+item['data'])
        new Item(item['id'], item['data'])

