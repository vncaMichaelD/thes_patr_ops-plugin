class CommonIndexer

  @@record_types << :patron_reg

  add_indexer_initialize_hook do |indexer|

    indexer.add_document_prepare_hook {|doc, record|
      if record['record']['jsonmodel_type'] == 'patron_reg'
        doc['title'] = record['record']['display_string']
      end
    }

  end

end