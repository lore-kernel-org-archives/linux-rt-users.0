From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch] mm/zsmalloc: Use get/put_cpu_light in
 zs_map_object()/zs_unmap_object()
Date: Tue, 29 Mar 2016 18:37:28 +0200
Message-ID: <20160329163728.GH13334@linutronix.de>
References: <1458641769.15742.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33369 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648AbcC2Qha convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 12:37:30 -0400
Content-Disposition: inline
In-Reply-To: <1458641769.15742.2.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2016-03-22 11:16:09 [+0100]:

>Otherwise, we get a ___might_sleep() splat.

Applied. A backtrace would be nice =E2=80=A6

>Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
