service 'nginx' do
  user 'root'
  action [:disable, :stop]
end