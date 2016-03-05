
function loadIndexResponse(response) {
  clearForIndex();

  if(response.categories){
    $.each($(response.categories), function(i, object) {
      $('#col_1_list').append(createListItem(object));
    });
  }else if(response.subjects){
    $.each($(response.subjects), function(i, object) {
      $('#col_1_list').append(createListItem(object));
    });
  }else if(response.resources){
    $.each($(response.resources), function(i, object) {
      $('#col_1_list').append(createListItem(object));
    });
  }else{
    $.each($(response.users), function(i, object) {
      $('#col_1_list').append(createListItem(object));
    });
  }
}

function clearForIndex() {
  var newList = document.createElement('ul');
  newList.setAttribute('id', 'col_1_list');

  $('#col_1').html(newList);
}

function createListItem(object) {
  var class_name = classNameSetter( object.class_name.toLowerCase() );
  var path = pathSetter( object, class_name )
debugger;
  if( class_name == 'resources' ) {
    return('<li><a href="http://' + object.url + '">' + object.name + '</li>')
  }else if( class_name != 'users' ) {
    return('<li><a class="index_link" id="' + object.id + '" href="/' + path + '">' + object.name + '</li>')
  }else{
    return('<li><a id=' + object.id + 'href="/' + class_name + '/' + object.id + '">' + object.username + '</li>')
  }
}

function classNameSetter(class_name) {

  if ( class_name == "category" ) {
    class_name = 'categories';
  }else{
    class_name = class_name + 's';
  }
  return class_name;
}

function pathSetter( object, class_name ) {
  if( class_name == 'subjects' ) {
    return( 'categories/' + object.category_id + '/' + class_name + "/" + object.id )
  }else if( class_name == 'categories' ) {
    return( class_name + '/' + object.id )
  }
}
