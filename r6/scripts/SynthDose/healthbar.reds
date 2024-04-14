@replaceMethod(healthbarWidgetGameController)
public final func EvaluateOvershieldBarVisibility() -> Void {
    inkWidgetRef.SetVisible(this.m_overshieldBarRef,this.m_currentOvershieldValuePercent > 0.00);
}