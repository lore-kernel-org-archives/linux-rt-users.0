From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] backfire: fix build failure for 4.11+ kernels
Date: Thu, 13 Jul 2017 18:39:48 +0200
Message-ID: <20170713163948.kzj4yfqm7fejswly@pengutronix.de>
References: <1499795099-29710-1-git-send-email-marcelo.cerri@canonical.com>
 <20170712084218.mkw22vz7qpoaunhf@pengutronix.de>
 <alpine.LFD.2.20.1707131719280.12788@planxty>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51473 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752401AbdGMQjy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jul 2017 12:39:54 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1707131719280.12788@planxty>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello John,

On Thu, Jul 13, 2017 at 05:26:08PM +0200, John Kacur wrote:
> On Wed, 12 Jul 2017, Uwe Kleine-König wrote:
> > On Tue, Jul 11, 2017 at 02:44:59PM -0300, Marcelo Henrique Cerri wrote:
> > > Since v4.11-rc1~18^2~76, kill_pid() is declared in
> > > "linux/sched/signal.h" instead of in "linux/sched.h".
> > > 
> > > Include the correct header file based on the kernel version to keep
> > > it compatible with older kernels.
> > > 
> > > Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > 
> > When talking on irc to Sebastian we thought it a better idea to just
> > remove backfire. I patched if already in the past for the debian
> > packaging to build on 2.6.32 and 3.6 which were the versions available
> > in Debian back then. That also means that the patch in question here
> > isn't sufficient to make backfire build on 4.11. In fact it doesn't
> > compile since 2.6.39-rc1 when SPIN_LOCK_UNLOCKED was killed in
> > d04fa5a3ba06 ("locking: Remove deprecated lock initializers").
> > 
> > @John and Clark: Which branch do you want me to base a "remove bitrotten
> > backfire" patch on? IMHO there is a bit of chaos there because the v1.1
> > tag bases on v2.0 and has VERSION = 2.0 in Makefile. stable/v1.0
> > bases on v1.0, while unstable/devel/v1.1.1 bases on v1.1 and v1.1.1
> > seems to be its target version?
> > 
> > Best regards
> > Uwe
> 
> Hmmn, I find the idea of backfire kinda neat, my first instinct is to
> say, why can't we fix this? If something is broken in the devel version
> too, that's okay with me, you can disable that part if you want to
> ship the devel version.

"neat" isn't IMHO enough to justify keeping that. If nobody is using it
and even nobody notices that it doesn't compile on kernels released in
the last 6 years ...
 
> The naming chaos is my fault, it took my awhile to settle on naming
> the devel version. However I wonder if something is wrong with your
> local repo, because I thought I had cleaned that all up? I don't
> see VERSION = 2.0 in the makefile for example.

It's not my local repo:

	uwe@taurus:~$ git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.gitCloning into 'rt-tests'...
	remote: Counting objects: 2917, done.
	remote: Total 2917 (delta 0), reused 0 (delta 0)
	Receiving objects: 100% (2917/2917), 739.04 KiB | 0 bytes/s, done.
	Resolving deltas: 100% (1898/1898), done.
	uwe@taurus:~$ cd rt-tests/
	uwe@taurus:~/rt-tests$ git show v1.1:Makefile | grep ^VERSION
	VERSION = 2.0

> Not sure what to do about this. Does your patch for versions below 3.6
> actually work, or does it allow you to compile, but it's still broken?
> If it is broken, then I guess I would be okay with removing it from
> 1.0, but leave it in the devel version for now.

I'm sure I tested 3.6 and back then it worked fine. And if you (i.e.
upstream) care about this, I'm willing to invest the time to make it
compile again. The follow-up question then is which version range we
care about. I'm not sure if we can have a nice source without much
#ifdeffery that compiles on the full range 3.2 - 4.11.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
