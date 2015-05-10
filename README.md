Lib Integration Test
====================

This repository contains integration tests to test the compatibility of the
Shamir's Secret Sharing libraries developed for the project duse.

Build the docker image

	docker build -t duse-integration-test .

Then run the test

	docker run --rm duse-integration-test

The at the end output should be something like this

```
RESULTS
Secret:
test

Ruby
Ruby-Shares:
1-2aa4e9d4,2-46b059b4
Ruby-Output:
test

Dart
Dart-Shares:
1-1ad178c1,2-2709778e,3-3341765b
Dart-Output:
test
```

If the the output of both is tests, then it worked.
