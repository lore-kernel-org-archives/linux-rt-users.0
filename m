From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH RFC] BKL not necessary in cpuid_open
Date: Wed, 7 Oct 2009 23:44:10 +0200
Message-ID: <20091007214408.GF5903@nowhere>
References: <alpine.LFD.2.00.0910072016190.15183@localhost.localdomain> <20091007201338.GE5903@nowhere> <alpine.LFD.2.00.0910072259230.9428@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Kacur <jkacur@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:53597 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbZJGVos (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2009 17:44:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0910072259230.9428@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 07, 2009 at 11:01:23PM +0200, Thomas Gleixner wrote:
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
> Thanks,
> 
> 	tglx



Yeah, but you know, I very good when it comes to find/remember
something obvious only right after posting a patch (I rarely
posted a patch not followed by a v2 lately). A kind of
post-posting only memory, something that becomes common with me,
I guess I need to start learning how to live with it :)

That said, some developers who don't read lwn (or other kind of
people gifted by the post-patch-posting memory power) may come and try
to remove the bkl there, since it's not visible in lkml archives
or in the master branch of the x86 tree.

Ah, for example hpa has just committed my patch :-)



