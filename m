From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: debian RT kernel
Date: Sat, 30 May 2015 23:07:31 +0300
Message-ID: <556A1883.8090006@pavlinux.ru>
References: <7f79-55642000-25-50abc380@46760505>	 <1432681902.6319.10.camel@decadent.org.uk>	 <CAG_ZyaArK3knBuCqM68AdjqO_iVUySUZYAa546i9eje9hwJaJA@mail.gmail.com> <1433014732.6319.65.camel@decadent.org.uk>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Braud Caroline <Caroline.Braud@univ-lille1.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>,
	=?UTF-8?B?SmFyb23DrXIgTWlrZcWh?= <mira.mikes@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:60803 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757707AbbE3UIW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 May 2015 16:08:22 -0400
In-Reply-To: <1433014732.6319.65.camel@decadent.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

30.05.2015 22:38, Ben Hutchings =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

>>> I uploaded a new linux package (version 4.0.4-1) to unstable earlie=
r
>>> today with the PREEMPT_RT patchset included, so you could also just=
 wait
>>> a day for it to hit the mirrors.
>>
>> Why we don't have linux-image-rt-amd64 but just linux-image-rt-686-p=
ae?
>
> The build broke on amd64; it will be fixed in the next upload.

My config http://pastebin.com/GcbQf6gK

$ cat /proc/cmdline
root=3D/dev/sda2 ro quiet vga=3D0 noapg pci=3Drouteirq nmi_watchdog=3D0=
 iommu=3Dnoagp=20
clocksource=3Dhpet workqueue.power_efficient=3D0 hpet=3Dforce processor=
=2Emax_cstate=3D1


~$ uname -a
Linux amd64 4.0.4-rt1+ #1 SMP PREEMPT RT Thu May 28 19:20:20 MSK 2015 x=
86_64=20
GNU/Linux

~$ cat /etc/debian_version
8.0

~$ grep 'model name' /proc/cpuinfo | uniq
model name      : AMD Opteron(tm) Processor 4386

Motherboard: Tyan s8225

--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
