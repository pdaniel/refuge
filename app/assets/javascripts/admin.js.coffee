$ ->
  # Toggle Media description block
  $('.doToggleMediaDescription').click ->
    $(this).closest('.col').next('.category_description').slideToggle('slow')

 
  $("[data-do='sort']").sortable
    axis: 'y',
    update: (e, ui) ->
      reSort()
 
reSort = () ->
  i = 1
  $("[data-do='sort'] li").each ->
    $("[data-handle='position']", this).val(i)
    i++
