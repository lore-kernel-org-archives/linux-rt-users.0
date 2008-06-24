From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: 2.6.25.8-rt7
Date: Tue, 24 Jun 2008 16:46:07 +0200
Message-ID: <200806241646.08335.jbe@pengutronix.de>
References: <4860CD0B0200005A0003944C@sinclair.provo.novell.com> <4860CD140200005A0003944F@sinclair.provo.novell.com> <4860CD140200005A0003944F@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gregory Haskins" <GHaskins@novell.com>, mingo@elte.hu,
	rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:44973 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757833AbYFXOqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 10:46:22 -0400
In-Reply-To: <4860CD140200005A0003944F@sinclair.provo.novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 24 June 2008 16:31, Gregory Haskins wrote:
> I believe this is my fault.  You must be building for uniprocessor?  =
Ingo
> has a fix for this issue in sched-devel that should be pulled into -r=
t.

I can avoid this failure, when I disable the "Group scheduling for=20
SCHED_RR/FIFO" menu entry. Don't know the impact.

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
