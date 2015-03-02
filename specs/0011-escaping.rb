
describe 'escaping' do

  it "escapes text" do
    actual = Touch_Up.new(
      "<strong>text</strong> *text*"
    ).to_html

    actual.should == Escape_Escape_Escape.html(
      "<strong>text</strong> <strong>text</strong>"
    )
  end # === it escapes text

  it "accespts escaped text, w/o double escaping it" do
    actual = Touch_Up.new(
      Escape_Escape_Escape.html "<strong>text</strong> *text*"
    ).to_html

    actual.should == Escape_Escape_Escape.html(
      "<strong>text</strong> <strong>text</strong>"
    )
  end # === it accespts escaped text, w/o double escaping it

end # === describe 'escaping'

