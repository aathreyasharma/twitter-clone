//= require_tree
//= require jquery
//= require rails-ujs


$(document).ready(function () {
  $(document).on('click', ".fa-thumbs-up", function () {
    is_liked = JSON.parse($(this).hasClass('liked'))
    obj_type = $(this).data('object-type');
    obj_id = $(this).data('object-id')
    $.ajax({
      type: 'GET',
      url: '/likes/toggle_likes',
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: {
        obj_type: obj_type,
        obj_id: obj_id,
        like: is_liked
      },
      success: function (data) {
        id = obj_type.toLowerCase() + '_' + obj_id
        $("#" + id).html('').append(data['likes_count'])
        //debugger
        if(is_liked) {
          $('#thumb_' + id).removeClass('liked')
        } else {
          $('#thumb_' + id).addClass('liked')
        }
      }
    });
  })
})
