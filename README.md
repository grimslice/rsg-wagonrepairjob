items for core 

['wagonrepairkit'] = {['name'] = 'wagonrepairkit', ['label'] = 'wagonrepairkit', ['weight'] = 5, ['type'] = 'item', ['image'] = 'wagonrepairkit.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['level'] = 0, ['description'] = 'wagon repairs'},


jobs 

['wagonmechanic'] = {
        label = 'wagonmechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Trainee',
				isboss = true,
                payment = 25
            },
            ['1'] = {
                name = 'Master',
                isboss = true,
                payment = 75
            },
        },
    },
	
	
	dont forget to add image to inventory 

 use target to repair wagons that have lost wheels or damaged and make them shiny and new 
