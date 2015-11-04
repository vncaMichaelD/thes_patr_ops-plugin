module PatronCallslips

  def self.included(base)
        base.one_to_many :patron_callslip


        base.def_nested_record(:the_property => :patron_callslips,
                               :contains_records_of_type => :patron_callslip,
                               :corresponding_to_association => :patron_callslip)
  end

end
