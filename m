From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/5] tcp: force a dst refcount when prequeue packet
Date: Fri, 03 May 2013 17:37:04 -0400
Message-ID: <20130503213817.778015700@goodmis.org>
References: <20130503213703.521223574@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Mike Galbraith <bitbucket@online.de>,
	Eric Dumazet <edumazet@google.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-tcp-force-a-dst-refcount-when-prequeue-packet.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Before escaping RCU protected section and adding packet into
prequeue, make sure the dst is refcounted.

Cc: stable-rt@vger.kernel.org
Reported-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/net/tcp.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1f000ff..9297897 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1015,6 +1015,7 @@ static inline bool tcp_prequeue(struct sock *sk, struct sk_buff *skb)
 	if (sysctl_tcp_low_latency || !tp->ucopy.task)
 		return false;
 
+	skb_dst_force(skb);
 	__skb_queue_tail(&tp->ucopy.prequeue, skb);
 	tp->ucopy.memory += skb->truesize;
 	if (tp->ucopy.memory > sk->sk_rcvbuf) {
-- 
1.7.10.4
