From: Gregoire Gentil <gregoire@gentil.com>
Subject: TI wl1271 wireless bug with 3.4-rt17
Date: Sun, 02 Sep 2012 23:24:47 -0700
Message-ID: <50444D2F.3040607@gentil.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de> <20120902194911.GT28643@pengutronix.de>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:38276 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab2ICGYv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Sep 2012 02:24:51 -0400
In-Reply-To: <20120902194911.GT28643@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm trying to debug a wifi bug with 3.4-rt17 applied, running on an=20
OMAP4 ARM board such as Pandaboard.

Wi-Fi works perfectly well without rt patches. It also works quite well=
=20
with rt patches AND without wifi module loaded. But with both rt patche=
s=20
and wifi module, the system is very flaky and even if I manage to launc=
h=20
a big download, I get a kernel hang. I managed to get a trace:

BUG: scheduling while atomic: irq/213-wl12xx/1588/0x00010002
Modules linked in: omapdce(C) wl12xx wlcore omaprpc(C) mac80211 d
[<c001beb4>] (unwind_backtrace+0x0/0xf0) from [<c0613548>] (dump)
[<c0613548>] (dump_stack+0x20/0x24) from [<c0073908>] (__schedul)
[<c0073908>] (__schedule_bug+0x54/0x60) from [<c0614818>] (__sch)
[<c0614818>] (__schedule+0x74/0x6c0) from [<c0614f60>] (schedule)
[<c0614f60>] (schedule+0xa0/0xb8) from [<c0615eb8>] (rt_spin_loc)
[<c0615eb8>] (rt_spin_lock_slowlock+0x198/0x288) from [<c06160a8)
[<c06160a8>] (rt_spin_lock+0x18/0x1c) from [<bf0c6b24>] (wl12xx_)
[<bf0c6b24>] (wl12xx_hardirq+0x2c/0xa4 [wlcore]) from [<c00bd4f0)
[<c00bd4f0>] (handle_irq_event_percpu+0xac/0x24c) from [<c00bd70)
[<c00bd70c>] (handle_irq_event+0x7c/0x9c) from [<c00c08f0>] (han)
[<c00c08f0>] (handle_level_irq+0xe4/0x134) from [<c00bcf58>] (ge)
[<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c03217e8>] (g)
[<c03217e8>] (gpio_irq_handler+0x160/0x1a4) from [<c00bcf58>] (g)
[<c00bcf58>] (generic_handle_irq+0x34/0x3c) from [<c001449c>] (h)
[<c001449c>] (handle_IRQ+0x88/0xc8)

Source code including the function wl12xx_hardirq is here:
http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3Dblob;f=3D=
drivers/net/wireless/ti/wlcore/main.c;h=3D45fe911a6504f92dddff5a9415bb7=
7a643b3c4a9;hb=3Df84c72f6b36418ff11d16808c16a7c3216730bb0

Any idea what could be wrong and how I could debug and fix this situati=
on?

Many thanks in advance,

Gr=E9goire

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
