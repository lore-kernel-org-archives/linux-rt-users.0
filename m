From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] backfire: fix build failure for 4.11+ kernels
Date: Wed, 12 Jul 2017 10:42:18 +0200
Message-ID: <20170712084218.mkw22vz7qpoaunhf@pengutronix.de>
References: <1499795099-29710-1-git-send-email-marcelo.cerri@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
To: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37535 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756858AbdGLImY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jul 2017 04:42:24 -0400
Content-Disposition: inline
In-Reply-To: <1499795099-29710-1-git-send-email-marcelo.cerri@canonical.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 11, 2017 at 02:44:59PM -0300, Marcelo Henrique Cerri wrote:
> Since v4.11-rc1~18^2~76, kill_pid() is declared in
> "linux/sched/signal.h" instead of in "linux/sched.h".
> 
> Include the correct header file based on the kernel version to keep
> it compatible with older kernels.
> 
> Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>

When talking on irc to Sebastian we thought it a better idea to just
remove backfire. I patched if already in the past for the debian
packaging to build on 2.6.32 and 3.6 which were the versions available
in Debian back then. That also means that the patch in question here
isn't sufficient to make backfire build on 4.11. In fact it doesn't
compile since 2.6.39-rc1 when SPIN_LOCK_UNLOCKED was killed in
d04fa5a3ba06 ("locking: Remove deprecated lock initializers").

@John and Clark: Which branch do you want me to base a "remove bitrotten
backfire" patch on? IMHO there is a bit of chaos there because the v1.1
tag bases on v2.0 and has VERSION = 2.0 in Makefile. stable/v1.0
bases on v1.0, while unstable/devel/v1.1.1 bases on v1.1 and v1.1.1
seems to be its target version?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
