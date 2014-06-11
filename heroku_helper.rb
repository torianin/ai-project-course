$str, t = "", nil
Shoes.app :height => 150, :width => 450 do
  background "../static/menu-gray.png"
  background "../static/menu-top.png", :height => 50
  background "../static/menu-left.png", :top => 50, :width => 55
  background "../static/menu-right.png", :right => 0, :top => 50, :width => 55
  image "../static/menu-corner1.png", :top => 0, :left => 0
  image "../static/menu-corner2.png", :right => 0, :top => 0

  background rgb(77, 77, 77)

  stack :margin => 10 do
    para span("Update aplikacji", :stroke => red, :fill => white), " * alt-q, żeby wyjść", :stroke => white
  end

  stack :margin => 10 do
    t = para "", :font => "Monospace 12px", :stroke => white
    t.cursor = -1
  end

  stack :margin => 10 do
    button "Aktualizuj" do
      `./sync.sh \"#{$str}\"`
      $str = ""    
      t.replace $str
    end
  end

  keypress do |k|
    case k
    when String
      $str += k
    when :backspace
      $str.slice!(-1)
    when :tab
      $str += "  "
    when :alt_q
      quit
    when :alt_c
      self.clipboard = $str
    when :alt_v
      $str += self.clipboard
    end
    t.replace $str
  end
end
