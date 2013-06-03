require 'spec_helper'

describe Judge::Trainer do
  let(:trainer) do
    Judge::Trainer.new
  end

  it "train corpus" do
    trainer.corpus.class.should be Hash
    trainer.corpus.should_not be_empty
  end

  it "judge text is spam" do
    trainer.spam?('肥胖减肥星座水瓶座').should be_true
    trainer.spam?('今天我吃了一个煎饼果子').should be_false
    trainer.spam?('据阿塞拜疆媒体爆料，女排名将魏秋月新赛季将赴海外打球，有望加盟阿塞拜疆的伊蒂萨奇俱乐部征战阿塞拜疆超级联赛和欧冠。。').should be_false
    trainer.spam?('真心没上集好看，卷福和spark是唯一的亮点，舰长绝对的配角，非星际迷建议表浪费时间了').should be_false
    trainer.spam?('深圳一名小学生上学途中，一辆汽车突然撞了过来。身后的张老师危急时刻一把将他推开，自己却被撞倒，车轮从她左腿轧了过去。直至孩子家长写信感谢，此事才被周知。张老师说，这没什么，只是出于一种本能。人间自有真情在，祝她早日康复！').should be_false
    trainer.spam?('西南大学 宋妍琦 生日：10月21日。星座：天秤座，(快生日了哦 )身高：168cm，体重：46kg，三围： 83 60 82，淘女郎、为多品牌服饰做过模特，气质清纯高雅，微笑中带着妩媚，楚楚动人').should be_true
    trainer.spam?('华硕,华擎,你们两家谁提前搞出来"在线主题"提供UEFI BIOS的主题下载和换肤功能,再搞一个1~2元下载的生态圈,你们就赢了,看看小米就知道了').should be_false
    trainer.spam?('中国是全世界对道歉需求量最大的国家，就像对奶粉的需求一样。中新社批评李娜，顺带又批评她在北京奥运要观众闭嘴的举动').should be_false
  end

end