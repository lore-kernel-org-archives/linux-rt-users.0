Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAE1DE8A0
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Mar 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474493; cv=none; b=gg0iD4+vw4Nq6KHjW7bsKBiyNJxQ600wKKoryybUAM7mbI3voCju5CgwLTwUowskj7crRV7J4X0183ttmtMYhPd+8OfH9pWuwgwzYO3ZiNoNSTXftuCeQNBsTsCiLGrLmp0/nhmrda4EVpVUyW8KGWoughmQu0C8nx6xyGOYqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474493; c=relaxed/simple;
	bh=uJNgNdZDQ/2PC9hcIrOpRPEGx0wzupEKlnOR05eG9pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPY24Zs+0sH51TyGU7a4u5ds2gj9/U7vN3DjLWXLO8xnnigCZrkDNbaDnb9eJ0sSP6MTsIAd2U9YtzHVY1Qrq4oGBBlaBnzRHW8HDCNUat5+6UNmnCAVPvkCrEtLj54BkqEgNh0qfxqnWN63610eX1vgrIt9ti9HaAoF8k5O3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=TpnsNzUk; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="TpnsNzUk"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250320124121961bb7f062f0a2577f
        for <linux-rt-users@vger.kernel.org>;
        Thu, 20 Mar 2025 13:41:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=c0r9K1Oai3gyP+GjxoUNl2fOIbRrTnrWaZYsOLsZDrA=;
 b=TpnsNzUkkIAoVd4x7s9CvjzuD+tAhg7LpBA6ux7k6lj+suGNGWIl12pyXTS2uV057EwtB3
 XakJO5HyqgzA9UhHGivAMY8rgVLRECLGUN9ZXVGCK8RJ1oTbRqahVh1wOO/i2RX+Xpt5l7wQ
 ZKmaMWFgzrQ7PTTB6iTtV9dsn3myv7FCq/x5E05tmxTtUwskJaMnN2I6/2hLFvKDh7lz3gqL
 lBSvRwa/sLgTaS+d7hcu1Ii5PucocJPxzYebjo0oJ3V5YlBjeu29BYLsQLk2NTuxuQfTYeFJ
 1oWoMHqZIpKXRqp4fG8vAIjxjj30lAj56X5DPSDS1ntKUEFgGl5fbKgQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	williams@redhat.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	jan.kiszka@siemens.com,
	netfilter-devel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 6.1.y 6.6.y 1/1] netfilter: nft_counter: Use u64_stats_t for statistic.
Date: Thu, 20 Mar 2025 13:41:08 +0100
Message-ID: <20250320124108.338412-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 4a1d3acd6ea86075e77fcc1188c3fc372833ba73 upstream.

The nft_counter uses two s64 counters for statistics. Those two are
protected by a seqcount to ensure that the 64bit variable is always
properly seen during updates even on 32bit architectures where the store
is performed by two writes. A side effect is that the two counter (bytes
and packet) are written and read together in the same window.

This can be replaced with u64_stats_t. write_seqcount_begin()/ end() is
replaced with u64_stats_update_begin()/ end() and behaves the same way
as with seqcount_t on 32bit architectures. Additionally there is a
preempt_disable on PREEMPT_RT to ensure that a reader does not preempt a
writer.
On 64bit architectures the macros are removed and the reads happen
without any retries. This also means that the reader can observe one
counter (bytes) from before the update and the other counter (packets)
but that is okay since there is no requirement to have both counter from
the same update window.

Convert the statistic to u64_stats_t. There is one optimisation:
nft_counter_do_init() and nft_counter_clone() allocate a new per-CPU
counter and assign a value to it. During this assignment preemption is
disabled which is not needed because the counter is not yet exposed to
the system so there can not be another writer or reader. Therefore
disabling preemption is omitted and raw_cpu_ptr() is used to obtain a
pointer to a counter for the assignment.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
I propose the backport, as this is a performance improvement. Note,
that this is a bugfix on RT kernels.

 net/netfilter/nft_counter.c | 90 +++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 781d3a26f5df..8d19bd001277 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/seqlock.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
@@ -17,6 +17,11 @@
 #include <net/netfilter/nf_tables_offload.h>
 
 struct nft_counter {
+	u64_stats_t	bytes;
+	u64_stats_t	packets;
+};
+
+struct nft_counter_tot {
 	s64		bytes;
 	s64		packets;
 };
@@ -25,25 +30,24 @@ struct nft_counter_percpu_priv {
 	struct nft_counter __percpu *counter;
 };
 
