class PatronCallslip < Sequel::Model(:patron_callslip)
  include ASModel
  corresponds_to JSONModel(:patron_callslip)

  set_model_scope :repository

end
