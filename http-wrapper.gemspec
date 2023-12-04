# frozen_string_literal: true

require_relative "lib/http/wrapper/version"

Gem::Specification.new do |spec|
  spec.name = "http-wrapper"
  spec.version = Http::Wrapper::VERSION
  spec.authors = ["Pablo Peuscovich"]
  spec.email = ["ppeusco@gmail.com"]

  spec.summary = "HTTP Wrapper Gem."
  spec.description = "A Ruby gem for wrapping HTTP requests in a convenient way."
  spec.homepage = "https://github.com/ppeusco-dev/http-wrapper.git"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/ppeusco-dev/http-wrapper.git"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 2.7", ">= 2.7.11"
  spec.add_dependency "oj", "~> 3.16", ">= 3.16.1"
  spec.add_dependency "rspec", "~> 3.11", ">= 3.11.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug", "~> 11.1", ">= 11.1.3"
  spec.add_development_dependency "rake", "~> 13.1"
  spec.add_development_dependency "rspec-rails", "~> 6.0", ">= 6.0.3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
