@wrapMethod(Vendor)
public final func PlayerCanBuy(itemStack: script_ref<SItemStack>) -> Bool {
    let idToCheck: ItemID;
    let tags: array<CName>;
    let tags2: array<CName>;
    let player: ref<GameObject>;
    let isInInventory: Bool;
    let i: Int32;
    let playerItems: array<wref<gameItemData>>;
    let itemData: wref<gameItemData>;

    idToCheck = Deref(itemStack).itemID;
    tags = TweakDBInterface.GetItemRecord(ItemID.GetTDBID(idToCheck)).Tags();

    if ArrayContains(tags, n"SynthDose.Generic") {
        itemData = GameInstance.GetTransactionSystem(this.m_gameInstance).GetItemData(this.m_vendorObject, idToCheck);
        player = GetPlayer(this.m_gameInstance);
        GameInstance.GetTransactionSystem(this.m_gameInstance).GetItemList(player, playerItems);
        i = 0;

        while i < ArraySize(playerItems) {
          tags2 = TweakDBInterface.GetItemRecord(ItemID.GetTDBID(playerItems[i].GetID())).Tags();
          if !ArrayContains(tags2, n"SynthDose.Generic") {
          } else {
            if playerItems[i].GetID() == idToCheck {
              isInInventory = true;
              break;
            };
            if ItemID.GetTDBID(playerItems[i].GetID()) == ItemID.GetTDBID(itemData.GetID()) {
              isInInventory = true;
              break;
            };
          };
          i += 1;
        };
        if isInInventory {
            return false;
        }
    }

    return wrappedMethod(itemStack);
}