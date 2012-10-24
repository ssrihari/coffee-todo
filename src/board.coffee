class @Board
  @COUNT: 0
  @all: []

  constructor: (id) ->
    Board.COUNT++
    @lists = []
    @boardNameView = $('<span type="text" class="board-name"></span>')
    name = prompt("Enter your new Board's name:", "Board");
    @id = (if (id?) then id else Board.COUNT)
    (if (name) then @boardNameView.text(name) else @boardNameView.text("Board"))

    this.setUpView()
    this.save()

  setUpView: =>
    boardNamesDiv = $(".board-names")
    boardNamesDiv.append('<p class="board-name-separator">&nbsp|&nbsp</p>')
    boardNamesDiv.append(@boardNameView)
    @boardNameView.dblclick this.changeName
    @view = $('<div class="board"></div>')
    @view.attr('id', "board-#{@id}")
    $(".boards").append(@view)

  addList: =>
    @lists.push new List(@id)

  content: =>
    @boardNameView.text()

  changeName: =>
    name = prompt("Enter your Board's new name:", this.content());
    if name
      @boardNameView.text(name)
      this.save()


  save: =>
    boardName = this.content()
    $.post "board.php",
      'name': boardName
      'id': @id
    , (data) ->
      console.log "Board save data: " + data

  # fetchItems: =>
  #   $.get "item.php",
  #     list_id: @id
  #   , (data) =>
  #     data = JSON.parse data
  #     for i, item of data
  #       @lists.push new Item(@id, item['id'], item['data']);

  # delete: =>
  #   return unless confirm("Are you sure?")
  #   @view.remove()
  #   $.post "list.php",
  #     'delete': true
  #     'id': @id
  #   , (data) ->
  #     console.log "Board save data: " + data

  @init: ->
    Board.all.push(new Board());

  # @init: ->
  #   $.get "list.php",
  #     all: "true"
  #   , (data) ->
  #     data = JSON.parse data
  #     for i, list of data
  #       list = new Board(list['id'], list['name']);
  #       Board.all.push list
  #       list.fetchItems()
