require 'mechanize'

def plan_urls
  agent = Mechanize.new
  links = []
  i_images = []

  current_page  = agent.get("https://owner-style.com/")
  elements      = current_page.search('.container .plans_pc .plan_card_medium')
  index_images  = current_page.search('.container .plans_pc .plan_card_medium .card .card-img-top')

  #index_imageのurlの部分を抽出
  index_images.each do |index_image|
    str       = index_image.attribute('style').to_s
    reg       = /"/.match(str)
    reg_post  = reg.post_match
    reg_pre   = /"/.match(reg_post)
    i_images  << reg_pre.pre_match
  end

  elements.first(40).each do |ele|
    links << ele.get_attribute('href') if ele
  end

  links.zip(i_images).each do |link, i_image|
    create_plans('https://owner-style.com' + link, i_image)
  end
end

def create_plans(link, i_image)
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
  card_desc         = page.search('.border-0 .card-body h3, .plan_detail_list .card .card-body.desc p') if page.search('.border-0 .card-body h3, .plan_detail_list .card .card-body.desc p')
  card_images       = page.search('.plan_detail_list .card .card-img-top') if page.search('.plan_detail_list .card .card-img-top')

  #title_imageのurlの部分を抽出
  str_title       = title_image
  reg_title       = /\(/.match(str_title)
  reg_post_title  = reg_title.post_match
  reg_pre_title   = /\)/.match(reg_post_title)
  title_image_url = reg_pre_title.pre_match

  #card_imageのurlの部分を抽出
  str_card        = card_images[0].get_attribute('style').to_s
  reg_card        = /\(/.match(str_card)
  reg_post_card   = reg_card.post_match
  reg_pre_card    = /\)/.match(reg_post_card)
  card_image_url_1  = reg_pre_card.pre_match
  if card_title[1].present?
    str_card_2        = card_images[1].get_attribute('style').to_s
    reg_card          = /\(/.match(str_card_2)
    reg_post_card_2   = reg_card.post_match
    reg_pre_card_2    = /\)/.match(reg_post_card_2)
    card_image_url_2  = reg_pre_card_2.pre_match
  end

  plan = Plan.new(
    title: title,
    shop_name: shop_name,
    contents: contents,
    place: place,
    closing_date_month: month,
    closing_date_day: day,
    registration_fee: registration_fee,
    plan_detail: plan_detail
    )

  course_1 = plan.courses.new(
    title: card_title.first.inner_text,
    price:card_price.first.inner_text,
    desc: card_desc[0..3],
    )
  if card_title[1].present?
    course_2 = plan.courses.new(
      title: card_title[1].inner_text,
      price: card_price[1].inner_text,
      desc: card_desc[4..7],
    )
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
  plan.save!
end

plan_urls
