class JSGirls

  # JSGirls
  def jsgirls
    @jsgirls
  end

  # Items formatted for Alfred
  def alfred_items
    @alfred_items
  end

  # JSGirls constructor
  def initialize(query = '')
    @jsgirls = load_jsgirls
    @alfred_items = []
    select!(query.split)
  end

  # Load JSGirls from jsgirls folder
  def load_jsgirls
    Dir.glob("./jsgirls/*.png").map do |path|
      File.basename(path, ".png")
    end.compact.uniq.sort
  end

  # Filter with query
  def select!(queries, jsgirls = @jsgirls)
    queries.each do |query|
      jsgirls.reject! do |jsgirl|
        jsgirl.index(query.downcase) ? false : true
      end
    end
  end

  # Get Alfred items
  def get_items(alfred_items = @alfred_items, jsgirls = @jsgirls)
    jsgirls.each do |jsgirl|
      alfred_items.push(format_item(jsgirl))
    end
    alfred_items
  end

  # Format for Alfred
  def format_item(jsgirl)
    {
        :uid      => "",
        :title    => jsgirl,
        :subtitle => "Copy to clipboard #{jsgirl} URL",
        :arg      => jsgirl,
        :icon     => { :type => "default", :name => "./jsgirls/#{jsgirl}.png" },
        :valid    => "yes",
    }
  end

end