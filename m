From: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH RT] tasklet/rt: Prevent tasklets from going into infinite
 spin in RT
Date: Wed, 30 Nov 2011 07:56:54 -0800
Message-ID: <20111130155654.GA2213@monkey.beaverton.ibm.com>
References: <1322618120.17003.104.camel@frodo>
 <20111129215039.344b5109@redhat.com>
 <20111130062431.GA2185@monkey.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54813 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756665Ab1K3P5S (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Nov 2011 10:57:18 -0500
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <mkravetz@us.ibm.com>;
	Wed, 30 Nov 2011 10:57:16 -0500
Content-Disposition: inline
In-Reply-To: <20111130062431.GA2185@monkey.beaverton.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 29, 2011 at 10:24:31PM -0800, Mike Kravetz wrote:
> On Tue, Nov 29, 2011 at 09:50:39PM -0600, Clark Williams wrote:
> > On Tue, 29 Nov 2011 20:55:20 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Ingo,
> > > 
> > > I forward ported this code from 2.6.33.9-rt31, but I think you were the
> > > original author, as I found most of this code in the
> > > "tasklet-redesign.patch" from my broken out 2.6.24-rt patches. I
> > > committed it into my git tree (stable-rt) under your name, and added the
> > > Signed-off-by that you had in that patch, if you have and objections,
> > > please let me know. This patch should never see mainline, but it will
> > > probably be going into the -rt branch. I wrote up this change log, if
> > > there's something you don't like in it, let me know and I'll fix it.
> > > 
> > > Luis and Clark (I love saying that),
> > 
> > No matter how many times you say it, I'm still not treking across the
> > USA with Luis. :)
> > 
> > > I booted this patch against 3.0-rt stable, and it didn't crash ;)
> > > Could you apply it and see if it fixes the hang that you've been seeing.
> > 
> > Yeah, since Luis is a couple of time zones ahead of us, maybe it'll all
> > be fixed when we get up in the morning.
> 
> I've got it running on a system here that frequently encountered the
> condition.  I will let it perform some automated testing while I sleep.
> Should have results by morning (west coast US).

133 successful test executions (just normal reboot/restart of system).  Without
patch, system would hang/stall during restart more than 50% of the time.

-- 
Mike

