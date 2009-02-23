From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Mon, 23 Feb 2009 21:46:56 +0100
Message-ID: <20090223204656.GO5367@pengutronix.de>
References: <49A1BA49.7060308@gmail.com> <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com> <49A1D930.4010600@gmail.com> <20090223124016.GH5367@pengutronix.de> <49A2CD10.4080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Lukasz Majewski <majess1982@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45555 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZBWUq7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 15:46:59 -0500
Content-Disposition: inline
In-Reply-To: <49A2CD10.4080605@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Lukasz,

On Mon, Feb 23, 2009 at 05:21:36PM +0100, Lukasz Majewski wrote:
> I'm building toolchain for AT572D940HF Atmel chip. It's ARM9 combined
> with DSP. I'd like to build toolchain for ARM9 (ARMv5tej) with
> -msoft-float support, EABI and full glibc ,to support all stuff
> connected with PREEMPT_RT patch - especially librt.

Ok.

> Now I've downloaded:
> ptxdist-1.99.11 and ptxdist-1.99.11-patches.

yup

> and
> OSELAS.Toolchain-1.99.3

exactly

> I've selected
> ./ptxconfigs/arm-v5te-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized
>
> I need toolchain with -msoft-float support and EABI.

The toolchain you've selected above actually is softfloat and EABI. You
don't have to change anything, just do the steps you've mentioned above
and 'ptxdist go'.

> Unfortunately there is an error about mismatch in the linux-kernel
> headers.

Please send the exact error message (if too long, please off-list, to me
and "Marc Kleine-Budde <m.kleine-budde@pengutronix.de>").

> My Host PC has linux-kernel of 2.6.24 and not 2.6.27.

That's no problem; the toolchain you are trying to build is based on the
2.6.27 sanitized kernel headers. It's usually no problem at all using
such a toolchain on a variety of other kernel versions.

> My target is working under 2.6.26.8-rt14 kernel.

Should work.

> The error is in building of NTPL library, after successfully compilation
> of gcc compiler.
>
> How can I provide proper kernel headers?

See above, error messages, please.

> Now I'm trying with
> arm-v5te-linux-gnueabi-gcc-4.1.2-glibc-2.5-binutils-2.17-kernel-2.6.18
> ptxconfig. I hope that this will be sufficiently new to provide priority
> inheritance, futexes , librt with all features.

Yes, it is.

> I'm building it now and hope that I won't encounter any problems.

You may want to check that we have an update for 1.99.3 here:
http://www.pengutronix.de/oselas/toolchain/download/OSELAS.Toolchain-1.99.3.1.tar.bz2

There has been a build error on some distros and it might happen that
you are seeing exactly this issue.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
