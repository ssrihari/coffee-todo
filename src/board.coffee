class @Board
  @COUNT: 0
  @all: []
  @DEFAULT_NAME: "Board"

  constructor: (id, name) ->
    Board.COUNT++
    @lists = []
    @boardNameView = $('<span type="text" class="board-name"></span>')
    @id = if id? then id else Board.COUNT
    @setName(name)
    @setUpView()
    @save()

  setName:(name) =>
    name = prompt("Enter your new Board's name:", "Board") unless name
    if name then @boardNameView.text(name) else @boardNameView.text(Board.DEFAULT_NAME)

  setUpView: =>
    boardNamesDiv = $(".board-names")
    boardNamesDiv.append('<p class="board-name-separator">&nbsp|&nbsp</p>')
    boardNamesDiv.append(@boardNameView)
    @boardNameView.dblclick @menu
    @boardNameView.click @makeActive
    @view = $('<div class="board"></div>')
    @view.attr('id', "board-#{@id}")
    addListView = $('<span class="add-list">+</span>')
    @view.append(addListView)
    addListView.click @addList
    $(".boards").append(@view)

  addList: =>
    @lists.push new List(@id)

  content: =>
    @boardNameView.text()

  menu: =>
    left = @boardNameView.position().left
    top = @boardNameView.position().top + @boardNameView.height() + 10
    $(".board-menu").dialog("option", { position: [left, top] })
    $("input.new-board-name").val('')
    $("input.new-board-name").keyup @changeName
    $("button.delete-board").click @delete
    $(".board-menu").dialog("open")

  changeName: (e) =>
    new_name = $(e.target).val()
    if @boardNameView.hasClass('active') && new_name
      @boardNameView.text(new_name)
      $(".board-menu").dialog({ title: "#{new_name} " })
      @save()

  save: =>
    boardName = @content()
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

  delete: =>
    if @boardNameView.hasClass('active')
      return unless confirm("Are you sure?")
      @view.remove()
      @boardNameView.remove()
      $(".board-menu").dialog("close")
      Board.all[Board.all.length - 2].makeActive()
      $.post "board.php",
        'delete': true
        'id': @id
      , (data) ->
        console.log "Board save data: " + data

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
