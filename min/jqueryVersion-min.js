!function($){var a=function(a){for(var n=$("#people"),e=0,p=a.length;p>e;e++){var s=a[e],l=$("<li></li>").addClass(s.profession);l.append('<span class="name">'+s.name+"</span>"),l.append('<span class="url"><a href="http://'+s.url+'"> go there </a></span>'),l.append('<span class="date">'+s.date+"</span>"),n.append(l)}};$.getJSON("exhibits.json",a)}(jQuery);