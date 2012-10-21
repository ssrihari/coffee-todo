class @List
  @COUNT: 0
  @all: {}

  constructor: (id, name) ->
    List.COUNT++
    @items = []
    @input = $('<input type="text"/>')
    @input.keyup this.listNameChanged

    switch arguments.length
      when 0
        @id = List.COUNT
        @input.val('List')
      when 2
        @id = id
        @input.val(name)

    # TODO refactor following into a set up method
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
    # TODO convert following to class instead of id
    addItemDiv = $('<div class="add-item">+</div>')
    addItemDiv.click this.addItem
    listContainer.append(listNameDiv)
    listContainer.append(listItemsDiv)
    listContainer.append(addItemDiv)
    listContainer

  content: ->
    $(this.input).val()

  save: ->
    # console.log("save called")
    # listData = this.content()
    # id = this.id
    # $.post "list.php",
    #   data: listData
    #   'id': id
    # , (data) ->
    #   console.log "Data Loaded: " + data

  listNameChanged: ->
    # id = $(this).attr('id').split("-")[1]
    # List.all[id].save()

  @init: ->
    List.all[1] = new List()
    # Item.init()
    # $.get "list.php",
    #   all: "true"
    # , (data) ->
    #   data = JSON.parse data
    #   for i, list of data
    #     console.log(list['id']+'-'+list['data'])
    #     List.all[list['id']] = new List(list['id'], list['data']);

