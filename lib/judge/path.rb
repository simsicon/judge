module Judge
  class<<self
      
    def root
      File.expand_path '../../..', __FILE__
    end

    def corpus_yaml_file_path
      @corpus_yaml_file_path ||= begin
        _dir = File.join(Judge.root, 'corpus')
        _path = File.join(_dir, 'corpus.yml')
        Dir.mkdir(_dir) unless Dir.exist?(_dir)
        File.open(_path, 'w'){} unless File.exist? _path
        _path
      end
    end

  end
end