
describe 'escaping' do

  it "escapes text" do
    text = "<strong>text</strong>"
    actual = Touch_Up.new("#{text} *text*").to_html

    actual.should == "#{Escape_Escape_Escape.html text} <strong>text</strong>"
  end # === it escapes text

  it "accepts escaped text, w/o double escaping it" do
    text = "<strong>e</strong>"
    actual = Touch_Up.new(
      Escape_Escape_Escape.html "#{text} *text*"
    ).to_html

    actual.should == "#{Escape_Escape_Escape.html text} <strong>text</strong>"
  end # === it accespts escaped text, w/o double escaping it

  it "escapes :href, not just html" do
    href = "http://www.example.com/?test='test"
    e_href = Escape_Escape_Escape.href(href)
    actual = Touch_Up.new("*my href* #{href}").to_html

    actual.should == %^<a href="#{e_href}">my href</a>^
  end # === it escapes :href, not just html

  it "escapes content of :a tags" do
    href = "http://www.example.com/"
    e_href = Escape_Escape_Escape.href(href)

    text = "my <href>"
    e_text = Escape_Escape_Escape.html(text)
    actual = Touch_Up.new("*#{text}* #{href}").to_html

    actual.should == %^<a href="#{e_href}">#{e_text}</a>^
  end # === it escapes content of :a tags

end # === describe 'escaping'

