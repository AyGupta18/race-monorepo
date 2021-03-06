[@celo/utils](../README.md) › ["packages/sdk/utils/src/address"](_packages_sdk_utils_src_address_.md)

# Module: "packages/sdk/utils/src/address"

## Index

### References

* [Address](_packages_sdk_utils_src_address_.md#address)
* [NULL_ADDRESS](_packages_sdk_utils_src_address_.md#null_address)
* [bufferToHex](_packages_sdk_utils_src_address_.md#buffertohex)
* [ensureLeading0x](_packages_sdk_utils_src_address_.md#ensureleading0x)
* [eqAddress](_packages_sdk_utils_src_address_.md#eqaddress)
* [findAddressIndex](_packages_sdk_utils_src_address_.md#findaddressindex)
* [getAddressChunks](_packages_sdk_utils_src_address_.md#getaddresschunks)
* [hexToBuffer](_packages_sdk_utils_src_address_.md#hextobuffer)
* [isHexString](_packages_sdk_utils_src_address_.md#ishexstring)
* [isValidChecksumAddress](_packages_sdk_utils_src_address_.md#isvalidchecksumaddress)
* [mapAddressListDataOnto](_packages_sdk_utils_src_address_.md#mapaddresslistdataonto)
* [mapAddressListOnto](_packages_sdk_utils_src_address_.md#mapaddresslistonto)
* [normalizeAddress](_packages_sdk_utils_src_address_.md#normalizeaddress)
* [normalizeAddressWith0x](_packages_sdk_utils_src_address_.md#normalizeaddresswith0x)
* [toChecksumAddress](_packages_sdk_utils_src_address_.md#tochecksumaddress)
* [trimLeading0x](_packages_sdk_utils_src_address_.md#trimleading0x)

### Functions

* [isValidAddress](_packages_sdk_utils_src_address_.md#const-isvalidaddress)
* [isValidPrivateKey](_packages_sdk_utils_src_address_.md#const-isvalidprivatekey)
* [privateKeyToAddress](_packages_sdk_utils_src_address_.md#const-privatekeytoaddress)
* [privateKeyToPublicKey](_packages_sdk_utils_src_address_.md#const-privatekeytopublickey)
* [publicKeyToAddress](_packages_sdk_utils_src_address_.md#const-publickeytoaddress)

## References

###  Address

• **Address**:

___

###  NULL_ADDRESS

• **NULL_ADDRESS**:

___

###  bufferToHex

• **bufferToHex**:

___

###  ensureLeading0x

• **ensureLeading0x**:

___

###  eqAddress

• **eqAddress**:

___

###  findAddressIndex

• **findAddressIndex**:

___

###  getAddressChunks

• **getAddressChunks**:

___

###  hexToBuffer

• **hexToBuffer**:

___

###  isHexString

• **isHexString**:

___

###  isValidChecksumAddress

• **isValidChecksumAddress**:

___

###  mapAddressListDataOnto

• **mapAddressListDataOnto**:

___

###  mapAddressListOnto

• **mapAddressListOnto**:

___

###  normalizeAddress

• **normalizeAddress**:

___

###  normalizeAddressWith0x

• **normalizeAddressWith0x**:

___

###  toChecksumAddress

• **toChecksumAddress**:

___

###  trimLeading0x

• **trimLeading0x**:

## Functions

### `Const` isValidAddress

▸ **isValidAddress**(`input`: string): *boolean*

*Defined in [packages/sdk/utils/src/address.ts:46](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/utils/src/address.ts#L46)*

**Parameters:**

Name | Type |
------ | ------ |
`input` | string |

**Returns:** *boolean*

___

### `Const` isValidPrivateKey

▸ **isValidPrivateKey**(`privateKey`: string): *boolean*

*Defined in [packages/sdk/utils/src/address.ts:43](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/utils/src/address.ts#L43)*

**Parameters:**

Name | Type |
------ | ------ |
`privateKey` | string |

**Returns:** *boolean*

___

### `Const` privateKeyToAddress

▸ **privateKeyToAddress**(`privateKey`: string): *string*

*Defined in [packages/sdk/utils/src/address.ts:32](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/utils/src/address.ts#L32)*

**Parameters:**

Name | Type |
------ | ------ |
`privateKey` | string |

**Returns:** *string*

___

### `Const` privateKeyToPublicKey

▸ **privateKeyToPublicKey**(`privateKey`: string): *string*

*Defined in [packages/sdk/utils/src/address.ts:35](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/utils/src/address.ts#L35)*

**Parameters:**

Name | Type |
------ | ------ |
`privateKey` | string |

**Returns:** *string*

___

### `Const` publicKeyToAddress

▸ **publicKeyToAddress**(`publicKey`: string): *string*

*Defined in [packages/sdk/utils/src/address.ts:38](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/utils/src/address.ts#L38)*

**Parameters:**

Name | Type |
------ | ------ |
`publicKey` | string |

**Returns:** *string*
