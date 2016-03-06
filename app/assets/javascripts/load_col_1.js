
function loadIndexResponse(response) {
  hideHomeIndex();
  col1BackButton();

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

function hideHomeIndex() {
  var time = 1000
  var delayed = time + 2000

  $('#home_index').hide(time);
  $('.home_col').css('display','table-cell');
}

function createListItem(object) {
  var class_name = classNameSetter( object.class_name.toLowerCase() );
  var path = pathSetter( object, class_name );

  if( class_name == 'resources' ) {
    return('<li><a class="js_objects" href="http://' + object.url + '">' + object.name + '</li>');
  }else if( class_name != 'users' ) {
    var return_var;

    // checks length of path to attach correct id for event listeners
    if( path.match(/\//g).length < 3 ) {
      return_var = ('<li><a class="index_link js_objects" id="' + object.id + '" href="/' + path + '">' + object.name + '</li>');
    }else{
      return_var = ('<li><a class="col_2_link js_objects" id="' + object.id + '" href="/' + path + '">' + object.name + '</li>');
    }
    return return_var;
  }else{
    return('<li><a class="js_objects" id=' + object.id + 'href="/' + class_name + '/' + object.id + '">' + object.username + '</li>');
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

function col1BackButton() {
  $('#col_1').append('<p id="back">Back</p>');
}
