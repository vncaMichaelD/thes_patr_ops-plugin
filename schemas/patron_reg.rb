{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/repositories/:repo_id/patron_regs",
    "properties" => {
      "primary_name" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
      "title" => {"type" => "string", "maxLength" => 16384},
      "prefix" => {"type" => "string", "maxLength" => 65000},
      "rest_of_name" => {"type" => "string", "maxLength" => 65000},
      "suffix" => {"type" => "string", "maxLength" => 65000},
      "fuller_form" => {"type" => "string", "maxLength" => 65000},
      "number" => {"type" => "string", "maxLength" => 255},
	  "address" => {"type" => "string", "maxLength" => 255},
	  "city" => {"type" => "string", "maxLength" => 255},
	  "state" => {"type" => "string", "maxLength" => 255},
	  "zip" => {"type" => "string", "maxLength" => 255},
	  "country" => {"type" => "string", "maxLength" => 255},
	  "int_ext" => {"type" => "string", "dynamic_enum" => "patron_int_ext"},
	  "external_name" => {"type" => "string", "maxLength" => 255},
	  "emails" => {"type" => "string", "maxLength" => 255},
	  "status" => {"type" => "string", "dynamic_enum" => "patron_status"},
	  "purpose" => {"type" => "string", "dynamic_enum" => "patron_purpose"},
	  "status_note" => {"type" => "string", "maxLength" => 65000},
	  "purpose_note" => {"type" => "string", "maxLength" => 65000},
	  "research_topic" => {"type" => "string", "maxLength" => 65000},
	  "general_note" => {"type" => "string", "maxLength" => 65000},
	  "date_signed" => {"type" => "date"},
	  
	  "patron_callslips" => {"type" => "array", "items" => {"type" => "JSONModel(:patron_callslip) object"}},

      "uri" => {"type" => "string", "required" => false},
      "suppressed" => {"type" => "boolean", "default" => false},
      "display_string" => {"type" => "string", "maxLength" => 8192, "readonly" => true},
    },
  },
}