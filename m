From: Victor henri <nadaeck@hotmail.com>
Subject: RE: disk thread problem when using RT-kernel
Date: Mon, 31 Jan 2011 15:16:37 +0100
Message-ID: <SNT110-W43EA23908D4C70AD72A176A8E20@phx.gbl>
References: <SNT110-W222DEC20897CB3D9F79E20A8E00@phx.gbl>,<20110131112346.GD10900@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s11.snt0.hotmail.com ([65.55.90.22]:42447 "EHLO
	snt0-omc1-s11.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab1AaOQh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 09:16:37 -0500
In-Reply-To: <20110131112346.GD10900@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello Daniel and Luis

=A0-=A0 Yes i'm using the rtirq script;

=A0- I'm using the latest version of linuxsampler 1.0.0 (in Gentoo : fr=
om=20
pro-audio overlay; in Ubuntu : not in the repositories so I compile it=20
myself, after taking it on the linuxsampler website); same for libgig=20
(dependency of linuxsampler);

=A0- I'll have a look at hwlat_detector; it seems not to be in the repo=
sitories in Ubuntu; i'll be searching;

=A0- regarding the logs=A0 of the USB, how can I do it please? I'm usin=
g an=20
external USB sound card (a M-Audio Fast Track Pro); the keybord is=20
connected to the card via midi.

Thank you all

Victor

> Date: Mon, 31 Jan 2011 09:23:46 -0200
> From: lclaudio@uudg.org
> To: linux-rt-users@vger.kernel.org; nadaeck@hotmail.com
> Subject: Re: disk thread problem when using RT-kernel
>=20
> On Sat, Jan 29, 2011 at 10:41:47PM +0100, Victor henri wrote:
> ...
> | Here are some technical details:
> | =A0=A0=A0 - I have laptop Asus Core i7 for gamers (supposed to be v=
ery fast);to
> | be noted : it also happens on another Asus Core I7, but NOT on an a=
nother
> | Asus Core i3; 4Go RAM;
>=20
> Have you tried running hwlat_detector? You (hopefully) can find it in=
 your
> kernel sources and notes on how to use it at Documentation/hwlat_dete=
ctor.txt.
> In short, you could be seeing long latencies spikes created by SMIs. =
That kernel
> module, hwlat_detector, may help you identifying them.
>=20
> The hint about setting the priority of the IRQ threads is also a good=
 one.
> You should also look at the logs of the USB/firewire/whatever you are=
 using
> to commounicate with your keyboard... you may be suffering buffer und=
erruns
> due to file size or something similar to it.
>=20
> Luis
> --=20
> [ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
> [ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
