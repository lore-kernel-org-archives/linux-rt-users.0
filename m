From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] fec: don't enable irqs in hard irq context
Date: Mon, 7 Sep 2009 16:01:38 +0200
Message-ID: <20090907140138.GA20441@pengutronix.de>
References: <1251882856-23549-1-git-send-email-u.kleine-koenig@pengutronix.de> <1251882856-23549-2-git-send-email-u.kleine-koenig@pengutronix.de> <4A9F1870.7070408@snapgear.com> <20090902.231709.224187980.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37673 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZIGOBm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Sep 2009 10:01:42 -0400
Content-Disposition: inline
In-Reply-To: <20090902.231709.224187980.davem@davemloft.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> Applied to net-next-2.6
who ever does the next .30-rt release, can you please cherry pick these
patches?

Assuming the commit ids don't change anymore it's:

	$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-ne=
xt-2.6.git master
	$ git cherry-pick -x 84177a20799072c65a69b62571660d4d9780823c
	$ git cherry-pick -x 81538e74ca12a71ea37ce72f809ebc65a90b9538

Best regards and thanks
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
