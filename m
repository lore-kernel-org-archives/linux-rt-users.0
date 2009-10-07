From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH RFC] BKL not necessary in cpuid_open
Date: Wed, 7 Oct 2009 23:58:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910072356050.15183@localhost.localdomain>
References: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain> <20091007201338.GE5903@nowhere> <alpine.LFD.2.00.0910072259230.9428@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755082AbZJGWJb@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0910072259230.9428@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Wed, 7 Oct 2009, Thomas Gleixner wrote:

> On Wed, 7 Oct 2009, Frederic Weisbecker wrote:
> > Hmm, I'm discovering that in tip:rt/kill-the-bkl
> > 
> > http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=commitdiff;h=55968ede164ae523692f00717f50cd926f1382a0
> > 
> > Looks like we have overlaped.
> > 
> > Thomas it would be nice to post these patches on LKML (or I missed
> > them?) and may be to merge them into tip:master, so that they are
> > visible and then we lower the risk of any duplicate works in this area.
> 
> Now guess why I mentioned this branch sevaral times at the rt summit
> last week. It's even documented in Jonathans excellent meeting
> minutes on lwn.net :)
> 

Well, the overlap is unfortunate but I did do a git diff with 
tip/core/kill-the-BKL BEFORE I posted.

not sure what the difference is between
tip/kill-the-BKL
and 
tip/core/kill-the-BKL
btw

Also
git describe 55968ede164ae523692f00717f50cd926f1382a0
v2.6.31-rc6-4-g55968ed

Not sure what to make of that either, since my patch was against the 
latest linus updated this morning.

Frederic: what was your method to discover that patch from Thomas?
