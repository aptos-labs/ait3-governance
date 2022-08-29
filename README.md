# ait3-governance

1. To create a proposal, in the aptos-core repo, run
cargo run -p aptos -- governance propose --metadata-url <url-to-metadata-file.json> \
   --pool-address $owner_address --script-path /path/to/proposal.move --framework-git-rev testnet
2. To vote on a proposer, use the UI at https://explorer.devnet.aptos.dev/proposals/ or run
cargo run -p aptos -- governance vote --proposal-id <proposal-id> --pool-address $owner_address --yes/no
3. To execute a proposal that has passed, in the aptos-core repo, run
cargo run -p aptos -- governance execute-proposal --proposal-id <proposal-id> \
   --script-path path/to/proposal.move --framework-git-rev testnet --max-gas 500000
