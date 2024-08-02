# react-native-beldex-core

This library packages Beldex C++ crypto methods for use on React Native.

It has a single default export that mostly matches the `WABridge` interface found in [@bdxi/beldex-client](https://github.com/Beldex-Coin/react-native-beldex-core.git). The big difference is that react-native-beldex-core only has async methods, whereas many of the upstream `WABridge` methods are synchronous.

## Usage

First, add this library to your React Native app using NPM or Yarn, and run `pod install` as necessary to integrate it with your app's native code.

Here is a simple usage example. Note the `await` on the method call, but not on the require:

```js
const bridge = require('react-native-beldex-core')

const addressInfo = await bridge.decodeAddress('...', 'MAINNET')
```

You can also use ES6 imports if you prefer:

```js
import bridge from 'react-native-beldex-core'
```

We have types too, if you need those:

```ts
import type { CppBridge } from 'react-native-beldex-core'
```

The available methods are:

- addressAndKeysFromSeed
- compareMnemonics
- createTransaction
- decodeAddress
- estimateTxFee
- generateKeyImage
- generatePaymentId
- generateWallet
- isIntegratedAddress
- isSubaddress
- isValidKeys
- mnemonicFromSeed
- newIntegratedAddress
- seedAndKeysFromMnemonic

See the documentation at [@bdxi/beldex-client](https://github.com/Beldex-Coin/beldex-utils/tree/master/packages/beldex-client) for more information.

## Developing

This library relies on a large amount of native C++ code from other repos. To integrate this code, you must run the following script before publishing this library to NPM:

```sh
npm run update-sources
```

This script does the following tasks:

- Download third-party source code.
- Set up the Android build system:
  - Determine which C++ headers are actually necessary.
  - Copy the necessary sources into `android/src/main/cpp`.
  - Assemble `CMakeLists.txt`.
- Compile an iOS universal static library and put it into an XCFramework.
- Generate Flow types from the TypeScript definitions.

The `update-sources` script is also the place to make edits when upgrading any of the third-party dependencies. The react-native-beldex-core repo doesn't include these third-party C++ sources, since they are enormous.
