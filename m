From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 6/6] [ARM] Use atomic_spin_lock/atomic_spin_unlock for irqdesc lock
Date: Fri,  7 Aug 2009 22:55:16 +0200
Message-ID: <1249678516-8639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1249677761-19470-6-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755269AbZHGUzZ@vger.kernel.org>
In-Reply-To: <1249677761-19470-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This was missed in commit

	fd2bde5 (genirq: Convert irqdesc lock to atomic_spinlock)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/mach/irq.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mac=
h/irq.h
index acac530..3981cf2 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -26,9 +26,9 @@ extern int show_fiq_list(struct seq_file *, void *);
  */
 #define do_bad_IRQ(irq,desc)				\
 do {							\
-	spin_lock(&desc->lock);				\
+	atomic_spin_lock(&desc->lock);			\
 	handle_bad_irq(irq, desc);			\
-	spin_unlock(&desc->lock);			\
+	atomic_spin_unlock(&desc->lock);		\
 } while(0)
=20
 #endif
--=20
1.6.3.3
