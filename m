From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
 threads with -h option.
Date: Wed, 01 Jul 2009 16:43:17 -0700
Message-ID: <1246491797.19116.212.camel@sven.thebigcorporation.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
	 <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
	 <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
	 <49b7c2350907010642ga8c261p8c3a7c58937b7d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48410 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbZGAXnS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jul 2009 19:43:18 -0400
Received: by pzk26 with SMTP id 26so1174322pzk.33
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Jul 2009 16:43:21 -0700 (PDT)
In-Reply-To: <49b7c2350907010642ga8c261p8c3a7c58937b7d0a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2009-07-01 at 22:42 +0900, GeunSik Lim wrote:
> Sorry I'm late according to going out.
> 
> On Tue, Jun 30, 2009 at 6:30 PM, Sven-Thorsten
> Dietrich<sven@thebigcorporation.com> wrote:
> > I that was a single CPU scenario.
> > For testing on SMP, the cyclictest threads need to behave identicallly
> > (even in priority) on all CPUs.
> Additionally, I want you to consider  both Unicore  and Multicore
> when some users  will use  -h option.
> 

-h works fine that way now, but only for one thread / CPU.

> > That same argument also applies to this patch, doesn't it?
> > In other words, without changing the existing code, you could change the
> > prios for the histogram mode via a similar script, right?
> Yes, It's right.
> But. I am talking about output style of prios to avoid confusion
> between without -h and with -h.
> As you know, Cyclictest  display  result of latencies on the console
> without detailed  explanation.
> So, When we add -h option to get histogram data,  Most users have to
> view source code
> because of  the different output style suddenly.
> 

Well the out put IS different. So I don't understand your point?

If you want to document the format, that would be great, but I don't see
how this relates at all to this patch.

> > I don't disagree, but I think the proper fix may be to decouple
> > histogram from priority, via another parameter.
> >
> > Note that the thread interval is also held constant when histogram is
> > configured -- not just the priority.
> >
> >                if (!histogram) /* histogram requires same interval on CPUs*/
> >                        interval += distance;
> >
> >
> > The patch you sent basically reverts a bug-fix for the histogram
> > application on SMP, but doesn't change the interval behavior.
> >
> > So you would also have to decouple the interval code as well.
> Thank you for explanation  of  histogram related  patches like
> priority and interval.
> If you accept  my proposal to avoid confusion of output style,
> I want to change  interval code reversely .  -:)
> 

Not sure what you mean, but I still object to having different
priorities on different CPUs on SMP.

> But,
> If you and others don't  agree with my opinions,
> I think that  We have to append  additional explanation in the "#>
> cyclictest --help" to
> understand output  using -h option at least like belows.
> 
>  before) "-h       --histogram=US    dump a latency histogram to
> stdout after the run\n"
>  after   ) "-h       --histogram=US    dump a latency histogram to
> stdout after the run (with same priority about threads)\n"
> 
> How about you think  this my opinions?
> 

Sounds good. So you want to document this? 

You are still omitting the interval issue here, which is equally
important.

> > It would be better to be able to explicitly set priorities and intervals
> > to be the same, when distributed per-CPU on SMP. That is one kind of
> > test, which is important.
> >
> > Inversely relating priority versus interval on UP is another kind of
> > test. This seems to be what you are trying to do.
> >
> > So to have both, means you can to stack threads on SMP and have multiple
> > threads on each CPU, operating at increasing intervals. Each thread
> > would report data.
> >
> > But that implies a 3-D table to log the data returned from cyclictest
> > threads at lower priorities (lower than the highest priority).
> >
> > The histogram code is only able to log one set of data for each thread
> > as it is today.
> >
> > And as-is, the histogram assumes threads are distributed per-cpu via
> > affinity on SMP. Changing to a 3-D matrix is interesting, but how would
> > you represent that / store ?
> >
> > What exactly are you testing / looking for?
> I want to test maximum latencies based on background stress conditions  on SMP.
> And, I  want to get histogram data about worstcase latencies using -h option.
> 
> 

You can get that now. But if you run cyclictest on SMP at PRIO < 99, you
will get preempted by the migration thread, which is exactly why it
doesn't make sense to stagger the priorities.

In summary, I don't see the benefit of a 3-D histogram to log multiple
cyclic threads per-cpu, but if you want to send a patch to make this
happen, be my guest.

Otherwise, send a patch to add to the man pages to document the output
format.

Or send a patch to add parameters to control the interval and prio
staggering individually. 

But the patch you sent doesn't make any sense and won't produce correct
results on SMP, which you should have verified yourself by now.

Thanks,

Sven


