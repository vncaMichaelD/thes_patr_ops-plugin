class PatronStat < Sequel::Model(:patron_stat)
  include ASModel
  corresponds_to JSONModel(:patron_stat)

  set_model_scope :repository


  def self.sequel_to_jsonmodel(objs, opts = {})
    jsons = super

    jsons.zip(objs).each do |json, obj|
      p json
      subject = json['type_of_patron']
      terms = json['questions']
      json['display_string'] = subject
      json['display_string'] += " -- #{terms}"
    end

    jsons
  end

end