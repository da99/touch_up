
describe 'it runs' do

  it "turns slash-ed text into italics: /slash/ <i>slash</i>" do
    text = Touch_Up.new(<<-EOF)
      This is my /slash/ text.
    EOF
    text.to_html.strip.should == <<-EOF.strip
      This is my <i>slash</i> text.
    EOF
  end # === it turns slash-ed text into italics: /slash/ <i>slash</i>

  it "turns star-ed text to strong: *bold* <strong>bold</strong>" do
    text = Touch_Up.new(<<-EOF)
      This is my brave and *bold* text.
    EOF
    text.to_html.strip.should == <<-EOF.strip
      This is my brave and <strong>bold</strong> text.
    EOF
  end # === it turns star-ed text to strong: *bold* <strong>bold</strong>

  it "turns star-dash-ed text to strong: *-del-* <del>del</del>" do
    text = Touch_Up.new(<<-EOF)
      This is my *-old-* text.
    EOF
    text.to_html.strip.should == <<-EOF.strip
      This is my <del>old</del> text.
    EOF
  end # === it "turns star-dash-ed text to strong: *-del-* <del>del</del>" do

end # === describe 'it runs'

describe "linking" do

  it "turns text into links: *my link* google.com" do
    text = Touch_Up.new "This is *my link* google.com."
    text.to_html.should == "This is <a href=\"http:&#47;&#47;google.com\">my link</a>."
  end

  it "turns only text with a period inside to links: text. vs my.text." do
    text = Touch_Up.new "This is *bold* text. This is my *link* lewrockwell.com."
    text.to_html.should == "This is <strong>bold</strong> text. This is my <a href=\"http:&#47;&#47;lewrockwell.com\">link</a>."
  end

  it "does not create invalid links: javascript://alert('text.text')" do
    Touch_Up.new("This is my *link* javascript://alert('text.text').").
    to_html.should == "This is my <strong>link</strong> javascript://alert('text.text')."
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
    text.to_html.should == "Yes <a href=\"http:&#47;&#47;my.website.com&#47;?image\">my.website.com/?image</a>? Yes."
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

end # === describe "linking"
