
function loadIndexResponse(response) {
  hideHomeIndex();
  col1BackButton();
  appendCreateButton('#col_1', response);

  if(response.categories){
    $.each($(response.categories), function(i, object) {
      $('#col_1').prepend(createListItem(object));
    });
  }else if(response.subjects){
    $.each($(response.subjects), function(i, object) {
      $('#col_1').prepend(createListItem(object));
    });
  }else if(response.resources){
    $.each($(response.resources), function(i, object) {
      $('#col_1').prepend(createListItem(object));
    });
  }else{
    $.each($(response.users), function(i, object) {
      $('#col_1').prepend(createListItem(object));
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

  if( class_name != 'users' ) {
    var className = classNameSetter(object.class_name.toLowerCase() );
    var return_var;

    // for subjects and categories list items
    if (className == 'categories') {
      return_var = ('id="' + object.id + '" href="/' + path + '">' + object.name + '</a>' + '<a class="edit" id="' + object.id + '" href="/' + className + '/' + object.id + '/edit' + '" >Edit ' + object.name + ' <br>(for Legend & Master only)</a>');
    }else if(className == 'subjects'){
      return_var = ('id="' + object.id + '" href="/' + path + '">' + object.name + '</a>' + '<a class="edit" id="' + object.id + '" href="/categories/' + object.category_id + '/' + className + '/' + object.id + '/edit' + '" >Edit ' + object.name + ' <br>(for Legend & Master only)</a>');
    }else if(className == 'resources'){
      return_var = ('id="' + object.id + '" href="/' + path + '">' + object.name + '</a>' + '<a class="edit" id="' + object.id + '" href="/categories/' + object.category.id + '/subjects/' + object.subject_id + '/' + className + '/' + object.id + '/edit' + '" >Edit ' + object.name + ' <br>(for Legend & Master only)</a>');
    }

    // checks length of path to attach correct id for event listeners
    if(path.match(/\//g).length < 3) {
      return_var = ('<a class="index_link js_objects" ' + return_var);
    }else if( path.match(/\//g).length < 5 ) {
      return_var = ('<a class="col_2_link js_objects" ' + return_var);
    }else{
      return_var = ('<a class="col_3_link js_objects" ' + return_var);
    }
    return return_var;
  }else{
    // users link
    return('<a class="js_objects" id=' + object.id + 'href="/' + class_name + '/' + object.id + '">' + object.username + '</a>');
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
    return( 'categories/' + object.category_id + '/' + class_name + "/" + object.id );
  }else if( class_name == 'categories' ) {
    return( class_name + '/' + object.id );
  }else if( class_name == 'resources' ) {
    return( 'categories/' + object.category.id + '/subjects/' + object.subject_id + '/' + class_name + "/" + object.id );
  }
}

function col1BackButton() {
  $('#col_1').append('<p id="back">Back</p>');
}
