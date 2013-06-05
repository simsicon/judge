# Judge

Spam filter supports Chinese segmentation, based on bayesian inference algorithm.

## Installation

Add this line to your application's Gemfile:

    gem 'judge', git: 'git://github.com/simsicon/judge.git'

And then execute:

    $ bundle

## Usage

### Train your corpus

```
rake -T

rake judge:train_and_export_corpus[normal_path,spam_path]

```

### Judge after properly trained

```
Judge.spam?('今天我吃了一个煎饼果子') # => false
Judge.spam?('肥胖减肥星座水瓶座') # => true
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
