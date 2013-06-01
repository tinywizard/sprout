include_recipe "pivotal_workstation::addloginitem"

app_path="/Applications/ShiftIt.app"

unless File.exists?(app_path)
  remote_file "#{Chef::Config[:file_cache_path]}/ShiftIt.app.zip" do
    source "https://github.com/downloads/onsi/ShiftIt/ShiftIt.app.zip"
    mode "0644"
  end

  execute "unzip ShiftIt" do
    command "unzip #{Chef::Config[:file_cache_path]}/ShiftIt.app.zip ShiftIt.app/* -d /Applications/"
    user node['current_user']
    group "admin"
  end

  # start up on login
  execute "Start ShiftIt on login" do
    command "su #{node['current_user']} -c \"addloginitem #{app_path}\""
  end
end
