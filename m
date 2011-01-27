From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Kernel module crashed in 2.6.33.7-rt30
Date: Thu, 27 Jan 2011 10:20:39 +0100
Message-ID: <20110127092039.GK1147@pengutronix.de>
References: <1295941160.4853.0.camel@vikram-pc>
 <20110125162136.GD22005@pengutronix.de>
 <AANLkTikQW6mkV_a6umKY0NnoinD-UnJQK4Gm+kxuKfCa@mail.gmail.com>
 <20110127075904.GJ1147@pengutronix.de>
 <AANLkTinW4koreUTXS_ieXb9wGVUKhebTgLvkfEMP4O6y@mail.gmail.com>
 <AANLkTikceiY2yZHBkHbuhUs+mvRhAfHY2hMLmaXMmy=u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pradyumna Sampath <pradysam@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Vikram Narayanan <vikram186@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48310 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab1A0JUm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Jan 2011 04:20:42 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikceiY2yZHBkHbuhUs+mvRhAfHY2hMLmaXMmy=u@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 27, 2011 at 02:08:35PM +0530, Vikram Narayanan wrote:
> Hi,
>=20
> I was using a older version of RT patch. After going through the
> thread that you mentioned I moved to the latest one. But still the
> crash happens for me.
> Also I don't have iptables running in my system.
> And another thing is that, my kernel module always stops when it is
> trying to acquire a spinlock (spin_lock_irqsave) which is shared with
> code in the ISR. Is there any way to see the information about the
> lock, like who is holding the lock??
Try enabling

	CONFIG_PROVE_LOCKING
	CONFIG_PROVE_RCU
	CONFIG_DEBUG_RT_MUTEXES:

(don't know which of these are available in your version, these are fro=
m
=2E38-rc2).

Some others in the kernel hacking menu might be useful, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
