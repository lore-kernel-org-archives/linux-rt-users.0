From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: 2.6.35 RT support roadmap
Date: Thu, 12 Aug 2010 23:05:36 -0700
Message-ID: <1281679536.7356.8.camel@baracus>
References: <CD8FEF6F82F55744AA1ED2BE5E7D8FD2015184EE0B@dnce01.ent.ti.com>
	 <AANLkTimmCqNz+ZhSCqMGhaiCmW38hnjfkLV0ZU+e2gkX@mail.gmail.com>
	 <1281638311.7093.4.camel@marge.simson.net> <4C645567.2080308@gmail.com>
	 <AANLkTikoUbL4Q8PNia38AByEfTY56Bqr5uVnyyNxvS1W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <efault@gmx.de>,
	Xianghua Xiao <xiaoxianghua@gmail.com>,
	"Walzer, Frank" <f-walzer@ti.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jordan johnston <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39564 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab0HMGFl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 02:05:41 -0400
Received: by ywh1 with SMTP id 1so755392ywh.19
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Aug 2010 23:05:40 -0700 (PDT)
In-Reply-To: <AANLkTikoUbL4Q8PNia38AByEfTY56Bqr5uVnyyNxvS1W@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-08-12 at 23:17 -0400, jordan johnston wrote:
> > Google did Android and even Palm woke up (just long enough to watch its own
> > demise).
> >
> > The rest is history.
> >
> > Except of course putting the RT Kernel in Android.
> 
> As i understand it, many Android users are using the BFS patchset, and
> have been for a while. BFS pretty much does what "the end result of
> using the rt-patches" accomplish, minus rtirq, spin-locks, etc. You
> will get the desired
> responsiveness that using RT would give you.
> 

I assume that it might well depend to some extent on whether I am
pumping market data feeds into a processing model using 512 CPUs or
playing a game on my Nexus-1, but I won't disagree agree with you on the
importance of task-appropriate efficient scheduling, appropriate
workload partitioning, and all that jazz.


> Im pretty sure that is why Zen-kernel has a git repository "very
> specifically" for android (BFS is the default kernel setting). I'm
> sure there are other goodies for android in there too.
> 
> www.zen-kernel.org
> 
> I don't know much about the Android repo's state (as it's fairly new).
> but worth a
> look for your "rt-usage" (ie. performance/responsiveness) for android.
>  As i do not own an Android, i have not tested it, but i have talked
> with people who do..
> 
> I'm waiting to see what 2.6.35 holds for RT.... but personally i am
> using BFS and 2.6.34 with a lot of performance tuning (a good deal of
> time spent analyzing/tuning) and i am yielding better results not
> using the upstream rt-patches.
> we will see what happens in 2.6.35/36....
> 

Sounds good. I know there has been some extensive discussion about the
interpretation and applicability of the various scheduler performance
metrics, including special examination of BFS vs. CFS - and I definitely
think that has been hashed out in gore and detail already.

But if you have some pretty plots that characterize performance for your
platform, vs. Preempt-RT, I am always interested in looking at pictures
and numbers about what's happening on the other side of the fence.

Cheers,

Sven


> just my 2 cents :)
> 
> cheers
> 
> jordan


