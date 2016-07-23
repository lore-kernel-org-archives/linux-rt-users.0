From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: rt8 and virtualbox-dkms
Date: Sat, 23 Jul 2016 02:02:52 +0200
Message-ID: <6b0724e6-de34-9c8c-53d2-c36396c7f237@manjaro.org>
References: <1e93878d-4357-16fc-009e-b01c0efacfc5@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from manjaro.org ([176.9.38.148]:51874 "EHLO manjaro.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbcGWADJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2016 20:03:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by manjaro.org (Postfix) with ESMTP id D1EE430A28A4
	for <linux-rt-users@vger.kernel.org>; Sat, 23 Jul 2016 02:03:06 +0200 (CEST)
Received: from manjaro.org ([127.0.0.1])
	by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnTot1uR+I4w for <linux-rt-users@vger.kernel.org>;
	Sat, 23 Jul 2016 02:02:58 +0200 (CEST)
In-Reply-To: <1e93878d-4357-16fc-009e-b01c0efacfc5@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've investigated a little more into this.
Removing the mod_timer_pinned function - as happened here:

https://lkml.org/lkml/2016/7/4/214

means that VirtualBox module can no longer be built because it still=20
relies on it:

$ grep -re "mod_timer_pinned"
src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:# define=20
mod_timer_pinned               mod_timer
src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:=20
mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,=20
pSubTimer->u.Std.ulNextJiffies);
src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:=20
mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,=20
pSubTimer->u.Std.ulNextJiffies);
src/VBox/Runtime/r0drv/linux/timer-r0drv-linux.c:=20
mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,=20
pSubTimer->u.Std.ulNextJiffies);

So does that mean the rt-kernel will no longer run VirtualBox??

Regards
Bernhard Landauer

On 16/07/16 20:57, Bernhard Landauer wrote:
> Hi everyone and thank you for your awesome work.
> Since recently we are building an rt-kernel for Manjarolinux.
> With the latest rt8 patch we are running into this issue with buildin=
g=20
> the virtualbox-dkms modules:
>
> /var/lib/dkms/vboxhost/5.1.0_OSE/build/vboxdrv/r0drv/linux/timer-r0dr=
v-linux.c:=20
> In function =E2=80=98rtTimerLnxStartSubTimer=E2=80=99:
> /var/lib/dkms/vboxhost/5.1.0_OSE/build/vboxdrv/r0drv/linux/timer-r0dr=
v-linux.c:364:13:=20
> error: implicit declaration of function =E2=80=98mod_timer_pinned=E2=80=
=99 [-$
>              mod_timer_pinned(&pSubTimer->u.Std.LnxTimer,=20
> pSubTimer->u.Std.ulNextJiffies);
>              ^~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:292:=20
> /var/lib/dkms/vboxhost/5.1.0_OSE/build/vboxdrv/r0drv/linux/timer-r0dr=
v-linux.o]=20
> Error 1
> make[1]: *** [scripts/Makefile.build:440:=20
> /var/lib/dkms/vboxhost/5.1.0_OSE/build/vboxdrv] Error 2
> make: *** [Makefile:1429:=20
> _module_/var/lib/dkms/vboxhost/5.1.0_OSE/build] Error 2
> make: Leaving directory '/usr/lib/modules/4.6.4-1-rt8-MANJARO/build'
>
> The issue persists with the very latest virutalbox packages 5.1.0
>
> Any hints will be greatly appreciated.
> kind regards
> Bernhard Landauer
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
