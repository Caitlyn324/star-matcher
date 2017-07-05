require 'capybara/poltergeist'

backstage_page = "https://www.backstage.com/casting/?exclude_nationwide=true&gender=B&geo=-75.16378900000001%2C39.952335&location=Philadelphia%2C+PA&max_age=100&min_age=0&page=1&pt=60&pt=69&pt=70&radius=10&sort_by=newest"

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false, phantomjs: Phantomjs.path})
end

browser = Capybara::Session.new(:poltergeist)
browser.visit(backstage_page)
union = browser.all("a.tag.union")
links = []
browser.all('h3.prod__title').each do |div_title|
  links << div_title.text
end

links.each_with_index do |link, index|
  browser.click_link link

  role_divs = browser.all("div.role-group")
  while role_divs.empty?
    role_divs = browser.all("div.role-group")
  end

  roles = []
  role_divs.each do |role_div|
    roles << role_div.text
  end

  equity = true
  if !union[index] || !union[index].text.downcase.include?("UNION")
    equity = false
  end

  deets = []

  details = browser.all("div.prod-listing__details.undefined")
  while details.empty?
    details = browser.all("div.prod-listing__details.undefined")
  end

  details.each do |detail|
    deets << detail.find("p")
  end

  date_string = browser.find("span.expires-text--date").text
  date = Date.parse(date_string)

  audy = Audition.create!(
    show: link,
    roles: roles,
    equity: equity,
    date: date,
    company: deets[0].text,
    description: "#{deets[1].text}\n#{deets[3].text}",
    created_at: Time.now,
    updated_at: Time.now
  )
  browser.go_back
end
Actor.destroy_all
actor = Actor.create!(
  name: 'Chris Donohue',
  phone_number: '2679871412',
  email: 'chris.donohue0628@gmail.com',
  password: 'tbatst4892'
)
