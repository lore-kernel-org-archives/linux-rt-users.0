From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] v3.2-rc1-52e4c2a05-rt1 fix for compile break
Date: Mon, 14 Nov 2011 02:44:42 +0100
Message-ID: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43489 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab1KNBpA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Nov 2011 20:45:00 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

kernel/rcutorture.c:492: error: =E2=80=98synchronize_rcu_bh=E2=80=99 un=
declared here (not in a function)

In CONFIG_PREEMPT_RT_FULL
doesn't cover function pointer assignment unless we remove the brackets=
=2E

Compile-tested.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 include/linux/rcutree.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 800b840..6e503a3 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -60,7 +60,7 @@ static inline void exit_rcu(void)
 #ifndef CONFIG_PREEMPT_RT_FULL
 extern void synchronize_rcu_bh(void);
 #else
-# define synchronize_rcu_bh()	synchronize_rcu()
+# define synchronize_rcu_bh	synchronize_rcu
 #endif
 extern void synchronize_sched_expedited(void);
 extern void synchronize_rcu_expedited(void);
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
