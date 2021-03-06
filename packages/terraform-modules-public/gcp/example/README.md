# HOWTO

1. Create and checkout new branch (optional)

    ```console
    git checkout -b $new_branch
    ```
    

2. Update gcloud.env

    If starting from scratch,
    
    ```console
    cp gcloud.env.example gcloud.env
    ```
    
    or just run
    
    ```console
    ./bootstrap.sh
    ```
    
    which will create gcloud.env for you.

    Now set the project name.  If this is a key rotation rather than a fresh install, also comment out the last line, which sets the service account name, e.g.
   
    `#export TF_VAR_GCP_DEFAULT_SERVICE_ACCOUNT="151785056447-compute@developer.gserviceaccount.com"`
   
    This account will be created when the project is created, and will be appended to gcloud.env by bootstrap.sh


3. Source gcloud.env

    ```console
    source gcloud.env
    ```

    So that bootstrap.sh has the env vars it needs to properly provision the project.


4. Run bootstrap.sh

    ```console
    ./bootstrap.sh
    ```

    This will take awhile, as it enables and configures a series of API's within GCP.

5. Source gcloud.env again

    This is necessary because bootstrap.sh creates a service account that Terraform needs to know about

    ```console
    source gcloud.env
    ```

    ** If storing terraform (tfstate) on GCS, now is a good time to browse to that bucket and remove permissions to the tfstate bucket for 'viewers' and 'editors' of the proejct.  This will prevent an attacker who gets code execution on the proxy or validator or txnode or attestation service node from pulling the tfstate from gcs, which is important because the tfstate contains sensitive data such as signing keys ** 


6. Update terraform.tfvars with the following critical and environment sensitive values:

      ```
      google = {
        project = "celo-rc1"
        region  = "asia-southeast1"
        zone    = "asia-southeast1-c"
      }

      validator_name = "Acme-RC1-Validator"

      proxy_name = "Acme-RC1-Proxy"

      validator_signer_accounts = {
          account_addresses = [
            "0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
          ]
          private_keys = [
            "cxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
          ]
          #define your own strong password here
          account_passwords = [
            "Iez5lodohzaShap7ohH6ro5ohm9aecaezied4Esii3xeeBo1uxooP6aeluithu0u",
          ]
          release_gold_addresses = [
            "0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          ]
      }

      proxy_accounts = {
        
          account_addresses = [
            "0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
          ]
          private_keys = [
            "10xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
          ]
          
          #note that complete enode is not revealed from celocli account:new. FIXME  
          enodes = [
            "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          ]
          #define your own strong password here
          account_passwords = [
            "oi0ahsas8ahghaaxeenoh0fo7ar2EoFa2aloj2chaveelu6Veegh4ahNgeikaegh",
          ]
      }

      attestation_signer_accounts = {
          account_addresses = [
            "0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxf7",
          ]
          private_keys = [
            "46xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx58",
          ]
          #define your own strong password here
          account_passwords = [
            "el5Lai2ohvex4ohv1ree9Noo2iethoolae6be0aijeishaemiexohtae3meika2u"
          ]
      }

      attestation_service_db = {
          username = "celo"
          #define your own strong password here
          password = "Yeu4Chaotoh0eiG4xij2oob5phaekaeGeexel5thoo0xahsha2meihahLohk9wai"
      }

      attestation_service_credentials = {
          sms_providers                = "twilio"
          nexmo_key                    = ""
          nexmo_secret                 = ""
          nexmo_blacklist              = ""
          twilio_account_sid           = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          twilio_messaging_service_sid = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          twilio_verify_service_sid    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          twilio_auth_token            = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          twilio_blacklist             = ""
      }

      public_www_fqdn = "www.mysite.org"
      ```

    Note re: proxy enodes: these are critical and tell the validator which proxy to connect to.
          
    They aren't properly exposed yet by Celocli.
          
    Until this is resolved you'll need to pull this from the running proxy by running
              
    ```console
    docker exec geth geth --exec "admin.nodeInfo['enode'].split('//')[1].split('@')[0]" attach | tr -d '"'
    ```
              
    and then updating the enodes value in terraform.tfvars  
          
    We recommend using a unique proxy account address for each new validator.
          
    For key rotations we do not usually rotate attestation signers.
          
    The metadata is signed by the group vote signer, so there is no need to update metadata when rotating a validator signer.

