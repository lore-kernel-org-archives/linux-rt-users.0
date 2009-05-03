From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH 3/3] Makefile: don't override DESTDIR, prefix, bindir and
	mandir
Date: Sun, 3 May 2009 15:37:18 +0200
Message-ID: <c384c5ea0905030637m4d8bc960l956fa1e90d40598c@mail.gmail.com>
References: <20090502185004.GA14150@cassiopeia.tralala>
	 <1241290402-15234-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:29590 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbZECNnj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 May 2009 09:43:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1916059yxj.1
        for <linux-rt-users@vger.kernel.org>; Sun, 03 May 2009 06:43:39 -0700 (PDT)
In-Reply-To: <1241290402-15234-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

2009/5/2 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> This eases packaging rt-tests and shouldn't have any further impact.
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

In addition to this, could LDFLAGS be respected?)

Acked-by: Leon Woestenberg <leon@sidebranch.com>


Regards,
--=20
Leon
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
