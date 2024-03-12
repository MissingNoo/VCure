if (ach == -1) { exit; }
if (!Achievements[ach].unlocked) {
    UnlockableAchievements[ach] = true;
	switch (Achievements[ach].rewardType) {
	    case Rewards.Coins:
	        global.holocoins+=Achievements[ach].amount;
	        break;
	    case Rewards.Item:
	        UnlockableItems[Achievements[ach].rewardId] = true;
	        break;
	    case Rewards.Weapon:
	        UnlockableWeapons[Achievements[ach].rewardId] = true;
	        break;
	    default:
	        // code here
	        break;
	}
	load_unlocked();
}
alpha -= .0025;
if (alpha <= 0) {
    instance_destroy();
}