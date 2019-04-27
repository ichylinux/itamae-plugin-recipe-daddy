template '/etc/yum.repos.d/google-chrome.repo' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

package 'google-chrome-stable' do
  user 'root'
end