-static DEFINE_PER_CPU(seqcount_t, nft_counter_seq);
+static DEFINE_PER_CPU(struct u64_stats_sync, nft_counter_sync);
 
 static inline void nft_counter_do_eval(struct nft_counter_percpu_priv *priv,
 				       struct nft_regs *regs,
 				       const struct nft_pktinfo *pkt)
 {
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
-
-	write_seqcount_begin(myseq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
-	this_cpu->bytes += pkt->skb->len;
-	this_cpu->packets++;
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->bytes, pkt->skb->len);
+	u64_stats_inc(&this_cpu->packets);
+	u64_stats_update_end(nft_sync);
 
-	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
@@ -66,17 +70,16 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
-	preempt_disable();
-	this_cpu = this_cpu_ptr(cpu_stats);
+	this_cpu = raw_cpu_ptr(cpu_stats);
 	if (tb[NFTA_COUNTER_PACKETS]) {
-	        this_cpu->packets =
-			be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_PACKETS]));
+		u64_stats_set(&this_cpu->packets,
+			      be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_PACKETS])));
 	}
 	if (tb[NFTA_COUNTER_BYTES]) {
-		this_cpu->bytes =
-			be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_BYTES]));
+		u64_stats_set(&this_cpu->bytes,
+			      be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_BYTES])));
 	}
-	preempt_enable();
+
 	priv->counter = cpu_stats;
 	return 0;
 }
@@ -104,40 +107,41 @@ static void nft_counter_obj_destroy(const struct nft_ctx *ctx,
 }
 
 static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
-			      struct nft_counter *total)
+			      struct nft_counter_tot *total)
 {
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
+
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->packets, -total->packets);
+	u64_stats_add(&this_cpu->bytes, -total->bytes);
+	u64_stats_update_end(nft_sync);
 
-	write_seqcount_begin(myseq);
-	this_cpu->packets -= total->packets;
-	this_cpu->bytes -= total->bytes;
-	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
 static void nft_counter_fetch(struct nft_counter_percpu_priv *priv,
-			      struct nft_counter *total)
+			      struct nft_counter_tot *total)
 {
 	struct nft_counter *this_cpu;
-	const seqcount_t *myseq;
 	u64 bytes, packets;
 	unsigned int seq;
 	int cpu;
 
 	memset(total, 0, sizeof(*total));
 	for_each_possible_cpu(cpu) {
-		myseq = per_cpu_ptr(&nft_counter_seq, cpu);
+		struct u64_stats_sync *nft_sync = per_cpu_ptr(&nft_counter_sync, cpu);
+
 		this_cpu = per_cpu_ptr(priv->counter, cpu);
 		do {
-			seq	= read_seqcount_begin(myseq);
-			bytes	= this_cpu->bytes;
-			packets	= this_cpu->packets;
-		} while (read_seqcount_retry(myseq, seq));
+			seq	= u64_stats_fetch_begin(nft_sync);
+			bytes	= u64_stats_read(&this_cpu->bytes);
+			packets	= u64_stats_read(&this_cpu->packets);
+		} while (u64_stats_fetch_retry(nft_sync, seq));
 
 		total->bytes	+= bytes;
 		total->packets	+= packets;
@@ -148,7 +152,7 @@ static int nft_counter_do_dump(struct sk_buff *skb,
 			       struct nft_counter_percpu_priv *priv,
 			       bool reset)
 {
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -236,7 +240,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, g
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -244,11 +248,9 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, g
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
-	preempt_disable();
-	this_cpu = this_cpu_ptr(cpu_stats);
-	this_cpu->packets = total.packets;
-	this_cpu->bytes = total.bytes;
-	preempt_enable();
+	this_cpu = raw_cpu_ptr(cpu_stats);
+	u64_stats_set(&this_cpu->packets, total.packets);
+	u64_stats_set(&this_cpu->bytes, total.bytes);
 
 	priv_clone->counter = cpu_stats;
 	return 0;
@@ -266,17 +268,17 @@ static void nft_counter_offload_stats(struct nft_expr *expr,
 				      const struct flow_stats *stats)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
-	write_seqcount_begin(myseq);
-	this_cpu->packets += stats->pkts;
-	this_cpu->bytes += stats->bytes;
-	write_seqcount_end(myseq);
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->packets, stats->pkts);
+	u64_stats_add(&this_cpu->bytes, stats->bytes);
+	u64_stats_update_end(nft_sync);
 	local_bh_enable();
 }
 
@@ -285,7 +287,7 @@ void nft_counter_init_seqcount(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
+		u64_stats_init(per_cpu_ptr(&nft_counter_sync, cpu));
 }
 
 struct nft_expr_type nft_counter_type;
-- 
2.49.0

