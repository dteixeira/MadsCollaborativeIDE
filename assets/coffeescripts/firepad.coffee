$('document').ready ->
  firepadRef = new Firebase('https://mads.firebaseio.com/')
  codeMirror = CodeMirror(document.getElementById('firepad'), {
    lineWrapping: false,
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true
  })
  firepad = Firepad.fromCodeMirror(firepadRef, codeMirror, {})
