local skinsTable = {
[0] = "CJ", [1] = "Truth", [2] = "Maccer", [7] = "Casual JeanJacket", [9] = "Business Lady",
[10] = "Old Fat Lady", [11] = "Card Dealer 1", [12] = "Classy Gold Hooker", [13] = "Homegirl", [14] = "Floral Shirt",
[15] = "Plaid Baldy", [16] = "Earmuff Worker", [17] = "Black suit", [18] = "Black Beachguy", [19] = "Beach Gangsta",
[20] = "Fresh Prince", [21] = "Striped Gangsta", [22] = "Orange Sportsman", [23] = "Skater Kid", [24] = "LS Coach",
[25] = "Varsity jacket", [26] = "Hiker", [27] = "Construction 1", [28] = "Black Dealer", [29] = "White Dealer",
[30] = "Religious Essey", [31] = "Fat Cowgirl", [32] = "Eyepatch", [33] = "Bounty Hunter", [34] = "Marlboro Man",
[35] = "Fisherman", [36] = "Mailman", [37] = "Baseball Dad", [38] = "Old Golf Lady", [39] = "Old Maid",
[40] = "Classy Dark Hooker", [41] = "Tracksuit Girl", [43] = "Porn Producer", [44] = "Tatooed Plaid", [45] = "Beach Mustache",
[46] = "Dark Romeo", [47] = "Top Button Essey", [49] = "Ninja Sensei", [50] = "Mechanic", [51] = "Black Bicyclist",
[52] = "White Bicyclist", [53] = "Golf Lady", [54] = "Hispanic Woman", [55] = "Rich Bitch", [56] = "Legwarmers 1",
[57] = "Chinese Businessman", [58] = "Chinese Plaid", [59] = "Chinese Romeo", [60] = "Chinese Casual", [61] = "Pilot",
[62] = "Pajama Man 1", [63] = "Trashy Hooker", [64] = "Transvestite", [66] = "Varsity Bandits", [67] = "Red Bandana",
[68] = "Preist", [69] = "Denim Girl", [70] = "Scientist", [71] = "Security Guard", [72] = "Bearded Hippie",
[73] = "Flag Bandana", [75] = "Skanky Hooker", [76] = "Businesswoman 1", [77] = "Bag Lady", [78] = "Homeless Scarf",
[79] = "Fat Homeless", [80] = "Red Boxer", [81] = "Blue Boxer", [82] = "Fatty Elvis", [83] = "Whitesuit Elvis",
[84] = "Bluesuit Elvis", [85] = "Furrcoat Hooker", [87] = "Firecrotch", [88] = "Casual Old Lady", [89] = "Cleaning Lady",
[90] = "Barely Covered", [91] = "Sharon Stone", [92] = "Rollergirl", [93] = "Hoop Earrings 1", [94] = "Andy Capp",
[95] = "Poor Old Man", [96] = "Soccer Player", [97] = "Baywatch Dude", [99] = "Rollerguy", [100] = "Biker Blackshirt",
[101] = "Jacker Hippie", [102] = "Baller Shirt", [103] = "Baller Jacket", [104] = "Baller Sweater", [105] = "Grove Sweater",
[106] = "Grove Tropbutton", [107] = "Grove Jersey", [108] = "Vagos Topless", [109] = "Vagos Pants", [110] = "Vagos Shorts",
[111] = "Russian Muscle", [112] = "Russian Hitman", [113] = "Russian Boss", [114] = "Aztecas Stripes", [115] = "Aztecas Jacket",
[116] = "Aztecas Shorts", [117] = "Triad 1", [118] = "Triad 2", [119] = "Triad 3", [120] = "Sinacco Suit",
[121] = "Da Nang Army", [122] = "Da Nang Bandana", [123] = "Da Nang Shades", [124] = "Sinacco Muscle", [125] = "Mafia Enforcer",
[126] = "Mafia Wiseguy", [127] = "Mafia Hitman", [128] = "Native Rancher", [129] = "Native Librarian", [130] = "Native Ugly",
[131] = "Native Sexy", [132] = "Native Geezer", [133] = "Furys Trucker", [134] = "Homeless Smoker", [135] = "Skullcap Hobo",
[136] = "Old Rasta", [137] = "Boxhead", [138] = "Bikini Tattoo", [139] = "Yellow Bikini", [140] = "Buxom Bikini",
[141] = "Cute Librarian", [142] = "African 1", [143] = "Sam Jackson", [144] = "Drug Worker 1", [145] = "Drug Worker 2",
[146] = "Drug Worker 3", [147] = "Sigmund Freud", [148] = "Businesswoman 2", [149] = "Businesswoman 2 b", [150] = "Businesswoman 3",
[151] = "Melanie", [152] = "Schoolgirl 1", [153] = "Foreman", [154] = "Beach Blonde", [155] = "Pizza Guy",
[156] = "Old Reece", [157] = "Farmer Girl", [158] = "Farmer", [159] = "Farmer Redneck", [160] = "Bald Redneck",
[161] = "Smoking Cowboy", [162] = "Inbred", [163] = "Casino Bouncer 1", [164] = "Casino Bouncer 2", [165] = "Agent Kay",
[166] = "Agent Jay", [167] = "Chicken", [168] = "Hotdog Vender", [169] = "Asian Escort", [170] = "PubeStache Tshirt",
[171] = "Card Dealer 2", [172] = "Card Dealer 3", [173] = "Rifa Hat", [174] = "Rifa Vest", [175] = "Rifa Suspenders",
[176] = "Style Barber", [177] = "Vanilla Ice Barber", [178] = "Masked Stripper", [179] = "War Vet", [180] = "Bball Player",
[181] = "Punk", [182] = "Pajama Man 2", [183] = "Klingon", [184] = "Neckbeard", [185] = "Nervous Guy",
[186] = "Teacher", [187] = "Japanese Businessman 1", [188] = "Green Shirt", [189] = "Valet", [190] = "Barbara Schternvart",
[191] = "Helena Wankstein", [192] = "Michelle Cannes", [193] = "Katie Zhan", [194] = "Millie Perkins", [195] = "Denise Robinson",
[196] = "Aunt May", [197] = "Smoking Maid", [198] = "Ranch Cowgirl", [199] = "Heidi", [200] = "Hairy Redneck",
[201] = "Trucker Girl", [202] = "Beer Trucker", [203] = "Ninja 1", [204] = "Ninja 2", [205] = "Burger Girl",
[206] = "Money Trucker", [207] = "Grove Booty", [209] = "Noodle Vender", [210] = "Sloppy Tourist", [211] = "Staff Girl",
[212] = "Tin Foil Hat", [213] = "Hobo Elvis", [214] = "Caligula Waitress", [215] = "Explorer", [216] = "Turtleneck",
[217] = "Staff Guy", [218] = "Old Woman", [219] = "Lady In Red", [220] = "African 2", [221] = "Beardo Casual",
[222] = "Beardo Clubbing", [223] = "Greasy Nightclubber", [224] = "Elderly Asian 1", [225] = "Elderly Asian 2", [226] = "Legwarmers 2",
[227] = "Japanese Businessman 2", [228] = "Japanese Businessman 3", [229] = "Asian Tourist", [230] = "Hooded Hobo", [231] = "Grannie",
[232] = "Grouchy lady", [233] = "Hoop Earrings 2", [234] = "Buzzcut", [235] = "Retired Tourist", [236] = "Happy Old Man",
[237] = "Leopard Hooker", [238] = "Amazon", [240] = "Hugh Grant", [241] = "Afro Brother", [242] = "Dreadlock Brother",
[243] = "Ghetto Booty", [244] = "Lace Stripper", [245] = "Ghetto Ho", [246] = "Cop Stripper", [247] = "Biker Vest",
[248] = "Biker Headband", [249] = "Pimp", [250] = "Green Tshirt", [251] = "Lifeguard", [252] = "Naked Freak",
[253] = "Bus Driver", [254] = "Biker Vest b", [255] = "Limo Driver", [256] = "Shoolgirl 2", [257] = "Bondage Girl",
[258] = "Joe Pesci", [259] = "Chris Penn", [260] = "Construction 2", [261] = "Southerner", [262] = "Pajama Man 2 b",
[263] = "Asian Hostess", [264] = "Whoopee the Clown", [265] = "Tenpenny", [266] = "Pulaski", [267] = "Hern",
[268] = "Dwayne", [269] = "Big Smoke", [270] = "Sweet", [271] = "Ryder", [272] = "Forelli Guy",
[274] = "Medic 1", [275] = "Medic 2", [276] = "Medic 3", [277] = "Fireman LS", [278] = "Fireman LV",
[279] = "Fireman SF", [280] = "Cop 1", [281] = "Cop 2", [282] = "Cop 3", [283] = "Cop 4",
[284] = "Cop 5", [285] = "SWAT", [286] = "FBI", [287] = "Army", [288] = "Cop 6",
[290] = "Rose", [291] = "Kent Paul", [292] = "Cesar", [293] = "OG Loc", [294] = "Wuzi Mu",
[295] = "Mike Toreno", [296] = "Jizzy", [297] = "Madd Dogg", [298] = "Catalina", [299] = "Claude from GTA 3",
[300] = "Ryder", [301] = "Ryder Robber", [302] = "Emmet", [303] = "Andre", [304] = "Kendl",
[305] = "Jethro", [306] = "Zero", [307] = "T-bone Mendez", [308] = "Sindaco Guy", [309] = "Janitor",
[310] = "Big Bear", [311] = "Big Smoke with Vest", [312] = "Physco", 
}
function getSkinNameFromID(i)
    local id = tonumber (i)
        assert(id, "Bad argument 1 @ getSkinFromID [Number expected, got " .. type(i) .. "]")
    local name = skinsTable[id]
        assert(name,"Bad argument 1 @ getSkinFromID [Invaild skin ID]")
    return name 
end 

maleSkins = {0, 1, 2, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311, 312}

function findSkin(model)
	for i,v in ipairs(maleSkins) do
		if v == model then
			return true
		end
	end
	return false
end
