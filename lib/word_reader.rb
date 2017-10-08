class WordReader
  def read_from_file(file_name)
    if File.exist?(file_name)
      lines = File.readlines(file_name).sample.chomp
    else
      raise "Запрашиваемый файл отсутствует!"
    end
  end
end
