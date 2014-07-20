function getPublications() {
  $.ajax({
    url: '/publications',
    method: 'get',
    dataType: 'json',
    success: showCategories
  });
}

function showCategories(data) {
  for (var i = 0; i < data.length; i++) {
    var div      = $('<div>').addClass('category');
    var category = $('<h4>').html(data[i].cat);
    var pubUl    = $('<ul>');
    for (var j = 0; j < data[i].pubs.length; j++) {
      var pubs = data[i].pubs;
      var pub  = $('<li>').html(pubs[j].name);
      pub.attr('data', pubs[j].id).appendTo(pubUl);
    }
    div.append(category).append(pubUl);
    $('.categories').append(div);
  }
  togglePublications();
}

function togglePublications() {
  $('.category').find('ul').hide();
  var firstCat = $('.categories').children().first();
  firstCat.find('h4').addClass('current');
  firstCat.find('ul').clone().appendTo($('.publications')).show();
  subscriptionBuilder();

  $('.category h4').click(function(e) {
    $('.current').removeClass('current');
    $(e.target).addClass('current');
    var pubUl = $(e.target).parent().find('ul');
    $('.publications').empty();
    pubUl.clone().appendTo($('.publications')).hide().toggle('fold');
    subscriptionBuilder();
  });
  subscriptionBuilder();
}


function updateSubscription() {
  var pubs    = $('.current-sub li');
  var pub_ids = [];
  for (var i = 0; i < pubs.length; i++) {
    pub_ids.push($(pubs[i]).attr('data'));
  }

  $.ajax({
    url: '/subscriptions',
    method: 'post',
    dataType: 'json',
    data: { pub_ids: pub_ids },
    success: function(data) {
      $('.notify').html(data['msg']);
      notify();
    }
  });
}

function currentSubscription() {
  $.ajax({
    url: '/subscriptions',
    method: 'get',
    dataType: 'json',
    success: function(data) {
      for (i = 0; i < data.length; i++) {
        var pub = $('<li>').html(data[i].name).attr('data', data[i].id);
        $(pub).append('<i class="fa fa-times"></i>');
        $('.current-sub ul').append(pub);
        $('i').click(function(e) {
          $(e.target).parent().remove();
        });
      }
    }
  });
}

function updateProfile() {
  var email    = $('#reader_email').val();
  var password = $('#reader_password').val();
  var name     = $('#reader_name').val();
  var image    = $('#reader_image').val();

  $.ajax({
    url: '/profile',
    method: 'post',
    dataType: 'json',
    data: { reader: { email: email, password: password, name: name, image: image } },
    success: function(data) {
      $('.notify').html(data['msg']);
      notify();
    }
  })
}

function subscriptionBuilder() {
  var pubs = $('.publications li');
  pubs.draggable({ cursor: 'move', helper: 'clone' });

  $('.current-sub').droppable({
    drop: function(e, dropped) {
      var pubLi = dropped.draggable;
      $(pubLi).append('<i class="fa fa-times"></i>');
      $(pubLi).appendTo($('.current-sub ul'));
      removeSubscription();
    }
  });
}

function removeSubscription() {
  $('i').click(function(e) {
    var pubLi = $(e.target).parent();
    pubLi.remove();
  });
}
