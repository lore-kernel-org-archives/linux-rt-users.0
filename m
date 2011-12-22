From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel panic with PREEMPT_RT_FULL and UIO driver
Date: Thu, 22 Dec 2011 13:58:21 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112221246350.3020@ionos>
References: <4EF1B984.4010102@x2e.de> <20111222103114.GE24496@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-64323086-1324558702=:3020"
Cc: Lukas Erlinghagen <lukas.erlinghagen@x2e.de>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34637 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab1LVM6X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Dec 2011 07:58:23 -0500
In-Reply-To: <20111222103114.GE24496@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-64323086-1324558702=:3020
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 22 Dec 2011, Uwe Kleine-König wrote:

> On Wed, Dec 21, 2011 at 11:48:36AM +0100, Lukas Erlinghagen wrote:
> > ------------[ cut here ]------------
> > kernel BUG at kernel/rtmutex.c:724!
> That's a recursive spinlock. Try enabling CONFIG_PROVE_LOCKING.

News at eleven. I already explained Lukas, _why_ this happens. So what
the heck will CONFIG_PROVE_LOCKING provide as extra value?

We all appreciate your helpfulness, but your signal to noise ratio is
approaching zero.

Thanks,

	tglx
--8323328-64323086-1324558702=:3020--
