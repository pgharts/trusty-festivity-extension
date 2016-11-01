Admin::PagesController.class_eval do
  only_allow_access_to :index,
                       :when => [:designer, :admin],
                       :denied_url => { :controller => '/admin/configuration', :action => 'show' },
                       :denied_message => 'You must have Admin or Designer privileges to access Content.'
end