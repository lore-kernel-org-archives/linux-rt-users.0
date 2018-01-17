From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/13] net: use trylock in icmp_sk
Date: Wed, 17 Jan 2018 10:14:16 -0500
Message-ID: <20180117151432.549401282@goodmis.org>
References: <20180117151404.093229667@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753386AbeAQPOe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jan 2018 10:14:34 -0500
Content-Disposition: inline; filename=0012-net-use-trylock-in-icmp_sk.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.91-rt98-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The locking path can be recursive (same as for sk->sk_lock.slock) and
therefore we need a trylock version for the locallock, too.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 net/ipv4/icmp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 76b11e3e2b95..434eef536092 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -218,7 +218,11 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 
 	local_bh_disable();
 
-	local_lock(icmp_sk_lock);
+	if (!local_trylock(icmp_sk_lock)) {
+		local_bh_enable();
+		return NULL;
+	}
+
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
-- 
2.13.2


