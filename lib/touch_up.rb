
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
    Escape_Escape_Escape.html(@origin).

      # "a" (anchor) tags, auto-linking
      gsub(%r@(\*([^\*]+)\*\s+)?([^\.\s]+\.[^\.\s]+[^\s]+[^\.\s])@) { |full, match|

      raw_text   = Escape_Escape_Escape.decode_html $2
      raw_append = Escape_Escape_Escape.decode_html $3
      raw_link   = extract_urls(raw_append).first

      if !raw_link
        full
      else

        append   = Escape_Escape_Escape.html raw_append.sub(raw_link, NOTHING)
        text     = if raw_text
                   Escape_Escape_Escape.html(raw_text)
                 else
                   Escape_Escape_Escape.html(raw_link)
                 end

        raw_link = Escape_Escape_Escape.decode_html(raw_link)

        if !raw_link['://']
          raw_link = 'http://' + raw_link
        end

        begin
          link = Escape_Escape_Escape.href(raw_link)

          "<a href=\"#{link}\">#{text}</a>#{append}"

        rescue Escape_Escape_Escape::Invalid_HREF
          full
        end # begin

      end # if


    }.


    # "i", "del", "strong" tags
    gsub(/(\&\#47\;|~~|\*)([^\1\<\>]+)(\1)/) { |full, match|
      case
      when $1 == $3 && $1 == '&#47;'
        "<i>#{$2}</i>"
      when $1 == '~~' && $3 == '~~'
        "<del>#{$2}</del>"
      when $1 == $3 && $1 == '*'
        "<strong>#{$2}</strong>"
      else
        full
      end
    }

  end

end # === class Touch_Up ===
