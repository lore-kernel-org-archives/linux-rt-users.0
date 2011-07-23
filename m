From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rtc-tegra: properly initialize spinlock
Date: Sat, 23 Jul 2011 09:29:08 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107230926420.2702@ionos>
References: <1311323756-18013-1-git-send-email-u.kleine-koenig@pengutronix.de> <20110722151338.9b1e9594.akpm@linux-foundation.org> <58E25CAF-EAC4-4613-81B2-D713F5DC8CEF@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Andrew Chew <achew@nvidia.com>,
	linux-rt-users@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, jkastner@redhat.com
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38634 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab1GWH3R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 03:29:17 -0400
In-Reply-To: <58E25CAF-EAC4-4613-81B2-D713F5DC8CEF@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Jul 2011, Sven-Thorsten Dietrich wrote:
> 
> On Jul 22, 2011, at 3:13 PM, Andrew Morton wrote:
> 
> > On Fri, 22 Jul 2011 10:35:56 +0200
> > Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
> > 
> >> Using __SPIN_LOCK_UNLOCKED for a dynamically allocated lock is wrong and
> >> breaks with PREEMPT_RT_FULL.
> > 
> > Please define "breaks".  Lockdep warnings?  Deadlocks?
> 
> Narrr, I think its a compile-time problem with the static initializer.

Correct. The macro expansion magic of the static initializer barfs and
with lockdep the lockdep key assignment is missing.

Thanks,

	tglx
