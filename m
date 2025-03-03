Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55623C8AD;
	Mon,  3 Mar 2025 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042385; cv=none; b=LJsn/429Qjld1u3Q0DXHMP2/nRg8lwQz337DU/wGgsp/AYqdIyOLlIWq+e81PXfAlJAXt/OFC/hk+6SrHlKDlvsc0ohAgs4JNKPSuCo9hqrVnXFCdVTUvyqQJj4mvjeHIA/ce2ypw6recKZREx98tuTF27IdDShQntcZTS6U9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042385; c=relaxed/simple;
	bh=todK3bY9z826RJDzKx4uUYTLuZrnQc6OWFYWpEA2/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa13H+QwhKKFLguKCgsOFtL8gYb2uIauteUDBnOegwtKwEHS06kyXrSLebOCsgRu69bWatE3C2tEQIRKcjimzF0n72omMZ7bF6Rtr4kiSZjqCFtfuVYTsrqTW644OYbnhs8D6Nhvl7EVuPhL9l3I7vnS3Db0ntmZuUxB2bNVbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVqXiT3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVqXiT3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6681C4CEED;
	Mon,  3 Mar 2025 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042385;
	bh=todK3bY9z826RJDzKx4uUYTLuZrnQc6OWFYWpEA2/Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVqXiT3EVw+XiIeDU8E4JN+EfIrWcVa/4YjbSacqIjkEUV18TXz/yn6DYxFEqrGZu
	 akSGTHM86ksKCP+pF7N5LtXj+9i6iz9c6ugvnfckveYFaARp6JYof5W8GvpvTi4ndT
	 3G5NIXa+Zen36jNypnT//cLs4Bx7L0UP4+DtlF1iZRHHJgJg/IOXmxusHs2x9CGYPM
	 eqS9f7YKgyCet9/Ut4cFbkkXKhdZSW1fmvzm4VMSp4Lv/Pf2LfzhEm+7fHzAWl4/uC
	 jbHIaOwFtqN+oei+2xCVUv705ClkOkQrZ4Rl7PLamGrk8TScwzZK92k/1UFQ1AwtDk
	 vsANEczEdpelQ==
From: zanussi@kernel.org
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Tom Zanussi <zanussi@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH RT 3/4] netfilter: nft_counter: Use u64_stats_t for statistic.
Date: Mon,  3 Mar 2025 16:52:57 -0600
Message-ID: <dda7ee82da31c6a0e9ee10c2964c3161e42d1b03.1741042351.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741042351.git.zanussi@kernel.org>
References: <cover.1741042351.git.zanussi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.4.290-rt96-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 4a1d3acd6ea86075e77fcc1188c3fc372833ba73 ]

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
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 net/netfilter/nft_counter.c | 78 +++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index bf829fabf2785..2b3ae0fd25619 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -8,13 +8,18 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/seqlock.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
 
 struct nft_counter {
+	u64_stats_t	bytes;
+	u64_stats_t	packets;
+};
+
+struct nft_counter_tot {
 	s64		bytes;
 	s64		packets;
 };
@@ -23,25 +28,24 @@ struct nft_counter_percpu_priv {
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
 
@@ -64,17 +68,16 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
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
@@ -102,40 +105,41 @@ static void nft_counter_obj_destroy(const struct nft_ctx *ctx,
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
@@ -146,7 +150,7 @@ static int nft_counter_do_dump(struct sk_buff *skb,
 			       struct nft_counter_percpu_priv *priv,
 			       bool reset)
 {
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -235,7 +239,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -243,11 +247,9 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
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
@@ -279,7 +281,7 @@ static int __init nft_counter_module_init(void)
 	int cpu, err;
 
 	for_each_possible_cpu(cpu)
-		seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
+		u64_stats_init(per_cpu_ptr(&nft_counter_sync, cpu));
 
 	err = nft_register_obj(&nft_counter_obj_type);
 	if (err < 0)
-- 
2.43.0

