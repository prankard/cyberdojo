
class Exercise

  def initialize(kata)
    @kata = kata
  end

  def manifest
    m = eval IO.read(folder + '/' + 'exercise_manifest.rb')
    m[:visible_files].each do |filename,file|
      file[:content] = IO.read(folder + '/' + filename)
    end
    m
  end

  def visible_files
    manifest[:visible_files]
  end

  def hidden_files
    if manifest[:hidden_files]
      manifest[:hidden_files]
    else
      {}
    end
  end

  def unit_test_framework
    manifest[:unit_test_framework]
  end

  def folder
    'languages' + '/' + @kata.language
  end
   
end


