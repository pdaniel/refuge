module ImageHelper

  # Cache Dragonfly thumbnail generation and produce friendly SEO URLs
  def thumbnail_tag(image, size, options={})

    image ? this_image = image : this_image = $conf.default_avatar

    sub_dir    = 'images'
    resource   = File.join(Rails.root, 'public', sub_dir, size, this_image.name)

    unless File.exists?(resource)
      this_image.thumb(size).to_file(resource)
    end 

    attrs = ''
    options.each do |key, value| 
      if key == :data        
        value.each do |key, value|
          attrs << "data-#{key.to_s}='#{value.to_s}' "
        end
      else
        attrs << "#{key.to_s}='#{value.to_s}' "
      end
    end

    attrs << "alt='#{this_image.name}'"         if options[:alt].blank? 
    width  = "width='#{size.split('x')[0]}px'"  unless size.split('x')[0].blank?  
    height = "height='#{size.split('x')[1]}px'" unless size.split('x')[1].blank? 

    "<img src='/#{sub_dir}/#{size}/#{this_image.name}' #{width} #{height} #{attrs} />".html_safe
  end

end