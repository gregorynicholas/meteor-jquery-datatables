Tinytest.add "jQuery DataTables - Definition", ( test ) ->
  test.notEqual DataTableComponent, undefined, "Expected DataTableComponent to be defined on the client and server."
  test.notEqual DataTableMixins, undefined, "Expected DataTableComponent to be defined on the client and server."

  if Meteor.isClient
    test.notEqual $().dataTable, undefined, "Expected DataTable jQuery plugin to be defined on the client."
    test.notEqual Template.DataTable, undefined, "Expected Template.DataTable to be defined on the client."

Tinytest.add "jQuery DataTables - Constructor", ( test ) ->
  if Meteor.isClient
    component = UI.renderWithData Template.DataTable, ReactiveData
    tI = component.templateInstance

  if Meteor.isServer
    tI = new DataTableComponent ReactiveData

  test.equal tI.__name__, "DataTable", "Class __name__ should be DataTable"
  test.notEqual tI.id, undefined, "Component should have id method defined."
  test.equal tI.id(), ReactiveData.id, "Component id should be equal the id passed in through constructor."

if Meteor.isClient
  Tinytest.add "jQuery DataTables - Rendered", ( test ) ->
    component = UI.renderWithData Template.DataTable, ReactiveData
    tI = component.templateInstance
    $DOM = $( '<div id="parentNode"></div>' )
    UI.insert component, $DOM

    test.notEqual tI.$, undefined, "Component should have a jQuery node defined after being rendered."
    test.notEqual tI.selector, undefined, "Component should have selector method defined."
    test.equal tI.selector(), "##{ ReactiveData.id }", "Component selector should be based on the id passed in through constructor."

Tinytest.add "jQuery DataTables - fnServerData", ( test ) ->
  if Meteor.isClient
    component = UI.renderWithData Template.DataTable, ReactiveData
    tI = component.templateInstance
    $DOM = $( '<div id="parentNode"></div>' )
    UI.insert component, $DOM

    test.notEqual tI.fnServerData, undefined, "All components should have an fnServerData method defined."
    test.notEqual tI.mapTableState, undefined, "fnServerData() expects @mapTableState() to be defined"
    test.notEqual tI.setSubscriptionOptions, undefined, "fnServerData() expects @setSubscriptionOptions() to be defined"
    test.notEqual tI.setSubscriptionHandle, undefined, "fnServerData() expects @setSubscriptionHandle() to be defined"
    test.notEqual tI.setSubscriptionAutorun, undefined, "fnServerData() expects @setSubscriptionAutorun() to be defined"

  if Meteor.isServer
    component = new DataTableComponent ReactiveData

    ###try
      component.fnServerData()
    catch error
      test.equal error.message, "fnServerData can only be called from the client.", "Calling fnServerData on the server should throw an error."###







