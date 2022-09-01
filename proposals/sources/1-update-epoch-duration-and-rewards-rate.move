script {
    use aptos_framework::aptos_governance;
    use aptos_framework::block;
    use aptos_framework::staking_config;

    fun main(proposal_id: u64) {
        let framework_signer = &aptos_governance::resolve(proposal_id, @aptos_framework);

        // Update epoch duration from 2 hours to 1 hour.
        let updated_epoch_duration_secs = 1 * 60 /* minutes */ * 60 /* seconds */;
        let updated_epoch_duration_microsecs = updated_epoch_duration_secs * 1000000;
        block::update_epoch_interval_microsecs(updated_epoch_duration_microsecs);

        // Halve current rewards rate to keep effective APY the same (since epoch duration is halved).
        let (reward_rate_numerator, reward_rate_denominator) = staking_config::get_reward_rate(&staking_config::get());
        let updated_reward_rate_numerator = reward_rate_numerator / 2;
        // Ensure updated_reward_rate_numerator doesn't get rounded down to 0.
        assert!(updated_reward_rate_numerator > 0, 0);
        staking_config::update_rewards_rate(framework_signer, updated_reward_rate_numerator, reward_rate_denominator);

        // Always trigger a reconfig event at the end of a proposal execution.
        aptos_governance::reconfigure(framework_signer);
    }
}
