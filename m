From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH 2/3] cyclictest: Fix the same priority method of many
 threads with -h option.
Date: Tue, 30 Jun 2009 02:30:19 -0700
Message-ID: <1246354219.11056.36.camel@quadrophenia.thebigcorporation.com>
References: <1246030689.2153.32.camel@centos51>
	 <1246330564.8104.37.camel@sven.thebigcorporation.com>
	 <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: williams <williams@redhat.com>, tglx <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:4113 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbZF3JaS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Jun 2009 05:30:18 -0400
Received: by rv-out-0506.google.com with SMTP id f6so64rvb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Jun 2009 02:30:21 -0700 (PDT)
In-Reply-To: <49b7c2350906300012x3a188622o3f15240199faf901@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-06-30 at 16:12 +0900, GeunSik Lim wrote:
> On Tue, Jun 30, 2009 at 11:56 AM, Sven-Thorsten
> Dietrich<sven@thebigcorporation.com> wrote:
> > When generating a histogram on multiple cores, the priority of
> > cyclictest threads should be the same on each CPU.
> Of course, But original cyclictest is different  test scenario using
> many threads.
> 

I that was a single CPU scenario.

For testing on SMP, the cyclictest threads need to behave identicallly
(even in priority) on all CPUs. 

> > This change would make the priority lower on higher CPU ids, resulting
> > in apparent performance skew in favor of CPU0.
> Um. I don't agree with your opinions because we can try  cyclictest
> commands like belows
> using "-h" option.
> 

That same argument also applies to this patch, doesn't it?

In other words, without changing the existing code, you could change the
prios for the histogram mode via a similar script, right?

> In other words,
> If cyclictest user want to same priority about many threads ,
> They can assign same priority  with belows method or additional  bash scripts.
> 
> For example,
> 
> case )  before remove your some patches
> #> cyclictest -t 3    -p 90 -h -D 100 &[enter]
> 
> case )  after remove your some patches
> #> cyclictest -t 1    -p 90 -h -D 100 &[enter]
> #> cyclictest -t 1    -p 90 -h -D 100 &[enter]
> #> cyclictest -t 1    -p 90 -h -D 100 &[enter]
> 
> or
> #> define i=3; while ($i) do  cyclictest -t 1   -p 90 -h -D 100 & ;
> $i-- ; done
> 
> I think that many users will confuse  output  results  because of the
> differnece output style
> between  "without -h" option and "with -h" option.
> If I mistake , Pleasse correct me.
> 

I don't disagree, but I think the proper fix may be to decouple
histogram from priority, via another parameter.

Note that the thread interval is also held constant when histogram is
configured -- not just the priority.

                if (!histogram) /* histogram requires same interval on CPUs*/
                        interval += distance;
  

The patch you sent basically reverts a bug-fix for the histogram
application on SMP, but doesn't change the interval behavior.

So you would also have to decouple the interval code as well.

It would be better to be able to explicitly set priorities and intervals
to be the same, when distributed per-CPU on SMP. That is one kind of
test, which is important. 

Inversely relating priority versus interval on UP is another kind of
test. This seems to be what you are trying to do.

So to have both, means you can to stack threads on SMP and have multiple
threads on each CPU, operating at increasing intervals. Each thread
would report data. 

But that implies a 3-D table to log the data returned from cyclictest
threads at lower priorities (lower than the highest priority). 

The histogram code is only able to log one set of data for each thread
as it is today. 

And as-is, the histogram assumes threads are distributed per-cpu via
affinity on SMP. Changing to a 3-D matrix is interesting, but how would
you represent that / store ?

What exactly are you testing / looking for?

Sven 

> Thks.
> 

