var AdBase = function() {

  var adbaseConnectUrl = 'http://adbase.yh.com.tr/connect/'

  // You don't need to touch below.
  var zones = zones || [];
  var zonesCount = zonesCount || 0

  this.enabled = false;

  function init() {
    this.enabled = true;
    collectZones();
  }

  function addToBase(a) {
    zones.push(a);
  }

  function collectZones() {
    zonesCount = document.getElementsByClassName('adbase').length;
    getZoneContents();
  }

  function getZoneContents() {
    var b = zones.join("")
    var tag = (document.createElementNS) ? document.createElementNS('http://www.w3.org/1999/xhtml', 'script') : document.createElement('script');
    tag.type = 'text/javascript';
    tag.src = adbaseConnectUrl + b + '.js';
    document.getElementsByTagName('head')[0].appendChild(tag);
  }

  return {
    ad: function(a) {
      addToBase(a);
    },
    init: function() {
      init();
    },
    exit: function() {
      exit();
    }
  };
}();

window.onload = AdBase.init;