
class Slash_Star_Link

  class << self
  end # === class self ===

  def initialize str
    @origin = str
  end

  def to_html
    @origin.
      gsub(/([\/\*\-]{1,2})([^\1]+)(\1)/) { |full, match|
      case
      when $1 == $3 && $1 == '/'
        "<i>#{$2}</i>"
      when $1 == $3 && $1 == '*'
        "<strong>#{$2}</strong>"
      when $1 == $3 && $1 == '--'
        "<strike>#{$2}</strike>"
      else
        full
      end
    }
  end

end # === class Slash_Star_Link ===
