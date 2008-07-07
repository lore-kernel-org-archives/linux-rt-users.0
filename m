From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [RFC][PATCH] fix SCHED_FIFO spec violation (backport)
Date: Mon, 07 Jul 2008 08:24:31 -0700
Message-ID: <1215444271.6369.5.camel@Aeon>
References: <1215124898.11333.20.camel@Aeon>
	 <520f0cf10807040608w7e8cea01r39e2489269bc9f73@mail.gmail.com>
	 <1215271090.18491.20.camel@Aeon>
	 <520f0cf10807070400l67c14367hff52f7b16c7ee757@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Clark Williams <williams@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53438 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYGGPY2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Jul 2008 11:24:28 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67FOS6I013737
	for <linux-rt-users@vger.kernel.org>; Mon, 7 Jul 2008 11:24:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m67FORv0174734
	for <linux-rt-users@vger.kernel.org>; Mon, 7 Jul 2008 11:24:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m67FOQcV021163
	for <linux-rt-users@vger.kernel.org>; Mon, 7 Jul 2008 11:24:27 -0400
In-Reply-To: <520f0cf10807070400l67c14367hff52f7b16c7ee757@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-07-07 at 13:00 +0200, John Kacur wrote:
> On Sat, Jul 5, 2008 at 5:18 PM, Darren Hart <dvhltc@us.ibm.com> wrote:
> > On Fri, 2008-07-04 at 15:08 +0200, John Kacur wrote:
> >> Since we're always being admonished to do code-review, and I needed to
> >> waste some time, here are a few comments, to what looks largely like a
> >> nice patch to me.
> >
> > Hi John, thanks for the review.  Note that this is a backport of Peter'z
> > git patch, so I'll try to address some of your rationale questions
> > below, but the short answer is "I tried to match Peter's implementation
> > as closely as possible."  Regarding the patch applying, it worked for
> > me... see below.
> >
> >>
> >> On Fri, Jul 4, 2008 at 12:41 AM, Darren Hart <dvhltc@us.ibm.com> wrote:
> >> > Enqueue deprioritized RT tasks to head of prio array
> >> >
> >> > This patch backports Peter Z's enqueue to head of prio array on
> >> > de-prioritization to 2.6.24.7-rt14 which doesn't have the
> >> > enqueue_rt_entity and associated changes.
> >> >
> >> > I've run several long running real-time java benchmarks and it's
> >> > holding so far.  Steven, please consider this patch for inclusion
> >> > in the next 2.6.24.7-rtX release.
> >> >
> >> > Peter, I didn't include your Signed-off-by as only about half your
> >> > original patch applied to 2.6.24.7-r14.  If you're happy with this
> >> > version, would you also sign off?
> >> >
> >> > Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> >> >
> >> >
> >> > ---
> >> > Index: linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
> >> > ===================================================================
> >> > --- linux-2.6.24.7-ibmrt2.6-view.orig/include/linux/sched.h
> >> > +++ linux-2.6.24.7-ibmrt2.6-view/include/linux/sched.h
> >> > @@ -897,11 +897,16 @@ struct uts_namespace;
> >> >  struct rq;
> >> >  struct sched_domain;
> >> >
> >> > +#define ENQUEUE_WAKEUP 0x01
> >> > +#define ENQUEUE_HEAD   0x02
> >> > +
> >> > +#define DEQUEUE_SLEEP  0x01
> >> > +
> >>
> >> Question: is ENQUEUE_WAKEUP equal to DEQUEUE_SLEEP by design or
> >> coincidence?
> >
> > Coincidence.  The ENQUEUE_* flags are only to be used with the
> > enqueue_task* methods, while the DEQUEUE_* flags are for deqeue_task*.
> > Note that the conversion of sleep to the DEQUEUE_SLEEP flag isn't really
> > necessary as there is only the one flag, but it makes the calls
> > parallel, which I suspect was Peter's intention (but I speculate here).
> >
> >> The renaming of wakeup and sleep to flags makes it at
> >> least superficially seem like they overlap. Since a large part of the
> >> patch is renaming, it might be easier to understand if the renaming
> >> was done as a separate patch, but on the other hand, that is probably
> >> just a PITA. :)
> >
> > Seems a small enough patch to be all in one to me.  If others object
> > I'll split it out, but again, I tried to keep the backport as close to
> > Peter's original patch as possible.
> ----SNIP-----
> I'm not sure the renaming is necessary at all, since "wakeup" and
> "sleep" seem more descriptive than "flags". If you skip the renaming
> then the size of the patch is reduced to half it's current size.

The renaming isn't strictly necessary, but the name "flags" denotes that
there are multiple value that can be passed whereas "wakeup" is binary -
either on or off.  Since ENQUEUE_HEAD has nothing to do with "wakeup" it
doesn't make since to reuse the old name.  Changing the dequeue*
routines makes the related calls parallel in signature and allows for
similar changes in the future.

Also, as this is a backport, I would rather not try and change it here
only to have it revert back to Peter's original in the upstream -rt
tree.

Thanks,

-- 
Darren Hart
Real-Time Linux Team Lead
IBM Linux Technology Center

