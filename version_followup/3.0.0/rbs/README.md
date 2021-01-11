# ruby 3.0.0 RBS

[Official README](https://github.com/ruby/rbs)

## typeprof

```sh
typeprof example.rb -o example.rbs
```

## rbs

```sh
rbs -I . method ChatApp::Message reply
# output
::ChatApp::Message#reply
  defined_in: ::ChatApp::Message
  implementation: ::ChatApp::Message
  accessibility: public
  types:
      (string: ::String, from: ::ChatApp::Bot | ::ChatApp::User) -> ::ChatApp::Message
# 
```