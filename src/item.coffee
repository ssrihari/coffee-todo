class @Item
  @COUNT: 0
  @all: {}

  constructor: (id, data) ->
    Item.COUNT++
    @input = $('<input class="item" type="text"/>')
    @input.keyup this.itemChanged

    switch arguments.length
      when 0
        @id = Item.COUNT
      when 2
        @id = id
        @input.val(data)

    @input.attr('id', "item-#{@id}")
    $(".list").append(@input)

  content: ->
    $(this.input).val()

  save: ->
    console.log("save called")
    itemData = this.content()
    id = this.id
    $.post "item.php",
      data: itemData
      'id': id
    , (data) ->
      console.log "Data Loaded: " + data

  itemChanged: ->
    id = $(this).attr('id').split("-")[1]
    Item.all[id].save()

  @init: ->
    $.get "item.php",
      all: "true"
    , (data) ->
      data = JSON.parse data
      for i, item of data
        console.log(item['id']+'-'+item['data'])
        Item.all[item['id']] = new Item(item['id'], item['data']);

