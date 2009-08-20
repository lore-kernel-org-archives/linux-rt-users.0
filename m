From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: hrtimer problem on AT91RM9200
Date: Thu, 20 Aug 2009 21:52:00 +0200
Message-ID: <20090820195200.GA3331@pengutronix.de>
References: <4A8BEF09.2080300@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57936 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbZHTTwA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Aug 2009 15:52:00 -0400
Content-Disposition: inline
In-Reply-To: <4A8BEF09.2080300@newtec.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

> PC is at clkevt32k_next_event+0x70/0xac
This function has a WARN_ON_ONCE(...).  Can you check if this triggers?

Can you provide me a kernel image with CONFIG_DEBUG_INFO=3Dy and a
matching oops?

Best regards
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
