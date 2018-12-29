service 'nginx' do
  user 'root'
  action [:enable, :start]
end
