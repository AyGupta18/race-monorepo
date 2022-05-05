const { log } = require('firebase-functions/lib/logger')

export enum ExecutionResult {
  Ok = 'Ok',
  /** Enqued Faucet Request has invalid type */
  InvalidRequestErr = 'InvalidRequestErr',
  /** Failed to obtain a free acount to faucet from */
  NoFreeAccountErr = 'NoFreeAccountErr',
  /** Faucet Action timed out */
  ActionTimedOutErr = 'ActionTimedOutErr',
  OtherErr = 'OtherErr',
}

export function logExecutionResult(snapKey: string, result: ExecutionResult) {
  log(`${snapKey}: Faucet result was ${result}`, {
    event: 'celo/faucet/result',
    executionResult: result,
    failed: result !== ExecutionResult.Ok,
    snapKey,
  })
}
