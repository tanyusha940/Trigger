trigger AccountTest on Account (before insert, before update) {
    for (Account oAccount : trigger.new) {
        oAccount.Name = '1345678';
    }

}