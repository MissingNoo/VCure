ps = undefined;
ps2 = undefined;
lowest = 0;
upgID = irandom(9999);
ps = undefined;
ghost = false;
perkBonusDmg = 0;
upg = UPGRADES[0];
resetcooldown = true;
cooldownwasreset = false;
mindmg = upg[$ "mindmg"] * level;
maxdmg = upg[$ "maxdmg"] * level;