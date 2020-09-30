/**
 * @author Jangbi
 * Field 
 * Enum Data type Property
 * Example> 
 * 		Enum_data.LogType[3].N2  ->  코어삭제 return;
 * 		Enum_data.LogType[1].N3[2].S2  ->  Game상점내구매 return;
 */

var Enum_data = {
            'DataType':[
					            {'N1':0,'N2':'Other'},
					            {'N1':1,'N2':'Item'},
					            {'N1':2,'N2':'Hench'},
					            {'N1':3,'N2':'GP'},
					            {'N1':4,'N2':'No Info'}
              ],
	            'ItemType':[
						            {'N1':0,'N2':'Serial Re-arrangement'},
						            {'N1':1,'N2':'Rooting'},
						            {'N1':2,'N2':'Purchase in Game Shop'},
						            {'N1':3,'N2':'Purchase in now'},
						            {'N1':4,'N2':'Operatione Tool'},
						            {'N1':5,'N2':'Creating as Character is created'},
						            {'N1':6,'N2':'Quest'},
						            {'N1':7,'N2':'Gamble'},
						            {'N1':8,'N2':'Holy Water, Def Items'},
						            {'N1':9,'N2':'Trade Items'},
						            {'N1':10,'N2':'No Info'},
						            {'N1':11,'N2':'Box Open Item'}
		            ],
		            'CoreType':[
						            {'N1':0,'N2':'Serial Re-arrangement'},
						            {'N1':1,'N2':'Rooting'},
						            {'N1':2,'N2':'Purchase in Game Shop'},
						            {'N1':3,'N2':'Purchase in now'},
						            {'N1':4,'N2':'Operation Tool'},
						            {'N1':5,'N2':'Creating as Character is created'},
						            {'N1':6,'N2':'Quest'},
						            {'N1':7,'N2':'Mix'},
						            {'N1':8,'N2':'Holy Water, Def Items'},
						            {'N1':9,'N2':'No Info'}
		            ],
	                'OptionType':[
						            {'N1':0,'N2':'-'},
						            {'N1':1,'N2':'Accuracy'},
						            {'N1':2,'N2':'Attack'},
						            {'N1':3,'N2':'Avoidance'},
						            {'N1':4,'N2':'Power'},
						            {'N1':5,'N2':'Agility'},
						            {'N1':6,'N2':'Hit Rate'},
						            {'N1':7,'N2':'Luck'},
						            {'N1':8,'N2':'HP'}
		            ],
		            'SynergyType':[
						            {'N1':0,'N2':'-'},
						            {'N1':1,'N2':'Dragon'},
						            {'N1':2,'N2':'Devil'},
						            {'N1':3,'N2':'Animal'},
						            {'N1':4,'N2':'Bird'},
						            {'N1':5,'N2':'Insect'},
						            {'N1':6,'N2':'Plant'},
						            {'N1':7,'N2':'Mystery'},
						            {'N1':8,'N2':'Metal'},
						            {'N1':9,'N2':'Special'}
		            ],
		            'RemarkType':[
					            {'N1':0,'N2':'No Info'},
					            {'N1':1,'N2':'Option-Type Items'},
					            {'N1':2,'N2':'Item Options Level'},
					            {'N1':3,'N2':'Hench Options'},
					            {'N1':4,'N2':'Synergy Type'},
					            {'N1':5,'N2':'Level of Synergy'},
					            {'N1':6,'N2':'Hench Max Level'},
					            {'N1':7,'N2':'Item Duration'},
					            {'N1':8,'N2':'Hench Sex Change'},
					            {'N1':9,'N2':'Hench Att. Change'},
					            {'N1':10,'N2':'Character Gold'},
					            {'N1':11,'N2':'Hench Level'},
					            {'N1':12,'N2':'Item Count'},
					            {'N1':13,'N2':'Character Type'},
					            {'N1':14,'N2':'Character Level'},
					            {'N1':15,'N2':'Guild Group'},
					            {'N1':16,'N2':'Guild Promotor'},
					            {'N1':17,'N2':'Warehouse Open Phase'},
					            {'N1':18,'N2':'Guild Funds'},
					            {'N1':19,'N2':'Trade'}
	                ],
	                'LogType':[
					            {	'N1':0,
					            	'N2':'Generated Items',
					            	'N3':[
					            	      	{'S1':0,'S2':'Serial Re-arrangement'},
	                                       	{'S1':1,'S2':'Rooting'},
	                                       	{'S1':2,'S2':'Purchase in Game Shop'},
	                                       	{'S1':3,'S2':'Purchase in now'},
	                                       	{'S1':4,'S2':'Operation Tool'},
	                                       	{'S1':5,'S2':'As Character is created'},
	                                       	{'S1':6,'S2':'Quest'},
	                                       	{'S1':7,'S2':'Gamble'},
	                                       	{'S1':8,'S2':'Holy Water, Def Items'},
	                                       	{'S1':9,'S2':'Trade'},
	                                       	{'S1':10,'S2':'No Info'},
											{'S1':11,'S2':'Box Open Item'},
											{'S1':12,'S2':'Box Open Hench'}
					                       ]
					            },
					            {	'N1':1,
					            	'N2':'Core Generation',
					            	'N3':[
					            	      	{'S1':0,'S2':'Serial Re-arrangement'},
	                                       	{'S1':1,'S2':'Rooting'},
	                                       	{'S1':2,'S2':'Purchase in Game Shop'},
	                                       	{'S1':3,'S2':'Purchase in now'},
	                                       	{'S1':4,'S2':'Operation Tool'},
	                                       	{'S1':5,'S2':'As Character is created'},
	                                       	{'S1':6,'S2':'Quest'},
	                                       	{'S1':7,'S2':'Mix'},
	                                       	{'S1':8,'S2':'Holy Water, Def Items'},
	                                       	{'S1':9,'S2':'No Info'}
					                       ]
					            },
					            {	'N1':2,
					            	'N2':'Delete an Item',
					            	'N3':[
					            	      	{'S1':0,'S2':'Used'},
	                                       	{'S1':1,'S2':'Broken durability'},
	                                       	{'S1':2,'S2':'Bought on a selling'},
	                                       	{'S1':3,'S2':'Gone by enchant'},
	                                       	{'S1':4,'S2':'Overwritten by disappearance'},
	                                       	{'S1':5,'S2':'Cleared from the field at regular intervals'},
	                                       	{'S1':6,'S2':'Gone by Quest'},
	                                       	{'S1':7,'S2':'Deleted from operating tools'},
	                                       	{'S1':8,'S2':'As Deleting character'},
	                                       	{'S1':9,'S2':'No Info'}
					                       ]
					            },
					            {	'N1':3,
					            	'N2':'Core Removed',
					            	'N3':[
					            	      	{'S1':0,'S2':'Bought on a selling'},
	                                       	{'S1':1,'S2':'Gone by enchant'},
	                                       	{'S1':2,'S2':'Gone by Mix failure'},
	                                       	{'S1':3,'S2':'Gone by Mix success'},
	                                       	{'S1':4,'S2':'Cleared from the field at regular intervals'},
	                                       	{'S1':5,'S2':'Gone by Quest'},
	                                       	{'S1':6,'S2':'Deleted from operating tools'},
	                                       	{'S1':7,'S2':'Deleted character'},
	                                       	{'S1':8,'S2':'Change, deleted lords'},
	                                       	{'S1':9,'S2':'Transfer pack saddle deleted'},
	                                       	{'S1':10,'S2':'길마이양,성주변경실패로주었던헨치삭제'},
	                                       	{'S1':11,'S2':'No Info'}
					                       ]
					            },
					            {	'N1':4,
					            	'N2':'Movement',
					            	'N3':[
					            	      	{'S1':0,'S2':'Warehouse'},
	                                       	{'S1':1,'S2':'Taken from Warehouse'},
	                                       	{'S1':2,'S2':'Drop in the field'},
	                                       	{'S1':3,'S2':'Picked up from the field'},
	                                       	{'S1':4,'S2':'Mounting'},
	                                       	{'S1':5,'S2':'Eliminating'},
	                                       	{'S1':6,'S2':'Move to effective Item'},
	                                       	{'S1':7,'S2':'No Info'}
					                       ]
					            },
					            {	'N1':5,
					            	'N2':'Exchange',
					            	'N3':[
					            	      	{'S1':0,'S2':'Sold at Store'},
	                                       	{'S1':1,'S2':'Purchasing at Store'},
	                                       	{'S1':2,'S2':'Traded'},
	                                       	{'S1':3,'S2':'Sold at Super Store'},
	                                       	{'S1':4,'S2':'Purchasing at Super Store'}
					                       ]
					            },
					            {	'N1':6,
					            	'N2':'Enchantment',
					            	'N3':[
					            	      	{'S1':0,'S2':'Enchant Item option failed'},
	                                       	{'S1':1,'S2':'Enchant Item option success'},
	                                       	{'S1':2,'S2':'Enchant Item level failed'},
	                                       	{'S1':3,'S2':'Enchant Item level success'},
	                                       	{'S1':4,'S2':'Core Enchant failed'},
	                                       	{'S1':5,'S2':'Core Enchant success'},
	                                       	{'S1':6,'S2':'Synergy type failed'},
	                                       	{'S1':7,'S2':'Synergy type success'},
	                                       	{'S1':8,'S2':'Synergy level failed'},
	                                       	{'S1':9,'S2':'Synergy level success'},
	                                       	{'S1':10,'S2':'Functional items'}
					                       ]
					            },
					            {	'N1':7,
					            	'N2':'Core Mix',
					            	'N3':[
					            	      	{'S1':0,'S2':'Core Mix failed'},
	                                       	{'S1':1,'S2':'Core Mix success'}
					                       ]
					            },
					            {	'N1':8,
					            	'N2':'Character Deletion',
					            	'N3':[
					            	      	{'S1':0,'S2':'-'},
					                    ]
					            },
					            {	'N1':9,
					            	'N2':'Generated at Character Creation',
					            	'N3':[
					            	      	{'S1':0,'S2':'-'},
					                       ]
					            },
					            {	'N1':10,
					            	'N2':'Trade',
					            	'N3':[
					            	      	{'S1':0,'S2':'Traded items'},
	                                       	{'S1':1,'S2':'Traded items to Gamble'}
					                       ]
					            },
					            {	'N1':11,
					            	'N2':'No Info',
					            	'N3':[
					            	      	{'S1':0,'S2':'-'},
					                       ]
					            }
					            
	                ],
	                'M_LogType':[
					            {	'N1':0,
					            	'N2':'Character Creation',
					            	'N3':[
					            	      	{'S1':0,'S2':'Seiral Re-arrangement'},
	                                       	{'S1':1,'S2':'Generated from the game'},
	                                       	{'S1':2,'S2':'Generated from operating tools'},
	                                       	{'S1':3,'S2':'No Info'}
					                       ]
					            },
					            {	'N1':1,
					            	'N2':'Delete a Character',
					            	'N3':[
					            	      	{'S1':0,'S2':'Waiting to be deleted'},
	                                       	{'S1':1,'S2':'Purged'},
	                                       	{'S1':2,'S2':'Deleted from operating tools'},
	                                       	{'S1':3,'S2':'No Info'}
					                       ]
					            },
					            {	'N1':2,
					            	'N2':'Guild',
					            	'N3':[
					            	      	{'S1':0,'S2':'Generated Guild Master'},
	                                       	{'S1':1,'S2':'Promoter who generated Guild'},
	                                       	{'S1':2,'S2':'Withdraw as Guild genarates'},
	                                       	{'S1':3,'S2':'Delete Guild'},
	                                       	{'S1':4,'S2':'Handing over Guild Master'},
	                                       	{'S1':5,'S2':'Taking over Guild Master'},
	                                       	{'S1':6,'S2':'Guild deposits'},
	                                       	{'S1':7,'S2':'Guild funds withdrawal'}
					                       ]
					            },
					            {	'N1':3,
					            	'N2':'Warehouse',
					            	'N3':[
					            	      	{'S1':0,'S2':'Warehouse Open/Expansion'}
					                       ]
					            },
					            {	'N1':4,
					            	'N2':'Siege-related',
					            	'N3':[
					            	      	{'S1':0,'S2':'Attacker request'},
	                                       	{'S1':1,'S2':'Attacker period'},
	                                       	{'S1':2,'S2':'Mercenaries request'},
	                                       	{'S1':3,'S2':'Mercenaries canceled'},
	                                       	{'S1':4,'S2':'Changing Castellan'},
					                       ]
					            },
					            {	'N1':5,
					            	'N2':'No Info',
					            	'N3':[
					            	      	{'S1':0,'S2':'No Info'}
					                    ]
					            }
					 ],
					 //Block_Type(code)
					 'BlockType':[
                        {'N1':'ALLOW','N2':'Top'},
						            {'N1':'GAME','N2':'Game'},
						            {'N1':'WEB','N2':'Web'},
						            {'N1':'SUM','N2':'Web/Game'},
						            {'N1':'WAIT','N2':'Stand by Drop-out'},
						            {'N1':'SECEDER','N2':'Drop Out'}
                  ],
            'BlockType2':[
						            {'N1':'GAME','N2':'Game'},
						            {'N1':'WEB','N2':'Web'},
						            {'N1':'SUM','N2':'Web/Game'},
						            {'N1':'WAIT','N2':'Stand by Drop-out'}
                  ],
           'ACC_Type':[
						            {'N1':'ALLOW','N2':'Normal State'},
						            {'N1':'DENY','N2':'Block Status'},
						            {'N1':'WAIT','N2':'Stand by Drop-out'}
						           ],
             //Acc_Deny_Type(code)  
					 'ACC_DENYType':[
						            {'N1':'0','N2':'General Block'},
						            {'N1':'2200-12-31','N2':'Permanent Seizure'},
						            {'N1':'2222-12-31','N2':'Delete Character'}
                  ],
					 'CHAR_Type':[
						            {'N1':'0','N2':'Ditt','N3':[{'S1':8569},{'S1':307},{'S1':32192}]},
						            {'N1':'1','N2':'Jin','N3':[{'S1':10719},{'S1':30618},{'S1':4261}]},
						            {'N1':'2','N2':'Penril','N3':[{'S1':5624},{'S1':32584},{'S1':32256}]},
						            {'N1':'3','N2':'Phoy','N3':[{'S1':605},{'S1':7685},{'S1':15227}]}
                  ],
					 'HType':[
						            {'N1':'0','N2':'-'},
						            {'N1':'1','N2':'Strong'},
						            {'N1':'2','N2':'Swift'},
						            {'N1':'3','N2':'Accurate'},
						            {'N1':'4','N2':'Fortunate'},
						            {'N1':'5','N2':'Attribute Strong'}
                  ],
            'HENCHType':[
						            {'N1':'0','N2':'Dragon'},
						            {'N1':'1','N2':'Devil'},
						            {'N1':'2','N2':'Animal'},
						            {'N1':'3','N2':'Bird'},
						            {'N1':'4','N2':'Insect'},
						            {'N1':'5','N2':'Plant'},
						            {'N1':'6','N2':'Mystery'},
						            {'N1':'7','N2':'Metal'},
						            {'N1':'8','N2':'Special'}
                  ],
					  'PositionType':[
						            {'N1':'0','N2':'Battle'},
						            {'N1':'1','N2':'Pocket'},
						            {'N1':'2','N2':'Warehouse'}
                  ],
					  'ItemSocketType':[
						            {'N1':'0','N2':'Inventory'},
						            {'N1':'1','N2':'Warehouse'},
						            {'N1':'2','N2':'Mounting'},
						            {'N1':'3','N2':'Effective Item'}
                  ],
             //Item_Type_search(code)
					  'ItemType_GBN':[
						            {'N1':'0','N2':'NUI'},
						            {'N1':'1','N2':'Equipment'},
						            {'N1':'2','N2':'Supplies'},
						            {'N1':'3','N2':'Special Items'},
						            {'N1':'4','N2':'Add Enchant'},
						            {'N1':'5','N2':'Strengthen Enchant'},
						            {'N1':'6','N2':'Enchant Core'},
						            {'N1':'7','N2':'Hench Items'},
						            {'N1':'8','N2':'Mix Items'},
						            {'N1':'9','N2':'Megaphone'},
						            {'N1':'10','N2':'Box Item'},
						            {'N1':'11','N2':'Particular Box Item'},
						            {'N1':'50','N2':'Production (Weapons)'},
						            {'N1':'51','N2':'Production (Armors)'},
						            {'N1':'52','N2':'Production (Accessories)'},
						            {'N1':'53','N2':'Production (Consumable)'},
						            {'N1':'54','N2':'Production - Main'},
						            {'N1':'55','N2':'Production - Sub'}
                  ],
                 'BlockSUBType':[
						            {'N1':'0','N2':'Plastering all over Page with bad words'},
						            {'N1':'1','N2':'Disturbing Games'},
						            {'N1':'2','N2':'Trying to Attempt,Sale ID'},
						            {'N1':'3','N2':'Trying to Attempt Fraud'},
						            {'N1':'4','N2':'Parent/Abuse of Sexuality'},
						            {'N1':'5','N2':'Improper Name of Guild and character'},
						            {'N1':'6','N2':'Advertising illegal site'},
						            {'N1':'7','N2':'Using/Spreading illegal program'},
						            {'N1':'8','N2':'Attempting illegal payments at item Mall'},
						            {'N1':'9','N2':'Impersonating as GM and Staff'},
						            {'N1':'10','N2':'Insult and Slander'},
						            {'N1':'11','N2':'Impersonating Similar Character'},
						            {'N1':'12','N2':'False Rumor Canard'},
						            {'N1':'13','N2':'Slandering and Insulting'},
						            {'N1':'14','N2':'Fraud of Character &Impersonation'},
						            {'N1':'15','N2':'Attempting a trade with other Game'},
						            {'N1':'16','N2':'Hacking'},
						            {'N1':'17','N2':'Using/Spreading hacking program'},
						            {'N1':'18','N2':'False Charge'},
						            {'N1':'19','N2':'Attempting Cash Trade'},
						            {'N1':'20','N2':'Ignoring GM\u0027s Warnings/Operational interference'},
						            {'N1':'21','N2':'Ignoring GM\u0027s Warnings/Operational interference'},
						            {'N1':'22','N2':'Abusing/Spreading Bugs'},
						            {'N1':'etc','N2':'Etc'}
                  ],
                  'M_Question':[
						            {'N1':'','N2':'Select Questions'},
						            {'N1':'00','N2':'Your fam\u0027s name?'},
						            {'N1':'01','N2':'Your mom\u0027s name?'},
						            {'N1':'02','N2':'Where\u0027s best place to wanna go?'},
						            {'N1':'03','N2':'What\u0027s the name of your pet?'},
						            {'N1':'04','N2':'What\u0027s your most precious thing?'},
						            {'N1':'05','N2':'What\u0027s your Motto?'},
						            {'N1':'06','N2':'What\u0027s your favorite teacher\u0027s Name?'},
						            {'N1':'07','N2':'What\u0027s your Nickname?'},
						            {'N1':'08','N2':'Who\u0027s your Lover?'}
                  ],
                  'JobType':[
						            {'N1':'','N2':'Career Choice'},
						            {'N1':'00','N2':'Office Worker'},
						            {'N1':'01','N2':'Profession or specialty'},
						            {'N1':'02','N2':'Elementary Students'},
						            {'N1':'03','N2':'Mid/High Students'},
						            {'N1':'04','N2':'Collegian'},
						            {'N1':'05','N2':'Public Official'},
						            {'N1':'06','N2':'Self-Employ'},
						            {'N1':'07','N2':'House Wife'},
						            {'N1':'08','N2':'Unemployed'},
						            {'N1':'09','N2':'Etc'}
                  ],
                  'Server':[
						            {'N1':'','N2':'All'},
						            {'N1':'magirita','N2':'Magirita'},
						            {'N1':'mekrita','N2':'Mekrita'},
						            {'N1':'herseba','N2':'Herseba'},
						            {'N1':'purmai','N2':'Purmai '}
                  ],
                  'SEX':[
						            {'N1':'0','N2':'Male'},
						            {'N1':'1','N2':'Female'}
                  ],
                  'ITEM_GIVE_POSITION':[
						            {'N1':'I','N2':'Iventory'},
						            {'N1':'S','N2':'Storage'}
                  ],
                  'ITEM_DB_YN':[
						            {'N1':'0','N2':'Possible'},
						            {'N1':'1','N2':'Impossible'}
                  ],
                  'ITEM_Rarity':[
						            {'N1':'0','N2':'General Item'},
						            {'N1':'1','N2':'Rare Item'},
						            {'N1':'2','N2':'Unique Item'}
                  ],
                  'Guild_Grade':[
						            {'N1':'1','N2':'Stand By application'},
						            {'N1':'2','N2':'Objector to Join'},
						            {'N1':'3','N2':'Person to establish'},
						            {'N1':'4','N2':'Waiting person dropping out'},
						            {'N1':'10','N2':'General Member'},
						            {'N1':'11','N2':'Sub Guild Master'},
						            {'N1':'12','N2':'Guild Master'},
						            {'N1':'12','N2':'Waiting Guild Master'}
                  ],
                  'GilMa_ETC':[
						            {'N1':'0','N2':'Transfer out'},
						            {'N1':'1','N2':'Openning'}
                  ]
                  
				};