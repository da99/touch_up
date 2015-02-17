
describe 'it runs' do

  it "turns slash-ed text into italics: /slash/ <i>slash</i>" do
    text = Slash_Star_Link.new(<<-EOF)
      This is my /slash/ text.
    EOF
    text.to_html.strip.should == <<-EOF.strip
      This is my <i>slash</i> text.
    EOF
  end # === it turns slash-ed text into italics: /slash/ <i>slash</i>

  it "turns star-ed text to strong: *bold* <strong>bold</strong>" do
    text = Slash_Star_Link.new(<<-EOF)
      This is my brave and *bold* text.
    EOF
    text.to_html.strip.should == <<-EOF.strip
      This is my brave and <strong>bold</strong> text.
    EOF
  end # === it turns star-ed text to strong: *bold* <strong>bold</strong>

  it "turns star-dash-ed text to strong: *-del-* <del>del</del>" do
    text = Slash_Star_Link.new(<<-EOF)
      This is my *-old-* text.
    EOF
    text.to_html.strip.should == <<-EOF.strip
      This is my <del>old</del> text.
    EOF
  end # === it "turns star-dash-ed text to strong: *-del-* <del>del</del>" do

  it "turns text into links: *my link* google.com" do
    text = Slash_Star_Link.new "This is *my link* google.com."
    text.to_html.should == "This is <a href=\"http://google.com\">my link</a>."
  end

  it "turns only text with a period inside to links: text. vs my.text." do
    text = Slash_Star_Link.new "This is *bold* text. This is my *link* lewrockwell.com."
    text.to_html.should == "This is <strong>bold</strong> text. This is my <a href=\"http://lewrockwell.com\">link</a>."
  end

  it "does not create invalid links: javascript://alert('text.text')" do
    text = Slash_Star_Link.new "This is my *link* javascript://alert('text.text')."
    text.to_html['href'].should.not == 'href'
  end

end # === describe 'it runs'
