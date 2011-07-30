From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] dma: ipu: convert back_lock to a raw spinlock
Date: Sat, 30 Jul 2011 09:24:26 -0700
Message-ID: <CABE8wwuJPSPmJ=fHacdPcPAX5Lrewknd=f4uKtwLP08=+qDnww@mail.gmail.com>
References: <1311949627-13260-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, kernel@pengutronix.de,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:24823 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374Ab1G3Qd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Jul 2011 12:33:57 -0400
Received: by pzk5 with SMTP id 5so24682811pzk.17
        for <linux-rt-users@vger.kernel.org>; Sat, 30 Jul 2011 09:24:26 -0700 (PDT)
In-Reply-To: <1311949627-13260-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2011/7/29 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> It's used in irq handling, so needs to be hardirq safe.
>

This changelog does not make sense,  spin_lock_irqsave *is* hardirq
safe.  Is this trying to workaround a lockdep report?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
