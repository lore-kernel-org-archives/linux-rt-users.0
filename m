From: Mike Galbraith <efault@gmx.de>
Subject: Re: task switch from net-rx to idle when there is napi processing
 to be done
Date: Wed, 25 Jan 2012 10:18:13 +0100
Message-ID: <1327483093.6973.10.camel@marge.simson.net>
References: <4F1F6B66.5010005@caviumnetworks.com>
	 <20120125085523.GG6305@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Venkat Subbiah <vsubbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:33484 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752664Ab2AYJST (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 04:18:19 -0500
In-Reply-To: <20120125085523.GG6305@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-25 at 09:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Jan 24, 2012 at 06:39:34PM -0800, Venkat Subbiah wrote:
> > In the process of debugging a napi ethernet driver performance
> > issue, what I am noticing is
> >=20
> > 1. While the driver is in the middle of a napi packet processing
> > loop, there is a task switch from
> > sirq-net-rx to idle even though there is pending napi processing to=
 be done.
> I didn't check your logs below, but maybe this is related to the defa=
ult
> settings in /proc/sys/kernel/sched_rt_period_us and
> /proc/sys/kernel/sched_rt_runtime_us? That is 0.05s per second is
> reserved for non-RT tasks tasks such that a run-away realtime process
> will not lock up the machine.
>=20
> To verify that, try
>=20
> 	echo -1 > /proc/sys/kernel/sched_rt_runtime_us

Hm, makes sense if this is a UP box.  SMP would just go borrow a cup of
runtime from a neighbor.

	-Mike

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
