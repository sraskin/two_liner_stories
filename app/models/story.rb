class Story < ActiveRecord::Base

  def self.scrap

  end

  def fetch_stories(url)
    doc = Nokogiri::HTML(open(url))
    next_page = doc.at_css('div.pagination-older a')
    stories = doc.css('li.postWrapper')
    stories.each do |story|
      title = story.at_css('h2').text
      content = story.at_css('div.post p').text
      rating_text = story.at_css('div.ratingtext')
      rating = rating_text.gsub('Rating: ', '').gsub('/', '')

      begin
        story = Story.create(title: title, content: content, rating: rating.to_f)
        puts "Story: #{story.id}"
      rescue
        puts 'ERROR!!!!'
      end
    end
  end

end
