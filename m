From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 14/15] net: use trylock in icmp_sk
Date: Fri, 01 Dec 2017 19:02:03 -0500
Message-ID: <20171202000428.964845943@goodmis.org>
References: <20171202000149.842718953@goodmis.org>
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
        rt-stable@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0014-net-use-trylock-in-icmp_sk.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The locking path can be recursive (same as for sk->sk_lock.slock) and
therefore we need a trylock version for the locallock, too.

Cc: rt-stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 net/ipv4/icmp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e6864ff11352..330224ef4174 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -219,7 +219,11 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 
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
