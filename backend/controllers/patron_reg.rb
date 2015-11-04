class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/patron_regs/:id')
    .description("Update a Patron Registration")
    .params(["id", :id],
            ["patron_reg", JSONModel(:patron_reg), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(PatronReg, params[:id], params[:patron_reg])
  end


  Endpoint.post('/repositories/:repo_id/patron_regs')
    .description("Create a Patron Registration")
    .params(["patron_reg", JSONModel(:patron_reg), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(PatronReg, params[:patron_reg])
  end


  Endpoint.get('/repositories/:repo_id/patron_regs')
    .description("Get a list of Patron Registrations for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:patron_reg)]"]) \
  do
    handle_listing(PatronReg, params)
  end


  Endpoint.get('/repositories/:repo_id/patron_regs/:id')
    .description("Get a Patron Registration by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:patron_reg)"]) \
  do
    json = PatronReg.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/patron_regs/:id')
    .description("Delete a Patron Registration")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(PatronReg, params[:id])
  end

end