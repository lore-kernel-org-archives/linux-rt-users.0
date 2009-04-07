From: Jan Blunck <jblunck@suse.de>
Subject: [patch 3/3] kvm: wake up waitqueue before calling get_cpu()
Date: Wed, 08 Apr 2009 01:58:56 +0200
Message-ID: <20090407235902.542493610@suse.de>
References: <20090407235853.309888494@suse.de>
Cc: kvm@vger.kernel.org
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=patches.rt/kvm-wake-up-waitqueue-before-calling-get_cpu.patch
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This moves the get_cpu() call down to be called after we wake up the
waiters. Therefore the waitqueue locks can savely be rt mutex.

Signed-off-by: Jan Blunck <jblunck@suse.de>
Signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
---
 arch/x86/kvm/x86.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/arch/x86/kvm/x86.c
===================================================================
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4229,7 +4229,7 @@ static void vcpu_kick_intr(void *info)
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 {
 	int ipi_pcpu = vcpu->cpu;
-	int cpu = get_cpu();
+	int cpu;
 
 	if (waitqueue_active(&vcpu->wq)) {
 		wake_up_interruptible(&vcpu->wq);
@@ -4239,6 +4239,7 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu
 	 * We may be called synchronously with irqs disabled in guest mode,
 	 * So need not to call smp_call_function_single() in that case.
 	 */
+	cpu = get_cpu();
 	if (vcpu->guest_mode && vcpu->cpu != cpu)
 		smp_call_function_single(ipi_pcpu, vcpu_kick_intr, vcpu, 0);
 	put_cpu();


