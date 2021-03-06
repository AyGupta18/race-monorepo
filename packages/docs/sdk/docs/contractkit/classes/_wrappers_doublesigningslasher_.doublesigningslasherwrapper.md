[@celo/contractkit](../README.md) › ["wrappers/DoubleSigningSlasher"](../modules/_wrappers_doublesigningslasher_.md) › [DoubleSigningSlasherWrapper](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md)

# Class: DoubleSigningSlasherWrapper

Contract handling slashing for Validator double-signing

## Hierarchy

  ↳ [BaseSlasher](_wrappers_baseslasher_.baseslasher.md)‹DoubleSigningSlasher›

  ↳ **DoubleSigningSlasherWrapper**

## Index

### Constructors

* [constructor](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#constructor)

### Properties

* [eventTypes](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#eventtypes)
* [events](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#events)
* [methodIds](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#methodids)
* [slashingIncentives](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#slashingincentives)

### Accessors

* [address](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#address)

### Methods

* [getBlockNumberFromHeader](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#getblocknumberfromheader)
* [getPastEvents](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#getpastevents)
* [slashSigner](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#slashsigner)
* [slashValidator](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#slashvalidator)
* [version](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md#version)

## Constructors

###  constructor

\+ **new DoubleSigningSlasherWrapper**(`kit`: [ContractKit](_kit_.contractkit.md), `contract`: DoubleSigningSlasher): *[DoubleSigningSlasherWrapper](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md)*

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[constructor](_wrappers_basewrapper_.basewrapper.md#constructor)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:30](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L30)*

**Parameters:**

Name | Type |
------ | ------ |
`kit` | [ContractKit](_kit_.contractkit.md) |
`contract` | DoubleSigningSlasher |

**Returns:** *[DoubleSigningSlasherWrapper](_wrappers_doublesigningslasher_.doublesigningslasherwrapper.md)*

## Properties

###  eventTypes

• **eventTypes**: *EventsEnum‹T›* = Object.keys(this.events).reduce<EventsEnum<T>>(
    (acc, key) => ({ ...acc, [key]: key }),
    {} as any
  )

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[eventTypes](_wrappers_basewrapper_.basewrapper.md#eventtypes)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:61](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L61)*

___

###  events

• **events**: *DoubleSigningSlasher["events"]* = this.contract.events

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[events](_wrappers_basewrapper_.basewrapper.md#events)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:59](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L59)*

___

###  methodIds

• **methodIds**: *Record‹keyof T["methods"], string›* = Object.keys(this.contract.methods).reduce<Record<Methods<T>, string>>(
    (acc, method: Methods<T>) => {
      const methodABI = this.contract.options.jsonInterface.find((item) => item.name === method)

      acc[method] =
        methodABI === undefined
          ? '0x'
          : this.kit.connection.getAbiCoder().encodeFunctionSignature(methodABI)

      return acc
    },
    {} as any
  )

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[methodIds](_wrappers_basewrapper_.basewrapper.md#methodids)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:66](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L66)*

___

###  slashingIncentives

• **slashingIncentives**: *function* = proxyCall(
    this.contract.methods.slashingIncentives,
    undefined,
    (res) => ({
      reward: valueToBigNumber(res.reward),
      penalty: valueToBigNumber(res.penalty),
    })
  )

*Inherited from [BaseSlasher](_wrappers_baseslasher_.baseslasher.md).[slashingIncentives](_wrappers_baseslasher_.baseslasher.md#slashingincentives)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseSlasher.ts:69](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseSlasher.ts#L69)*

Returns slashing incentives.

**`returns`** Rewards and penalties for slashing.

#### Type declaration:

▸ (...`args`: InputArgs): *Promise‹Output›*

**Parameters:**

Name | Type |
------ | ------ |
`...args` | InputArgs |

## Accessors

###  address

• **get address**(): *string*

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[address](_wrappers_basewrapper_.basewrapper.md#address)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:35](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L35)*

Contract address

**Returns:** *string*

## Methods

###  getBlockNumberFromHeader

▸ **getBlockNumberFromHeader**(`header`: string): *Promise‹number›*

*Defined in [packages/sdk/contractkit/src/wrappers/DoubleSigningSlasher.ts:15](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/DoubleSigningSlasher.ts#L15)*

Parses block number out of header.

**Parameters:**

Name | Type | Description |
------ | ------ | ------ |
`header` | string | RLP encoded header |

**Returns:** *Promise‹number›*

Block number.

___

###  getPastEvents

▸ **getPastEvents**(`event`: Events‹DoubleSigningSlasher›, `options`: PastEventOptions): *Promise‹EventLog[]›*

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[getPastEvents](_wrappers_basewrapper_.basewrapper.md#getpastevents)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:55](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L55)*

Contract getPastEvents

**Parameters:**

Name | Type |
------ | ------ |
`event` | Events‹DoubleSigningSlasher› |
`options` | PastEventOptions |

**Returns:** *Promise‹EventLog[]›*

___

###  slashSigner

▸ **slashSigner**(`signerAddress`: Address, `headerA`: string, `headerB`: string): *Promise‹CeloTransactionObject‹void››*

*Defined in [packages/sdk/contractkit/src/wrappers/DoubleSigningSlasher.ts:38](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/DoubleSigningSlasher.ts#L38)*

Slash a Validator signer for double-signing.

**Parameters:**

Name | Type | Description |
------ | ------ | ------ |
`signerAddress` | Address | - |
`headerA` | string | First double signed block header. |
`headerB` | string | Second double signed block header.  |

**Returns:** *Promise‹CeloTransactionObject‹void››*

___

###  slashValidator

▸ **slashValidator**(`validatorAddress`: Address, `headerA`: string, `headerB`: string): *Promise‹CeloTransactionObject‹void››*

*Defined in [packages/sdk/contractkit/src/wrappers/DoubleSigningSlasher.ts:26](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/DoubleSigningSlasher.ts#L26)*

Slash a Validator for double-signing.

**Parameters:**

Name | Type | Description |
------ | ------ | ------ |
`validatorAddress` | Address | Validator to slash. |
`headerA` | string | First double signed block header. |
`headerB` | string | Second double signed block header.  |

**Returns:** *Promise‹CeloTransactionObject‹void››*

___

###  version

▸ **version**(): *Promise‹NonNullable‹T["methods"] extends object ? ContractVersion<> : never››*

*Inherited from [BaseWrapper](_wrappers_basewrapper_.basewrapper.md).[version](_wrappers_basewrapper_.basewrapper.md#version)*

*Defined in [packages/sdk/contractkit/src/wrappers/BaseWrapper.ts:39](https://github.com/celo-org/celo-monorepo/blob/master/packages/sdk/contractkit/src/wrappers/BaseWrapper.ts#L39)*

**Returns:** *Promise‹NonNullable‹T["methods"] extends object ? ContractVersion<> : never››*
