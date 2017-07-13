From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] backfire: fix build failure for 4.11+ kernels
Date: Thu, 13 Jul 2017 17:26:08 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1707131719280.12788@planxty>
References: <1499795099-29710-1-git-send-email-marcelo.cerri@canonical.com> <20170712084218.mkw22vz7qpoaunhf@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1685824890-1499959578=:12788"
Cc: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36797 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGMP0V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jul 2017 11:26:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so5792389wmh.3
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jul 2017 08:26:20 -0700 (PDT)
In-Reply-To: <20170712084218.mkw22vz7qpoaunhf@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1685824890-1499959578=:12788
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Wed, 12 Jul 2017, Uwe Kleine-König wrote:

> On Tue, Jul 11, 2017 at 02:44:59PM -0300, Marcelo Henrique Cerri wrote:
> > Since v4.11-rc1~18^2~76, kill_pid() is declared in
> > "linux/sched/signal.h" instead of in "linux/sched.h".
> > 
> > Include the correct header file based on the kernel version to keep
> > it compatible with older kernels.
> > 
> > Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> 
> When talking on irc to Sebastian we thought it a better idea to just
> remove backfire. I patched if already in the past for the debian
> packaging to build on 2.6.32 and 3.6 which were the versions available
> in Debian back then. That also means that the patch in question here
> isn't sufficient to make backfire build on 4.11. In fact it doesn't
> compile since 2.6.39-rc1 when SPIN_LOCK_UNLOCKED was killed in
> d04fa5a3ba06 ("locking: Remove deprecated lock initializers").
> 
> @John and Clark: Which branch do you want me to base a "remove bitrotten
> backfire" patch on? IMHO there is a bit of chaos there because the v1.1
> tag bases on v2.0 and has VERSION = 2.0 in Makefile. stable/v1.0
> bases on v1.0, while unstable/devel/v1.1.1 bases on v1.1 and v1.1.1
> seems to be its target version?
> 
> Best regards
> Uwe

Hmmn, I find the idea of backfire kinda neat, my first instinct is to
say, why can't we fix this? If something is broken in the devel version
too, that's okay with me, you can disable that part if you want to
ship the devel version.

That being said, in a quick chat with Clark, he said he's not using it.
It was written by Carsten I believe.

The naming chaos is my fault, it took my awhile to settle on naming
the devel version. However I wonder if something is wrong with your
local repo, because I thought I had cleaned that all up? I don't
see VERSION = 2.0 in the makefile for example.

Not sure what to do about this. Does your patch for versions below 3.6
actually work, or does it allow you to compile, but it's still broken?
If it is broken, then I guess I would be okay with removing it from
1.0, but leave it in the devel version for now.

Thanks

John
 
---1463804494-1685824890-1499959578=:12788--