7. Update variables.tf

    Set the quantity of validators as desired.  Note that a proxy is created automatically for each validator.  This is also where you can adjust instance types to taste.


8. Run terraform plan

    ```console
    terraform plan
    ```
    
    This will reveal ~50 some resources to create.

9. Run terraform apply

    ```console
    terraform apply -auto-approve
    ```
    
    This will create the resources.

10. Run terraform apply again

    This is necessary because Terraform will error out trying to apply IAM policies to GCS buckets that are created but are waiting for 'eventual consistency' :)

    ```console
    terraform apply -auto-approve
    ```

11. Upload chaindata archive

    In order for this new project to quickly bootstrap nodes, it needs chain data. A GCS bucket has been created for this purpose, but it's empty.  There are two ways to deal with this

        1. Wait for the P2P network to sync, and then run /root/backup.sh or /root/backup_rsync.sh from the tx-node, once the p2p sync is completed.  OR

        2. Upload a tarball of chaindata to the GCS bucket:

      ```console
      gsutil cp chaindata.tgz gs://${TF_VAR_project}-chaindata
      ```
            
      Chaindata inside the tarball (should) include the chaindata directory and all the containing DB files.


12. Redeploy nodes quickly

    Now that chaindata exists in the GCS bucket, you can run
    
    ```console
    terraform destroy
    ```
    
    to destroy existing infrastructure and then run

    ```console
    terraform apply -auto-approve
    ```
    
    to deploy new infrastructure which will be synced much more quickly.
    
    Note that `terraform destroy` won't destroy the chaindata in the GCS bucket, so can be run safely.  Alternatively you can just set node count to 0 in variables.tf and `terraform apply`.

