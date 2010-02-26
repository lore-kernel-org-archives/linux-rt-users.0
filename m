From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RT] trivial fix to REMINDER block in init/main.c
Date: Fri, 26 Feb 2010 10:03:33 +0100
Message-ID: <20100226090333.GA3088@pengutronix.de>
References: <20100225163923.3621094e@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38490 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935599Ab0BZJDj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2010 04:03:39 -0500
Content-Disposition: inline
In-Reply-To: <20100225163923.3621094e@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Thu, Feb 25, 2010 at 04:39:23PM -0600, Clark Williams wrote:
> Thomas,
>=20
> Here's a trivial patch to the RT tree. I noticed during testing that =
I
> was getting an empty REMINDER block in dmesg. Looks like STACK_TRACER
> got dropped.

This patch doesn't qualify for a patent:

http://marc.info/?l=3Dlinux-rt-users&m=3D123839719221161&w=3D2

:-)  (IIRC I reordered the tests to have the same order as in the #if,
but didn't recheck.)

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
