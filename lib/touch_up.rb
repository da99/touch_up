
require 'escape_escape_escape'
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
      raw_link = Escape_Escape_Escape.decode_html($3)

      link = extract_urls(raw_link).first

      if !link
        full
      else

        append           = raw_link.sub(link, NOTHING)
        short_link       = link
        clean_short_link = Escape_Escape_Escape.html(short_link)

        if !link['://']
          link = 'http://' + link
        end

        begin
          clean_link = Escape_Escape_Escape.href(link)

          if text
            "<a href=\"#{clean_link}\">#{text}</a>#{append}"
          else
            "<a href=\"#{clean_link}\">#{clean_short_link}</a>#{append}"
          end

        rescue Escape_Escape_Escape::Invalid_HREF
          full
        end # begin

      end # if


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
