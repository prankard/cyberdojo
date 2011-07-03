require 'GitDiffParser'
class GitDiffParserTests < ActionController::TestCase 
  include GitDiff
  
    was_line =  '--- a/sand box/xxx'
    assert_equal 'a/sand box/xxx', 
      GitDiffParser.new(was_line).parse_was_filename
    was_line =  '--- a/sandbox/xxx'
    assert_equal 'a/sandbox/xxx', 
      GitDiffParser.new(was_line).parse_was_filename
      now_line = '+++ /dev/null'
      assert_equal '/dev/null',
      GitDiffParser.new(now_line).parse_now_filename
    was_line =  '--- /dev/null'
    assert_equal '/dev/null', 
      GitDiffParser.new(was_line).parse_was_filename
    now_line = '+++ b/sandbox/untitled_6TJ'
    assert_equal 'b/sandbox/untitled_6TJ',
      GitDiffParser.new(now_line).parse_now_filename