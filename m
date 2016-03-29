From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] mm/zsmalloc: Use get/put_cpu_light in
 zs_map_object()/zs_unmap_object()
Date: Tue, 29 Mar 2016 19:37:06 +0200
Message-ID: <1459273026.3628.5.camel@gmail.com>
References: <1458641769.15742.2.camel@gmail.com>
	 <20160329163728.GH13334@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33772 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbcC2RhK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 13:37:10 -0400
Received: by mail-wm0-f41.google.com with SMTP id r72so66968043wmg.0
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2016 10:37:09 -0700 (PDT)
In-Reply-To: <20160329163728.GH13334@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2016-03-29 at 18:37 +0200, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2016-03-22 11:16:09 [+0100]:
>=20
> > Otherwise, we get a ___might_sleep() splat.
>=20
> Applied. A backtrace would be nice =E2=80=A6

Ugh, I elided it because I thought it didn't add any meat.  The
cleaning lady (/me) binned it, but can re-create if really needed.

	-Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
