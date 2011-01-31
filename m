From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: disk thread problem when using RT-kernel
Date: Mon, 31 Jan 2011 13:17:49 -0200
Message-ID: <20110131151749.GH10900@uudg.org>
References: <SNT110-W222DEC20897CB3D9F79E20A8E00@phx.gbl>
 <20110131112346.GD10900@uudg.org>
 <SNT110-W43EA23908D4C70AD72A176A8E20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Victor henri <nadaeck@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61746 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab1AaPYg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 10:24:36 -0500
Received: by vxb37 with SMTP id 37so289725vxb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Jan 2011 07:24:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <SNT110-W43EA23908D4C70AD72A176A8E20@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 31, 2011 at 03:16:37PM +0100, Victor henri wrote:
|=20
| Hello Daniel and Luis
|=20
| =A0-=A0 Yes i'm using the rtirq script;
|=20
| =A0- I'm using the latest version of linuxsampler 1.0.0 (in Gentoo : =
from=20
| pro-audio overlay; in Ubuntu : not in the repositories so I compile i=
t=20
| myself, after taking it on the linuxsampler website); same for libgig=
=20
| (dependency of linuxsampler);

Have you tried running linuxsample at a higher priority? I would try
running it as sched_fifo, priority 60 or 70. You can use 'chrt' to achi=
eve
that.

| =A0- I'll have a look at hwlat_detector; it seems not to be in the
| repositories in Ubuntu; i'll be searching;

hwlat_detector is a kernel module. You just have to load the module and
tweak the values (though IIRC the defaults are sane) and let it run for=
 a
while (at least 2h).

| =A0- regarding the logs=A0 of the USB, how can I do it please? I'm us=
ing an=20
| external USB sound card (a M-Audio Fast Track Pro); the keybord is=20
| connected to the card via midi.

Have a look at /var/log/messages and dmesg and see if anything suspect
catches your eyes :)

Regards,
Luis
--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
