$('document').ready ->

  # Create empty Codemirror instance.
  codeMirror = CodeMirror(document.getElementById('firepad'), {
    lineWrapping: false,
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true,
    mode: 'ruby'
  })

  # Destroy the Firepad connection.
  dispose_fp = () ->
    if firepad?
      firepad.dispose()
      firepad = null
    if codeMirror?
      codeMirror.setValue('')
      codeMirror.clearHistory()

  # Setup theme change.
  $('#theme_select').change ->
    theme = $('#theme_select option:selected').text()
    codeMirror.setOption("theme", theme)

  # Setup mode change.
  $('#mode_select').change ->
    mode = $('#mode_select option:selected').text()
    codeMirror.setOption("mode", mode)

  # File loading function
  window.load_file = (file) ->

    # Retrieve the file's hash.
    $.post(
      '/file/file_hash',
      { file: file },
      (data) ->
        json = $.parseJSON(data)
        if !json['success']
          alert('Invalid file')
        else

          # Dispose of current connection and editor.
          dispose_fp()

          # Build Firebase connection.
          url = 'https://mads.firebaseio.com/' + json['project'] + '/' + json['hash']
          firepadRef = new Firebase(url)
          firepad = Firepad.fromCodeMirror(firepadRef, codeMirror, { userId: "" })

          # Create user list.
          firepadUserList = FirepadUserList.fromDiv(firepadRef.child('users'),
            document.getElementById('userlist'), "")

          # First time initialization; if the history
          # is empty (new file) load the files contents
          # from disk.
          firepad.on('ready', () ->
            if firepad.isHistoryEmpty()
              $.post(
                '/file/load_file',
                { file: file },
                (content) ->
                  json = $.parseJSON(content)
                  if json['success']
                    firepad.setText(json['content'])
              )
          )
    )
