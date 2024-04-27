mod = {
    ready = false
}

registerForEvent('onInit', function()
    Override('ConsumablesChargesHelper', 'GetConsumableTag;array<CName>', function( tags, originalFunction)
        if isInArray(tags, CName.new("SynthDose.Coolant")) then return CName.new("SynthDose.Coolant") end
        if isInArray(tags, CName.new("SynthDose.Injector")) then return CName.new("SynthDose.Injector") end
        if isInArray(tags, CName.new("SynthDose.SuperJet")) then return CName.new("SynthDose.SuperJet") end
        if isInArray(tags, CName.new("SynthDose.Inhaler")) then return CName.new("SynthDose.Inhaler") end


        return originalFunction(tags)
    end)
end)



registerForEvent('onTweak', function ()
    main()
    mod.ready = true
end)

basePath = 'SynthDose.'
toxicityEffect = ''
overDoseStartValue = 10
nonHealingDrugDescriptionStatPath = ''

function main()    
    DisableHealthMonitorForDrugs()
    toxicityEffect = CreateToxicityEffect()
    illegalGoodPriceMultiplier = 'SynthDose.IllegaPrice'
    nonHealingDrugDescriptionStatPath = CreateOnEquipDescription(basePath..'nonHealing', { CreateSingleStatUpdate("NonHealingStat", "Additive", "BaseStats.NonHealingDrugEquipped", 1) }) 

    TweakDB:CloneRecord(illegalGoodPriceMultiplier, 'Price.Injector')
    TweakDB:SetFlat(illegalGoodPriceMultiplier..'.value', 2.5)


    SCPrereqs = { }

    for _, input in ipairs({10, 15, 20, 25, 30, 35, 40, 50}) do
        SCPrereqs[input] = createSCPrereq(input)
    end

    local leverPrereqTier1 = 'LootPrereqs.PlayerLevel_Tier_1_Exclusion_Prereq'
    local leverPrereqTier2 = 'LootPrereqs.PlayerLevel_Tier_1_to_2_Exclusion_Prereq'
    local leverPrereqTier3 = 'LootPrereqs.PlayerLevel_Tier_2_to_3_Exclusion_Prereq'
    local leverPrereqTier4 = 'LootPrereqs.PlayerLevel_Tier_3_to_4_Exclusion_Prereq'


    local leverPrereqTier5 = 'SynthDose.Tier5LevelPrereq'
    TweakDB:CloneRecord(leverPrereqTier5, 'LootPrereqs.PlayerLevel_Tier_3_to_4_Exclusion_Prereq')
    TweakDB:CloneRecord(leverPrereqTier5..'_inline0', 'LootPrereqs.PlayerLevel_Tier_3_to_4_Exclusion_Prereq_inline0')
    TweakDB:CloneRecord(leverPrereqTier5..'_inline1', 'LootPrereqs.PlayerLevel_Tier_3_to_4_Exclusion_Prereq_inline1')
    TweakDB:SetFlat(leverPrereqTier5..'.nestedPrereqs', { leverPrereqTier5..'_inline0', leverPrereqTier5..'_inline1' })
    TweakDB:SetFlat(leverPrereqTier5..'_inline0.valueToCheck', 33)
    TweakDB:SetFlat(leverPrereqTier5..'_inline0.comparisonType', 'GreaterOrEqual')
    TweakDB:SetFlat(leverPrereqTier5..'_inline1.valueToCheck', 41)
    TweakDB:SetFlat(leverPrereqTier5..'_inline1.Less', 'Less')
    local leverPrereqTier5Plus = 'LootPrereqs.PlayerLevel_Tier_5_Plus_Start_Prereq'


    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------IC3C0LD--------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    IC3C0LDV1Effects = {
        CreateSingleStatUpdate("IC3C0LDV1", "Additive", "BaseStats.MemoryRegenRate", 0.5)
    }

    IC3C0LDV2Effects = {
        CreateSingleStatUpdate("IC3C0LDV2", "Additive", "BaseStats.MemoryRegenRate", 0.65)
    }

    IC3C0LDV3Effects = {
        CreateSingleStatUpdate("IC3C0LDV3", "Additive", "BaseStats.MemoryRegenRate", 0.8)
    }

    IC3C0LDV4Effects = {
        CreateSingleStatUpdate("IC3C0LDV4", "Additive", "BaseStats.MemoryRegenRate", 1)
    }

    IC3C0LDV5Effects = {
        CreateSingleStatUpdate("IC3C0LDV5", "Additive", "BaseStats.MemoryRegenRate", 1.2) 
    }

    IC3C0LDV5PlusEffects = {
        CreateSingleStatUpdate("IC3C0LDV5P", "Additive", "BaseStats.MemoryRegenRate", 1.4) 
    }

    IC3C0LDV1Descriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.IC3C0LDV1_Description_1',
        nonHealingDrugDescriptionStatPath
    }

    IC3C0LDV2Descriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.IC3C0LDV2_Description_1',
        nonHealingDrugDescriptionStatPath
    }

    IC3C0LDV3Descriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.IC3C0LDV3_Description_1',
        nonHealingDrugDescriptionStatPath
    }
    
    IC3C0LDV4Descriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.IC3C0LDV4_Description_1',
        nonHealingDrugDescriptionStatPath
    }   

    IC3C0LDV5Descriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.IC3C0LDV5_Description_1',
        nonHealingDrugDescriptionStatPath
    }

    IC3C0LDV5PlusDescriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.IC3C0LDV5Plus_Description_1',
        nonHealingDrugDescriptionStatPath
    }

    
    local IC3C0LDV1 = createInjector("IC3C0LDV1", "injector_6_IC3C0LD", "injector___14", "synthDose_IC3C0LD_flavor", IC3C0LDV1Descriptions, "synthDose_IC3C0LDV1_name", "Quality.Common", 15, {}, IC3C0LDV1Effects,{}, {'SynthDose.Coolant'},1, 'SynthDose.IC3C0LD_Icon',{}) 
    local IC3C0LDV2 = createInjector("IC3C0LDV2", "injector_6_IC3C0LD", "injector___14", "synthDose_IC3C0LD_flavor", IC3C0LDV2Descriptions, "synthDose_IC3C0LDV2_name", "Quality.Uncommon", 15, {}, IC3C0LDV2Effects,{}, {'SynthDose.Coolant'},1, 'SynthDose.IC3C0LD_Icon',{}) 
    local IC3C0LDV3 = createInjector("IC3C0LDV3",  "injector_6_IC3C0LD", "injector___14", "synthDose_IC3C0LD_flavor", IC3C0LDV3Descriptions, "synthDose_IC3C0LDV3_name", "Quality.Rare", 15, {}, IC3C0LDV3Effects,{}, {'SynthDose.Coolant'},1, 'SynthDose.IC3C0LD_Icon',{}) 
    local IC3C0LDV4 = createInjector("IC3C0LDV4", "injector_6_IC3C0LD", "injector___14", "synthDose_IC3C0LD_flavor", IC3C0LDV4Descriptions, "synthDose_IC3C0LDV4_name", "Quality.Epic", 15, {}, IC3C0LDV4Effects,{}, {'SynthDose.Coolant'},1, 'SynthDose.IC3C0LD_Icon',{}) 
    local IC3C0LDV5 = createInjector("IC3C0LDV5", "injector_6_IC3C0LD", "injector___14", "synthDose_IC3C0LD_flavor", IC3C0LDV5Descriptions, "synthDose_IC3C0LDV5_name", "Quality.Legendary", 15, {}, IC3C0LDV5Effects,{}, {'SynthDose.Coolant'},1, 'SynthDose.IC3C0LD_Icon',{}) 
    local IC3C0LDV5Plus = createInjector("IC3C0LDV5Plus", "injector_6_IC3C0LD", "injector___14", "synthDose_IC3C0LD_flavor", IC3C0LDV5PlusDescriptions, "synthDose_IC3C0LDV5_name", "Quality.LegendaryPlus", 15, {}, IC3C0LDV5PlusEffects,{}, {'SynthDose.Coolant'},1, 'SynthDose.IC3C0LD_Icon',{}) 

    local IC3C0LDV1VendorItem = createVendorItem('IC3C0LDV1', nil, { leverPrereqTier1 }, IC3C0LDV1)
    local IC3C0LDV2VendorItem = createVendorItem('IC3C0LDV2', nil, { leverPrereqTier2 }, IC3C0LDV2)
    local IC3C0LDV3VendorItem = createVendorItem('IC3C0LDV3', nil, { leverPrereqTier3 }, IC3C0LDV3)
    local IC3C0LDV4VendorItem = createVendorItem('IC3C0LDV4', nil, { leverPrereqTier4 }, IC3C0LDV4)
    local IC3C0LDV5VendorItem = createVendorItem('IC3C0LDV5', nil, { leverPrereqTier5 }, IC3C0LDV5)
    local IC3C0LDV5PlusVendorItem = createVendorItem('IC3C0LDV5Plus', nil, { leverPrereqTier5Plus }, IC3C0LDV5Plus)

    
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------Thunderbolt-----------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local ThunderboltDescriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.ThunderBolt_Description_1',
        'SynthDose.Item_Duration_20',
        nonHealingDrugDescriptionStatPath
    }

    local ThunderBoltEffects = {
        CreateSingleStatUpdate("ThunderBolt", "Additive", "BaseStats.StaminaRegenStartDelay", -10)
    }


    local ThunderBolt = createInhaler("ThunderBolt", "inhaler_16_oxyboost", "drug_7", "synthDose_thunderbolt_flavor", ThunderboltDescriptions, "synthDose_thunderbolt_name", "Quality.Uncommon", 20, {}, ThunderBoltEffects,{}, {},1, 'SynthDose.Thunderbolt_Icon', {})

    local ThunderBoltVendorItem = createVendorItem('ThunderBolt', nil, {}, ThunderBolt)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------Code Freeze------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local CodeFreezeDescriptions = {
        'SynthDose.Toxicity_Moderate_StatData',
        'SynthDose.CodeFreeze_Description_1',
        nonHealingDrugDescriptionStatPath
    }

    local CodeFreezeEffects = {
        CreateSingleStatUpdate("CodeFreeze", "Additive", "BaseStats.OverclockedStateHealthCost", -35)
    }

    local CodeFreeze = createInjector("CodeFreeze", "injector_14_HeatBeat", "injector___13", "synthDose_codefreeze_flavor", CodeFreezeDescriptions, "synthDose_codefreeze_name", "Quality.Epic", 15, {}, CodeFreezeEffects,{}, {'IllegalItem'},3,'SynthDose.CodeFreeze_Icon', {})

    local CodeFreezeVendorSCItem = createVendorItem('CodeFreezeSC', SCPrereqs[40], {}, CodeFreeze)
    local CodeFreezeVendorNoSCItem = createVendorItem('CodeFreeze', nil, {}, CodeFreeze)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------Aspis--------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local AspisDescriptions = {
        'SynthDose.Toxicity_Moderate_StatData',
        'SynthDose.Aspis_Description_1',
        'SynthDose.Aspis_Description_2',
        'SynthDose.Aspis_Description_3',
        'SynthDose.Aspis_Description_4',
        nonHealingDrugDescriptionStatPath
    }

    local AspisEffects = {
        CreateSingleStatUpdate("Aspis", "Additive", "BaseStats.ArmorMultBonus", 1.5),
        CreateSingleStatUpdate("Aspis", "AdditiveMultiplier", "BaseStats.Health", 1),
        CreateSingleStatUpdate("Aspis", "Multiplier", "BaseStats.MaxSpeed", 0.4),
        CreateSingleStatUpdate("Aspis", "Multiplier", "BaseStats.CanJump", 0), 
        CreateSingleStatUpdate("Aspis", "Multiplier", "BaseStats.CanUseCovers", 0), 
        CreateSingleStatUpdate("Aspis", "Multiplier", "BaseStats.HasDodge", 0), 
        CreateSingleStatUpdate("Aspis", "Multiplier", "BaseStats.HasAirDodge", 0), 
        CreateSingleStatUpdate("Aspis", "Multiplier", "BaseStats.CanSprint", 0), 
        CreateSingleStatUpdate("Aspis", "Additive", "BaseStats.KnockdownImmunity", 1)
    }

    local AspisEffectorEffects = {
        createStatGroupEffector("Aspis", "Weapon", "Prereqs.AlwaysTruePrereq", "AdditiveMultiplier", "BaseStats.RecoilKickMin", -0.15),
        createStatGroupEffector("Aspis", "Weapon", "Prereqs.AlwaysTruePrereq", "AdditiveMultiplier", "BaseStats.RecoilKickMax", -0.15),
        createStatGroupEffector("Aspis", "Weapon", "Prereqs.AlwaysTruePrereq", "Multiplier", "BaseStats.AttackSpeed", 0.5), 
        createStatGroupEffector("Aspis", "Weapon", "Prereqs.AlwaysTruePrereq", "Additive", "BaseStats.ReloadTimeBonus", 1.2)
    }

    local Aspis = createInjector("Aspis", "injector_7_Aspis", "injector___5", "synthDose_aspis_flavor", AspisDescriptions, "synthDose_aspis_name", "Quality.Rare", 20, {}, AspisEffects, AspisEffectorEffects, {},3,'SynthDose.Aspis_Icon', {}) 

    local AspisVendorItem = createVendorItem('Aspis', nil, {}, Aspis)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------Stim--------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
    local StimDescriptions = {
        'SynthDose.Toxicity_Moderate_StatData',
        'SynthDose.Stim_Description_1',
        'SynthDose.Stim_Description_2',
        'SynthDose.Stim_Description_3',
        nonHealingDrugDescriptionStatPath
    }

    local StimEffects = {
        CreateSingleStatUpdate("Stim", "AdditiveMultiplier", "BaseStats.MaxSpeed", 0.2),
        CreateSingleStatUpdate("Stim", "Additive", "BaseStats.CritChance", 0.25)
    }

    local StimEffectorEffects = {
        createStatGroupEffector("Stim", "Weapon", "Prereqs.AlwaysTruePrereq", "Additive", "BaseStats.ReloadTimeBonus", -0.5),
        createStatGroupEffector("Stim", "Weapon", "Prereqs.AlwaysTruePrereq", "AdditiveMultiplier", "BaseStats.RecoilKickMin", -0.8),
        createStatGroupEffector("Stim", "Weapon", "Prereqs.AlwaysTruePrereq", "AdditiveMultiplier", "BaseStats.RecoilKickMax", -0.8),
        createStatGroupEffector("Stim", "Weapon", "Prereqs.AlwaysTruePrereq", "AdditiveMultiplier", "BaseStats.EffectiveRange", 0.5),
        createStatGroupEffector("Stim", "Weapon", "Prereqs.AlwaysTruePrereq", "Multiplier", "BaseStats.BulletMagnetismDefaultAngle", 2),
        createStatGroupEffector("Stim", "Weapon", "Prereqs.AlwaysTruePrereq", "Multiplier", "BaseStats.BulletMagnetismHighVelocityAngle", 2)
        
    }
    
    local StimInstantEffects = {
        CreateInstantPoolEffector('Stim3', 'Health', -20, true, 'Prereqs.AlwaysTruePrereq')
    }
    
    local Stim = createInjector("Stim", "injector_11_donner", "injector___10", "synthDose_stim_flavor", StimDescriptions, "synthDose_stim_name", "Quality.Rare", 15, StimInstantEffects, StimEffects,StimEffectorEffects, {'IllegalItem'},3,'SynthDose.Stim_Icon', {})  -- find correct appearance
    local StimVendorSCItem = createVendorItem('StimSC', SCPrereqs[30], {}, Stim)
    local StimVendorNoSCItem = createVendorItem('Stim', nil, {}, Stim)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------K----------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local KersDescriptions = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.Kers_Description_1',
        'SynthDose.Kers_Description_2',
        'SynthDose.Kers_Description_3',
        'SynthDose.Item_Duration_15',
        nonHealingDrugDescriptionStatPath
    }

    local KersEffects = {
        CreateSingleStatUpdate("Kers", "Multiplier", "BaseStats.TimeDilationKerenzikovTimeScale", 0.75),
        CreateSingleStatUpdate("Kers", "Additive", "BaseStats.TimeDilationKerenzikovPlayerTimeScale", 1.5),
        CreateSingleStatUpdate("Kers", "Multiplier", "BaseStats.TimeDilationKerenzikovDuration", 3),
        CreateSingleStatUpdate("Kers", "Multiplier", "BaseStats.StaminaRegenRate", 0.75),
    }
    
    local KersEffectorEffects = {
        
    }

    local Kers = createInhaler("Kers", "inhaler_5_kereznikov", "drug_2", "synthDose_kers_flavor", KersDescriptions, "synthDose_kers_name", "Quality.Common", 15, {}, KersEffects,KersEffectorEffects, {'IllegalItem'},1, 'SynthDose.Kers_Icon', {'Items.Alcohol_inline6'})
    
    local KersVendorSCItem = createVendorItem('KersSC', SCPrereqs[15], {}, Kers)
    local KersVendorNoSCItem = createVendorItem('Kers', nil, {}, Kers)


    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------Happy Kill------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    
    local HappyKillDescriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.HappyKill_Description_1',
        'SynthDose.HappyKill_Description_2',
        'SynthDose.HappyKill_Description_3',
        nonHealingDrugDescriptionStatPath
    }

    local HappyKillEffects = {
    }
    
    local HappyKillEffectorEffects = {
        createPrereqEffector("HappyKill1", "NewPerks.Tech_Master_Perk_3_inline13", "BaseStatusEffect.Tech_Master_Perk_3_Buff", true),
        'Items.AdvancedHealOnKillRare_inline1',
        'Items.AdvancedMemoryBoostEpic_inline1',
        'Items.MemoryBoostSFXEffector',
        'Items.HealOnKillSFXEffector',
        createPrereqEffector("HappyKill2",
            "Prereqs.AnyTakedownOrKill",
            CreateBaseStatusEffect("HappyKill3", {
                CreateSingleStatUpdate("HappyKill4", "AdditiveMultiplier", "BaseStats.MaxSpeed", 0.3),
                CreateSingleStatUpdate("HappyKill6", "Additive", "BaseStats.CritChance", 5), 
                CreateSingleStatUpdate("HappyKill7", "Additive", "BaseStats.CritDamage", 25), 
                CreateSingleStatUpdate("HappyKill8", "Additive", "BaseStats.AttacksNumber", 10)
            }, {
                createStatGroupEffector("HappyKill5", "Weapon", "Prereqs.AlwaysTruePrereq","AdditiveMultiplier", "BaseStats.AttackSpeed", 0.2),

            }, 6, 'SynthDose.Bloodlust_Icon', true),
            false
        ),

    }

    local HappyKill = createInjector("HappyKill", "injector_9_quicksave", "injector___16", "synthDose_happyKill_flavor", HappyKillDescriptions, "synthDose_happyKill_name", "Quality.Legendary", 45, {}, HappyKillEffects,HappyKillEffectorEffects, {'IllegalItem'},5, 'SynthDose.HappyKill_Icon', {})

    local HappyKillSCItem = createVendorItem('HappyKillSC',  SCPrereqs[40], {}, HappyKill)
    local HappyKillNoSCItem = createVendorItem('HappyKill', nil, {}, HappyKill)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------Black Lace------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    ConvertBlackLace()

    local BlackLaceSCVendorItem = createVendorItem('BlackLaceV1SC', SCPrereqs[35], {}, 'Items.BlackLaceV1')
    local BlackLaceNoSCVendorItem = createVendorItem('BlackLaceV1', nil, {}, 'Items.BlackLaceV1')

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------Roaring Phoenix---------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    local RoaringPhoenixV1Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.RoaringPhoenixV1_Description_1',
        CreateOnEquipDescription(basePath..'RoaringPhoenixV1_1', {
            CreateSingleStatUpdate("RoaringPhoenixV1_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("RoaringPhoenixV1_3", "Additive", "BaseStats.InjectorBaseOverTheTimeHealing", 3.5),
            CreateSingleStatUpdate("RoaringPhoenixV1_4", "Additive", "BaseStats.InjectorBaseHealing", 35),
        }),
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local RoaringPhoenixV2Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.RoaringPhoenixV2_Description_1',
        CreateOnEquipDescription(basePath..'RoaringPhoenixV2_1', {
            CreateSingleStatUpdate("RoaringPhoenixV2_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("RoaringPhoenixV2_3", "Additive", "BaseStats.InjectorBaseOverTheTimeHealing", 4.5),
            CreateSingleStatUpdate("RoaringPhoenixV2_4", "Additive", "BaseStats.InjectorBaseHealing", 45),
        }),
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local RoaringPhoenixV3Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.RoaringPhoenixV3_Description_1',
        CreateOnEquipDescription(basePath..'RoaringPhoenixV3_1', {
            CreateSingleStatUpdate("RoaringPhoenixV3_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("RoaringPhoenixV3_3", "Additive", "BaseStats.InjectorBaseOverTheTimeHealing", 6),
            CreateSingleStatUpdate("RoaringPhoenixV3_4", "Additive", "BaseStats.InjectorBaseHealing", 60),
        }),
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local RoaringPhoenixV4Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.RoaringPhoenixV4_Description_1',
        CreateOnEquipDescription(basePath..'RoaringPhoenixV4_1', {
            CreateSingleStatUpdate("RoaringPhoenixV4_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("RoaringPhoenixV4_3", "Additive", "BaseStats.InjectorBaseOverTheTimeHealing", 7.5),
            CreateSingleStatUpdate("RoaringPhoenixV4_4", "Additive", "BaseStats.InjectorBaseHealing", 75),
        }),
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local RoaringPhoenixV5Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.RoaringPhoenixV5_Description_1',
        CreateOnEquipDescription(basePath..'RoaringPhoenixV5_1', {
            CreateSingleStatUpdate("RoaringPhoenixV5_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("RoaringPhoenixV5_3", "Additive", "BaseStats.InjectorBaseOverTheTimeHealing", 8.5),
            CreateSingleStatUpdate("RoaringPhoenixV5_4", "Additive", "BaseStats.InjectorBaseHealing", 85),
        }),
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local RoaringPhoenixV5PlusDescription = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.RoaringPhoenixV5Plus_Description_1',
        CreateOnEquipDescription(basePath..'RoaringPhoenixV5Plus_1', {
            CreateSingleStatUpdate("RoaringPhoenixV5Plus_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("RoaringPhoenixV5Plus_3", "Additive", "BaseStats.InjectorBaseOverTheTimeHealing", 10),
            CreateSingleStatUpdate("RoaringPhoenixV5Plus_4", "Additive", "BaseStats.InjectorBaseHealing", 100),
        }),
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local RoaringPhoenixEffectorEffects = {
        'BaseStatusEffect.BonesMcCoy70V0_inline1',
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV1InstantEffects = {
        CreateInstantPoolEffector('RoaringPhoenixV1_5', 'Health', 35, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV2InstantEffects = {
        CreateInstantPoolEffector('RoaringPhoenixV2_5', 'Health', 45, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV3InstantEffects = {
        CreateInstantPoolEffector('RoaringPhoenixV3_5', 'Health', 60, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV4InstantEffects = {
        CreateInstantPoolEffector('RoaringPhoenixV4_5', 'Health', 70, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV5InstantEffects = {
        CreateInstantPoolEffector('RoaringPhoenixV5_5', 'Health', 85, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV5PlusInstantEffects = {
        CreateInstantPoolEffector('RoaringPhoenixV5Plus_5', 'Health', 100, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local RoaringPhoenixV1 = createInjector("RoaringPhoenixV1", "injector_5_roaring_phoenix", "injector___17", "synthDose_roaringPhoenix_flavor", RoaringPhoenixV1Description, "synthDose_roaringPhoenixV1_name", "Quality.Common", 10, RoaringPhoenixV1InstantEffects, {}, RoaringPhoenixEffectorEffects, {'IllegalItem', 'SynthDose.Injector'},1,'SynthDose.RoaringPhoenix_Icon', {}) 
    local RoaringPhoenixV2 = createInjector("RoaringPhoenixV2", "injector_5_roaring_phoenix", "injector___17", "synthDose_roaringPhoenix_flavor", RoaringPhoenixV2Description, "synthDose_roaringPhoenixV2_name", "Quality.Uncommon", 10, RoaringPhoenixV2InstantEffects, {}, RoaringPhoenixEffectorEffects, {'IllegalItem', 'SynthDose.Injector'},1,'SynthDose.RoaringPhoenix_Icon', {}) 
    local RoaringPhoenixV3 = createInjector("RoaringPhoenixV3", "injector_5_roaring_phoenix", "injector___17", "synthDose_roaringPhoenix_flavor", RoaringPhoenixV3Description, "synthDose_roaringPhoenixV3_name", "Quality.Rare", 10, RoaringPhoenixV3InstantEffects, {}, RoaringPhoenixEffectorEffects, {'IllegalItem', 'SynthDose.Injector'},1,'SynthDose.RoaringPhoenix_Icon', {}) 
    local RoaringPhoenixV4 = createInjector("RoaringPhoenixV4", "injector_5_roaring_phoenix", "injector___17", "synthDose_roaringPhoenix_flavor", RoaringPhoenixV4Description, "synthDose_roaringPhoenixV4_name", "Quality.Epic", 10, RoaringPhoenixV4InstantEffects, {}, RoaringPhoenixEffectorEffects, {'IllegalItem', 'SynthDose.Injector'},1,'SynthDose.RoaringPhoenix_Icon', {}) 
    local RoaringPhoenixV5 = createInjector("RoaringPhoenixV5", "injector_5_roaring_phoenix", "injector___17", "synthDose_roaringPhoenix_flavor", RoaringPhoenixV5Description, "synthDose_roaringPhoenixV5_name", "Quality.Legendary", 10, RoaringPhoenixV5InstantEffects, {}, RoaringPhoenixEffectorEffects, {'IllegalItem', 'SynthDose.Injector'},1,'SynthDose.RoaringPhoenix_Icon', {}) 
    local RoaringPhoenixV5Plus = createInjector("RoaringPhoenixVPlus", "injector_5_roaring_phoenix", "injector___17", "synthDose_roaringPhoenix_flavor", RoaringPhoenixV5PlusDescription, "synthDose_roaringPhoenixV5_name", "Quality.LegendaryPlus", 10, RoaringPhoenixV5PlusInstantEffects, {}, RoaringPhoenixEffectorEffects, {'IllegalItem', 'SynthDose.Injector'},1,'SynthDose.RoaringPhoenix_Icon', {}) 

    local RoaringPhoenixV1SCVendorItem = createVendorItem('RoaringPhoenixV1SC', SCPrereqs[10], { leverPrereqTier1 }, RoaringPhoenixV1)
    local RoaringPhoenixV1NoSCVendorItem = createVendorItem('RoaringPhoenixV1', nil, { leverPrereqTier1 }, RoaringPhoenixV1)

    local RoaringPhoenixV2SCVendorItem = createVendorItem('RoaringPhoenixV2SC', SCPrereqs[10], { leverPrereqTier2 }, RoaringPhoenixV2)
    local RoaringPhoenixV2NoSCVendorItem = createVendorItem('RoaringPhoenixV2', nil, { leverPrereqTier2 }, RoaringPhoenixV2)

    local RoaringPhoenixV3SCVendorItem = createVendorItem('RoaringPhoenixV3SC', SCPrereqs[10], { leverPrereqTier3 }, RoaringPhoenixV3)
    local RoaringPhoenixV3NoSCVendorItem = createVendorItem('RoaringPhoenixV3', nil, { leverPrereqTier3 }, RoaringPhoenixV3)

    local RoaringPhoenixV4SCVendorItem = createVendorItem('RoaringPhoenixV4SC', SCPrereqs[10], { leverPrereqTier4 }, RoaringPhoenixV4)
    local RoaringPhoenixV4NoSCVendorItem = createVendorItem('RoaringPhoenixV4', nil, { leverPrereqTier4 }, RoaringPhoenixV4)

    local RoaringPhoenixV5SCVendorItem = createVendorItem('RoaringPhoenixV5SC', SCPrereqs[10], { leverPrereqTier5 }, RoaringPhoenixV5)
    local RoaringPhoenixV5NoSCVendorItem = createVendorItem('RoaringPhoenixV5', nil, { leverPrereqTier5 }, RoaringPhoenixV5)

    local RoaringPhoenixV5PlusSCVendorItem = createVendorItem('RoaringPhoenixVPlusSC', SCPrereqs[10], { leverPrereqTier5Plus }, RoaringPhoenixV5Plus)
    local RoaringPhoenixV5PlusNoSCVendorItem = createVendorItem('RoaringPhoenixVPlus', nil, { leverPrereqTier5Plus }, RoaringPhoenixV5Plus)


    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------Glitter-------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local GlitterDescriptions = {
        'SynthDose.Toxicity_Lethal_StatData',
        'SynthDose.Glitter_Description_1',
        'SynthDose.Effect_Stacks',
        'SynthDose.Item_Duration_60',
        nonHealingDrugDescriptionStatPath
    }

    local GlitterEffects = {
        CreateSingleStatUpdate("Glitter", "AdditiveMultiplier", "BaseStats.MaxSpeed", 1.2),
        CreateSingleStatUpdate("Glitter", "AdditiveMultiplier", "BaseStats.JumpHeight", 0.8),
        
    }
    
    local GlitterEffectorEffects = {
        createStatGroupEffector("Glitter", "Weapon", "Prereqs.AlwaysTruePrereq", "AdditiveMultiplier", "BaseStats.AttackSpeed", 1)
    }

    local Glitter = createInhaler("Glitter", "inhaler_7_glitter", "drug_4", "synthDose_glitter_flavor", GlitterDescriptions, "synthDose_glitter_name", "Quality.Uncommon", 60, {}, GlitterEffects,GlitterEffectorEffects, {'IllegalItem'}, 10, 'SynthDose.Glitter_Icon', {})
    TweakDB:SetFlat('BaseStatusEffect.Glitter_inline0.stackable', true) 

    local GlitterSCVendorItem = createVendorItem('GlitterSc', SCPrereqs[25], {  }, Glitter)
    local GlitterNoSCVendorItem = createVendorItem('Glitter', nil, {  }, Glitter)
    

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------Rambo 8-------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    local Rambo8Descriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.Rambo_Description_1',
        'SynthDose.Rambo_Description_2',
        'SynthDose.Item_Duration_30',
        nonHealingDrugDescriptionStatPath
    }

    local Rambo8Effects = {
        CreateSingleStatUpdate("Rambo8_3", "Additive", "BaseStats.MeleeDamagePercentBonus", 2),
        CreateSingleStatUpdate("Rambo8_4", "AdditiveMultiplier", "BaseStats.BaseMeleeAttackStaminaCost", 1),
        CreateSingleStatUpdate("Rambo8_6", "Additive", "BaseStats.StrengthSkillcheckBonus", 4)
    }
    
    local Rambo8EffectorEffects = {
        createStatGroupEffector("Rambo8_7", "Weapon", "Prereqs.AlwaysTruePrereq", "Multiplier", "BaseStats.AttackSpeed", 0.5)
    }
    

    local Rambo8 = createInhaler("Rambo8", "inhaler_20_grits", "drug_13", "synthDose_rambo_flavor", Rambo8Descriptions, "synthDose_rambo_name", "Quality.Epic", 30, {}, Rambo8Effects,Rambo8EffectorEffects, {'IllegalItem'}, 5, 'SynthDose.Rambo_Icon', {})
    local Rambo8SCVendorItem = createVendorItem('Rambo8Sc', SCPrereqs[35], {  }, Rambo8)
    local Rambo8NoSCVendorItem = createVendorItem('Rambo8', nil, {  }, Rambo8)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------Elude--------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local EludeDescription = {
        'SynthDose.Toxicity_Moderate_StatData',
        'SynthDose.Elude_Description_1',
        'SynthDose.Elude_Description_2',
        'SynthDose.Item_Duration_60',
        nonHealingDrugDescriptionStatPath
    }

    local EludeEffects = {
        CreateSingleStatUpdate("Elude4", "Additive", "BaseStats.MitigationChance", 10),
        CreateSingleStatUpdate("Elude5", "Multiplier", "BaseStats.AudioLocomotionStimRangeMultiplier", 0.5),
        CreateSingleStatUpdate("Elude6", "Multiplier", "BaseStats.Armor", 0.5),
        CreateSingleStatUpdate("Elude7", "AdditiveMultiplier", "BaseStats.MaxSpeed", 0.2),
        
    }

    local EludeEffectorEffects = {

    }

    local Elude = createInhaler("Elude", "inhaler_18_elude", "drug_7", "synthDose_elude_flavor", EludeDescription, "synthDose_elude_name", "Quality.Rare", 60, {}, EludeEffects,EludeEffectorEffects, {}, 3, 'SynthDose.Elude_Icon', {})

    local EludeVendorItem = createVendorItem('Elude', nil, {  }, Elude)


    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------Gris Gris------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    local GrisGrisDescription = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.GrisGris_Description_1',
        'SynthDose.GrisGris_Description_2',
        'SynthDose.GrisGris_Description_3',
        nonHealingDrugDescriptionStatPath
    }

    local GrisGrisEffects = {
        CreateSingleStatUpdate("GrisGris4", "AdditiveMultiplier", "BaseStats.HackRevealPositionModifier", 0.5),    
        CreateSingleStatUpdate("GrisGris5", "Additive", "BaseStats.QuickhackDamageBonusMultiplier", 0.30),
    }

    local GrisGrisEffectorEffects = {

    }

    local GrisGris = createInjector("GrisGris", "injector_12_grisgris", "injector___8", "synthDose_grisgris_flavor", GrisGrisDescription, "synthDose_grisgris_name", "Quality.Epic", 60, {}, GrisGrisEffects,GrisGrisEffectorEffects, {}, 5, 'SynthDose.GrisGris_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})

    local GrisGrisSCVendorItem = createVendorItem('GrisGrisSC', SCPrereqs[50], {  }, GrisGris)
    local GrisGrisNoSCVendorItem = createVendorItem('GrisGris', nil, {  }, GrisGris)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------BeRiteBack-----------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    local BeRiteBackV1Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.BeRiteBackV1_Description_1',
        CreateOnEquipDescription(basePath..'BeRiteBackV1_1', {
            CreateSingleStatUpdate("BeRiteBackV1_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("BeRiteBackV1_3", "Additive", "BaseStats.InhalerBaseHealing", 35),
        }),
        'SynthDose.Item_Duration_15',
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local BeRiteBackV2Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.BeRiteBackV2_Description_1',
        CreateOnEquipDescription(basePath..'BeRiteBackV2_1', {
            CreateSingleStatUpdate("BeRiteBackV2_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("BeRiteBackV2_3", "Additive", "BaseStats.InhalerBaseHealing", 45),
        }),
        'SynthDose.Item_Duration_15',
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local BeRiteBackV3Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.BeRiteBackV3_Description_1',
        CreateOnEquipDescription(basePath..'BeRiteBackV3_1', {
            CreateSingleStatUpdate("BeRiteBackV3_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("BeRiteBackV3_3", "Additive", "BaseStats.InhalerBaseHealing", 60),
        }),
        'SynthDose.Item_Duration_15',
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local BeRiteBackV4Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.BeRiteBackV4_Description_1',
        CreateOnEquipDescription(basePath..'BeRiteBackV4_1', {
            CreateSingleStatUpdate("BeRiteBackV4_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("BeRiteBackV4_3", "Additive", "BaseStats.InhalerBaseHealing", 70),
        }),
        'SynthDose.Item_Duration_15',
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local BeRiteBackV5Description = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.BeRiteBackV5_Description_1',
        CreateOnEquipDescription(basePath..'BeRiteBackV5_1', {
            CreateSingleStatUpdate("BeRiteBackV5_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("BeRiteBackV5_3", "Additive", "BaseStats.InhalerBaseHealing", 85),
        }),
        'SynthDose.Item_Duration_15',
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }

    local BeRiteBackV5PlusDescription = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.BeRiteBackV5Plus_Description_1',
        CreateOnEquipDescription(basePath..'BeRiteBackV5P_1', {
            CreateSingleStatUpdate("BeRiteBackV5P_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("BeRiteBackV5P_3", "Additive", "BaseStats.InhalerBaseHealing", 100),
        }),
        'SynthDose.Item_Duration_15',
        'SynthDose.DisableHealthMonitorBasedOnToxicityDescription'
    }


    local BeRiteBackV1Effects = {
        CreateSingleStatUpdate("BeRiteBackV1_4", "Additive", "BaseStats.CyberwareCooldownReduction", 0.05),  
    }

    local BeRiteBackV2Effects = {
        CreateSingleStatUpdate("BeRiteBackV2_4", "Additive", "BaseStats.CyberwareCooldownReduction", 0.06),  
    }

    local BeRiteBackV3Effects = {
        CreateSingleStatUpdate("BeRiteBackV3_4", "Additive", "BaseStats.CyberwareCooldownReduction", 0.07),  
    }

    local BeRiteBackV4Effects = {
        CreateSingleStatUpdate("BeRiteBackV4_4", "Additive", "BaseStats.CyberwareCooldownReduction", 0.08),  
    }

    local BeRiteBackV5Effects = {
        CreateSingleStatUpdate("BeRiteBackV5_4", "Additive", "BaseStats.CyberwareCooldownReduction", 0.9),  
    }

    local BeRiteBackV5PlusEffects = {
        CreateSingleStatUpdate("BeRiteBackV5P_4", "Additive", "BaseStats.CyberwareCooldownReduction", 0.1),  
    }


    local BeRiteBackV1InstantEffects = {
        CreateInstantPoolEffector('BeRiteBackV1_5', 'Health', 35, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local BeRiteBackV2InstantEffects = {
        CreateInstantPoolEffector('BeRiteBackV2_5', 'Health', 45, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local BeRiteBackV3InstantEffects = {
        CreateInstantPoolEffector('BeRiteBackV3_5', 'Health', 60, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local BeRiteBackV4InstantEffects = {
        CreateInstantPoolEffector('BeRiteBackV4_5', 'Health', 70, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local BeRiteBackV5InstantEffects = {
        CreateInstantPoolEffector('BeRiteBackV5_5', 'Health', 85, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local BeRiteBackV5PlusInstantEffects = {
        CreateInstantPoolEffector('BeRiteBackV5Plus_5', 'Health', 100, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local BeRiteBackV1 = createInhaler("BeRiteBackV1", "inhaler_3_health_beriteback", "medical_2", "synthDose_beRiteBack_flavor", BeRiteBackV1Description, "synthDose_beRiteBackV1_name", "Quality.Common", 10, BeRiteBackV1InstantEffects, BeRiteBackV1Effects, {}, {'SynthDose.Inhaler'},1,'SynthDose.BeRiteBack_Icon', {}) 
    local BeRiteBackV2 = createInhaler("BeRiteBackV2", "inhaler_3_health_beriteback", "medical_2", "synthDose_beRiteBack_flavor", BeRiteBackV2Description, "synthDose_beRiteBackV2_name", "Quality.Uncommon", 10, BeRiteBackV2InstantEffects, BeRiteBackV2Effects, {}, {'SynthDose.Inhaler'},1,'SynthDose.BeRiteBack_Icon', {}) 
    local BeRiteBackV3 = createInhaler("BeRiteBackV3", "inhaler_3_health_beriteback", "medical_2", "synthDose_beRiteBack_flavor", BeRiteBackV3Description, "synthDose_beRiteBackV3_name", "Quality.Rare", 10, BeRiteBackV3InstantEffects, BeRiteBackV3Effects, {}, {'SynthDose.Inhaler'},1,'SynthDose.BeRiteBack_Icon', {}) 
    local BeRiteBackV4 = createInhaler("BeRiteBackV4", "inhaler_3_health_beriteback", "medical_2", "synthDose_beRiteBack_flavor", BeRiteBackV4Description, "synthDose_beRiteBackV4_name", "Quality.Epic", 10, BeRiteBackV4InstantEffects, BeRiteBackV4Effects, {}, {'SynthDose.Inhaler'},1,'SynthDose.BeRiteBack_Icon', {}) 
    local BeRiteBackV5 = createInhaler("BeRiteBackV5", "inhaler_3_health_beriteback", "medical_2", "synthDose_beRiteBack_flavor", BeRiteBackV5Description, "synthDose_beRiteBackV5_name", "Quality.Legendary", 10, BeRiteBackV5InstantEffects, BeRiteBackV5Effects, {}, {'SynthDose.Inhaler'},1,'SynthDose.BeRiteBack_Icon', {}) 
    local BeRiteBackV5Plus = createInhaler("BeRiteBackV5P", "inhaler_3_health_beriteback", "medical_2", "synthDose_beRiteBack_flavor", BeRiteBackV5PlusDescription, "synthDose_beRiteBackV5_name", "Quality.LegendaryPlus", 10, BeRiteBackV5PlusInstantEffects, BeRiteBackV5PlusEffects, {}, {'SynthDose.Inhaler'},1,'SynthDose.BeRiteBack_Icon', {}) 

    local BeRiteBackV1VendorItem = createVendorItem('BeRiteBackV1', nil, { leverPrereqTier1 }, BeRiteBackV1)
    local BeRiteBackV2VendorItem = createVendorItem('BeRiteBackV2', nil, { leverPrereqTier2 }, BeRiteBackV2)
    local BeRiteBackV3VendorItem = createVendorItem('BeRiteBackV3', nil, { leverPrereqTier3 }, BeRiteBackV3)
    local BeRiteBackV4VendorItem = createVendorItem('BeRiteBackV4', nil, { leverPrereqTier4 }, BeRiteBackV4)
    local BeRiteBackV5VendorItem = createVendorItem('BeRiteBackV5', nil, { leverPrereqTier5 }, BeRiteBackV5)
    local BeRiteBackV5PlusVendorItem = createVendorItem('BeRiteBackV5Plus', nil, { leverPrereqTier5Plus }, BeRiteBackV5Plus)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------Super Jet------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local SuperJetV1Descriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.SuperJetV1_Description_1',
        CreateOnEquipDescription(basePath..'SuperJetV1_1', {
            CreateSingleStatUpdate("SuperJetV1_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV1_3", "Additive", "BaseStats.InjectorBaseHealing", 100)
        }),
        'SynthDose.SuperJet_Description_2',
        nonHealingDrugDescriptionStatPath
    }

    local SuperJetV2Descriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.SuperJetV2_Description_1',
        CreateOnEquipDescription(basePath..'SuperJetV2_1', {
            CreateSingleStatUpdate("SuperJetV2_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV2_3", "Additive", "BaseStats.InjectorBaseHealing", 130)
        }),
        'SynthDose.SuperJet_Description_2',
        nonHealingDrugDescriptionStatPath
    }

    local SuperJetV3Descriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.SuperJetV3_Description_1',
        CreateOnEquipDescription(basePath..'SuperJetV3_1', {
            CreateSingleStatUpdate("SuperJetV3_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV3_3", "Additive", "BaseStats.InjectorBaseHealing", 168)
        }),
        'SynthDose.SuperJet_Description_2',
        nonHealingDrugDescriptionStatPath
    }

    local SuperJetV4Descriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.SuperJetV4_Description_1',
        CreateOnEquipDescription(basePath..'SuperJetV4_1', {
            CreateSingleStatUpdate("SuperJetV4_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV4_3", "Additive", "BaseStats.InjectorBaseHealing", 200)
        }),
        'SynthDose.SuperJet_Description_2',
        nonHealingDrugDescriptionStatPath
    }

    local SuperJetV5Descriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.SuperJetV5_Description_1',
        CreateOnEquipDescription(basePath..'SuperJetV5_1', {
            CreateSingleStatUpdate("SuperJetV5_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV5_3", "Additive", "BaseStats.InjectorBaseHealing", 232)
        }),
        'SynthDose.SuperJet_Description_2',
        nonHealingDrugDescriptionStatPath
    }

    local SuperJetV5PlusDescriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.SuperJetV5Plus_Description_1',
        CreateOnEquipDescription(basePath..'SuperJetV5P_1', {
            CreateSingleStatUpdate("SuperJetV5P_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV5P_3", "Additive", "BaseStats.InjectorBaseHealing", 252)
        }),
        'SynthDose.SuperJet_Description_2',
        nonHealingDrugDescriptionStatPath
    }

    local SuperJetEffects = {
        CreateSingleStatUpdate("SuperJetV1_5", "AdditiveMultiplier", "BaseStats.StaminaRegenRate", 0.5),
    }
    
    local SuperJetV1EffectorEffects = {
        CreateOverTimeRegenEffector('SuperJetV1_6', 'Overshield', 'Prereqs.AlwaysTruePrereq', 5)
    }
    local SuperJetV2EffectorEffects = {
        CreateOverTimeRegenEffector('SuperJetV2_6', 'Overshield', 'Prereqs.AlwaysTruePrereq', 6.5)
    }
    local SuperJetV3EffectorEffects = {
        CreateOverTimeRegenEffector('SuperJetV3_6', 'Overshield', 'Prereqs.AlwaysTruePrereq', 8.5)
    }
    local SuperJetV4EffectorEffects = {
        CreateOverTimeRegenEffector('SuperJetV4_6', 'Overshield', 'Prereqs.AlwaysTruePrereq', 10)
    }
    local SuperJetV5EffectorEffects = {
        CreateOverTimeRegenEffector('SuperJetV5_6', 'Overshield', 'Prereqs.AlwaysTruePrereq', 12)
    }
    local SuperJetV5PlusEffectorEffects = {
        CreateOverTimeRegenEffector('SuperJetV5P_6', 'Overshield', 'Prereqs.AlwaysTruePrereq', 14)
    }

    local SuperJetV1InstantEffects = {
        CreateInstantPoolEffector('SuperJetV1_7', 'Health', 100, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }
    local SuperJetV2InstantEffects = {
        CreateInstantPoolEffector('SuperJetV2_7', 'Health', 130, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }
    local SuperJetV3InstantEffects = {
        CreateInstantPoolEffector('SuperJetV3_7', 'Health', 168, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }
    local SuperJetV4InstantEffects = {
        CreateInstantPoolEffector('SuperJetV4_7', 'Health', 200, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }
    local SuperJetV5InstantEffects = {
        CreateInstantPoolEffector('SuperJetV5_7', 'Health', 232, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }
    local SuperJetV5PlusInstantEffects = {
        CreateInstantPoolEffector('SuperJetV5P_7', 'Health', 252, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }

    local SuperJetV1 = createInjector("SuperJetV1", "injector_2_wound", "injector___1", "synthDose_superJet_flavor", SuperJetV1Descriptions, "synthDose_superJetV1_name", "Quality.Common", 60, SuperJetV1InstantEffects, SuperJetEffects,SuperJetV1EffectorEffects, {'SynthDose.SuperJet'}, 5, 'SynthDose.SuperJet_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})
    local SuperJetV2 = createInjector("SuperJetV2", "injector_2_wound", "injector___1", "synthDose_superJet_flavor", SuperJetV2Descriptions, "synthDose_superJetV2_name", "Quality.Uncommon", 60, SuperJetV2InstantEffects, SuperJetEffects,SuperJetV2EffectorEffects, {'SynthDose.SuperJet'}, 5, 'SynthDose.SuperJet_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})
    local SuperJetV3 = createInjector("SuperJetV3", "injector_2_wound", "injector___1", "synthDose_superJet_flavor", SuperJetV3Descriptions, "synthDose_superJetV3_name", "Quality.Rare", 60, SuperJetV3InstantEffects, SuperJetEffects,SuperJetV3EffectorEffects, {'SynthDose.SuperJet'}, 5, 'SynthDose.SuperJet_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})
    local SuperJetV4 = createInjector("SuperJetV4", "injector_2_wound", "injector___1", "synthDose_superJet_flavor", SuperJetV4Descriptions, "synthDose_superJetV4_name", "Quality.Epic", 60, SuperJetV4InstantEffects, SuperJetEffects,SuperJetV4EffectorEffects, {'SynthDose.SuperJet'}, 5, 'SynthDose.SuperJet_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})
    local SuperJetV5 = createInjector("SuperJetV5", "injector_2_wound", "injector___1", "synthDose_superJet_flavor", SuperJetV5Descriptions, "synthDose_superJetV5_name", "Quality.Legendary", 60, SuperJetV5InstantEffects, SuperJetEffects,SuperJetV5EffectorEffects, {'SynthDose.SuperJet'}, 5, 'SynthDose.SuperJet_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})
    local SuperJetV5Plus = createInjector("SuperJetV5Plus", "injector_2_wound", "injector___1", "synthDose_superJet_flavor", SuperJetV5PlusDescriptions, "synthDose_superJetV5_name", "Quality.LegendaryPlus", 60, SuperJetV5PlusInstantEffects, SuperJetEffects,SuperJetV5PlusEffectorEffects, {'SynthDose.SuperJet'}, 5, 'SynthDose.SuperJet_Icon', {'Items.Alcohol_inline6', 'Items.Alcohol_inline6'})

    local SuperJetV1VendorItem = createVendorItem('SuperJetV1', nil, { leverPrereqTier1 }, SuperJetV1)
    local SuperJetV2VendorItem = createVendorItem('SuperJetV2', nil, { leverPrereqTier2 }, SuperJetV2)
    local SuperJetV3VendorItem = createVendorItem('SuperJetV3', nil, { leverPrereqTier3 }, SuperJetV3)
    local SuperJetV4VendorItem = createVendorItem('SuperJetV4', nil, { leverPrereqTier4 }, SuperJetV4)
    local SuperJetV5VendorItem = createVendorItem('SuperJetV5', nil, { leverPrereqTier5 }, SuperJetV5)
    local SuperJetV5PlusVendorItem = createVendorItem('SuperJetV5Plus', nil, { leverPrereqTier5Plus }, SuperJetV5Plus)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------Juice--------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local JuiceInstantEffects = {
        CreateInstantPoolEffector('Juice7', 'Overshield', 100, true, 'Prereqs.AlwaysTruePrereq'),
        CreateInstantPoolEffector('Juice8', 'Health', 20, false, 'Prereqs.AlwaysTruePrereq'),
        'Effectors.UsedHealingItemOrCyberwareEffector'
    }
    
    local JuiceEffects = {
        CreateSingleStatUpdate("Juice3", "AdditiveMultiplier", "BaseStats.MaxSpeed", 0.2),
        CreateSingleStatUpdate("Juice4", "Additive", "BaseStats.OvershieldDecayStartDelay", 20),
        CreateSingleStatUpdate("Juice5", "AdditiveMultiplier", "BaseStats.JumpHeight", 0.2),
        CreateSingleStatUpdate("Juice6", "Additive", "BaseStats.MeleeDamagePercentBonus", 0.1)
    }

    local JuiceDescription = {
        'SynthDose.Toxicity_Mild_StatData',
        'SynthDose.Juice_Description_1',
        'SynthDose.Juice_Description_2',
        'SynthDose.Item_Duration_20',
        CreateOnEquipDescription(basePath..'Juice_55', {
            CreateSingleStatUpdate("SuperJetV1_2", "Additive", "BaseStats.IsHealingItemEquipped", 1),
            CreateSingleStatUpdate("SuperJetV1_3", "Additive", "BaseStats.InjectorBaseHealing", 20)
        }),
        nonHealingDrugDescriptionStatPath
    }

    local JuiceEffectorEffects = {

    }

    local Juice = createInhaler("Juice", "inhaler_19_juice", "drug_13", "synthDose_juice_flavor", JuiceDescription, "synthDose_juice_name", "Quality.Rare", 20, JuiceInstantEffects, JuiceEffects,JuiceEffectorEffects, {'IllegalItem'}, 1, 'SynthDose.Juice_Icon', {})

    local JuiceSCVendorItem = createVendorItem('JuiceSC', SCPrereqs[20], {  }, Juice)
    local JuiceNoSCVendorItem = createVendorItem('JuiceNoSc', nil, {  }, Juice)


    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------Juice--------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    local DetoxV1VendorItem = createVendorItem('DetoxCommon', nil, { leverPrereqTier1 }, 'SynthDose.DetoxifierCommon') 
    local DetoxV2VendorItem = createVendorItem('DetoxCommon', nil, { leverPrereqTier2 }, 'SynthDose.DetoxifierUncommon')
    local DetoxV3VendorItem = createVendorItem('DetoxCommon', nil, { leverPrereqTier3 }, 'SynthDose.DetoxifierRare')
    local DetoxV4VendorItem = createVendorItem('DetoxCommon', nil, { leverPrereqTier4 }, 'SynthDose.DetoxifierEpic')
    local DetoxV5VendorItem = createVendorItem('DetoxCommon', nil, { 'LootPrereqs.PlayerLevel_Tier_4_to_5_Exclusion_Prereq' }, 'SynthDose.DetoxifierLegendary')   
    
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -----------------------------------------------------------------------------------------------------VENDORS---------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- Netrunners

    AddToVendor('Vendors.hey_rey_netrunner_01', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem })
    AddToVendor('Vendors.wat_kab_netrunner_01', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem }) 
    AddToVendor('Vendors.wat_lch_netrunner_01', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem, CodeFreezeVendorSCItem })
    AddToVendor('Vendors.wbr_jpn_netrunner_01', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem })
    AddToVendor('Vendors.wbr_jpn_netrunner_02', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem })
    AddToVendor('Vendors.pac_cvi_techstore_01', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem, GrisGrisSCVendorItem })
    AddToVendor('Vendors.cz_stadium_netrunner_01', { IC3C0LDV1VendorItem, IC3C0LDV2VendorItem, IC3C0LDV3VendorItem, IC3C0LDV4VendorItem, IC3C0LDV5VendorItem, IC3C0LDV5PlusVendorItem, CodeFreezeVendorNoSCItem, GrisGrisNoSCVendorItem })

    -- Med Vendors

	AddToVendor("Vendors.bls_ina_se1_medicstore_01",  { SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem, RoaringPhoenixV1SCVendorItem, RoaringPhoenixV2SCVendorItem, RoaringPhoenixV3SCVendorItem, RoaringPhoenixV4SCVendorItem, RoaringPhoenixV5SCVendorItem, RoaringPhoenixV5PlusSCVendorItem})
	AddToVendor("Vendors.cct_cpz_medic_01",  { SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem, ThunderBoltVendorItem, RoaringPhoenixV1SCVendorItem, RoaringPhoenixV2SCVendorItem, RoaringPhoenixV3SCVendorItem, RoaringPhoenixV4SCVendorItem, RoaringPhoenixV5SCVendorItem, RoaringPhoenixV5PlusSCVendorItem })
	AddToVendor("Vendors.cct_dtn_medic_01",  { ThunderBoltVendorItem, AspisVendorItem, EludeVendorItem, SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem })
	AddToVendor("Vendors.hey_spr_medicstore_01",  { AspisVendorItem, EludeVendorItem })
	AddToVendor("Vendors.pac_cvi_medicstore_01",  { JuiceSCVendorItem, BlackLaceSCVendorItem, GlitterSCVendorItem, EludeVendorItem, SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem })
	AddToVendor("Vendors.std_arr_medicstore_01",  { ThunderBoltVendorItem, StimVendorSCItem, KersVendorSCItem, SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem })
	AddToVendor("Vendors.std_rcr_medicstore_01",  { SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem })
	AddToVendor("Vendors.wat_kab_medicstore_01",  { SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem, EludeVendorItem, AspisVendorItem, KersVendorSCItem, RoaringPhoenixV1SCVendorItem, RoaringPhoenixV2SCVendorItem, RoaringPhoenixV3SCVendorItem, RoaringPhoenixV4SCVendorItem, RoaringPhoenixV5SCVendorItem, RoaringPhoenixV5PlusSCVendorItem })
	AddToVendor("Vendors.wat_lch_medicstore_01",  { ThunderBoltVendorItem, RoaringPhoenixV1SCVendorItem, RoaringPhoenixV2SCVendorItem, RoaringPhoenixV3SCVendorItem, RoaringPhoenixV4SCVendorItem, RoaringPhoenixV5SCVendorItem, RoaringPhoenixV5PlusSCVendorItem })
	AddToVendor("Vendors.wat_nid_medicstore_01",  { AspisVendorItem, KersVendorSCItem, EludeVendorItem }) -- northside
	AddToVendor("Vendors.wat_nid_medicstore_02",  { AspisVendorItem, StimVendorSCItem, KersVendorSCItem, EludeVendorItem, SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem }) -- docks
	AddToVendor("Vendors.wbr_jpn_medicstore_01",  { SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem, EludeVendorItem, ThunderBoltVendorItem, AspisVendorItem, KersVendorSCItem, RoaringPhoenixV1SCVendorItem, RoaringPhoenixV2SCVendorItem, RoaringPhoenixV3SCVendorItem, RoaringPhoenixV4SCVendorItem, RoaringPhoenixV5SCVendorItem, RoaringPhoenixV5PlusSCVendorItem })
	AddToVendor("Vendors.cz_stadium_medic_01",  { JuiceNoSCVendorItem, SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem, EludeVendorItem, Rambo8NoSCVendorItem, GlitterNoSCVendorItem, ThunderBoltVendorItem, AspisVendorItem, StimVendorNoSCItem, KersVendorNoSCItem, HappyKillNoSCItem, BlackLaceNoSCVendorItem, RoaringPhoenixV1NoSCVendorItem, RoaringPhoenixV2NoSCVendorItem, RoaringPhoenixV3NoSCVendorItem, RoaringPhoenixV4NoSCVendorItem, RoaringPhoenixV5NoSCVendorItem, RoaringPhoenixV5PlusNoSCVendorItem })
	AddToVendor("Vendors.cz_con_medic_01",  { JuiceNoSCVendorItem, SuperJetV1VendorItem, SuperJetV2VendorItem, SuperJetV3VendorItem, SuperJetV4VendorItem, SuperJetV5VendorItem, SuperJetV5PlusVendorItem, EludeVendorItem, ThunderBoltVendorItem, AspisVendorItem, StimVendorNoSCItem, KersVendorNoSCItem, BlackLaceNoSCVendorItem, RoaringPhoenixV1NoSCVendorItem, RoaringPhoenixV2NoSCVendorItem, RoaringPhoenixV3NoSCVendorItem, RoaringPhoenixV4NoSCVendorItem, RoaringPhoenixV5NoSCVendorItem, RoaringPhoenixV5PlusNoSCVendorItem })

    -- Junk Vendors

	AddToVendor("Vendors.wat_kab_junkshop_01",  { KersVendorSCItem, StimVendorSCItem, GlitterSCVendorItem }) -- frank emporium
	AddToVendor("Vendors.wbr_jpn_junkshop_02",  { HappyKillSCItem, Rambo8SCVendorItem }) -- dealer
	AddToVendor("Vendors.wbr_jpn_medicstore_03",  { BlackLaceSCVendorItem, GlitterSCVendorItem, JuiceSCVendorItem, ThunderBoltVendorItem, Kers }) -- dealer

    -- RipperDocs

    AddToVendor("Vendors.pac_wwd_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.std_arr_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.std_rcr_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wat_kab_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wat_kab_ripperdoc_02", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wat_kab_ripperdoc_03", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wat_lch_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wat_nid_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wbr_jpn_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wbr_jpn_ripperdoc_02", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.wbr_hil_ripdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.hey_spr_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.cct_dtn_ripdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.bls_ina_se1_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.bls_ina_se1_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.cz_stadium_ripperdoc_01", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.cz_monument_ripperdoc_farida", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
	AddToVendor("Vendors.cz_monument_ripperdoc_anderson", { BeRiteBackV1VendorItem, BeRiteBackV2VendorItem, BeRiteBackV3VendorItem, BeRiteBackV4VendorItem, BeRiteBackV5VendorItem, BeRiteBackV5PlusVendorItem, DetoxV1VendorItem, DetoxV2VendorItem, DetoxV3VendorItem, DetoxV4VendorItem, DetoxV5VendorItem })
end

function isInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

function createInjector(recordName, iconPath, appearanceName, flavourText, localizedDescription, localizedName, quality, duration, instantEffects, effects, effectorEffects, tags, toxicity, icon, extraEffects) 
    return createItem("Items.BonesMcCoy70V1", recordName, iconPath, appearanceName, flavourText, localizedDescription, localizedName, quality, duration, instantEffects, effects, effectorEffects, tags, toxicity, icon, extraEffects)
end

function createInhaler(recordName, iconPath, appearanceName, flavourText, localizedDescription, localizedName, quality, duration, instantEffects, effects, effectorEffects, tags, toxicity, icon, extraEffects) 
    return createItem("Items.FirstAidWhiffV0", recordName, iconPath, appearanceName, flavourText, localizedDescription, localizedName, quality, duration, instantEffects, effects, effectorEffects, tags, toxicity, icon, extraEffects)
end

function createItem(cloneName, recordName, iconPath, appearanceName, flavourText, localizedDescription, localizedName, quality, duration, instantEffects, effects, effectorEffects, tags, toxicity, icon, extraEffects)
    local itemName

    if recordName == 'BlackLaceV1' then itemName = 'Items.BlackLaceV1' else itemName = basePath..recordName end

    TweakDB:CloneRecord(itemName, cloneName)

    local baseTags = { 'Preload', 'Consumable', 'Drug', 'SkipActivityLogOnRemove', 'ChargedConsumable', 'SynthDose.Generic' }


    -- Price
    
    if isInArray(tags, 'IllegalItem') then 
        TweakDB:SetFlat(itemName..'.buyPrice', {'Price.ConsumableBasePrice', 'Price.ItemQualityMultiplier', 'Price.PlusTierMultiplier', 'Price.BuyPrice_StreetCred_Discount', 'Price.Injector', illegalGoodPriceMultiplier})
    else
        TweakDB:SetFlat(itemName..'.buyPrice', {'Price.ConsumableBasePrice', 'Price.ItemQualityMultiplier', 'Price.PlusTierMultiplier', 'Price.BuyPrice_StreetCred_Discount', 'Price.Injector'})
    end 


    -- Basic overwrites
    TweakDB:SetFlatNoUpdate(itemName..".CraftingData", nil)
    TweakDB:SetFlatNoUpdate(itemName..".iconPath", iconPath)
    TweakDB:SetFlatNoUpdate(itemName..".appearanceName", appearanceName)
    TweakDB:SetFlatNoUpdate(itemName..".OnEquip", localizedDescription)
    TweakDB:SetFlatNoUpdate(itemName..".displayName", LocKey(localizedName))
    TweakDB:SetFlatNoUpdate(itemName..".localizedDescription", LocKey(flavourText))
    TweakDB:SetFlatNoUpdate(itemName..".quality", quality)
    TweakDB:SetFlatNoUpdate(itemName..".tags", mergeTables(tags, baseTags))

    TweakDB:SetFlatNoUpdate(itemName..".statModifierGroups", nil)

    -- EffectBaseCode
    local toxicityStacks = {}  
    for i = 1, toxicity do
       toxicityStacks[i] = toxicityEffect 
    end

    local BaseEffectPath = CreateBaseStatusEffect(recordName, effects, effectorEffects, duration, icon, false)
    local InstantEffectPath = CreateBaseStatusEffect(recordName..'_instantEffects', {}, instantEffects, 0.1, icon, false)

    TweakDB:CloneRecord(basePath..recordName.."_inline3", 'Items.BonesMcCoy70V1_inline3')
    TweakDB:CloneRecord(basePath..recordName.."_inline4", 'Items.BonesMcCoy70V1_inline3')
    
    TweakDB:SetFlat(basePath..recordName.."_inline3.statusEffect", BaseEffectPath)
    TweakDB:SetFlat(basePath..recordName.."_inline4.statusEffect", InstantEffectPath)

    TweakDB:CloneRecord(basePath..recordName.."_inline0", 'Items.BonesMcCoy70V1_inline0')
    TweakDB:SetFlat(basePath..recordName.."_inline0.completionEffects", mergeTables(mergeTables({ basePath..recordName.."_inline4", basePath..recordName.."_inline3" }, toxicityStacks), extraEffects))
    TweakDB:SetFlat(basePath..recordName.."_inline0.startEffects", {})
    TweakDB:SetFlat(basePath..recordName.."_inline0.instigatorPrereqs", {"Prereqs.AlwaysTruePrereq"})
    TweakDB:SetFlat(itemName..".objectActions", {basePath..recordName.."_inline0"})

	TweakDB:Update(itemName)
    return itemName
end

function CreateBaseStatusEffect(recordName, effects, effectorEffects, duration, icon, removeWhenDurationEnds)
    local BaseEffectPath = "BaseStatusEffect."..recordName

    TweakDB:CloneRecord(BaseEffectPath, 'BaseStatusEffect.BonesMcCoy70V1')
    
    TweakDB:SetFlat(BaseEffectPath..".uiData", icon)
    TweakDB:CloneRecord(BaseEffectPath..'stacks0','BaseStatusEffect.Drugged_inline0')
    TweakDB:CloneRecord(BaseEffectPath..'stacks1','BaseStatusEffect.Drugged_inline1')
    TweakDB:SetFlat(BaseEffectPath..'.removeAllStacksWhenDurationEnds', removeWhenDurationEnds)
    TweakDB:SetFlat(BaseEffectPath..'stacks1.value', 10)
    TweakDB:SetFlat(BaseEffectPath..'stacks0.statModifiers', {BaseEffectPath..'stacks1'})
    TweakDB:SetFlat(BaseEffectPath..".maxStacks", BaseEffectPath..'stacks0')
    TweakDB:SetFlat(BaseEffectPath..'.gameplayTags', {'Buff', 'Buff'})
    TweakDB:SetFlat(BaseEffectPath..'.statusEffectType', 'BaseStatusEffectTypes.SynthDose')


    -- Duration of Effect
    TweakDB:CloneRecord(basePath..recordName.."Duration", 'Items.BonesMcCoy70Duration')
    TweakDB:CloneRecord(basePath..recordName.."Duration_inline0", 'Items.BonesMcCoy70Duration_inline0')
    TweakDB:SetFlat(basePath..recordName.."Duration.statModifiers", {basePath..recordName.."Duration_inline0"})
    TweakDB:SetFlat(basePath..recordName.."Duration_inline0.value", duration)
    TweakDB:SetFlat(BaseEffectPath..".duration", basePath..recordName.."Duration")
    TweakDB:SetFlat(basePath..recordName..'.statModifierGroups', { basePath..recordName.."Duration" })

    -- Effect package
    TweakDB:CloneRecord(BaseEffectPath.."_inline0", 'BaseStatusEffect.BonesMcCoy70V0_inline0')
    TweakDB:SetFlat(BaseEffectPath.."_inline0.stats", effects)
    TweakDB:SetFlat(BaseEffectPath.."_inline0.effectors", effectorEffects)
    TweakDB:SetFlat(BaseEffectPath..".packages", { BaseEffectPath.."_inline0" })

    return BaseEffectPath
end

function CreateSingleStatUpdate(recordName, modifierType, statType, value) 
    local newEffectName = "BaseStatusEffect."..recordName.."_effect_"..statType.."_inline1"

    TweakDB:CloneRecord(newEffectName, 'BaseStatusEffect.BlackLaceV0_inline1')
    TweakDB:SetFlatNoUpdate(newEffectName..".modifierType", modifierType)
    TweakDB:SetFlatNoUpdate(newEffectName..".statType", statType)
    TweakDB:SetFlatNoUpdate(newEffectName..".value", value)

    TweakDB:Update(newEffectName)
    return newEffectName
end

function createStatGroupEffector(recordName, target, prereqRecord, modifierType, statType, value)
    local newEffectName = "BaseStatusEffect."..recordName.."_weaponEffector_"..statType

    TweakDB:CloneRecord(newEffectName, 'NewPerks.BodyPerkReload_Buff_inline3')
    TweakDB:CloneRecord(newEffectName..'inline_2', 'NewPerks.BodyPerkReload_Buff_inline4')
    TweakDB:CloneRecord(newEffectName..'inline_3', 'NewPerks.BodyPerkReload_Buff_inline5')
    
    TweakDB:SetFlat(newEffectName..'inline_3'..".modifierType", modifierType)
    TweakDB:SetFlat(newEffectName..'inline_3'..".statType", statType)
    TweakDB:SetFlat(newEffectName..'inline_3'..".value", value)
    TweakDB:SetFlat(newEffectName..'inline_2'..".statModifiers", {newEffectName..'inline_3'})
    TweakDB:SetFlat(newEffectName..".statGroup", newEffectName..'inline_2')
    TweakDB:SetFlat(newEffectName..".applicationTarget", target)
    TweakDB:SetFlat(newEffectName..".prereqRecord", prereqRecord)

    return newEffectName
end

function createPrereqEffector(recordName, prereq, statusEffect, removeWithEffector)
    local finalRecord = basePath..recordName

    TweakDB:CloneRecord(finalRecord, 'Ability.CanUseCombatStims_inline4')
    TweakDB:SetFlat(finalRecord..".inverted", false)
    TweakDB:SetFlat(finalRecord..".prereqRecord", prereq)
    TweakDB:SetFlat(finalRecord..".statusEffect", statusEffect)
    TweakDB:SetFlat(finalRecord..".removeWithEffector", removeWithEffector)


    return finalRecord
end

function CreateOnEquipDescription(recordName, stats)
    local finalRecord = recordName..'_onEquip_inline1'

    TweakDB:CloneRecord(finalRecord, 'Items.AdvancedRamUpgradeCommon_inline1')
    
    TweakDB:CloneRecord(recordName..'_onEquip_inline2', 'Items.AdvancedRamUpgradeCommon_inline3')
    TweakDB:SetFlat(recordName..'_onEquip_inline2.localizedDescription', '')
    TweakDB:SetFlat(recordName..'_onEquip_inline2.floatValues', nil)

    TweakDB:SetFlat(finalRecord..'.UIData', recordName..'_onEquip_inline2')
    TweakDB:SetFlat(finalRecord..'.stats', stats)
    return finalRecord
end


function CreateToxicityEffect() 
    TweakDB:CloneRecord("BaseStatusEffect.Toxicity", "BaseStatusEffect.Drugged")

    local ToxicityEffects = {
        CreateSingleStatUpdate("ToxicityEffects", "AdditiveMultiplier", "BaseStats.StaminaRegenRate", -0.05),
        CreateSingleStatUpdate("ToxicityEffects", "Additive", "BaseStats.StaminaRegenStartDelay", 0.2),
        CreateSingleStatUpdate("ToxicityEffects", "AdditiveMultiplier", "BaseStats.MemoryRegenRate", -0.05),
        CreateSingleStatUpdate("ToxicityEffects", "Additive", "BaseStats.ToxicityCounter", 1)
    }
    

    local ToxicityEffectorEffects = {
        
    }

    --Toxicity Icon 
    TweakDB:CloneRecord('BaseStatusEffect.Toxicity_icon', 'BaseStatusEffect.Poisoned_inline38')
    TweakDB:SetFlat("BaseStatusEffect.Toxicity_icon.displayName", 'Toxicity')
    TweakDB:SetFlat("BaseStatusEffect.Toxicity_icon.description", 'Lowers stamina, ram regeneration, max HP, and speed. High toxicty can cause damage')
    TweakDB:SetFlat("BaseStatusEffect.Toxicity.uiData", 'SynthDose.Toxicity_Icon')

    -- Set the duration
    TweakDB:CloneRecord("BaseStatusEffect.ToxicityGameStatModifierGroupDuration", "BaseStatusEffect.Drugged_inline3")
    TweakDB:SetFlat("BaseStatusEffect.ToxicityGameStatModifierGroupDuration.statModifiers", {'SynthDose.ToxicityMaxDuration'})
    TweakDB:SetFlat("BaseStatusEffect.Toxicity.duration", "BaseStatusEffect.ToxicityGameStatModifierGroupDuration")

    -- Set the max stacks
    TweakDB:CloneRecord("BaseStatusEffect.ToxicityConstantStatModifierMaxStacks", "BaseStatusEffect.Drugged_inline1")
    TweakDB:SetFlat("BaseStatusEffect.ToxicityConstantStatModifierMaxStacks.value", 30)
    TweakDB:CloneRecord("BaseStatusEffect.ToxicityGameStatModifierGroupMaxStacks", "BaseStatusEffect.Drugged_inline0")
    TweakDB:SetFlat("BaseStatusEffect.ToxicityGameStatModifierGroupMaxStacks.statModifiers", {"BaseStatusEffect.ToxicityConstantStatModifierMaxStacks"})
    TweakDB:SetFlat("BaseStatusEffect.Toxicity.maxStacks", "BaseStatusEffect.ToxicityGameStatModifierGroupMaxStacks")

    -- Create Main Package
    TweakDB:CloneRecord("BaseStatusEffect.Toxicity_Package", "BaseStatusEffect.DruggedSevere_inline4")
    TweakDB:SetFlat("BaseStatusEffect.Toxicity_Package.stats", ToxicityEffects)
    TweakDB:SetFlat("BaseStatusEffect.Toxicity_Package.effectors", ToxicityEffectorEffects)

    TweakDB:SetFlat("BaseStatusEffect.Toxicity_Package.stackable", true)
    TweakDB:SetFlat("BaseStatusEffect.Toxicity.packages", {"BaseStatusEffect.Toxicity_Package"})

    
    TweakDB:CloneRecord("SynthDose.Toxicity", 'Items.BonesMcCoy70V1_inline3')
    TweakDB:SetFlat("SynthDose.Toxicity.statusEffect", "BaseStatusEffect.Toxicity")

    -- Create Overdose Package

    local OverdoseEffects = {
        'SynthDose.ToxicityOverDoseDamage',
        CreateSingleStatUpdate("ToxicityEffects", "AdditiveMultiplier", "BaseStats.MaxSpeed", -0.05),
        CreateSingleStatUpdate("ToxicityEffects", "AdditiveMultiplier", "BaseStats.Health", -0.04)
    }

    TweakDB:CloneRecord("BaseStatusEffect.Toxicity_Overdose_StatGroup", "BaseStatusEffect.CyberwareMalfunctionLvl4_inline10")
    TweakDB:SetFlat("BaseStatusEffect.Toxicity_Overdose_StatGroup.statModifiers", OverdoseEffects)

    function CreateOverdoseEffector(toxicityOverTheLimit)
        local EffectorName = "BaseStatusEffect.Toxicity_Overdose_Effector"..toxicityOverTheLimit
        TweakDB:CloneRecord(EffectorName, "BaseStatusEffect.CyberwareMalfunctionLvl4_inline8")

        local PrereqName = "BaseStatusEffect.Toxicity_Overdose_Prereq"..toxicityOverTheLimit
        TweakDB:CloneRecord(PrereqName, "BaseStatusEffect.CyberwareMalfunctionLvl4_inline9")
        TweakDB:SetFlat(PrereqName..".statType", "ToxicityCounter")
        TweakDB:SetFlat(PrereqName..".valueToCheck", toxicityOverTheLimit + overDoseStartValue)
        
        TweakDB:SetFlat(EffectorName..".prereqRecord", PrereqName)
        TweakDB:SetFlat(EffectorName..".removeWithEffector", true)
        TweakDB:SetFlat(EffectorName..".statGroup", "BaseStatusEffect.Toxicity_Overdose_StatGroup")
    
        return EffectorName
    end
    
    TweakDB:CloneRecord("BaseStatusEffect.Toxicity_Overdose_Package", "BaseStatusEffect.DruggedSevere_inline4")

    local overDoseEffectors = {
        CreateOverdoseEffector(0),
        CreateOverdoseEffector(1),
        CreateOverdoseEffector(2),
        CreateOverdoseEffector(3),
        CreateOverdoseEffector(4),
        CreateOverdoseEffector(5),
        CreateOverdoseEffector(6),
        CreateOverdoseEffector(7),
        CreateOverdoseEffector(8),
        CreateOverdoseEffector(9),
        CreateOverdoseEffector(10),
        CreateOverdoseEffector(11),
        CreateOverdoseEffector(12),
        CreateOverdoseEffector(13),
        CreateOverdoseEffector(14),
        CreateOverdoseEffector(15),
        CreateOverdoseEffector(16),
        CreateOverdoseEffector(17),
        CreateOverdoseEffector(18),
        CreateOverdoseEffector(19),
        CreateOverdoseEffector(20)
    }


    TweakDB:SetFlat("BaseStatusEffect.Toxicity_Overdose_Package.effectors", overDoseEffectors)

    local AddrenalinePerkPrereq = 'SynthDose.AddrenalinePerkPrereq'
    
	TweakDB:CreateRecord(AddrenalinePerkPrereq, "gamedataPlayerIsNewPerkBoughtPrereq_Record")
    TweakDB:SetFlat(AddrenalinePerkPrereq..'.perkType', 'Body_Central_Milestone_3')
    TweakDB:SetFlat(AddrenalinePerkPrereq..'.level', 3)
    TweakDB:SetFlat(AddrenalinePerkPrereq..'.prereqClassName', 'PlayerIsNewPerkBoughtPrereq')
    TweakDB:SetFlat(AddrenalinePerkPrereq..'.invert', true)
    
    local AddrenalineApplyPerk = 'SynthDose.AddrenalinApplyPerk'
    TweakDB:CloneRecord(AddrenalineApplyPerk, 'NewPerks.Body_Central_Milestone_3_inline10')
    TweakDB:CloneRecord(AddrenalineApplyPerk..'_12', 'NewPerks.Body_Central_Milestone_3_inline12')
    TweakDB:SetFlat(AddrenalineApplyPerk..'_12.prereqRecord', AddrenalinePerkPrereq)
    TweakDB:SetFlat(AddrenalineApplyPerk..'.stats', {})

    TweakDB:SetFlat(AddrenalineApplyPerk..'.effectors', {
        createStatGroupEffector("Addrenaline_55", "Self", AddrenalinePerkPrereq, "Additive", "BaseStats.OvershieldDecayRate", 15),
        AddrenalineApplyPerk..'_12'
    })

    -- ToxicityCounter
    TweakDB:SetFlat("BaseStatusEffect.Toxicity.packages", {"BaseStatusEffect.Toxicity_Package", "BaseStatusEffect.Toxicity_Overdose_Package", AddrenalineApplyPerk})


    return 'SynthDose.Toxicity'
end

function DisableHealthMonitorForDrugs() 
    local PrereqName = "BaseStatusEffect.NonHealingDrugEquippedChecker"
    TweakDB:CloneRecord(PrereqName, "BaseStatusEffect.CyberwareMalfunctionLvl4_inline9")
    TweakDB:SetFlat(PrereqName..".statType", "NonHealingDrugEquipped")
    TweakDB:SetFlat(PrereqName..".comparisonType", "NotEqual")
    TweakDB:SetFlat(PrereqName..".valueToCheck", 1)


    local healthMonitorEffectorTable = TweakDB:GetFlat('Items.HealthMonitorEffector_inline0.nestedPrereqs')

    table.insert(healthMonitorEffectorTable, PrereqName)

    TweakDB:SetFlat('Items.HealthMonitorEffector_inline0.nestedPrereqs', healthMonitorEffectorTable)
end

function CreateInstantPoolEffector(recordName, statPoolType, value, usePercent, prereq)
    local effectorName1 = "BaseStatusEffect."..recordName..'_instantEffector1'
    local effectorName2 = "BaseStatusEffect."..recordName..'_instantEffector2'
    TweakDB:CloneRecord(effectorName1, "Items.AdvancedHealOnKillRare_inline1")
    TweakDB:CloneRecord(effectorName2, "Items.AdvancedHealOnKillRare_inline2")

    TweakDB:SetFlat(effectorName1..'.prereqRecord', prereq)
    TweakDB:SetFlat(effectorName1..'.usePercent', usePercent)
    TweakDB:SetFlat(effectorName2..'.statPoolType', 'BaseStatPools.'..statPoolType)
    TweakDB:SetFlat(effectorName2..'.statPoolValue', value)

    TweakDB:SetFlat(effectorName1..'.statPoolUpdates', { effectorName2 })

    return effectorName1
end

function CreateOverTimeRegenEffector(recordName, statPoolType, prereqRecord, value) 
    local effectorName = "BaseStatusEffect."..recordName..'_regenEffector1'
    local effector2Name = "BaseStatusEffect."..recordName..'_regenEffector2'
    TweakDB:CloneRecord(effectorName, "BaseStatusEffect.BonesMcCoy70V0_inline1")
    TweakDB:CloneRecord(effector2Name, "BaseStatPools.HealthRegeneration")


    TweakDB:SetFlat(effectorName..'.statPoolType', statPoolType)
    TweakDB:SetFlat(effectorName..'.prereqRecord', prereqRecord)
    TweakDB:SetFlat(effectorName..'.poolModifier', effector2Name)
    TweakDB:SetFlat(effector2Name..'.valuePerSec', value)
    TweakDB:SetFlat(effector2Name..'.rangeBegin', 0)
    TweakDB:SetFlat(effector2Name..'.rangeEnd', 9999)

    return effectorName
end

function ConvertBlackLace() 
    local BlackLaceDescriptions = {
        'SynthDose.Toxicity_High_StatData',
        'SynthDose.BlackLace_Description_1',
        'SynthDose.BlackLace_Description_2',
        'SynthDose.Item_Duration_60',
        nonHealingDrugDescriptionStatPath
    }

    local BlackLaceEffects = {
        CreateSingleStatUpdate("BlackLaceV1_3", "Additive", "BaseStats.Armor", 150)        
    }

   

    local ShieldPrereqPath = 'SynthDose.BlackLaceExtraArmor'

    TweakDB:CloneRecord(ShieldPrereqPath, 'NewPerks.DoesPlayerHaveOvershield')
    TweakDB:CloneRecord(ShieldPrereqPath..'_inline0', 'NewPerks.DoesPlayerHaveOvershield_inline0')
    TweakDB:SetFlat(ShieldPrereqPath..'_inline0.value', 15)
    TweakDB:SetFlat(ShieldPrereqPath..'.valueToCheck', {ShieldPrereqPath..'_inline0'})
    TweakDB:SetFlat(ShieldPrereqPath..'.listenConstantly', true)

    local BlackLaceEffectorEffects = {
        createPrereqEffector("BlackLaceV1_5", 
            ShieldPrereqPath,
                         
            CreateBaseStatusEffect("BlackLaceV1_6", {
                    CreateSingleStatUpdate("BlackLaceV1_7", "Additive", "BaseStats.Armor", 400),
                    CreateSingleStatUpdate("BlackLaceV1_8", "Additive", "BaseStats.CritChance", 5), 
                    CreateSingleStatUpdate("BlackLaceV1_9", "Additive", "BaseStats.CritDamage", 15), 
                    CreateSingleStatUpdate("BlackLaceV1_10", "Additive", "BaseStats.StaminaRegenRateMult", 0.25)
                }, 
                {},
                0, 
                nil,
                true
            ),
            true
        ),
    }
    
    createInhaler("BlackLaceV1", "inhaler_13_skiff", "drug_1", "synthDose_blackLace_flavor", BlackLaceDescriptions, "synthDose_blackLace_name", "Quality.Epic", 60, {}, BlackLaceEffects,BlackLaceEffectorEffects, {'IllegalItem'},5, 'SynthDose.BlackLace_Icon', {})
    TweakDB:SetFlat("Items.BlackLaceV1.itemType",'ItemType.Con_Inhaler')
    TweakDB:SetFlat("Items.BlackLaceV1.statModifiers", { 'Items.Inhaler_inline0' })
    TweakDB:SetFlat("Items.BlackLaceV1.entityName", 'base_inhaler_item')
    TweakDB:SetFlat("Items.BlackLaceV1.consumableType", 'ConsumableType.Medical')
end

function createVendorItem(recordName, scPreq, levelPreq, item)
    local vendorItemName = 'SynthDose.VendorItem_'..recordName
	TweakDB:CreateRecord(vendorItemName, "gamedataVendorItem_Record")
	TweakDB:SetFlatNoUpdate(vendorItemName..".availabilityPrereq", scPreq)

	TweakDB:SetFlatNoUpdate(vendorItemName..".item", item)
	TweakDB:SetFlatNoUpdate(vendorItemName..".generationPrereqs", levelPreq)
	TweakDB:SetFlatNoUpdate(vendorItemName..".quantity", {"Vendors.IsPresent"})
	TweakDB:Update(vendorItemName)
    return vendorItemName
end

function AddToVendor(vendor, items)
    local vendorItems = TweakDB:GetFlat(vendor..'.itemStock')

    for _, v in ipairs(items) do
        table.insert(vendorItems, v)
    end

    TweakDB:SetFlat(vendor..'.itemStock', vendorItems)
end

function createSCPrereq(value)
    local path = "SynthDose.SCPreq_"..value
	TweakDB:CloneRecord("SynthDose.SCPreq_"..value, "Vendors.GlenCredAvailability")
	TweakDB:SetFlat("SCReq"..value..".valueToCheck", value)
    return path
end

function mergeTables(table1, table2)
    local mergedTable = {}

    -- Merge elements from table1
    for _, v in ipairs(table1) do
        table.insert(mergedTable, v)
    end

    -- Merge elements from table2
    for _, v in ipairs(table2) do
        table.insert(mergedTable, v)
    end

    return mergedTable
end

