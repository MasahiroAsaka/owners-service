require 'mechanize'

class Scraping
  def self.plan_urls
    agent = Mechanize.new
    links = []
    i_images = []
    a_images = []

    current_page  = agent.get("https://owner-style.com/")
    elements      = current_page.search('.container .plans_pc .plan_card_medium')
    index_images  = current_page.search('.container .plans_pc .plan_card_medium .card .card-img-top')
    avatars       = current_page.search('.container .plans_pc .plan_card_medium .card .avatar_72')

    # #index_imageのurlの部分を抽出
    index_images.each do |index_image|
      str       = index_image.attribute('style').to_s
      reg       = /"/.match(str)
      reg_post  = reg.post_match
      reg_pre   = /"/.match(reg_post)
      i_images  << reg_pre.pre_match
    end

    #avatarのurlの部分を抽出
    avatars.each do |avatar|
      reg_avatar        = /\(/.match(avatar.get_attribute('style').to_s)
      reg_post_avatar   = reg_avatar.post_match
      reg_pre_avatar    = /\)/.match(reg_post_avatar)
      avatar_image_url  = reg_pre_avatar.pre_match
      a_images << avatar_image_url
    end

    elements.first(40).each do |ele|
      links << ele.get_attribute('href') if ele
    end

    links.zip(i_images, a_images).each do |link, i_image, a_image|
      create_plans('https://owner-style.com' + link, i_image, a_image)
    end
  end

  def self.create_plans(link, i_image, a_image)
    agent = Mechanize.new
    page = agent.get(link)
    title             = page.search('#cover h1').inner_text if page.search('#cover h1').inner_text
    title_image       = page.at('#cover .cover_img_wrap').get_attribute('style').to_s
    contents          = page.search('.contents img, .contents h3, .contents p') if page.search('.contents img, .contents h3, .contents p')
    contents_images   = page.search('article .contents img')
    registration_fee  = page.search('.price_wrap .price').inner_text if page.search('.price_wrap .price').inner_text
    shop_name         = page.search('.info-producer .organization_name').inner_text if page.search('.info-producer .organization_name').inner_text
    place             = page.search('.location_name').inner_text if page.search('.location_name').inner_text
    closing_date      = page.search('.date').inner_text if page.search('.date').inner_text
      month           = closing_date[0] + closing_date[1]
      day             = closing_date[3] + closing_date[4]
    plan_detail       = page.search('.single .card-body') if page.search('.single .card-body')
    card_title        = page.search('h2.card-title') if page.search('h2.card-title')
    card_price        = page.search('.price.mb-3') if page.search('.price.mb-3')
    count_cards       = page.search('.plan_detail_list .card.border-0').count
    count_desc        = page.search('.card .card-body.desc').count
    card_desc         = page.search('.card .card-body.desc')
    card_desc_summary = page.search('article .sidebar p') if page.search('article .sidebar p')
    card_images       = page.search('.plan_detail_list .card .card-img-top') if page.search('.plan_detail_list .card .card-img-top')
    map               = page.search('script')[7]

    #title_imageのurlの部分を抽出
    str_title       = title_image
    reg_title       = /\(/.match(str_title)
    reg_post_title  = reg_title.post_match
    reg_pre_title   = /\)/.match(reg_post_title)
    title_image_url = reg_pre_title.pre_match

    #card_imageのurlの部分を抽出
    str_card          = card_images[0].get_attribute('style').to_s
    reg_card          = /\(/.match(str_card)
    reg_post_card     = reg_card.post_match
    reg_pre_card      = /\)/.match(reg_post_card)
    card_image_url_1  = reg_pre_card.pre_match
    if card_title[1].present?
      str_card_2        = card_images[1].get_attribute('style').to_s
      reg_card          = /\(/.match(str_card_2)
      reg_post_card_2   = reg_card.post_match
      reg_pre_card_2    = /\)/.match(reg_post_card_2)
      card_image_url_2  = reg_pre_card_2.pre_match
    end
    if card_title[2].present?
      str_card_3        = card_images[2].get_attribute('style').to_s
      reg_card          = /\(/.match(str_card_3)
      reg_post_card_3   = reg_card.post_match
      reg_pre_card_3    = /\)/.match(reg_post_card_3)
      card_image_url_3  = reg_pre_card_3.pre_match
    end
    if card_title[3].present?
      str_card_4        = card_images[3].get_attribute('style').to_s
      reg_card          = /\(/.match(str_card_4)
      reg_post_card_4   = reg_card.post_match
      reg_pre_card_4    = /\)/.match(reg_post_card_4)
      card_image_url_4  = reg_pre_card_4.pre_match
    end

    # registration_feeの金額を抽出
    reg_pre_registration_fee  = /円/.match(registration_fee)
    fee = reg_pre_registration_fee.pre_match

    # card_priceの金額を抽出
    reg_pre_card_price_1  = /円/.match(card_price.first.inner_text)
    price_1 = reg_pre_card_price_1.pre_match
    if card_title[1].present?
      reg_pre_card_price_2  = /円/.match(card_price[1].inner_text)
      price_2 = reg_pre_card_price_2.pre_match
    end
    if card_title[2].present?
      reg_pre_card_price_3  = /円/.match(card_price[2].inner_text)
      price_3 = reg_pre_card_price_3.pre_match
    end
    if card_title[3].present?
      reg_pre_card_price_4  = /円/.match(card_price[3].inner_text)
      price_4 = reg_pre_card_price_4.pre_match
    end

    # google map位置情報を取得
    lat = map.text.scan(/lat: (.+),/).first
    lng = map.text.scan(/lng: (.+)\n/).first

    plan = Plan.new(
      title: title,
      shop_name: shop_name,
      contents: contents,
      place: place,
      closing_date_month: month,
      closing_date_day: day,
      registration_fee: fee,
      plan_detail: plan_detail,
      lat: lat[0],
      lng: lng[0]
      )

    course_1 = plan.courses.new(
      title: card_title.first.inner_text,
      price: price_1,
      card_desc_summary: card_desc_summary[0]
      )
    if card_title[1].present?
      course_2 = plan.courses.new(
        title: card_title[1].inner_text,
        price: price_2,
        card_desc_summary: card_desc_summary[1]
      )
    end
    if card_title[2].present?
      course_3 = plan.courses.new(
        title: card_title[2].inner_text,
        price: price_3,
        card_desc_summary: card_desc_summary[2]
      )
    end
    if card_title[3].present?
      course_4 = plan.courses.new(
        title: card_title[3].inner_text,
        price: price_4,
        card_desc_summary: card_desc_summary[3]
      )
    end

    divide_num = count_desc/count_cards
    # cardが1枚の時、descを割った数が1だったら、2だったら
    if count_cards == 1
      if divide_num == 1
        course_1.course_descriptions.new(
          content: card_desc[0],
          course_id: course_1.id
        )
      elsif divide_num == 2
        course_1.course_descriptions.new(
          content: card_desc[0..1],
          course_id: course_1.id
        )
      end
    end
    # cardが2枚の時、descを割った数が1だったら、2だったら
    if count_cards == 2
      if divide_num == 1
        course_1.course_descriptions.new(
          content: card_desc[0],
          course_id: course_1.id
        )
        course_2.course_descriptions.new(
          content: card_desc[1],
          course_id: course_2.id
        )
      elsif divide_num == 2
        course_1.course_descriptions.new(
          content: card_desc[0..1],
          course_id: course_1.id
        )
        course_2.course_descriptions.new(
          content: card_desc[2..3],
          course_id: course_2.id
        )
      end
    end
    # cardが3枚の時、descを割った数が1だったら、2だったら
    if count_cards == 3
      if divide_num == 1
        course_1.course_descriptions.new(
          content: card_desc[0],
          course_id: course_1.id
        )
        course_2.course_descriptions.new(
          content: card_desc[1],
          course_id: course_2.id
        )
        course_3.course_descriptions.new(
          content: card_desc[2],
          course_id: course_3.id
        )
      elsif divide_num == 2
        course_1.course_descriptions.new(
          content: card_desc[0..1],
          course_id: course_1.id
        )
        course_2.course_descriptions.new(
          content: card_desc[2..3],
          course_id: course_2.id
        )
        course_3.course_descriptions.new(
          content: card_desc[4..5],
          course_id: course_3.id
        )
      end
    end
    # cardが4枚の時、descを割った数が1だったら、2だったら...
    if count_cards == 4
      if divide_num == 1
        course_1.course_descriptions.new(
          content: card_desc[0],
          course_id: course_1.id
        )
        course_2.course_descriptions.new(
          content: card_desc[1],
          course_id: course_2.id
        )
        course_3.course_descriptions.new(
          content: card_desc[2],
          course_id: course_3.id
        )
        course_4.course_descriptions.new(
          content: card_desc[3],
          course_id: course_4.id
        )
      elsif divide_num == 2
        course_1.course_descriptions.new(
          content: card_desc[0..1],
          course_id: course_1.id
        )
        course_2.course_descriptions.new(
          content: card_desc[2..3],
          course_id: course_2.id
        )
        course_3.course_descriptions.new(
          content: card_desc[4..5],
          course_id: course_3.id
        )
        course_4.course_descriptions.new(
          content: card_desc[6..7],
          course_id: course_4.id
        )
      end
    end

    link.slice!(0..28)
    num = link
    agent.get(i_image).save "app/assets/images/contents/#{num}_index.jpg"
    File.open("app/assets/images/contents/#{num}_index.jpg") do |ind|
      plan.captured_images.build(
        content: ind,
        status: 'index',
        order: 1,
        plan_id: plan.id
      )
    end

    agent.get(a_image).save "app/assets/images/contents/#{num}_avatar.jpg"
    File.open("app/assets/images/contents/#{num}_avatar.jpg") do |ava|
      plan.captured_images.build(
        content: ava,
        status: 'avatar',
        order: 1,
        plan_id: plan.id
      )
    end

    agent.get(title_image_url).save "app/assets/images/contents/#{num}_title.jpg"
    File.open("app/assets/images/contents/#{num}_title.jpg") do |title|
      plan.captured_images.build(
        content: title,
        status: 'main',
        order: 1,
        plan_id: plan.id
      )
    end

    contents_images.each_with_index do |image, i|
      agent.get(image.get_attribute('src')).save "app/assets/images/contents/#{num}_contents_#{i+1}.jpg"
      File.open("app/assets/images/contents/#{num}_contents_#{i+1}.jpg") do |f|
        plan.captured_images.build(
          content: f,
          status: 'sub',
          order: i + 1,
          plan_id: plan.id
        )
      end
    end

    agent.get(card_image_url_1).save "app/assets/images/contents/#{num}_card_1.jpg"
    File.open("app/assets/images/contents/#{num}_card_1.jpg") do |card_1|
      course_1.captured_image_courses.build(
        content: card_1,
        order: 1,
        course_id: course_1.id
      )
    end

    if card_image_url_2.present?
      agent.get(card_image_url_2).save "app/assets/images/contents/#{num}_card_2.jpg"
      File.open("app/assets/images/contents/#{num}_card_2.jpg") do |card_2|
        course_2.captured_image_courses.build(
          content: card_2,
          order: 2,
          course_id: course_2.id
        )
      end
    end

    if card_image_url_3.present?
      agent.get(card_image_url_3).save "app/assets/images/contents/#{num}_card_3.jpg"
      File.open("app/assets/images/contents/#{num}_card_3.jpg") do |card_3|
        course_3.captured_image_courses.build(
          content: card_3,
          order: 3,
          course_id: course_3.id
        )
      end
    end

    if card_image_url_4.present?
      agent.get(card_image_url_4).save "app/assets/images/contents/#{num}_card_4.jpg"
      File.open("app/assets/images/contents/#{num}_card_4.jpg") do |card_4|
        course_4.captured_image_courses.build(
          content: card_4,
          order: 4,
          course_id: course_4.id
        )
      end
    end
    # plan = Plan.where(title: title).first_or_initialize
    plan.save!
  end
  Scraping.plan_urls
end
