<html>
<head>
  <?php session_start(); ?>
  <meta charset="UTF-8">
  <script type="text/javascript" src = './vendor/jquery.js'></script>
  <script type="text/javascript" src = './vendor/jquery-ui.js'></script>
  <script type="text/javascript" src = './lib/item.js'></script>
  <script type="text/javascript" src = './lib/list.js'></script>
  <script type="text/javascript" src = './lib/board.js'></script>
  <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Marcellus+SC' />
  <link rel="stylesheet" href="./style/reset.css" />
  <link rel="stylesheet" href="./style/style.css" />
  <link rel="stylesheet" href="./style/board.css" />
  <link rel="stylesheet" href="./style/list.css" />
  <link rel="stylesheet" href="./style/item.css" />
  <link rel="stylesheet" href="./vendor/jquery-ui.css" />

  <title>A Simple ToDo app</title>
</head>
<body>
  <div class="h1">ToDo</div>
  <?php if ($_SESSION) : ?>
    <div class="logout"></div>
    <span class="username"><?= "Hi, " . $_SESSION['nick'] ?></span>
  <?php else : ?>
    <div class="login"></div>
  <?php endif; ?>
  <div class="board-names"></div>
  <span class="add-board">+</span>
  <div class="boards"></div>
  <div class="board-menu">
    <input type="text" class="new-board-name" placeholder="New Board Name"/>
    <br />
    <br />
    <button class="delete-board">Delete this board</button>
  </div>
  <script>
    $(document).ready(function() {
      Board.init();
      $(".add-board").click(function(){
        Board.all.push(new Board());
      });
      $(".board-menu").dialog({
        autoOpen : false,
        closeOnEscape: true,
        resizable: false
      });
      $('body').bind('click',function(e){
        if( $(".board-menu").dialog('isOpen')
         && !$(e.target).is('.ui-dialog, a')
         && !$(e.target).closest('.ui-dialog').length
        )
          $(".board-menu").dialog('close');
      });
      $(".ui-dialog-titlebar").hide()
      $(".login").click(function() {
        $('<form action="login.php?login" method="post"></form>').submit();
      });
      $(".logout").click(function(){
        if (confirm("Are you sure?")) {
          <?php session_destroy(); ?>
          $('<form action="logout.php" method="post"></form>').submit();
        }
      })
    });
  </script>
</body>
</html>
