class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/patron_stats/:id')
    .description("Update a Patron Stat")
    .params(["id", :id],
            ["patron_stat", JSONModel(:patron_stat), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(PatronStat, params[:id], params[:patron_stat])
  end


  Endpoint.post('/repositories/:repo_id/patron_stats')
    .description("Create a Patron Stat")
    .params(["patron_stat", JSONModel(:patron_stat), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(PatronStat, params[:patron_stat])
  end


  Endpoint.get('/repositories/:repo_id/patron_stats')
    .description("Get a list of Patron Stat for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:patron_stat)]"]) \
  do
    handle_listing(PatronStat, params)
  end


  Endpoint.get('/repositories/:repo_id/patron_stats/:id')
    .description("Get a Patron Stat by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:patron_stat)"]) \
  do
    json = PatronStat.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/patron_stats/:id')
    .description("Delete a Patron Stat")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(PatronStat, params[:id])
  end

end