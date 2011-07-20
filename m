From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Fix build failure for modular ext3/4 builds
Date: Wed, 20 Jul 2011 21:10:43 +0200
Message-ID: <1311189043-23175-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.LFD.2.02.1107200153070.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1107200153070.2702@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

=46ollowup for fs-jbd-replace-bh_state-lock.patch

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/buffer_head.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7283b77..d839fba 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -74,7 +74,8 @@ struct buffer_head {
 	atomic_t b_count;		/* users using this buffer_head */
 #ifdef CONFIG_PREEMPT_RT_BASE
 	spinlock_t b_uptodate_lock;
-#if defined(CONFIG_JBD) || defined(CONFIG_JBD2)
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || \
+	defined(CONFIG_JBD2) || defined(CONFIG_JBD2_MODULE)
 	spinlock_t b_state_lock;
 	spinlock_t b_journal_head_lock;
 #endif
--=20
1.7.5.4
