From: Austin Hendrix <ahendrix@willowgarage.com>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Mon, 16 Jan 2012 17:15:29 -0800
Message-ID: <CAOY97VZbk27gfpb-vV6xrKrj_3jqMP0Q01KUwwA9qjsZNyRCsQ@mail.gmail.com>
References: <4F143AB2.6070404@haw-aw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Matthias_S=F6llner?= <m.soellner@haw-aw.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:55834 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766Ab2AQBPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jan 2012 20:15:30 -0500
Received: by obcva7 with SMTP id va7so5247724obc.19
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2012 17:15:29 -0800 (PST)
In-Reply-To: <4F143AB2.6070404@haw-aw.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It looks like you're using an old version of the realtime kernel, and
the maintainer has neglected to package headers for it. (see:
http://debian.pengutronix.de/debian/pool/contrib/l/linuxrt-latest/ ).
If your CPU will support a 64-bit kernel, I suggest trying one of the
3.0 kernels. It's more likely to have your network driver built in,
and there's a matching linux-headers package if you need it.

-Austin

2012/1/16 Matthias S=F6llner <m.soellner@haw-aw.de>
>
> Hello,
> I installed a RT-Preempt Kernel in Debian 6
> as shown on
> http://pengutronix.de/software/linux-rt/debian_en.html
>
> I have a DELL Precision T1600 with onboard network card and additiona=
l
> PCI network-card.
>
> The onboard card is a Intel=AE 82579LM Gigabit-LAN.
>
> I used linux-image-2.6-rt-686 from Pengutronix APT repository.
>
> Installation worked fine, I can boot my debian with both kernels.
>
> If I boot normal debian kernel i have eth0 and eth1. both cards work =
fine.
>
> But if I boot RT-Preempt-Kernel the =A0internal network card is not s=
hown
> and I only have eth0.
>
> With normal debian kernel intel e1000e driver is loaded.
>
> What can I do to make my internal network card function properly with
> realtime kernel ?
>
>
> I tried to compile the intel network driver myself. But where to I ge=
t
> the right kernel-headers for my RT-Preempt-Kernel?
>
> Any hints?
> Thanks a lot
> Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
