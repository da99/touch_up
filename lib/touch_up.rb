
require 'twitter-text'

class Touch_Up

  NOTHING = ''.freeze

  include Twitter::Extractor

  class << self
  end # === class self ===

  def initialize str
    @origin = str
  end

  def to_html
    @origin.

      # "a" (anchor) tags, auto-linking
      gsub(%r@(\*([^\*]+)\*\s+)?([^\.\s]+\.[^\.\s]+[^\s]+[^\.\s])@) { |full, match|
      text = $2
      raw_link = $3

      link = extract_urls(raw_link).first

      if !link
        full
      else

        append = raw_link.sub(link, NOTHING)

        short_link = link

        if !link['://']
          link = 'http://' + link
        end

        if text
          "<a href=\"#{link}\">#{text}</a>#{append}"
        else
          "<a href=\"#{link}\">#{short_link}</a>#{append}"
        end

      end


    }.


    # "i", "del", "strong" tags
    gsub(/(?<=\s)([\*\/\-]{1,2})([^\1\<\>]+)(\1|\-\*)(?=\s)/) { |full, match|
      case
      when $1 == $3 && $1 == '/'
        "<i>#{$2}</i>"
      when $1 == '*-' && $3 == '-*'
        "<del>#{$2}</del>"
      when $1 == $3 && $1 == '*'
        "<strong>#{$2}</strong>"
      else
        full
      end
    }

  end

end # === class Touch_Up ===
