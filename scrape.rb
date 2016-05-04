###
# load all posts from tumblr
###
require 'mechanize'
DOMAIN = 'http://code4japan.org'

# get all ids of articls
def get_ids(url)
  agent = Mechanize.new
  page = agent.get(url)
  ids = page.search('article').map {|a|
    a.get_attribute 'id'
  }
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
def load_posts(url)
  p url
end
get_ids(DOMAIN).each{|id|
  load_posts(DOMAIN + "/#{id}")
  sleep 1
}
