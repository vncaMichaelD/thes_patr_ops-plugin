class PatronRegsController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "patron_reg", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @patron_reg = fetch_resolved(params[:id])
  end

  def new
    @patron_reg = PatronReg.new({:patron_reg_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:patron_reg_id]
      tes = PatronReg.find(params[:patron_reg_id], find_opts)

      if tes
        @patron_reg.populate_from_patron_reg(tes)
        flash.now[:info] = I18n.t("patron_reg._frontend.messages.spawned", JSONModelI18nWrapper.new(:patron_reg => tes))
        flash[:spawned_from_patron_reg] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'patron_reg'

      if defaults
        @patron_reg.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'patron_reg'

    values = defaults ? defaults.form_values : {:patron_reg_date => Date.today.strftime('%Y-%m-%d')}

    @patron_reg = PatronReg.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "patron_reg",
                                "lock_version" => params[:patron_reg].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:patron_reg],
                                                                        JSONModel(:patron_reg).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :patron_regs, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :patron_regs, :action => :defaults
    end

  end

  def edit
    @patron_reg = fetch_resolved(params[:id])

    if @patron_reg.suppressed
      redirect_to(:controller => :patron_regs, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :patron_reg,
                :model => PatronReg,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("patron_reg._frontend.messages.created", JSONModelI18nWrapper.new(:patron_reg => @patron_reg))
                    redirect_to(:controller => :patron_regs,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :patron_reg,
                :model => PatronReg,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("patron_reg._frontend.messages.updated", JSONModelI18nWrapper.new(:patron_reg => @patron_reg))
                  redirect_to :controller => :patron_regs, :action => :edit, :id => id
                })
  end


  def delete
    patron_reg = PatronReg.find(params[:id])
    patron_reg.delete

    flash[:success] = I18n.t("patron_reg._frontend.messages.deleted", JSONModelI18nWrapper.new(:patron_reg => patron_reg))
    redirect_to(:controller => :patron_regs, :action => :index, :deleted_uri => patron_reg.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    patron_reg = PatronReg.find(id, find_opts)

    patron_reg
  end


end
