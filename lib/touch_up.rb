
require 'escape_escape_escape'
require 'twitter-text'

class Touch_Up

  NOTHING    = ''.freeze
  HREFS      = %r@(\*([^\*]+)\*\s+)?([^\.\s]+\.[^\.\s]+[^\s]+[^\.\s])@
  MARK_DOWNS = /(\&\#47\;|~~|\*)([^\1\<\>]+)(\1)/

  include Twitter::Extractor

  class << self
  end # === class self ===

  def initialize str
    @origin = str
  end

  def to_html
    splits = Escape_Escape_Escape.html(@origin).gsub(HREFS) { |full, match|

      raw_text   = $2 ? Escape_Escape_Escape.decode_html($2) : nil
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


    }.split(/(\<[^\>]+\>[^\<]+\<\/[^\>]+\>)/)

    # "i", "del", "strong" tags
    final = ""
    i = 0
    while i < splits.size
      final << (splits[i].gsub(MARK_DOWNS) { |full, match|
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
      })

      i += 1
      if splits[i]
        final << splits[i]
        i += 1
      end
    end

    final

  end

end # === class Touch_Up ===