13. Configure Dashboards

    Even with the Monitoring API enabled, for some reason you still need to go to the [GCP Monitoring Console](https://console.cloud.google.com/monitoring/dashboards) prior to uploading the Celo dashboard configuration. You'll see a modal that says "Finishing Workspace creation".  Once this is done and then you can run 
    
    ```console
    cd dashboards && gcloud monitoring dashboards create --config-from-file=hud.json
    ```
    
    Voila, magically a Celo specific dashboard is created.  The Celo dashboard is called "HUD", for Heads Up Display.

14. Generate a proof of possession for the new validator signer

    Familiarize yourself with the [Celo Validator Signer Key Rotation](https://docs.celo.org/validator-guide/summary/key-rotation) docs before continuing.

    The validator signer key needs to be unlocked to complete this next step.  You can either do this on the freshly deployed validator instance, or you can do it on your accounts node.  Your choice.  There are pros and cons to each.  Specifically, you shouldn't be SSH'ing into production validators, but similarly the validator signer key shouldn't really be hanging around on the accounts node either.

    Edit [../scripts/generate_pop.sh].  Specifically you need to update the following variables:

    ```bash
    SIGNER_TO_AUTHORIZE=
    VALIDATOR_ACCOUNT_ADDRESS=
    ```

    Now run the following command, again on a node that has the validator signer key available:

    ```console
    ./generate_pop.sh
    ```

    The generate_pop.sh script executes the following commands, which generate a proof of possession and a BLS proof of possession of the validator signer key.  

    ```console
    docker run -v $PWD:/root/.celo --rm -it $CELO_IMAGE --nousb account proof-of-possession $SIGNER_TO_AUTHORIZE $VALIDATOR_ACCOUNT_ADDRESS
    docker run -v $PWD:/root/.celo --rm -it $CELO_IMAGE --nousb account proof-of-possession $SIGNER_TO_AUTHORIZE $VALIDATOR_ACCOUNT_ADDRESS --bls
    ```

    Copy the output of these commands, as we'll need them for the next step, in which these signatures will be used in the next step to authorize the new signer.

15. Authorize new signer

    Do *not* do this until the new validator and proxy are alive and synced.
    Once this step is completed, the new signer will take over for the old one at the beginning of the next epoch.

    Edit [../scripts/authorize_signer.sh].  Specifically you need to update the following variables:
    
    ```bash
    CELO_VALIDATOR_RG_ADDRESS
    SIGNER_TO_AUTHORIZE
    ```

    Update the next three variables using output from the previous step:

    ```bash
    SIGNER_PROOF_OF_POSSESSION
    BLS_PUBLIC_KEY
    BLS_PROOF_OF_POSSESSION
    ```

    Note that the `SIGNER_PROOF_OF_POSSESSION` and the `BLS_PROOF_OF_POSSESSION` are the signature and BLS signature outputs from the previous step.

    You may also need to update the `--ledgerCustomAddresses=[1]` parameter to match whichever Ledger slot holds your Validator RG beneficiary key.

    Once you have made 100% sure that the new validator and proxy are ready to take over, run the following command, again on a node that has the validator signer key available:

    ```console
    ./authorize_signer.sh
    ```

    This will execute the following command:

    ```console
    npx celocli releasegold:authorize --contract $CELO_VALIDATOR_RG_ADDRESS --role validator \
        --signer $SIGNER_TO_AUTHORIZE --signature 0x$SIGNER_PROOF_OF_POSSESSION --blsKey $BLS_PUBLIC_KEY --blsPop $BLS_PROOF_OF_POSSESSION \
        --useLedger --ledgerCustomAddresses=[1]
    ```

16. Wait for new epoch

    Now sit back, pull up [TheCelo](http://www.thecelo.com/) and wait for the new epoch to roll around.  You can track your validator on the [PRL Block Map Site](https://cauldron.pretoriaresearchlab.io/rc1-block-map), and get a visual indication of when your new signer has taken over.

17. Troubleshooting

    If your new validator isn't signing, check the following:
    
    * Make sure that both the proxy and the validator are synced.  You can verify this in the geth console:
    ```console
    docker exec -it geth geth attach
    eth.syncing
    ```
    * Ensure that the validator signer key is unlocked on the validator:
    ```console
    docker exec -it geth geth attach
    personal
    ```
    * Ensure that the proxy has >100 peers
    ```console
    docker exec -it geth geth attach
    admin.peers.length
    ```
    * Check that the enode variable for the proxy is set correctly in terraform.tfvars.
    * Verify network connectivity from the validator to the proxy on tcp/30503

18. Attestation Service

    First generate a new account to use for the attestation signer.

    ```console
    celocli account:new
    ```

    Use these values for the `attestation_signer_accounts` attributes:

        * account_addresses
        * private_keys
        * account_passwords
        
    Put these into terraform.tfvars.

    Now, on a system which has access to the attestation_signer private key, generate a proof of possession for that key as follows:

    ```bash
    #!/bin/bash
    set -x

    ######
    # use this script on an attestation signer tx-node to generate a proof of possession, needed for key rotation

    CELO_IMAGE=us.gcr.io/celo-org/geth:1.1.0
    CELO_ATTESTATION_SIGNER_ADDRESS=YOUR_ATTESTATION_SIGNER_ADDRESS
    CELO_VALIDATOR_RG_ADDRESS=YOUR_VALIDATOR_RELEASE_GOLD_ADDRESS

    # On the Attestation machine
    docker run -v $PWD:/root/.celo --rm -it $CELO_IMAGE account proof-of-possession $CELO_ATTESTATION_SIGNER_ADDRESS $CELO_VALIDATOR_RG_ADDRESS
    ```

    Use the generated signature to authorize a new attestation signer as follows:

    ```bash
    #!/bin/bash
    set -x

    ######
    # use this script to authorize a new attestation signer
    # signed by the validator release gold account

    CELO_ATTESTATION_SIGNER_SIGNATURE=YOUR_SIGNATURE_FROM_PREVIOUS_STEP
    CELO_ATTESTATION_SIGNER_ADDRESS=YOUR_ATTESTATION_SIGNER_ADDRESS
    CELO_VALIDATOR_RG_ADDRESS=YOUR_VALIDATOR_RELEASE_GOLD_ADDRESS

    npx celocli releasegold:authorize --contract $CELO_VALIDATOR_RG_ADDRESS --role attestation --signature 0x$CELO_ATTESTATION_SIGNER_SIGNATURE --signer $CELO_ATTESTATION_SIGNER_ADDRESS --useLedger --ledgerCustomAddresses=[1]
    ```

  19. Update DNS with public IP of attestation service
      
      This could be done via terraform down the track.
      This DNS name must be used in for the ATTESTATION_URL parameter used in the next step.

      Terminating SSL for the attestation service is presently out of scope for this doc, but can be set up quickly and easily using GCP load balancing, Cloudflare, or nginx as a reverse proxy.

      The attestation service requires that the following routes be exposed to the Internet to function correctly:
      * POST /attestations
      * POST /test_attestations
      * GET /get_attestations
      * POST /delivery_status_twilio
      * GET /delivery_status_nexmo
      * GET /status
      * GET /healthz
      * GET /metrics

  20. Validator metadata

      First create validator metadata as follows:

      ```console
      celocli account:create-metadata ./validator_metadata.json --from $CELO_VALIDATOR_RG_ADDRESS
      ```

    Claim the validator account on the group account:

    ```celocli account:claim-account ./validator_metadata.json --address $CELO_VALIDATOR_GROUP_RG_ADDRESS --from $CELO_ATTESTATION_SIGNER_ADDRESS```

    Now claim your attestation URL.  Note this must be run on a node that has the attestation signer key unlocked:
    
    ```console
    celocli account:claim-attestation-service-url ./validator_metadata.json --url https://YOUR_ATTESTATION_URL --from $CELO_ATTESTATION_SIGNER_ADDRESS
    ```

    Now register this url on-chain:
    ```console
    celocli releasegold:set-account --contract $CELO_VALIDATOR_RG_ADDRESS --property metaURL --value "https://YOUR_VALIDATOR_METADATA_URL"
    ```

    Verify that this worked as expected by running:

    ```console
    celocli account:get-metadata $CELO_VALIDATOR_RG_ADDRESS
    ```

    Verify that the attestation service works by running:

    ```console
    celocli identity:test-attestation-service --from $CELO_ATTESTATION_SIGNER_ADDRESS --phoneNumber "YOUR_PHONE_NUM" --message "hello world"
    ```

  21. Group metadata

    First create the group metadata

    ```console
    celocli account:create-metadata ./group_metadata.json --from $CELO_VALIDATOR_GROUP_RG_ADDRESS 
    ```

    Now set the group's name on chain

    ```console
    celocli releasegold:set-account --contract $CELO_VALIDATOR_GROUP_RG_ADDRESS --property name --value YourGroupName
    ```

    ```console
    celocli account:claim-domain ./group_metadata.json --domain YOURDOMAIN --from $CELO_VALIDATOR_GROUP_SIGNER_ADDRESS --useLedger --ledgerCustomAddresses=[2]
    ```

    This will output your claim signed under the provided signer address. This output should then be recorded via a DNS TXT Record on your domain.

    Now test that the metadata has been created successfully:

    ```console
    celocli account:show-metadata ./group_metadata.json
    ```

    Next claim the validator address from the group account:

    ```console
    celocli account:claim-account ./group_metadata.json --address $CELO_VALIDATOR_RG_ADDRESS --from $CELO_VALIDATOR_GROUP_SIGNER_ADDRESS --useLedger --ledgerCustomAddresses=[2]
    ```

    Now let's submit the corresponding claim from the validator account on the group account 

    ```console
    celocli account:claim-account ./validator_metadata.json --address $CELO_VALIDATOR_GROUP_RG_ADDRESS --from $CELO_ATTESTATION_SIGNER_ADDRESS
    ```console

    Now upload the validator_metadata.json and group_metadata.json to a publicly available location.  

    Finally, test that everything is properly configured:

    ```console
    celocli account:get-metadata $CELO_VALIDATOR_GROUP_RG_ADDRESS
    celocli account:get-metadata $CELO_VALIDATOR_RG_ADDRESS
    ```

22. Verify validator and attestation performance
    You can see how well your validator group is performing visually by looking at the [Mainnet Block Map](https://cauldron.pretoriaresearchlab.io/block-map) from [Pretoria Research Lab](https://cauldron.pretoriaresearchlab.io/).

    Pretoria has also created an [Attestation Map](https://cauldron.pretoriaresearchlab.io/attestations).

    The cLabs team also has a [firebase dashboard](https://metabase.celo-networks-dev.org/public/dashboard/b0a27650-1d62-4645-81d7-26ff7546ff0d?date_filter=past2weeks~&validator_address=0x474df04481f778b46Fc71204C72B6A8BE396F0FF) that allows you to visualize attestation performance, and also seeks to identify situations in which an attestation failed due to operator (rather than user) error.

# Areas for improvement
* move sshd to non standard port to reduce brute force noise



