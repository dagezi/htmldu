require 'json'

module Htmldu
  class Dirtree
    attr_reader :path, :name, :root, :blocks, :children, :accurate
         
    BLOCK_SIZE=512

    def initialize(root, name = nil)
      @root = root
      @name = name
      @path = name ? File.join(root, name) : root
    end

    def generate_tree()
      blocks = 0
      accurate = true
      @children = []
      Dir.foreach(@path) do |name|
        next if name == '.' or name == '..'
        path = File.join(@path, name)
        begin
          stat = File.lstat(path)
          blocks += stat.blocks

          if stat.directory? and !stat.symlink?
            child = Dirtree.new(@path, name)
            child.generate_tree
            @children << child
            blocks += child.blocks
            accurate &&= child.accurate
          end
        rescue => e
          accurate = false
        end
      end
      @blocks = blocks
      @accurate = accurate
    end

    def to_json(json: '')
      json << "{\"name\":\"#{@name}\","
      json << "\"path\":\"#{@path}\","
      json << "\"blocks\":#{@blocks},"
      json << "\"accurate\":#{@accurate},"
      json << '"children":['
      c = ''
      @children.each { |dir|
        json << c
        dir.to_json(json: json)
        c = ','
      }
      json << ']}'
    end
  end
end
