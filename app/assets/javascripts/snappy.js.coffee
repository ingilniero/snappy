Snappy = {}

Snappy.autoSelectSearch = ->
  window.onload = ->
    keyword = document.getElementById 'keyword'
    keyword.onclick = ->
      @select()

Snappy.autoSelectSearch()