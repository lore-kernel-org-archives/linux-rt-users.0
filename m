From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [solved] Kernel module crashed in 2.6.33.7-rt30
Date: Fri, 28 Jan 2011 08:57:25 +0100
Message-ID: <20110128075725.GQ1147@pengutronix.de>
References: <1295941160.4853.0.camel@vikram-pc>
 <20110125162136.GD22005@pengutronix.de>
 <AANLkTikQW6mkV_a6umKY0NnoinD-UnJQK4Gm+kxuKfCa@mail.gmail.com>
 <20110127075904.GJ1147@pengutronix.de>
 <AANLkTinW4koreUTXS_ieXb9wGVUKhebTgLvkfEMP4O6y@mail.gmail.com>
 <AANLkTikceiY2yZHBkHbuhUs+mvRhAfHY2hMLmaXMmy=u@mail.gmail.com>
 <20110127092039.GK1147@pengutronix.de>
 <AANLkTimYnhQ_4+=PJogMts65iLsoNcE60NTdnfDwVtJx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Vikram Narayanan <vikram186@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56132 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab1A1H51 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Jan 2011 02:57:27 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimYnhQ_4+=PJogMts65iLsoNcE60NTdnfDwVtJx@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

[just informing the ml about your issue being solved.]

On Fri, Jan 28, 2011 at 12:08:46PM +0530, Vikram Narayanan wrote:
> Thanks a lot, I enabled this option. The problem was on having an unb=
alanced
> spin lock. Now it is resolved. :)
> Thanks you so much.

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
