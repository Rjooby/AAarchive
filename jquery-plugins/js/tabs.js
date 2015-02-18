(function() {
  if (typeof Tabs === "undefined"){
    window.Tabs = {};
  }

  $.Tabs = function (el) {
    this.$el = $(el);
    this.$contentTabs = $(this.$el.data("content-tabs"));
    this.$activeTab = this.$contentTabs.find(".active");
    this.$el.on('click', 'a', function(){
      this.clickTab(event);
    }.bind(this));
  };

  $.Tabs.prototype.clickTab = function(event){

    event.preventDefault();

    //remove active from old link
    this.$el.find("a").removeClass("active");

    //add active to clicked link
    var $clicked = $(event.target);
    $clicked.addClass("active");

    var newActiveSel = $clicked.attr("href");
    var $newActiveTab = this.$contentTabs.find(newActiveSel);

    //remove active from old tab
    this.$activeTab.removeClass("active");
    this.$activeTab.addClass("transitioning");
    this.$activeTab.one("transitionend", function(){
      this.$activeTab.removeClass("transitioning");
      $newActiveTab.addClass("active transitioning");
      setTimeout(function(){
        $newActiveTab.removeClass("transitioning");
      }, 0);
      this.$activeTab = $newActiveTab;
    }.bind(this));
    //add active to new tab
  }


  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };




}());
