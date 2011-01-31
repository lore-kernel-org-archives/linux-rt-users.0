From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: disk thread problem when using RT-kernel
Date: Mon, 31 Jan 2011 09:23:46 -0200
Message-ID: <20110131112346.GD10900@uudg.org>
References: <SNT110-W222DEC20897CB3D9F79E20A8E00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org, Victor henri <nadaeck@hotmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49131 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab1AaLXx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 06:23:53 -0500
Received: by vws16 with SMTP id 16so1864078vws.19
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Jan 2011 03:23:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <SNT110-W222DEC20897CB3D9F79E20A8E00@phx.gbl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jan 29, 2011 at 10:41:47PM +0100, Victor henri wrote:
=2E..
| Here are some technical details:
| =A0=A0=A0 - I have laptop Asus Core i7 for gamers (supposed to be ver=
y fast);to
| be noted : it also happens on another Asus Core I7, but NOT on an ano=
ther
| Asus Core i3; 4Go RAM;

Have you tried running hwlat_detector? You (hopefully) can find it in y=
our
kernel sources and notes on how to use it at Documentation/hwlat_detect=
or.txt.
In short, you could be seeing long latencies spikes created by SMIs. Th=
at kernel
module, hwlat_detector, may help you identifying them.

The hint about setting the priority of the IRQ threads is also a good o=
ne.
You should also look at the logs of the USB/firewire/whatever you are u=
sing
to commounicate with your keyboard... you may be suffering buffer under=
runs
due to file size or something similar to it.

Luis
--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
