function dropdownMenu() {
  $('.menu #expand').click(function() {
    $('.menu .nav').toggle('blind');
  });

  $('.menu .nav a').click(function() {
    $('.menu .nav').toggle('blind');
  });
}

function loginToggle() {
  $('.signup').hide();
  $('#login').addClass('current');

  $('.form-wrapper span').click(function(e) {
    $('.current').removeClass('current');
    $(e.target).addClass('current');
    var action = $(e.target).attr('id');

    $('.form div').hide();
    $('.'+action).fadeIn('slow');
  });
}


var Dialog = function(element) {
  this.element = element;

  this.init = function() {
    var that = this;

    this.element.find('.close').click(function() {
      that.close();
    });

    $('.profile-link').click(function(e) {
      that.showSection(e);
    });
  };

  this.open = function() {
    this.element.addClass('active');
    $('.overlay').addClass('active');
  };

  this.close = function() {
    this.element.removeClass('active');
    $('.overlay').removeClass('active');
  };

  this.showSection = function(e) {
    var that = this;
    var section = $(e.target).attr('data-section');
    $('section.current').removeClass('current');
    $('.'+section+'-edit').addClass('current');

    this.open();
  };

  this.init();
};

var Navigation = function() {
  this.init = function() {
    this.detectPage();
  };

  this.detectPage = function() {
    var pathname = window.location.pathname;
    if (pathname === '/feed') {
      $('.profile .actions .feed').addClass('current');
    } else if (pathname === '/articles') {
      $('.profile .actions .bookmarks').addClass('current');
    }

  }

  this.init();

};


// HELPERS
function notify(msg, status) {
  var div;
  if (status === 'success') {
    div = $('.notify');
  } else if (status === 'error') {
    div = $('.alert');
  }

  div.html(msg).fadeIn();
  setTimeout(function() {
    div.fadeOut();
  }, 3000);
}
