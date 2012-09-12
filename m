From: Mike Galbraith <efault@gmx.de>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Wed, 12 Sep 2012 05:40:51 +0200
Message-ID: <1347421251.7037.27.camel@marge.simpson.net>
References: <OF6683632B.9200AAEB-ONC1257A76.0053E7B9-C1257A76.00558786@br-automation.com>
	 <1347387029.7018.53.camel@marge.simpson.net>
	 <E22FBA66-9D10-4CC6-975C-1F2A66BFAA07@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>,
	linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:48259 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751448Ab2ILDlF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 23:41:05 -0400
In-Reply-To: <E22FBA66-9D10-4CC6-975C-1F2A66BFAA07@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-09-11 at 11:55 -0700, Sven-Thorsten Dietrich wrote: 
> On Sep 11, 2012, at 11:10 AM, Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Tue, 2012-09-11 at 17:34 +0200, Wolfgang Wallner wrote:
> > 
> >>>> My questions are now:
> >>>> 
> >>>> * What does this logging entry mean?
> >>>> Could you please point me to some information about RT throttling
> >>>> so that I can understand what's it about?
> >> 
> >>> With stock settings, it means realtime task[s] consumed > 95% of the
> >>> throttle interval (1s), so the throttle activated, allowing
> >> SCHED_NORMAL
> >>> tasks to have a sip of CPU, to let you try to save the box from
> >> nutty RT
> >>> CPU hogs. See kernel/sched_rt.c.
> >> 
> >> I think if the application turns into a cpu hog...
> > 
> > Where from comes 'if'?  You presented evidence, so methinks there's not
> > a _lot_ of room for an 'if', there's just a missing 'why'.
> 
> Well, as you know a lot of folks do polling, but its important to make
> sure not ALL cores are doing that...

> [60382.945209] EplTimerHighResk: Continuous timer (handle 0x10000001)
> had to skip 836 interval(s)!

That and 'stops working' (as in forever) made me suspect spinner rather
than transient cpu over-commit.

> Need to look at the code, maybe we could add a mask to restrict
> throttling per cpu (e.g. to 0) ?

IMHO it's a debugging tool you turn off for normal operation.  Biggest
problem I've ever had with the thing is it allowing hogs to run over to
the neighbors to borrow a cup of CPU.  That's fixed.

-Mike

