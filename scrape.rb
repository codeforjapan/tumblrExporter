###
# load all posts from tumblr
###
require 'mechanize'
DOMAIN = 'http://code4japan.org'

# get all ids of articls
def get_ids(url)
  #return ['142730293478'] # for debugging
  #return ['141088779348'] # for debugging
  agent = Mechanize.new
  page = agent.get(url)
  ids = page.search('article').map do |a|
    a.get_attribute 'id'
  end
  if (nxt = page.at('#older'))
    sleep 1
    nextpage = nxt.get_attribute('href')
    p "get next #{nextpage}"
    ids.concat(get_ids(DOMAIN + nextpage))
  else
    ids
  end
end
# load post data from url
def load_posts(id)
  url = DOMAIN + "/#{id}"
  p "loading #{url}"
  agent = Mechanize.new
  begin
    page = agent.get(url)
    title = page.at("title").text
    date = page.at("article").get_attribute('date')
    if (page.at("article div.text"))
      # text post
      text = page.at("article div.text").inner_html
    elsif (page.at("article div.photo"))
      # photo post
      text = page.at("article div.photo").to_html + page.at("article div.captions").to_html
    else
      # video post
      text = page.at("body").to_html
    end
    buffer = <<-EOT
    <title><![CDATA[#{title}]]></title>
    <link>#{url}</link>
    <guid isPermaLink="true">#{url}</guid>
    <pubDate>#{date}</pubDate>
    <description><![CDATA[#{text}]]></description>
    EOT
    File.write("./out/#{id}.xml", buffer)
  rescue
    p "Error: we coudn't parse content from this url:#{url}"
  end
end
# make directory if it does not exist
FileUtils.mkdir_p("./out") unless FileTest.exist?("./out")
get_ids(DOMAIN).each do|id|
  load_posts id
  sleep 1
end
