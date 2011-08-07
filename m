From: Andrey Gursky <andrey.gursky@e-mail.ua>
Subject: Mitigation of license for the symbol __rt_mutex_init and more
Date: Mon, 8 Aug 2011 01:10:22 +0200
Message-ID: <CABg52H=D6vGam6W-0EqFFuSVh8LA5ouaYHv0wknVYzY0G0hh6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36452 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab1HGXKX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Aug 2011 19:10:23 -0400
Received: by ywn13 with SMTP id 13so2410971ywn.19
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Aug 2011 16:10:23 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

Since coming of the linux-3.0-rt patch I've decided to try to switch
to that kernel, especially the goal of the RT_PREEMPT claims to make a
desktop kernel become a realtime one. Thanks to all rt-developers for
this opportunity!

I'm testing it on 3 platforms:
1) notebook Core2Duo T7250,
2) old Pentium 4 3.2 GHz with an old passive ISDN hisax-card,
3) even older AthlonXP 2.8 GHz with TV-tuner.

The first desktop problem is:
the symbol __rt_mutex_init is exported as GPL-only. This make the
usage of proprietary nvidia driver impossible, while the normal
__mutex_init is not only GPL. Could you change the license also for
the rt_mutex_init (...and maybe few more if they being linked with
nvidia/ati(?) driver just as with the vanilla "desktop" kernel)?

The next issue is more complicated. On the P4 (platform 2) I use an
ISDN-hisax modem card and per-second internet account. After a timeout
the connection is being hung up. In firefox I have a lot of tabs. Some
web pages are "active". They try to call back on their own. While this
is happening my gnome freezes sometimes. SysRq-R helps sometimes to
switch back to the console. But the gdm doesn't start anymore. Is this
a relevant issue for the rt-project? What'd be the first place to look
at to debug this behavior?

Regards,
Andrey
