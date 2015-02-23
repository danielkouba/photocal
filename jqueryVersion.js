(function($) {
  var insertPeople = function (people) {
    var $people = $('#people');
    for (var i = 0, ii = people.length; i < ii; i++) {
      var person = people[i];
      var $element = $('<li></li>').addClass(person.profession);
      $element.append('<span class="name">' + person.name + '</span>');
      $element.append('<span class="url">' + '<a href="http://' + person.url + '"> go there </a>' + '</span>');
      $element.append('<span class="date">' + person.date + '</span>');
      $people.append($element);
    }
  };

  $.getJSON('exhibits.json', insertPeople);
})(jQuery); 