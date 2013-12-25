$('document').ready ->
  $('#file_tree').fileTree({
    root: '/',
    script: '/file/list_directory',
    expandSpeed: -1,
    collapseSpeed: -1,
    multiFolder: false
  }, (file) ->
    alert(file)
  )
