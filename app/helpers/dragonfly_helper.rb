module DragonflyHelper
  
  def thumbnail_tag(model, column, size, options={})

    unless this_image = model.send(column)
      model  = $conf
      column = 'default_avatar'
      this_image = model.send(column)
    end

    attrs = ''
    options.each do |key, value| 
      if key == :data        
        value.each {|key, value| attrs << "data-#{key.to_s}='#{value}' "}
      else
        attrs << "#{key.to_s}='#{value}' "
      end
    end

    attrs << "alt='#{File.basename(this_image.name, '.*')}'" if options[:alt].blank?     

    width, height = ''
    if(size.split('x')[0].to_i.to_s == size.split('x')[0] && size.split('x')[1].to_i.to_s == size.split('x')[1])
      width  = "width='#{size.split('x')[0].to_i}px' " 
      height = "height='#{size.split('x')[1].to_i}px'" 
    end

    "<img src='/thumbnails/#{model.class.name.downcase}/#{model.id}/#{column}/#{size}/#{this_image.name}' #{width}#{height} #{attrs} />".html_safe
  end

end