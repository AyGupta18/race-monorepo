import { ErrorMessage, rootLogger as logger } from '@celo/phone-number-privacy-common'
import { AzureKeyVaultClient } from '@celo/wallet-hsm-azure'
import config from '../config'
import { KeyProviderBase } from './key-provider-base'

export class AzureKeyProvider extends KeyProviderBase {
  public async fetchPrivateKeyFromStore() {
    try {
      const { vaultName, secretName } = config.keystore.azure

      const keyVaultClient = new AzureKeyVaultClient(vaultName)
      const privateKey = await keyVaultClient.getSecret(secretName)
      this.setPrivateKey(privateKey)
    } catch (err) {
      logger().info('Error retrieving key')
      logger().error(err)
      throw new Error(ErrorMessage.KEY_FETCH_ERROR)
    }
  }
}
