From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/6] powerpc/kvm: Disable in-kernel MPIC emulation for PREEMPT_RT_FULL
Date: Fri, 07 Aug 2015 14:07:14 -0400
Message-ID: <20150807180724.190416285@goodmis.org>
References: <20150807180709.744130098@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>, Scott Wood <scottwood@freescale.com>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46400 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946124AbbHGSH2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2015 14:07:28 -0400
Content-Disposition: inline; filename=0005-powerpc-kvm-Disable-in-kernel-MPIC-emulation-for-PRE.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.10.84-rt92-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Bogdan Purcareata <bogdan.purcareata@freescale.com>

While converting the openpic emulation code to use a raw_spinlock_t enables
guests to run on RT, there's still a performance issue. For interrupts sent in
directed delivery mode with a multiple CPU mask, the emulated openpic will loop
through all of the VCPUs, and for each VCPUs, it call IRQ_check, which will loop
through all the pending interrupts for that VCPU. This is done while holding the
raw_lock, meaning that in all this time the interrupts and preemption are
disabled on the host Linux. A malicious user app can max both these number and
cause a DoS.

This temporary fix is sent for two reasons. First is so that users who want to
use the in-kernel MPIC emulation are aware of the potential latencies, thus
making sure that the hardware MPIC and their usage scenario does not involve
interrupts sent in directed delivery mode, and the number of possible pending
interrupts is kept small. Secondly, this should incentivize the development of a
proper openpic emulation that would be better suited for RT.

Cc: stable-rt@vger.kernel.org
Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index eb643f862579..2c3c4dff49b5 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -154,6 +154,7 @@ config KVM_E500MC
 config KVM_MPIC
 	bool "KVM in-kernel MPIC emulation"
 	depends on KVM && E500
+	depends on !PREEMPT_RT_FULL
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_MSI
-- 
2.4.6


