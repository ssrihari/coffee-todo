class @Item
  @COUNT: 0
  @all: {}

  constructor: (id, data) ->
    Item.COUNT++
    @input = $('<input class="item" type="text"/>')
    @input.keyup this.itemChanged

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

  save: ->
    itemData = this.content()
    $.post "item.php",
      data: itemData
    , (data) ->
      alert "Data Loaded: " + data

  itemChanged: ->
    id = $(this).attr('id').split("-")[1]
    Item.all[id].save()
    console.log("save called for:"+Item.all[id].content())

  @init: ->
    $.get "item.php",
      all: "true"
    , (data) ->
      data = JSON.parse data
      for i, item of data
        console.log(item['id']+'-'+item['data'])
        Item.all[item['id']] = new Item(item['id'], item['data']);

