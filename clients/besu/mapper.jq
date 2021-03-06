# Removes all empty keys and values in input.
def remove_empty:
  . | walk(
    if type == "object" then
      with_entries(
        select(
          .value != null and
          .value != "" and
          .value != [] and
          .key != null and
          .key != ""
        )
      )
    else .
    end
  )
;

# Converts decimal string to number.
def to_int:
  if . == null then . else .|tonumber end
;

# Replace config in input.
. + {
    "config": {
        "ethash": {},
        "chainID": env.HIVE_CHAIN_ID|to_int,
        "homesteadBlock": env.HIVE_FORK_HOMESTEAD|to_int,
        "daoForkBlock": env.HIVE_FORK_DAO_BLOCK|to_int,
        "eip150Block": env.HIVE_FORK_TANGERINE|to_int,
        "eip150Hash": env.HIVE_FORK_TANGERINE_HASH,
        "eip155Block": env.HIVE_FORK_SPURIOUS|to_int,
        "eip158Block": env.HIVE_FORK_SPURIOUS|to_int,
        "byzantiumBlock": env.HIVE_FORK_BYZANTIUM|to_int,
        "constantinopleBlock": env.HIVE_FORK_CONSTANTINOPLE|to_int,
        "constantinopleFixBlock": env.HIVE_FORK_PETERSBURG|to_int,
        "istanbulBlock": env.HIVE_FORK_ISTANBUL|to_int,
        "muirGlacierBlock": env.HIVE_FORK_MUIR_GLACIER|to_int,
        "berlinBlock": env.HIVE_FORK_BERLIN|to_int,
    }|remove_empty
}
