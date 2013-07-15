  def setup
    @kata = make_kata('Ruby-installed-and-working')
  def teardown
    Thread.current[:file] = nil
    Thread.current[:git] = nil
    Thread.current[:task] = nil
    system("rm -rf #{root_dir}/katas/*")
    system("rm -rf #{root_dir}/zips/*")    
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    avatar = Avatar.create(@kata, 'wolf')  # creates tag-0
    delta = {
      :changed => [ ],
      :unchanged => visible_files.keys,
      :deleted => [ ],
      :new => [ ]                                    
    }
    run_test(delta, avatar, visible_files)  # creates tag-1
    delta = {
      :changed => [ ],
      :unchanged => visible_files.keys - [ deleted_filename ],
      :deleted => [ deleted_filename ],
      :new => [ ]                                          
    }    
    run_test(delta, avatar, visible_files)  # creates tag-2    
    before = avatar.visible_files(tag=1)
          "before.keys.include?(#{deleted_filename})"          
    after = avatar.visible_files(tag=2)
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    avatar = Avatar.create(@kata, 'wolf') # 0
    delta = {
      :changed => [ ],
      :unchanged => visible_files.keys,
      :deleted => [ ],
      :new => [ ]                              
     }    
    run_test(delta, avatar, visible_files) # 1
    delta = {
      :changed => [ 'cyber-dojo.sh' ],
      :unchanged => visible_files.keys - [ 'cyber-dojo.sh' ],
      :deleted => [ ],
      :new => [ ]                              
     }
    run_test(delta, avatar, visible_files) # 2    
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
    avatar = Avatar.create(@kata, 'wolf') # 0
    delta = {
      :changed => [ ],
      :unchanged => visible_files.keys - [ added_filename ],
      :deleted => [ ],
      :new => [ added_filename ]                        
    }
    run_test(delta, avatar, visible_files) # 1
        "+#{content}"
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    avatar = Avatar.create(@kata, 'wolf') # 0
    
    delta = {
      :changed => [ deleted_filename ],
      :unchanged => visible_files.keys - [ deleted_filename ],
      :deleted => [ ],
      :new => [ ]                  
    }    
    run_test(delta, avatar, visible_files)  # 1
    #- - - - -
    delta = {
      :changed => [ ],
      :unchanged => visible_files.keys - [ deleted_filename ],
      :deleted => [ deleted_filename ],
      :new => [ ]                        
    }
    run_test(delta, avatar, visible_files)  # 2    
    #- - - - -
    assert actual.include?(expected), actual
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test "output is correct on refresh" do
    language = 'Ruby-installed-and-working'
    kata = make_kata(language)
    avatar = Avatar.create(kata, 'lion')
    visible_files = avatar.visible_files
    delta = {
      :changed => visible_files.keys,
      :unchanged => [ ],
      :deleted => [ ],
      :new => [ ]      
    }        
    output = run_test(delta, avatar, visible_files)
    visible_files['output'] = output    
    traffic_light = { :colour => 'amber' }
    avatar.save_run_tests(visible_files, traffic_light)    
    # now refresh
    avatar = Avatar.new(kata, 'lion')
    assert_equal output, avatar.visible_files['output']
  end    