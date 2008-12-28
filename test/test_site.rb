require File.dirname(__FILE__) + '/helper'

class TestSite < Test::Unit::TestCase
  def setup
    source = File.join(File.dirname(__FILE__), *%w[source])
    @s = Site.new(source, dest_dir)
  end
  
  def test_site_init
    
  end
  
  def test_read_layouts
    @s.read_layouts
    
    assert_equal ["default", "simple"].sort, @s.layouts.keys.sort
  end
 
  def test_read_posts
    @s.read_posts(File.join(@s.source, '_posts'))
    
    assert_equal 4, @s.posts.size
  end

  def test_tags_name
    @s.read_posts(File.join(@s.source, '_posts'))

    assert_equal ["best", "complex", "markdown"], @s.tags.collect {|tag| tag.name}
 
    assert_equal 2, @s.tags[0].count
    assert_equal 1, @s.tags[1].count
    assert_equal 1, @s.tags[2].count
  end

  def test_tags_count
    @s.read_posts(File.join(@s.source, '_posts'))

  end
  
  def test_write_posts
    clear_dest
    
    @s.process
  end
end
