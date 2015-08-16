function dropdownMenu() {
  $('.menu #arrow').click(function() {
    $('.menu .nav').toggle('blind')
  });

  $('.menu .nav').children().click(function() {
    $('.menu .nav').removeClass('active');
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
    var section = $(e.target).parent().attr('data-section') + '-edit';
    $('.'+section).addClass('current');

    this.open();
  };

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
