
class Slash_Star_Link

  class << self
  end # === class self ===

  def initialize str
    @origin = str
  end

  def to_html
    @origin.
      gsub(/\*([^\*]+)\*\s+([^\.\s]+\.[^\.\s]+[^\s]+[^\.\s])/) { |full, match|
      text = $1
      link = $2
      unless link =~ /:\/\//i
        link = "http://#{link}"
      end
      "<a href=\"#{link}\">#{text}</a>"
    }.
    gsub(/([\*\/\-]{1,2})([^\1\<\>]+)(\1|\-\*)/) { |full, match|
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

end # === class Slash_Star_Link ===
