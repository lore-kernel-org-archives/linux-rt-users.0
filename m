From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Wed, 22 Jul 2015 09:26:35 -0400
Message-ID: <20150722092635.0766400e@gandalf.local.home>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
	<alpine.DEB.2.11.1507091605410.5134@nanos>
	<c7ec9b06a341497687b03c367196f534@FE-MBX1012.de.bosch.com>
	<20150710132318.GA27402@linutronix.de>
	<e1b9f04b95504df78cab1eb4e6946238@FE-MBX1012.de.bosch.com>
	<55A36EF0.7020404@linutronix.de>
	<15fcff88e0b4417aba7fd635a98b1ad0@FE-MBX1012.de.bosch.com>
	<55A37DC9.6050604@linutronix.de>
	<55A607CC.3030808@etas.com>
	<12C1B74BDFD05D40B2356A9B12DFA3396C276FDBA2@KEBMXSPMB01.keba.co.at>
	<20150720145648.GA9559@linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA3396C27797F4A@KEBMXSPMB01.keba.co.at>
	<b4572ce5932444febd055f1403c58d9e@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: eg Engleder Gerhard <eg@keba.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:42843 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756684AbbGVN0j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2015 09:26:39 -0400
In-Reply-To: <b4572ce5932444febd055f1403c58d9e@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 22 Jul 2015 06:26:42 +0000
"Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com> wrote:

> Hi all,
> > > >similar situation here with 3.18.11-rt7. The problem occurred once so far.
> > >
> > > Is this _with_ or _without_ the patch in question?
> > 
> > With the patch. slub_delay_ctor_on_rt.patch is applied. It is 3.18.11-rt7 with
> > additional drivers
> > for our hardware.
> 
> Since I have removed the slub_delay_ctor_on_rt.patch from 3.18.13-rt10 I have never seen this issue anymore on our systems.

>From my files, that is this patch:

----
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: slub: delay ctor until the object is requested

It seems that allocation of plenty objects causes latency on ARM since that code can not be preempted

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/slub.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1376,8 +1376,10 @@ static void setup_object(struct kmem_cac
                                void *object)
 {
        setup_object_debug(s, page, object);
+#ifndef CONFIG_PREEMPT_RT_FULL
        if (unlikely(s->ctor))
                s->ctor(object);
+#endif
 }
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
@@ -2499,6 +2501,10 @@ static __always_inline void *slab_alloc_
 
        if (unlikely(gfpflags & __GFP_ZERO) && object)
                memset(object, 0, s->object_size);
+#ifdef CONFIG_PREEMPT_RT_FULL
+       if (unlikely(s->ctor) && object)
+               s->ctor(object);
+#endif
 
        slab_post_alloc_hook(s, gfpflags, object);
----


> 
> Now I had a look at the latest 3.18.17-rt14: Here I do not see that patch anymore.

It's still there. Note, that when I pull -rt into stable, I do a
 git quiltimport, which renames the patch set. It's now called:

 0089-slub-delay-ctor-until-the-object-is-requested.patch

-- Steve

> Has it been removed from the patchset? 
> Is there still a need to ignore one of the patches?
> Neither in the announcement to 3.18.16-rt13 nor to 3.18.17-rt14 I read any comment on that.
> 
> Regards
> 
> Mathias

