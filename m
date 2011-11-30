From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 09:31:42 -0500
Message-ID: <1322663502.17003.121.camel@frodo>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	 <1322620613.17003.110.camel@frodo>
	 <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	 <1322651681.2921.247.camel@twins> <1322662465.17003.117.camel@frodo>
	 <1322662578.2921.275.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:62741 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab1K3Obo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 09:31:44 -0500
In-Reply-To: <1322662578.2921.275.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas (Schauss),

Can you try this patch. It has both patches that Peter pointed to
applied.

Thanks,

-- Steve

diff --git a/mm/slab.c b/mm/slab.c
index 096bf0a..86a8dec 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -764,6 +764,7 @@ static enum {
 	PARTIAL_AC,
 	PARTIAL_L3,
 	EARLY,
+	LATE,
 	FULL
 } g_cpucache_up;
 
@@ -795,7 +796,7 @@ static void init_node_lock_keys(int q)
 {
 	struct cache_sizes *s = malloc_sizes;
 
-	if (g_cpucache_up != FULL)
+	if (g_cpucache_up < LATE)
 		return;
 
 	for (s = malloc_sizes; s->cs_size != ULONG_MAX; s++) {
@@ -1744,6 +1745,11 @@ void __init kmem_cache_init_late(void)
 {
 	struct kmem_cache *cachep;
 
+	g_cpucache_up = LATE;
+
+	/* Annotate slab for lockdep -- annotate the malloc caches */
+	init_lock_keys();
+
 	/* 6) resize the head arrays to their final sizes */
 	mutex_lock(&cache_chain_mutex);
 	list_for_each_entry(cachep, &cache_chain, next)
@@ -1754,9 +1760,6 @@ void __init kmem_cache_init_late(void)
 	/* Done! */
 	g_cpucache_up = FULL;
 
-	/* Annotate slab for lockdep -- annotate the malloc caches */
-	init_lock_keys();
