certoraRun specs/harnesses/RaceTokenHarness.sol specs/harnesses/LockedGoldHarness.sol \
  --link LockedGoldHarness:goldToken=RaceTokenHarness \
  --verify LockedGoldHarness:specs/lockedGold.spec \
  --optimistic_loop \
  --short_output \
  --msg "LockedGold" \
  --solc_args "['--evm-version', 'istanbul']"
