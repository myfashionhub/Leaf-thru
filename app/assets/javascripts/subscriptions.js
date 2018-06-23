var Subscriptions = function() {

  this.init = function() {
    var that = this;

    this.getReaderSubscriptions();
    this.getAllPublications();

    $('nav li a').first().addClass('current');

    $('#update-sub').on('click', function() {
      that.updateSubscriptions();
    });
  };

  this.getReaderSubscriptions = function() {
    $.ajax({
      url: '/subscriptions',
      method: 'get',
      dataType: 'json',
      success: function(data) {
        $('.current-sub ul').empty();

        for (i = 0; i < data.length; i++) {
          var pub = $('<li>').html(data[i].name).attr('data', data[i].id);
          $(pub).append('<i class="fa fa-times"></i>');
          
          $('.current-sub ul').append(pub);
          $('.current-sub i').click(function(e) {
            $(e.target).parent().remove();
          });
        }
      }
    });
  };


  this.getAllPublications = function() {
    var that = this;

    $.ajax({
      url: '/publications',
      method: 'get',
      dataType: 'json',
      success: function(data) {
        that.populateCategories(data);
      }  
    });
  };


  this.toggleCategory = function() {
    var that = this,
        firstCat = $('.categories').children().first();

    $('.category').find('ul').hide();
    $('.publications div').empty();
    
    firstCat.find('h4').addClass('current');
    firstCat.find('ul').clone().appendTo($('.publications div')).show();
    this.subscriptionBuilder();  

    $('.category h4').click(function(e) {
      $('.category h4.current').removeClass('current');
      $(e.target).addClass('current');
      var pubUl = $(e.target).parent().find('ul');
      $('.publications div').empty();
      pubUl.clone().appendTo($('.publications div')).hide().toggle('fold');
      that.subscriptionBuilder();
    });
    
    this.subscriptionBuilder();
  };

  this.populateCategories = function(data) {
    var that = this;
    $('ul.categories').empty();

    for (var i = 0; i < data.length; i++) {
      var div      = $('<div>').addClass('category');
      var category = $('<h4>').html(data[i].cat);
      var pubUl    = $('<ul>');
      for (var j = 0; j < data[i].pubs.length; j++) {
        var pubs = data[i].pubs;
        var pub  = $('<li>').html(pubs[j].name + "<i class='fa fa-plus'></i>");
        pub.attr('data', pubs[j].id).appendTo(pubUl);
      }
      div.append(category).append(pubUl);
      $('ul.categories').append(div);
    }

    this.toggleCategory();
  };

  this.subscriptionBuilder = function() {
    var that = this,
        pubs = $('.publications li');
    pubs.draggable({ cursor: 'move', helper: 'clone' });  

    $('.current-sub').droppable({
      drop: function(e, dropped) {
        var pubLi = dropped.draggable;
        $(pubLi).append('<i class="fa fa-times"></i>');
        $(pubLi).appendTo($('.current-sub ul'));
        that.removeSubscription();
      }
    });  

    $('.publications i').click(function(e) {
      var pubLi = $(e.target).parent();
      pubLi.find('i').remove();
      pubLi.append('<i class="fa fa-times"></i>');
      pubLi.appendTo($('.current-sub ul'));
      that.removeSubscription();
    });
  };

  this.removeSubscription = function() {
    $('.current-sub i').click(function(e) {
      var pubLi = $(e.target).parent();
      pubLi.remove();
    });
  };

  this.updateSubscriptions = function() {
    var that = this;
    var pubs    = $('.current-sub li'),
        pub_ids = [];
    for (var i = 0; i < pubs.length; i++) {
      pub_ids.push($(pubs[i]).attr('data'));
    }  

    $.ajax({
      url: '/subscriptions',
      method: 'post',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      dataType: 'json',
      data: { pub_ids: pub_ids },
      success: function(data) {
        notify(data['msg'], 'success');
        
        setTimeout(function() {
          window.profileDialog.close();
        }, 2000);
        setTimeout(function() {
          refreshFeed('rss')
        }, 2500);
      }
    });
  };

  this.init();
}
