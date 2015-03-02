
describe 'italics' do

  it "turns slash-ed text into italics: /slash/ <i>slash</i>" do
    Touch_Up.new("This is my /slash/ text.").
      to_html.strip.should == "This is my <i>slash</i> text."
  end # === it turns slash-ed text into italics: /slash/ <i>slash</i>

  it "leaves surrounding chars alone: I am super-/slanted/." do
    Touch_Up.new("I am super-/slanted/.").
      to_html.should == "I am super-<i>slanted</i>."
  end

end # === describe 'italics'

describe "strong" do

  it "turns star-ed text to strong: *bold* <strong>bold</strong>" do
    Touch_Up.new("This is my brave and *bold* text.").
      to_html.strip.should == <<-EOF.strip
      This is my brave and <strong>bold</strong> text.
    EOF
  end # === it turns star-ed text to strong: *bold* <strong>bold</strong>

  it "leaves surrounding chars alone: I am super-*strong*." do
    Touch_Up.new("I am super*strong*.").
      to_html.should == "I am super<strong>strong</strong>."
  end

end # === describe "strong"

describe "strikethrough" do

  it "turns strikethrough text to :del: ~~del~~ <del>del</del>" do
    Touch_Up.new("This is my ~~old~~ text.").
      to_html.strip.should == "This is my <del>old</del> text."
  end # === it "turns strikethrough-ed text to strong: ~~del~~ <del>del</del>" do

  it "leaves surrounding chars alone: I am re~~deleted~~ed." do
    Touch_Up.new("I am re~~deleted~~ed.").
      to_html.should == "I am re<del>deleted</del>ed."
  end

end # === describe "strikethrough"

describe "linking" do

  it "turns text into links: *my link* google.com" do
    href="google.com"
    Touch_Up.new("This is *my link* #{href}.").
      to_html.should == "This is <a href=\"#{Escape_Escape_Escape.href "http://#{href}"}\">my link</a>."
  end

  it "turns only text with a period inside to links: text. vs my.text." do
    link  = "lewrockwell.com"
    clean = Escape_Escape_Escape.href "http://#{link}"
    Touch_Up.new(
      "This is *bold* text. This is my *link* #{link}."
    ).to_html.should ==
      "This is <strong>bold</strong> text. This is my <a href=\"#{clean}\">link</a>."
  end

  it "does not create invalid links: javascript://alert('text.text')" do
    link = "javascript://alert('text.text')"
    Touch_Up.new("This is my *link* #{link}.").
    to_html.should == "This is my <strong>link</strong> #{Escape_Escape_Escape.html link}."
  end

  it "ignores ending punctuation: .com." do
    text = Touch_Up.new "This is *my link* google.com."
    text.to_html.should == "This is <a href=\"http:&#47;&#47;google.com\">my link</a>."
  end

  it "ignores ending punctuation: .com?" do
    text = Touch_Up.new "Is it this google.com?"
    text.to_html.should == "Is it this <a href=\"http:&#47;&#47;google.com\">google.com</a>?"
  end

  it "ignores ending punctuation: .com!" do
    text = Touch_Up.new "Yes google.com!"
    text.to_html.should == "Yes <a href=\"http:&#47;&#47;google.com\">google.com</a>!"
  end

  it "allows a ? in the url, but ignores ending punctuation: my.website.com/?image?" do
    text = Touch_Up.new "Yes my.website.com/?image? Yes."
    text.to_html.should == "Yes <a href=\"http:&#47;&#47;my.website.com&#47;?image\">my.website.com&#47;?image</a>? Yes."
  end

  it "does not auto-link links in anchor tags: <a href=\"...\">..." do
    text = Touch_Up.new "*my* google.com. another.link."
    text.to_html.should == "<a href=\"http:&#47;&#47;google.com\">my</a>. <a href=\"http:&#47;&#47;another.link\">another.link</a>."
  end

  it "does not auto-link invalid urls: http://www.yahoo.com/&" do
    txt = "This is invalid: http://кц.рф"
    Touch_Up.new(txt).
      to_html.should == txt
  end

  it "does not double-escape hrefs" do
    href = Escape_Escape_Escape.href "http://www.google.com/"
    txt  = %^my link #{href}^
    Touch_Up.new(txt).
      to_html.should == %^my link <a href="#{href}">#{href}</a>^
  end

  it "escapes content for anchor tags" do
    href="www.google.com/?text=text&more=more"
    Touch_Up.new("my link #{href}").
      to_html.should == %^my link <a href="#{Escape_Escape_Escape.href 'http://' + href}">#{Escape_Escape_Escape.href href}</a>^
  end

end # === describe "linking"
