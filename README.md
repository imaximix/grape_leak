# grape_leak

```
bundle
bundle exec rspec
```


The failing test case (leak_spec.rb) checks for the no. of `Grape::Router::Route` objects created.
Commenting api.rb:19 line makes the test pass.
