Sequel.migration do

  up do
    $stderr.puts("Adding VVA Patrons tables, fields, and constraints.")

    create_table(:patron_stat) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      Integer :form_of_contact_id
	  Integer :type_of_patron_id
      Integer :int_ext_id
	  Integer :time_spent_id
	  String :from_where
	  String :num_on_tour
      TextField :patron_names
	  TextField :questions
	  TextField :answers_provided
	  TextField :general_note
	  String :staff_member
	  Date :todays_date

      apply_mtime_columns

	  Integer :star_record
    end

    create_table(:patron_reg) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      String :primary_name
      TextField :title
      TextField :prefix
      TextField :rest_of_name
      TextField :suffix
      TextField :fuller_form
      String :number
	  String :address
	  String :city
	  String :state
	  String :zip
	  String :country
	  Integer :int_ext_id
	  String :external_name
	  TextField :emails
	  Integer :status_id
	  Integer :purpose_id
	  String :status_note
	  String :purpose_note
	  TextField :research_topic
	  TextField :general_note
	  Date :date_signed
	  
      apply_mtime_columns

	  Integer :star_record
    end
	
    create_table(:patron_callslip) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :patron_reg_id

	  Date :date_signed
	  Integer :type_of_mat_id
      Integer :signed_by_id
	  String :signed_by_name
	  String :coll_title
	  String :coll_author
	  String :coll_location
	  TextField :box_nums
	  String :pulled_by
	  TextField :general_note
	  
      apply_mtime_columns

	  Integer :star_record
    end
	
    alter_table(:patron_callslip) do
      add_foreign_key([:patron_reg_id], :patron_reg, :key => :id)
    end

    create_editable_enum('patron_contact', ["email","phone","walkin","tour","letter","briefing","other"])
	create_editable_enum('patron_type', ["researcher","veteran","general_public","media","donor","oral_history","students_class","other"])
	create_editable_enum('patron_int_ext', ["unknown", "ttu", "other"])
	create_editable_enum('patron_time', ["0", "1", "5", "10", "15", "20", "25", "30", "45", "60", "90", "120", "150", "180", "210", "240", "270", "300"])
	create_editable_enum('patron_signed_by', ["not", "patron", "staff"])
	create_editable_enum('patron_status', ["undergrad", "gradstudent", "facultystaff", "techalum", "genealogist", "generalresearch", "other"])
	create_editable_enum('patron_purpose', ["class", "thesis", "genealogy", "publication", "other"])
  end

end
