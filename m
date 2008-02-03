From: "Uli Brueggemann" <uli.brueggemann@gmail.com>
Subject: Re: 2.6.24-rt1 SSttrraannggee keyboard behaviour
Date: Sun, 3 Feb 2008 17:45:18 +0100
Message-ID: <10a58eee0802030845m48a9d04cr3bde73966014cb56@mail.gmail.com>
References: <10a58eee0802010706s65929d0dte10a4cde35df317f@mail.gmail.com>
	 <47A346C3.8070308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:7478 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbYBCQpT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 Feb 2008 11:45:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2375006wah.23
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Feb 2008 08:45:18 -0800 (PST)
In-Reply-To: <47A346C3.8070308@redhat.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>
> I've seen this behavior before; on my system in addition to the doubled keystrokes,
> cursor animations were jerky.
>
> Are you running on a 64-bit kernel, is your clocksource hpet and is vsyscall64 on?
>
> $ uname -m
> x86_64
> $ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> hpet
> $ cat /proc/sys/kernel/vsyscall64
> 1
>
> If so, try putting this into your /etc/sysctl.conf and rebooting:
>
> # vsyscall64 off
> kernel.vsyscall64 = 0
>


Kernel is i686 (32bit), clocksource is tsc and vsyscall64 does not exist.
Only console, no X.

In the meantime I have further tried to detect a possible reason and I
guess I kow it now. But I do not know how to overcome:

The system is booted from USB memorystick. The keyboard is a USB
keyboard. And there is an IMON VFD display connected by USB. To use it
I run the lcdproc package.
It seems that the LCDd daemon (with imon_pad driver) is the reason. It
causes problems with the keyboard (as described in the topic) and also
with access to the memorystick.
If I use a PS/2 keyboard the keyboard problem does not occur. But
after a while the system still gives messages like

usb 5-3: reset high speed USB device using ehci_hcd and adress 3
usb 5-3: device not accepting adress 3, error -10

If I do not start LCDd then both keyboard and memorystick access keep stable.

So I suppose that updating the VFD display by LCDd via the USB
interface is the problem. But this is happening now the first time
with use of 2.6.24-rt1.
So avoiding LCDd helps but I like to use the VFD display. How to solve?

BTW I have noticed another effect: with a PS/2 keyboard the screen
switches off after some time of non-use (screensaver?). With an USB
keyboard the screen never switches off.

If someone can comment helpfully I would be happy.

Best

Uli
