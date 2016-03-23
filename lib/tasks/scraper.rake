require 'nokogiri'
require 'open-uri'

namespace :scraper do
  task :fetch_all => :environment do
    fetch_stories('http://www.twosentencestories.com/')
  end

  def fetch_stories(url)
    doc = Nokogiri::HTML(open(url))
    next_page = doc.at_css('div.pagination-older a')
    stories = doc.css('li.postWrapper')
    stories.each do |story|
      story_id = story['id']
      title = story.at_css('h2').text
      content = story.at_css('div.post p').text
      rating_text = story.at_css('div.ratingtext').text
      rating = rating_text.gsub('Rating: ', '').gsub('/', '')

      begin
        story = Story.where(post_id: story_id).first rescue nil
        unless story
          story = Story.create(title: title, content: content, rating: rating.to_f, post_id: story_id)
        end
        puts "Story: #{story.id}"
      rescue
        puts 'ERROR!!!!'
      end
    end
    if next_page.present?
      fetch_stories(next_page['href'])
    else
      return
    end
  end
end