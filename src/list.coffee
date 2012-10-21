class @List
  @COUNT: 0
  @all: []

  constructor: (id, name) ->
    List.COUNT++
    @items = []
    @input = $('<input type="text"/>')
    @input.keyup this.save
    @id = (if (id?) then id else List.COUNT)
    (if (name?) then @input.val(name) else @input.val("List"))

    @input.attr('id', "list-#{@id}-name")
    $(".board").append(this.setUpView())

  addItem: =>
    console.log(@id)
    @items.push new Item(@id)

  setUpView: =>
    listContainer = $('<div class="list-container"></div>')
    listNameDiv = $('<div class="list-name"></div>')
    listNameDiv.append(@input)
    listItemsDiv = $('<div class="list-items"></div>')
    listItemsDiv.attr('id', "list-#{@id}-items")
    addItemDiv = $('<div class="add-item">+</div>')
    addItemDiv.click this.addItem
    listContainer.append(listNameDiv)
    listContainer.append(listItemsDiv)
    listContainer.append(addItemDiv)
    listContainer

  content: =>
    @input.val()

  save: =>
    listName = this.content()
    $.post "list.php",
      'name': listName
      'id': @id
    , (data) ->
      console.log "List save data: " + data

  @init: ->
    $.get "list.php",
      all: "true"
    , (data) ->
      data = JSON.parse data
      for i, list of data
        List.all.push new List(list['id'], list['name']);
