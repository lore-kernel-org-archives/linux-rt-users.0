From: Don Estabrook <don.estabrook@gmail.com>
Subject: Fedora 20 RT hangs during suspend
Date: Thu, 23 Jan 2014 00:27:06 -0600
Message-ID: <CABB1KXppwfeZ6ARsRB4qqi--63RpMjQW-fBoWrTbpXyPuEOi4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44465 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaAWG1r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Jan 2014 01:27:47 -0500
Received: by mail-oa0-f49.google.com with SMTP id i7so1667457oag.36
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Jan 2014 22:27:47 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello -

On my HP Elitebook 8540w laptop (Intel i7 @ 2.67 GHz, 8 GiB RAM,
nouveau nVidia driver),
I've found that the Planet CCRMA kernels

    3.12.5-302.rt7.1.fc20.ccrma.x86_64
    3.12.6-300.rt9.1.fc20.ccrma.x86_64

seem to run fine - until I try to suspend, which causes the computer
to freeze, requiring a hard power-off to reboot.  I'm able to suspend
and resume fine with the stock F20 kernel - currently
3.12.7-300.fc20.x86_64.  Fernando Lopez-Lezcano suggested I post my
result here.

Visible behaviour: Using the GUI method in KDE (f > Leave > Sleep),
the screen lock comes on, then it switches to console mode, I see a
small number of kernel messages, and very quickly the screen shuts off
-- all good -- but then nothing more happens.  The keyboard LEDs and
fan continue to run for as long as I had patience to wait (~30 min in
one case).  I also tried "pm-suspend" from console mode (run level 3),
to see if it might either behave differently or give some more clues,
but it ends up the same.

This is an excerpt from the end of journalctl output (after
re-booting, looking at the previous boot):

> Jan 17 14:25:43 systemd[1]: Starting Network Manager Script Dispatcher Service...
> Jan 17 14:25:43 dbus-daemon[963]: dbus[963]: [system] Successfully activated service 'org.freedesktop.nm_dispatcher'
> Jan 17 14:25:43 dbus[963]: [system] Successfully activated service 'org.freedesktop.nm_dispatcher'
> Jan 17 14:25:43 systemd[1]: Started Network Manager Script Dispatcher Service.
> Jan 17 14:25:43 chronyd[975]: Can't synchronise: no reachable sources
> Jan 17 14:25:47 systemd-logind[962]: Delay lock is active but inhibitor timeout is reached.
> Jan 17 14:25:47 systemd[1]: Starting Sleep.
> Jan 17 14:25:47 systemd[1]: Reached target Sleep.
> Jan 17 14:25:47 systemd[1]: Starting Suspend...
> Jan 17 14:25:47 systemd-sleep[9388]: Suspending system...

I'd be happy to provide more information if needed - please advise if
full journalctl output and/or other logs would be useful.


It may not be relevant, but these RT kernels also throw warnings with
backtraces during boot-up, like these (again from journalctl) :

> kernel: WARNING: CPU: 2 PID: 858 at kernel/sched/core.c:2428 migrate_disable+0xed/0x100()

> kernel: WARNING: CPU: 2 PID: 858 at kernel/sched/core.c:2462 migrate_enable+0x17b/0x200()

> kernel: WARNING: CPU: 3 PID: 865 at kernel/sched/core.c:2428 migrate_disable+0xed/0x100()

I don't seem to see those issues when I look at previous boots using
the stock kernel.

Thanks,
Don
