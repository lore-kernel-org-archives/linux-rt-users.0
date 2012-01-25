From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: task switch from net-rx to idle when there is napi processing to
 be done
Date: Wed, 25 Jan 2012 09:55:23 +0100
Message-ID: <20120125085523.GG6305@pengutronix.de>
References: <4F1F6B66.5010005@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35768 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999Ab2AYIzZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 03:55:25 -0500
Content-Disposition: inline
In-Reply-To: <4F1F6B66.5010005@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, Jan 24, 2012 at 06:39:34PM -0800, Venkat Subbiah wrote:
> In the process of debugging a napi ethernet driver performance
> issue, what I am noticing is
>=20
> 1. While the driver is in the middle of a napi packet processing
> loop, there is a task switch from
> sirq-net-rx to idle even though there is pending napi processing to b=
e done.
I didn't check your logs below, but maybe this is related to the defaul=
t
settings in /proc/sys/kernel/sched_rt_period_us and
/proc/sys/kernel/sched_rt_runtime_us? That is 0.05s per second is
reserved for non-RT tasks tasks such that a run-away realtime process
will not lock up the machine.

To verify that, try

	echo -1 > /proc/sys/kernel/sched_rt_runtime_us

=2E

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
