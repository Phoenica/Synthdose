@addField(PlayerPuppet)
let overdoseSFEffectInProgress: Bool;

@addMethod(PlayerPuppet)
private final func ToxicityEffectProcessor(evt: ref<StatusEffectEvent>, applied: Bool) -> Void {
    let tocicityID: TweakDBID = t"BaseStatusEffect.Toxicity";
    if evt.staticData.GetID() != tocicityID {
        return;
    }

    if Cast<Int32>(StatusEffectHelper.GetStatusEffectByID(this, tocicityID).GetStackCount()) >= 10 {
        if !this.overdoseSFEffectInProgress {
            GameObjectEffectHelper.StartEffectEvent(this, n"status_drugged_heavy");
            this.overdoseSFEffectInProgress = true;
        }
    } else {
        if this.overdoseSFEffectInProgress {
            GameObjectEffectHelper.BreakEffectLoopEvent(this, n"status_drugged_heavy");
            this.overdoseSFEffectInProgress = false;
        }
    }
}

@wrapMethod(PlayerPuppet)
protected cb func OnStatusEffectRemoved(evt: ref<RemoveStatusEffect>) -> Bool {
    this.ToxicityEffectProcessor(evt, false);
    return wrappedMethod(evt);
}

@wrapMethod(PlayerPuppet)
protected cb func OnStatusEffectApplied(evt: ref<ApplyStatusEffectEvent>) -> Bool {
    this.ToxicityEffectProcessor(evt, true);
    return wrappedMethod(evt);
}

