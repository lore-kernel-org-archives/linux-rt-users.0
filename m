From: Victor henri <nadaeck@hotmail.com>
Subject: RE: disk thread problem when using RT-kernel
Date: Thu, 3 Feb 2011 21:50:07 +0100
Message-ID: <SNT110-W5817A2D3ADD8DC29980D08A8E70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s47.snt0.hotmail.com ([65.54.61.84]:14476 "EHLO
	snt0-omc1-s47.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752173Ab1BCUuI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 15:50:08 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello

I'm back after some testing.... and it is a complete mess; actually the=
re is more than that just problems with linuxsampler.... with every RT =
kernel greater than 2.6.31.12 (i started seeing it on gentoo), i have t=
otal system freeze... after a few minutes.... to the point that i have =
to force shut down the system without proper shutdown (i hate doing tha=
t); i have installed "das-watchdog" and see the pop-up window saying th=
at das watchdog has disabled real-time for 8 seconds... and this pop-up=
 appears every 8 sec... (forever)... everything happen before i have ti=
me to play a single note....
This old problem is coming again... and i've open a new subject=A0 to s=
olve this first

Vic

> Date: Mon, 31 Jan 2011 13:17:49 -0200
> From: lclaudio@uudg.org
> To: nadaeck@hotmail.com
> CC: linux-rt-users@vger.kernel.org
> Subject: Re: disk thread problem when using RT-kernel
>
> On Mon, Jan 31, 2011 at 03:16:37PM +0100, Victor henri wrote:
> |
> | Hello Daniel and Luis
> |
> |  -  Yes i'm using the rtirq script;
> |
> |  - I'm using the latest version of linuxsampler 1.0.0 (in Gentoo : =
from
> | pro-audio overlay; in Ubuntu : not in the repositories so I compile=
 it
> | myself, after taking it on the linuxsampler website); same for libg=
ig
> | (dependency of linuxsampler);
>
> Have you tried running linuxsample at a higher priority? I would try
> running it as sched_fifo, priority 60 or 70. You can use 'chrt' to ac=
hieve
> that.
>
> |  - I'll have a look at hwlat_detector; it seems not to be in the
> | repositories in Ubuntu; i'll be searching;
>
> hwlat_detector is a kernel module. You just have to load the module a=
nd
> tweak the values (though IIRC the defaults are sane) and let it run f=
or a
> while (at least 2h).
>
> |  - regarding the logs  of the USB, how can I do it please? I'm usin=
g an
> | external USB sound card (a M-Audio Fast Track Pro); the keybord is
> | connected to the card via midi.
>
> Have a look at /var/log/messages and dmesg and see if anything suspec=
t
> catches your eyes :)
>
> Regards,
> Luis
> --
> [ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
> [ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
>
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
