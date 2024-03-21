global.achievements = [

];
#macro Achievements global.achievements

/**
 * Function Description
 * @param {Real} _id Achievement id
 * @param {String} _internalName Internal name for Lexicon
 * @param {Asset.GMSprite} _thumbnail
 * @param {Asset.GMSprite} _rewardSprite Reward sprite
 * @param {Asset.GMSprite} _rewardType Reward type
 * @param {Asset.GMSprite} _rewardId Reward id
 * @param {Real} _amount Reward amount
 */
function Achievement(_id, _internalName, _thumbnail, _rewardSprite, _rewardType, _rewardId, _amount = 0, _hide = false) constructor
{
    id = _id;
    name = _internalName;
    thumbnail = _thumbnail;
	reward = _rewardSprite;
	rewardType = _rewardType;
	rewardId = _rewardId;
	amount = _amount;
	unlocked = false;
	hide = _hide;
}

enum Rewards {
	Item,
	Weapon,
	Coins
}

enum AchievementIds {
	
	FirstWin,
	FuburaIsComing,
	BBBRRRRRREEEEEEEEE,
	DeckedOut,
	Test,
	NoSound,
	Length,
}
Achievements[0] = new Achievement(AchievementIds.FirstWin, "First Win", sAchFirstWin, sPhaseCoin, Rewards.Coins, undefined, 500);
Achievements[1] = new Achievement(AchievementIds.FuburaIsComing, "Fubura is coming", sAchFubura, sFanBeamThumb, Rewards.Weapon, Weapons.FanBeam);
Achievements[2] = new Achievement(AchievementIds.BBBRRRRRREEEEEEEEE, "BBBRRRRRREEEEEEEEE", sAchFirstBoss, sGorillaPaw, Rewards.Item, ItemIds.GorillaPaw);
//Achievements[array_length(Achievements)] = new Achievement(AchievementIds.TearsOfHappiness, "Tears of Happiness...?", sAchTears, sCeoTearsThumb)
//Achievements[array_length(Achievements)] = new Achievement(AchievementIds.YouHaveBeenCursed, "You have been Cursed", sAchCursed, sENCurseThumb);
//Achievements[array_length(Achievements)] = new Achievement(AchievementIds.ThousandMileStare, "Thousand Mile Stare", sAchStare, sPhaseCoin, 10000);
Achievements[3] = new Achievement(AchievementIds.DeckedOut, "Decked Out", sAchDeckedOut, sStudyGlasses, Rewards.Item, ItemIds.StudyGlasses);
Achievements[4] = new Achievement(AchievementIds.Test, "Thousand Mile Stare", sAchStare, sPhaseCoin, Rewards.Coins, undefined, 10000);
Achievements[5] = new Achievement(AchievementIds.NoSound, "No Sound in this version", sAchStare, sBlank, Rewards.Coins, undefined, 0);
//Achievements[array_length(Achievements)] = new Achievement(AchievementIds.Test, "Thousand Mile Stare", sAchStare, sPhaseCoin, 10000);
//Achievements[array_length(Achievements)] = new Achievement(AchievementIds.Test, "Thousand Mile Stare", sAchStare, sPhaseCoin, 10000);

//show_message(achievements[0]);
//achievements[array_length(achievements)] = new Achievement(AchievementIds., "", , );