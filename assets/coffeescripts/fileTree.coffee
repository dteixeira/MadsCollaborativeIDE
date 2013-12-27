$('document').ready ->
  path = window.location.pathname
  project = path.substr(path.lastIndexOf('/') + 1)
  $('#file_tree').fileTree({
    root: '/',
    script: '/project/list_directory/' + project,
    expandSpeed: -1,
    collapseSpeed: -1,
    multiFolder: false
  }, window.load_file)
