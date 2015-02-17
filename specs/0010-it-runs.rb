
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

end # === describe 'it runs'