From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH -rt 2/2] KVM: arm/arm64: downgrade preempt_disable()d region to migrate_disable()
Date: Thu, 11 Feb 2016 11:54:01 -0600
Message-ID: <685c494e87e1b537881117a5098bc4b3447b3add.1455213062.git.joshc@ni.com>
References: <d08185b69f64d90e4dc458eb5051b3186c7d25a8.1455213062.git.joshc@ni.com>
Cc: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:40145 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751235AbcBKRyM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 12:54:12 -0500
In-Reply-To: <d08185b69f64d90e4dc458eb5051b3186c7d25a8.1455213062.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

kvm_arch_vcpu_ioctl_run() disables the use of preemption when updating
the vgic and timer states to prevent the calling task from migrating to
another CPU.  It does so to prevent the task from writing to the
incorrect per-CPU GIC distributor registers.

On -rt kernels, it's possible to maintain the same guarantee with the
use of migrate_{disable,enable}(), with the added benefit that the
migrate-disabled region is preemptible.  Update
kvm_arch_vcpu_ioctl_run() to do so.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Reported-by: Manish Jaggi <Manish.Jaggi@caviumnetworks.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 arch/arm/kvm/arm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4f5c42a..2ce9cc2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -568,7 +568,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * involves poking the GIC, which must be done in a
 		 * non-preemptible context.
 		 */
-		preempt_disable();
+		migrate_disable();
 		kvm_timer_flush_hwstate(vcpu);
 		kvm_vgic_flush_hwstate(vcpu);
 
@@ -587,7 +587,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			local_irq_enable();
 			kvm_timer_sync_hwstate(vcpu);
 			kvm_vgic_sync_hwstate(vcpu);
-			preempt_enable();
+			migrate_enable();
 			continue;
 		}
 
@@ -641,7 +641,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		kvm_vgic_sync_hwstate(vcpu);
 
-		preempt_enable();
+		migrate_enable();
 
 		ret = handle_exit(vcpu, run, ret);
 	}
-- 
2.7.0

