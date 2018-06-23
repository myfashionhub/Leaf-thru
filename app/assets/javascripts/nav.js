function initDropdownMenu() {
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
    this.map = {
      // path: className
      'feed': 'feed',
      'articles': 'bookmarks',
      'customize': 'customize',
      'leafers': 'network',
      'profile': 'account',
      'about': 'about'
    };
    this.detectPage();
  };

  this.detectPage = function() {
    var pathname = window.location.pathname.replace('/', '');
    if (pathname === 'feed') {
      $('.profile .actions .feed').addClass('current');
    } else if (pathname === 'articles') {
      $('.profile .actions .bookmarks').addClass('current');
    }
    $('.nav .' + this.map[pathname]).parent().addClass('current');
  };

  this.init();
};


function TabMenu(defaultTab, contentClass) {
  this.init = function() {
    this.activateTab(defaultTab);
    this.changeTab();
  };

  this.activateTab = function(tabName) {
    $('.tabs .' + tabName).addClass('active');
    $('.' + contentClass + '.' + tabName).addClass('active');
  };

  this.changeTab = function() {
    var that = this;
    $('.tabs li').click(function(e) {
      $('.tabs .active').removeClass('active');
      $('.' + contentClass + '.active').removeClass('active');
      tabName = $(e.target).attr('class');
      that.activateTab(tabName);
    });
  };

  this.init();
}

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
