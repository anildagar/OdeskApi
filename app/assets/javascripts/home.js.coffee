# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  
  # Write on keyup event of keyword input element
  $("#kwd_search").keyup ->
    
    # When value of the input is not blank
    term = $(this).val()
    unless term is ""
      
      # Show only matching TR, hide rest of them
      $("#my-table tbody>tr").hide()
      $("#my-table td").filter(->
        $(this).text().toLowerCase().indexOf(term) > -1
      ).parent("tr").show()
    else
      
      # When there is no input or clean again, show everything back
      $("#my-table tbody>tr").show()
    return

  return
