From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.2-rc1 and nvidia drivers
Date: Wed, 30 Nov 2011 09:14:25 -0500
Message-ID: <1322662465.17003.117.camel@frodo>
References: <CAOLSsAysHCVAHsSRMTXUpXm_qjK5D5DRagHCS0ZYrxGQ8mDkfw@mail.gmail.com>
	 <4EC384FD.1040106@tum.de> <alpine.LFD.2.02.1111161605580.4902@ionos>
	 <4ED35D9A.7090401@tum.de>
	 <CAONaPpE7Jgz0GhFUB41ZKoa8dUKOqKVFKj6jHfi3EAnPX0SRbQ@mail.gmail.com>
	 <alpine.LFD.2.00.1111291528590.5855@localhost6.localdomain6>
	 <1322620613.17003.110.camel@frodo>
	 <CAONaPpEp=bBJWZ4DzAem0TE+_2q5t+G=99_jdJxVsCwXZ4Mk9g@mail.gmail.com>
	 <1322651681.2921.247.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, Thomas Schauss <schauss@tum.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:34474 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab1K3OO1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 09:14:27 -0500
In-Reply-To: <1322651681.2921.247.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-11-30 at 12:14 +0100, Peter Zijlstra wrote:
> On Wed, 2011-11-30 at 09:23 +0100, John Kacur wrote:
> > > This was complained about in mainline too:
> > >
> > >  https://lkml.org/lkml/2011/10/3/364
> > >
> > > There was a fix to a similar bug that Peter pointed out, but this bug
> > > doesn't look like it was fixed.
> > >
> > > Peter? 
> 
> Re to the subject, every borkage of the nvidiot binary driver is a
> personal victory, I try as hard as possible to increase their pain.
> 

Well, this bug is not caused by nvidiot, but it prevents us from seeing
if there's locking issues in nvidiot. Because Thomas tripped over this
bug, lockdep shutdown before it could analyze anything further down,
including nvidiot too. But then again, maybe the bug Thomas is seeing is
in mainline, and nvidiot is helping us find bugs :)


> As to the actual subject of the email, see:
> 
> http://article.gmane.org/gmane.linux.kernel.mm/70863/match=

Thomas (Schauss),

Could you try this patch?

I took Peter's patch and ported it to 3.0-rt. Hopefully, I didn't screw
it up.

-- Steve

diff --git a/mm/slab.c b/mm/slab.c
index 096bf0a..966a8c4 100644
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
@@ -1752,7 +1753,7 @@ void __init kmem_cache_init_late(void)
 	mutex_unlock(&cache_chain_mutex);
 
 	/* Done! */
-	g_cpucache_up = FULL;
+	g_cpucache_up = LATE;
 
 	/* Annotate slab for lockdep -- annotate the malloc caches */
 	init_lock_keys();


