class @List
  @COUNT: 0
  @DEFAULT_NAME: "List"

  constructor: (board_id, id, name) ->
    #TODO Refactor to fit pattern as in Board
    List.COUNT++
    @board_id = board_id
    @items = []
    @setUpName(name)
    @id = if id? then id else List.COUNT

    @view = @setUpView()
    $("#board-#{@board_id}").append(@view)
    @save()

  setUpName:(name) =>
    @name = $('<input type="text"/>')
    @name.keyup @save
    if name? then @name.val(name) else @name.val(List.DEFAULT_NAME)
    console.log "this is default name :" + @DEFAULT_NAME
    console.log "set name is:" + @name.val()
    @name.attr('id', "list-#{@id}-name")

  setUpView: =>
    listContainer = $('<div class="list-container"></div>')
    listDeleteDiv = $('<div class="list-delete"><p>x</p></div>')
    listDeleteDiv.click @delete
    listNameDiv = $('<div class="list-name"></div>')
    listNameDiv.append(@name)
    listItemsDiv = $('<div class="list-items"></div>')
    listItemsDiv.attr('id', "list-#{@id}-items")
    addItemDiv = $('<div class="add-item">+</div>')
    addItemDiv.click @addItem
    listContainer.append(listDeleteDiv)
    listContainer.append(listNameDiv)
    listContainer.append(listItemsDiv)
    listContainer.append(addItemDiv)
    listContainer

  addItem: =>
    console.log(@id)
    @items.push new Item(@id)

  content: =>
    @name.val()

  save: =>
    listName = @content()
    $.post "list.php",
      'name': listName
      'id': @id
      'board_id': @board_id
    , (data) ->
      console.log "List save data: " + data

  fetchItems: =>
    $.get "item.php",
      list_id: @id
    , (data) =>
      data = JSON.parse data
      for i, item of data
        @items.push new Item(@id, item['id'], item['data']);

  delete: =>
    return unless confirm("Are you sure?")
    @view.remove()
    $.post "list.php",
      'delete': true
      'id': @id
    , (data) ->
      console.log "List save data: " + data
