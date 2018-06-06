require 'onceover/rake_tasks'
require 'puppetlabs_spec_helper/rake_tasks'

PuppetSyntax.hieradata_paths = ['**/hiera.yaml', '**/data/**/*.yaml']
PuppetSyntax.check_hiera_keys = true
PuppetSyntax.exclude_paths = ['module/**/*', 'vendor/**/*']

PuppetLint::RakeTask.new :lint do |config|
  config.pattern = 'site/*/manifests/**/*.pp'
  config.fail_on_warnings = true
end
