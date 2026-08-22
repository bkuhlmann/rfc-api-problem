# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "rfc-api-problem"
  spec.version = "0.0.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/rfc-api-problem"
  spec.summary = "A RFC 9457 Problem Details for HTTP APIs implementation."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/rfc-api-problem/issues",
    "changelog_uri" => "https://alchemists.io/projects/rfc-api-problem/versions",
    "homepage_uri" => "https://alchemists.io/projects/rfc-api-problem",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "RFC API Problem",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/rfc-api-problem"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = ">= 4.0"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
