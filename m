From: Jan Blunck <jblunck@suse.de>
Subject: [patch 2/3] kvm: convert spin-locks to raw_spinlock_t
Date: Wed, 08 Apr 2009 01:58:55 +0200
Message-ID: <20090407235902.400480759@suse.de>
References: <20090407235853.309888494@suse.de>
Cc: kvm@vger.kernel.org
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46230 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925AbZDHAB0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 20:01:26 -0400
Content-Disposition: inline; filename=patches.rt/kvm-pic.diff
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch converts some KVM spin-locks to be of type raw_spinlock_t.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 arch/x86/kvm/i8254.h |    2 +-
 arch/x86/kvm/irq.h   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: b/arch/x86/kvm/i8254.h
===================================================================
--- a/arch/x86/kvm/i8254.h
+++ b/arch/x86/kvm/i8254.h
@@ -33,7 +33,7 @@ struct kvm_kpit_state {
 	u32    speaker_data_on;
 	struct mutex lock;
 	struct kvm_pit *pit;
-	spinlock_t inject_lock;
+	raw_spinlock_t inject_lock;
 	unsigned long irq_ack;
 	struct kvm_irq_ack_notifier irq_ack_notifier;
 };
Index: b/arch/x86/kvm/irq.h
===================================================================
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -60,7 +60,7 @@ struct kvm_kpic_state {
 };
 
 struct kvm_pic {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	bool wakeup_needed;
 	unsigned pending_acks;
 	struct kvm *kvm;


