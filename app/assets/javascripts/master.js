
$(function(){

  function pieceHtml(piece){
    var pieceId
  }

  var pieceMoved = $('span#piece');
  // pieceMoved.on('mouseDown', function(){
  //   $('table#chessboard').css('z-index', '1');
  //   pieceMoved.css('z-index', '100');
  // });

  var pieceId;

  pieceMoved.mousedown(function(e){
    pieceId = $(e.target).data('id');
    console.log(pieceId);
  })

  pieceMoved.draggable({

  });

  $('td').droppable(
    { accept: pieceMoved },
    {drop: function(e){
      console.log(this.id);
      test = $.ajax({
       type: "PUT",
       url: "/pieces/" + pieceId,
       data: {coordinates: this.id}
     })
       }
    }
  )

});
