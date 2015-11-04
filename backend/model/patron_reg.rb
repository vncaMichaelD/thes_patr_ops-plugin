class PatronReg < Sequel::Model(:patron_reg)
  include ASModel
  corresponds_to JSONModel(:patron_reg)

  include PatronCallslips

  set_model_scope :repository


  def self.sequel_to_jsonmodel(objs, opts = {})
    jsons = super

    jsons.zip(objs).each do |json, obj|
      p json
      subject = json['rest_of_name']
      terms = json['primary_name']
      json['display_string'] = subject
      json['display_string'] += " #{terms}"
    end

    jsons
  end

end