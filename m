From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: 2.6.25.8-rt7
Date: Tue, 24 Jun 2008 16:54:58 +0200
Message-ID: <200806241654.58857.jbe@pengutronix.de>
References: <1214271257.8701.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45225 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756607AbYFXOzE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 10:55:04 -0400
In-Reply-To: <1214271257.8701.17.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 24 June 2008 03:34, Steven Rostedt wrote:
>   http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/patch-2.6.25.8.bz2
>   http://rt.et.redhat.com/download/patch-2.6.25.8-rt7.bz2

And for ARM I get a bunch of these warnings:

[...]
include/asm/atomic.h:241:1: warning: "cmpxchg" redefined
[...]
include/asm-generic/cmpxchg.h:19:1: warning: this is the location of th=
e previous definition
[...]


Can I ignore them?

Juergen
--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
