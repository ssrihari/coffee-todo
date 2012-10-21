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
