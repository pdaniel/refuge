$ ->
  # Tooltip init
  $("a[rel='tooltip']").tooltip()

  # Globaly turn 'http://...' strings to links
  jQuery('body').linkify()

  # Validation error messaging init
  $('.error_popover').each ->
    $(this).attr('rel','popover')
    $(this).attr('data-original-title', 'Oooops')
    $(this).attr('data-content',$(this).text())
    $(this).text('')
    $(this).popover('show')

  $('.dotoggle').click ->
    $($(this).data('block')).slideToggle()

  # Auto expandable textareas
  $('textarea.expandable').autogrow()

  # Date picker init
  $('.datepicker').datepicker
    dateFormat:'DD dd MM yy'
    altField: '#end_at'
    altFormat: 'yy-mm-dd'

  # Modal mail form
  $('.mail_me').click ->
    $('#recipient').html $(this).data('recipient')
    $('#recipient_id').val $(this).data('recipient_id')

  $('#remove_logo').click ->
    if confirm $(this).attr('data-message')
      $('.logo').empty()
      $('#logo_reset').val('true')
    return false

  $('li[data-do="switch_view_as_user"]').click ->
    if $(this).data('value') == true
      post_to_url('/members/1', {'user[view_as_user]':'true'}, 'put')
    else
      alert 'false'

