From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 2.6.33-rt4 core2duo oopses:  what method to catch
Date: Mon, 1 Mar 2010 09:38:50 +0100
Message-ID: <20100301083850.GA29952@pengutronix.de>
References: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: ulmo@sonic.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42616 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0CAIiv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 03:38:51 -0500
Content-Disposition: inline
In-Reply-To: <edada484761252d21f1ea67c507f6e98.squirrel@webmail.sonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Sun, Feb 28, 2010 at 03:49:38AM -0800, ulmo@sonic.net wrote:
> I'm getting kernel faults in 2.6.33-rt4 on a core 2 duo.  It takes a
> moment to hard-crash, so there's a chance for the output to be diagno=
sed.=20
> A few questions regarding that:
>=20
> Please point me the way to best get the diagnostic data (kernel trace=
).
>=20
> There used to be utilities to use System.map to give names to traces =
(like
> sysklogd).  There also used to be a built-in method for System.map so=
 the
> kernel could do that.  What's the option?  What are my options?  I
> currently use metalog for the syslog daemon.
I don't know if this is what you mean, but KALLSYMS (General setup ->
Configure standard kernel features -> Load all symbols for
debugging/ksymoops) and its subitems should be helpful.

> What's the easiest way to write the oops to disk while in the initrd?=
  I'm
> getting the oopses while it's doing reiserfsck, and I only have a bit=
 of
> room in /boot to stick some output.  Is there a way to log to /boot t=
he
> oopses, with some small initrd-fitting binary that will cull kernel
> logging for those and write them out?  Just a standard logger?
If you get an oops, the best way to catch it is via a serial console.
Then you can just copy&paste from another machine.

Best regards,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
