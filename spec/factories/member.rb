require 'RMagick'

FactoryGirl.define do
  factory :member do
    first_name 'guillaume'
    last_name  'barillot'
    birthday   '1987-02-13' 
    avatar_uid 'default_avatar.png'

    # Create an empty PNG image file if not exist
    resource = File.join(Rails.root, 'public', 'system', 'dragonfly', 'test', 'default_avatar.png')
    if !File.exist? resource    
      image = Magick::Image.new(100, 100)
      Dir.mkdir(File.join(Rails.root, 'public', 'system', 'dragonfly', 'test'))
      image.write(resource)
    end

  end
end

