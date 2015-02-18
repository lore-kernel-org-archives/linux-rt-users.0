From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Subject: [PATCH 2/2] powerpc/kvm: Limit MAX_VCPUS for guests running on RT Linux
Date: Wed, 18 Feb 2015 09:32:35 +0000
Message-ID: <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <scottwood@freescale.com>,
	<mihai.caraman@freescale.com>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
	<bigeasy@linutronix.de>, <agraf@suse.de>, <pbonzini@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Due to the introduction of the raw_spinlock for the KVM openpic, guests with a
high number of VCPUs may induce great latencies on the underlying RT Linux
system (e.g. cyclictest reports latencies of ~15ms for guests with 24 VCPUs).
This can be further aggravated by sending a lot of external interrupts to the
guest.

A malicious app can abuse this scenario, causing a DoS of the host Linux.
Until the KVM openpic code is refactored to use finer lock granularity, impose
a limitation on the number of VCPUs a guest can have when running on a
PREEMPT_RT_FULL system with KVM_MPIC emulation.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Reviewed-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/kvm_host.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 8ef0512..6f6b928 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -36,8 +36,14 @@
 #include <asm/cacheflush.h>
 #include <asm/hvcall.h>
 
+#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_KVM_MPIC)
+/* Limit the number of vcpus due to in-kernel mpic concurrency */
+#define KVM_MAX_VCPUS		4
+#define KVM_MAX_VCORES		4
+#else
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
+#endif
 #define KVM_USER_MEM_SLOTS 32
 #define KVM_MEM_SLOTS_NUM KVM_USER_MEM_SLOTS
 
-- 
2.1.4
