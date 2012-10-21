class @Item
  @COUNT: 0

  constructor: (listID, id, data) ->
    Item.COUNT++
    @listID = listID
    @id = (if (id?) then id else Item.COUNT)
    @input = $('<input type="text"/>')
    @input.attr('id', "list-#{@listID}-item-#{@id}")
    @input.val(data) if data?
    @input.keyup this.save

    inputDiv = $('<div class="item"></div>')
    inputDiv.append(@input)
    $("#list-#{@listID}-items").append(inputDiv)

  content: ->
    $(this.input).val()

  save: =>
    console.log("save called")
    itemData = this.content()
    $.post "item.php",
      data: itemData
      'id': @id
      'list_id': @listID
    , (data) ->
      console.log "Data Loaded: " + data

  @init: ->
    $.get "item.php",
      all: "true"
    , (data) ->
      data = JSON.parse data
      for i, item of data
        console.log(item['id']+'-'+item['data'])
        Item.all[item['id']] = new Item(item['id'], item['data']);

