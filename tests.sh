#!/bin/bash

echo
ruby --version
dart --version
pub --version
echo

rm -rf ruby
git clone https://github.com/flower-pot/secret_sharing.git ruby
(cd ruby && bundle install --without development test && rake install)

rm -rf dart
git clone https://github.com/Adracus/secret-sharing-dart.git dart
(cd dart && pub get)

SECRET="test"

cd ruby
RUBY_SHARES=`echo "require 'secret_sharing'
shares = SecretSharing.split('$SECRET', 2, 3)
puts shares[0..1].join(',')" | ruby`
cd ..

cd dart
DART_OUTPUT=`dart bin/secret_decoder.dart --shares $RUBY_SHARES`
DART_SHARES=`dart bin/secret_encoder.dart --total 3 --needed 2 --secret $SECRET`
cd ..

cd ruby
RUBY_OUTPUT=`echo "require 'secret_sharing'
shares = \"$RUBY_SHARES\".split(',')[0..1]
puts SecretSharing.reconstruct(shares)" | ruby`
cd ..

echo
echo
echo "RESULTS"
echo "Secret:"
echo $SECRET
echo
echo "Ruby"
echo "Ruby-Shares:"
echo $RUBY_SHARES
echo "Ruby-Output:"
echo $RUBY_OUTPUT
echo
echo "Dart"
echo "Dart-Shares:"
echo $DART_SHARES
echo "Dart-Output:"
echo $DART_OUTPUT
echo


if [ "$SECRET" != "$RUBY_OUTPUT" ];
then
  echo "Ruby decoding error"
  exit 1
fi

if [ "$SECRET" != "$DART_OUTPUT" ];
then
  echo "Dart decoding error"
  exit 1
fi

echo
rm -rf ruby
rm -rf dart
