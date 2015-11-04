class PatronStatsController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "patron_stat", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @patron_stat = fetch_resolved(params[:id])
  end

  def new
    @patron_stat = PatronStat.new({:patron_stat_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:patron_stat_id]
      tes = PatronStat.find(params[:patron_stat_id], find_opts)

      if tes
        @patron_stat.populate_from_patron_stat(tes)
        flash.now[:info] = I18n.t("patron_stat._frontend.messages.spawned", JSONModelI18nWrapper.new(:patron_stat => tes))
        flash[:spawned_from_patron_stat] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'patron_stat'

      if defaults
        @patron_stat.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'patron_stat'

    values = defaults ? defaults.form_values : {:patron_stat_date => Date.today.strftime('%Y-%m-%d')}

    @patron_stat = PatronStat.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "patron_stat",
                                "lock_version" => params[:patron_stat].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:patron_stat],
                                                                        JSONModel(:patron_stat).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :patron_stats, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :patron_stats, :action => :defaults
    end

  end

  def edit
    @patron_stat = fetch_resolved(params[:id])

    if @patron_stat.suppressed
      redirect_to(:controller => :patron_stats, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :patron_stat,
                :model => PatronStat,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("patron_stat._frontend.messages.created", JSONModelI18nWrapper.new(:patron_stat => @patron_stat))
                    redirect_to(:controller => :patron_stats,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :patron_stat,
                :model => PatronStat,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("patron_stat._frontend.messages.updated", JSONModelI18nWrapper.new(:patron_stat => @patron_stat))
                  redirect_to :controller => :patron_stats, :action => :edit, :id => id
                })
  end


  def delete
    patron_stat = PatronStat.find(params[:id])
    patron_stat.delete

    flash[:success] = I18n.t("patron_stat._frontend.messages.deleted", JSONModelI18nWrapper.new(:patron_stat => patron_stat))
    redirect_to(:controller => :patron_stats, :action => :index, :deleted_uri => patron_stat.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    patron_stat = PatronStat.find(id, find_opts)

    patron_stat
  end


end
