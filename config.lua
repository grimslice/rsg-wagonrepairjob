

Config = {}


Config.RepairJob = "wagonmechanic"


Config.RepairItem = "wagonrepairkit"


Config.RepairTime = 5000


Config.InteractionDistance = 2.5




-- Wagon models that players can repair more can be added 
Config.WagonModels = {
    GetHashKey('WAGON02X'),
	GetHashKey('COACH6'),
	GetHashKey('WAGONPRISON01X'),
	GetHashKey('COACH4'),
	GetHashKey('coach3'),
	GetHashKey('coach5'),
	GetHashKey('policewagon01x'),
	GetHashKey('huntercart01'),
    GetHashKey('gatchuck_2'),
	GetHashKey('cart05'),
	GetHashKey('WAGON04X'),
	GetHashKey('WAGON03X'),
	GetHashKey('CART08'),
	GetHashKey('CART01'),
	GetHashKey('CART06'),
	GetHashKey('wagon02x'),
	GetHashKey('cart07'),
	GetHashKey('STAGECOACH004X'),
	GetHashKey('ArmySupplyWagon'),
	GetHashKey('chuckwagon000x'),
	GetHashKey('wagontraveller01x'),
	GetHashKey('coach3_cutscene'),
	GetHashKey('coal_wagon'),
	GetHashKey('gatchuck_2')
}


Config.Texts = {
    NoJob = "You do not have the correct job to repair wagons!",
    NoKit = "You need a wagon repair kit!",
    NoMoney = "You don't have enough money to repair the wagon!",
    Repairing = "Repairing Wagon...",
    RepairSuccess = "Wagon repaired successfully!",
    NoRepairNeeded = "This wagon doesn't need repair!"
}
