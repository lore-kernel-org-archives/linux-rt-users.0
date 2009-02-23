From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [linux-2.6.26.8-rt14] RT Page Fault.
Date: Mon, 23 Feb 2009 13:40:16 +0100
Message-ID: <20090223124016.GH5367@pengutronix.de>
References: <49A1BA49.7060308@gmail.com> <3efb10970902221329h89b18cbl60c8d3365009e2d9@mail.gmail.com> <49A1D930.4010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Remy Bohmer <linux@bohmer.net>, linux-rt-users@vger.kernel.org
To: Lukasz Majewski <majess1982@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47202 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbZBWMkV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 07:40:21 -0500
Content-Disposition: inline
In-Reply-To: <49A1D930.4010600@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 23, 2009 at 12:01:04AM +0100, Lukasz Majewski wrote:
> Now some explanation about uClibc. I know that this C library lacks of
> many features (for instance NTPL support for ARM). Unfortunately, for
> ARM architecture, there is nice utility -> buildroot  for building
> toolchain and  root filesystems.

You can use ptxdist do do almost the same.

> I've tried pxtdist tool from pengutronix.de, but I cannot build proper
> toolchain without errors for my Atmel's ARM9 device (ARMv5tej arch to be
> precise). Or saying it in another way -> I gave up after spending some
> time and moved back toward working uClibc.

Well, you could have reported that to the OSELAS.Toolchain maintainers :)

What kind of problem do you see? We are using the the v5te toolchain
quite intensively on AT91SAM9260 and AT91SAM9263 without problems.

So send us your error output and let's see what we can do. The ptxdist
mailing list is probably the right list for that kind of discussion.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
