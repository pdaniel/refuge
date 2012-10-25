module ApplicationHelper

  # Say hello
  def hello
    Time.now.hour > 18 ? t(:good_evening) : t(:good_morning)
  end

  # Which role are you playing ?
  def is_admin
    (current_user.role == 'admin' && !current_user.view_as_user) ? true : false
  end

  # Just a handy shortcut
  def current_member
    current_user.member if current_user
  end

  # Display socials networks links and icon if profile exists
  def show_social_profiles(networks)
    out = ''
    networks.each do |network|
      out << "<a href='#{h network[:url]}'><img src='/assets/#{network[:icon]}' /></a>" unless network[:url].blank?
    end

    out.html_safe
  end

  # Check if member has filled in some infos
  def member_has_infos?(member)

    fields = ['organisation', 'prestations', 'references', 'phone', 'city', 'hobbies', 'powers']
    out = false

    fields.each do |f|
      out = true if !member[f].blank?
    end

    # CODEREVIEW return is not needed
    return out
  end

  # Check if member has some social networks profiles
  def member_has_profile?(networks)
    networks.find { |network| network.key?(:url) }
  end

  # Ouput a member's birthday whenever it is set or not
  def birthday

    @member.birthday ? obj = @member.birthday : obj = Time.now

    begin
      birthday = {
        :day   => obj.day,
        :month => obj.month,
        :year  => obj.year
      }
    rescue
      birthday = {
        :day   => obj['day'].to_i,
        :month => obj['month'].to_i,
        :year  => obj['year'].to_i
      }
    end
  end

  # Cache Dragonfly thumbnail generation and produce friendly SEO URLs
  def thumbnail_tag(image, size, options={})

    image ? this_image = image : this_image = $conf.default_avatar
    options[:alt].blank? ? image_name = this_image.name : image_name = options[:alt]

    unless File.exists?("#{Rails.root}/public/images/#{size}/#{this_image.name}")
      this_image.thumb(size).to_file("#{Rails.root}/public/images/#{size}/#{this_image.name}")
    end    

    image_tag "/images/#{size}/#{this_image.name}", :alt => image_name
  end

  # Format gauge width for surveys
  def gauge(percentage)
    (((percentage.to_f/100.to_f)*490.to_f)+30.to_f).to_i
  end

  # Fulfill Google calendar code
  def show_calendar(cal)
    '<iframe src="'+cal+'" style="border-width:0" width="875" height="600" frameborder="0" scrolling="no"></iframe>' if cal
  end

  # Fulfill Embed video snippet
  def show_video(vid)
    '<iframe width="560" height="315" src="http://'+vid+'" frameborder="0" allowfullscreen></iframe>' if vid
  end

  # Clean-up all tags except <br />
  def hard_clean(s)
    sanitize simple_format(s), :tags => %w(br)
  end

  # Clean-up except tags potentially used in TinyMCE
  def soft_clean(s)
    sanitize s, :tags => %w(strong br p table tr td a img ul ol li h1 h2 h3 h4 h5 h6 b font), :attributes => %w(id class style color alt src href)
  end

  # Formatted default end date for ads : seven days from now
  def default_end_at
    (7.days.since(Time.now)).strftime('%Y-%m-%d')
  end

  def fullmonth_names_start_1
    months = I18n.t('date.month_names')[1..-2]
    months.to_json
  end

  def shortmonth_names_start_1
    months = I18n.t('date.abbr_month_names')[1..-2]
    months.to_json
  end
  extend self
end

