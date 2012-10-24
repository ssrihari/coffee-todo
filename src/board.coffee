class @Board
  @COUNT: 0
  @all: []

  constructor: (id, name) ->
    Board.COUNT++
    @lists = []
    @boardNameView = $('<span type="text" class="board-name"></span>')
    @id = (if (id?) then id else Board.COUNT)

    name = prompt("Enter your new Board's name:", "Board") unless name
    (if (name) then @boardNameView.text(name) else @boardNameView.text("Board"))

    this.setUpView()
    this.save()

  setUpView: =>
    boardNamesDiv = $(".board-names")
    boardNamesDiv.append('<p class="board-name-separator">&nbsp|&nbsp</p>')
    boardNamesDiv.append(@boardNameView)
    @boardNameView.dblclick this.changeName
    @boardNameView.click this.makeActive
    @view = $('<div class="board"></div>')
    @view.attr('id', "board-#{@id}")
    addListView = $('<span class="add-list">+</span>')
    @view.append(addListView)
    addListView.click this.addList
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

  fetchLists: =>
    $.get "list.php",
      board_id: @id
      all: "true"
    , (data) =>
      data = JSON.parse data
      for i, list of data
        list = new List(@id, list['id'], list['name']);
        @lists.push list
        list.fetchItems()

  makeActive: =>
    for board in Board.all
      board.view.hide()
      board.boardNameView.removeClass('active')
    @view.show()
    @boardNameView.addClass('active')
    console.log("Board #{@id} is now active")

  # delete: =>
  #   return unless confirm("Are you sure?")
  #   @view.remove()
  #   $.post "list.php",
  #     'delete': true
  #     'id': @id
  #   , (data) ->
  #     console.log "Board save data: " + data

  @init: ->
    $.get "board.php",
      all: "true"
    , (data) ->
      data = JSON.parse data
      for i, board of data
        board = new Board(board['id'], board['name']);
        Board.all.push board
        board.fetchLists()
      Board.all[0].makeActive()
