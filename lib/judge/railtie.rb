require 'rails'

module Judge
  class Railtie < Rails::Railtie
    railtie_name :judge

    rake_tasks do
      load File.join(Judge.root, "tasks/judge.rake")
    end
  end
end