
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

end # === describe 'it runs'
