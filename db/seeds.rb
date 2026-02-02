AdminUser.find_or_create_by!(username: "admin") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

puts "Admin created: username=admin, password=password"

Setting::DEFAULTS.each do |key, value|
  Setting.find_or_create_by!(key: key) do |setting|
    setting.value = value
  end
end

puts "Default settings created."
