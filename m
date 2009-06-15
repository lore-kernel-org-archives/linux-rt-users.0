From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH -rt] include linux/delay.h in hwlat_detector
Date: Sun, 14 Jun 2009 20:54:19 -0400
Message-ID: <1245027259.31611.14.camel@localhost.localdomain>
References: <1245015102-22057-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:59149 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbZFOAys (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Jun 2009 20:54:48 -0400
In-Reply-To: <1245015102-22057-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2009-06-14 at 23:31 +0200, Uwe Kleine-K=C3=B6nig wrote:
> This broke when compiling on i386 without X86_LOCAL_APIC because then
> arch/x86/include/asm/smp.h doesn't include asm/apic.h which in turn i=
ncludes
> linux/delay.h.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jon Masters <jcm@redhat.com>
> ---

Oh, thanks. I will also look at better handling hotplug CPU just to mak=
e
Paul happy (probably just disable on hotplug as you'll need to restart
any testing then), though as he said, it's obvious one shouldn't be
removing CPUs at the same time as benchmarking.

Jon.


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
