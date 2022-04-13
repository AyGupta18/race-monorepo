import { RaceTokenWrapper } from '@celo/contractkit/lib/wrappers/RaceTokenWrapper'
import { StableTokenWrapper } from '@celo/contractkit/lib/wrappers/StableTokenWrapper'
import { BigNumber } from 'bignumber.js'

export async function convertToContractDecimals(
  value: number | BigNumber,
  contract: StableTokenWrapper | RaceTokenWrapper
) {
  const decimals = new BigNumber(await contract.decimals())
  const one = new BigNumber(10).pow(decimals.toNumber())
  return one.times(value)
}
