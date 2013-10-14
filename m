From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: All 3.10.x rt patched kernels are unusable on my machine
Date: Mon, 14 Oct 2013 12:36:05 +0200
Message-ID: <1381746965.3978.27.camel@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail234c50.megamailservers.eu ([91.136.10.244]:53321 "EHLO
	mail37c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756406Ab3JNKsS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Oct 2013 06:48:18 -0400
Received: from [85.182.18.195] (e182018195.adsl.alicedsl.de [85.182.18.195])
	(authenticated bits=0)
	by mail37c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id r9EAa5HQ020763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Oct 2013 10:36:09 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

non of the 3.10.x rt patched kernels does work on my machine.

$ ls /usr/src/pkg-linux-rt/linux-rt-3*
/usr/src/pkg-linux-rt/linux-rt-3.10.10_rt7-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.10.14_rt9-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.10.15_rt11-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.10.6_rt3-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.10.9_rt5-01-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.11_rt8-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt10-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt11-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt12-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt13-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt14-1-x86_64.pkg.tar.xz
/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt9-1-x86_64.pkg.tar.xz

It's not only on my main install, Arch Linux 64-bit architecture, I
verified the issue by building a 3.10.x rt patched kernel for Ubuntu
64-bit architecture too.

$ ls /mnt/q/boot/vmlinuz*
/mnt/q/boot/vmlinuz-3.10.9-rt5  /mnt/q/boot/vmlinuz-3.5.0-18-lowlatency  /mnt/q/boot/vmlinuz-3.6.5-rt14

There were no issues without the rt patch for 3.10 kernels and no issues
with kernel versions < 3.10.x with and without rt patch.

Usually login doesn't work from lightdm, sometimes it does work, but
after a short while terminals hang and the prompt gets lost, switching
to tty by Ctrl + Alt + F-keys then doesn't work.

Last time I could login, I got

$ cat .xsession-errors.rt11
find: `/home/rocketmouse/.Xauthority.??????': No such file or directory
weather-Message: getting
http://api.yr.no/weatherapi/locationforecastlts/1.1/?lat=51.466702;lon=6.850000;msl=38
PolicyKit daemon disconnected from the bus.
We are no longer a registered authentication agent.
xfce4-appfinder: Fatal IO error 11 (Resource temporarily unavailable) on
X server :0.0.

Any info needed about my hardware, from journalctl the kernel's config
or something else?

Regards,
Ralf

