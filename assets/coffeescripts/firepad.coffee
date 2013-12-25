$('document').ready ->

  # Launch Firepad.
  firepadRef = new Firebase('https://mads.firebaseio.com/')
  codeMirror = CodeMirror(document.getElementById('firepad'), {
    lineWrapping: false,
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true,
    mode: 'ruby'
  })
  firepad = Firepad.fromCodeMirror(firepadRef, codeMirror, {})

  # Setup theme change.
  $('#theme_select').change ->
    theme = $('#theme_select option:selected').text()
    codeMirror.setOption("theme", theme)

  # Setup mode change.
  $('#mode_select').change ->
    mode = $('#mode_select option:selected').text()
    codeMirror.setOption("mode", mode)
