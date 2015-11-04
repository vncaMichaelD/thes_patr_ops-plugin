{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/repositories/:repo_id/patron_stats",
    "properties" => {
	
	  "form_of_contact" => {"type" => "string", "dynamic_enum" => "patron_contact"},
	  "type_of_patron" => {"type" => "string", "dynamic_enum" => "patron_type"},
      "int_ext" => {"type" => "string", "dynamic_enum" => "patron_int_ext"},
	  "time_spent" => {"type" => "string", "dynamic_enum" => "patron_time"},
	  "from_where" => {"type" => "string", "maxLength" => 255},
	  "num_on_tour" => {"type" => "string", "maxLength" => 255},
      "patron_names" => {"type" => "string", "maxLength" => 8192},
	  "questions" => {"type" => "string", "maxLength" => 8192},
	  "answers_provided" => {"type" => "string", "maxLength" => 8192},
	  "general_note" => {"type" => "string", "maxLength" => 8192},
	  "staff_member" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
	  "todays_date" => {"type" => "date", "ifmissing" => "error"},

      "uri" => {"type" => "string", "required" => false},
      "suppressed" => {"type" => "boolean", "default" => false},
      "display_string" => {"type" => "string", "maxLength" => 8192, "readonly" => true},
    },
  },
}