From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: cyclictest abstime vs. reltime
Date: Thu, 18 Dec 2014 09:22:19 +0100
Message-ID: <20141218082219.GC10857@pengutronix.de>
References: <20141217151650.6ee5649c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>, williams@redhat.com,
	riel@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44941 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaLRIWV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 03:22:21 -0500
Content-Disposition: inline
In-Reply-To: <20141217151650.6ee5649c@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Luiz,

On Wed, Dec 17, 2014 at 03:16:50PM -0500, Luiz Capitulino wrote:
> So, my question boils down to: is there a relevant difference between
> the two modes? Why isn't reltime the default mode?
I don't know, but I think in reality you want abstime. Consider a proce=
ss
that does something with items that pass at your machine on a belt conv=
eyor.
Then you need to handle one item (say) each 200ms and using reltime mea=
ns
that your latencies add and even with a latency of 1=B5s you'd miss
approx. 1 item per year.

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
