ArchivesSpace::Application.routes.draw do

    match 'thesas/defaults' => 'thesas#defaults', :via => [:get]
    match 'thesas/defaults' => 'thesas#update_defaults', :via => [:post]
    resources :thesas
    match 'thesas/:id' => 'thesas#update', :via => [:post]
    match 'thesas/:id/delete' => 'thesas#delete', :via => [:post]

    match 'patron_stats/defaults' => 'patron_stats#defaults', :via => [:get]
    match 'patron_stats/defaults' => 'patron_stats#update_defaults', :via => [:post]
    resources :patron_stats
    match 'patron_stats/:id' => 'patron_stats#update', :via => [:post]
    match 'patron_stats/:id/delete' => 'patron_stats#delete', :via => [:post]
	
    match 'patron_regs/defaults' => 'patron_regs#defaults', :via => [:get]
    match 'patron_regs/defaults' => 'patron_regs#update_defaults', :via => [:post]
    resources :patron_regs
    match 'patron_regs/:id' => 'patron_regs#update', :via => [:post]
    match 'patron_regs/:id/delete' => 'patron_regs#delete', :via => [:post]

end
