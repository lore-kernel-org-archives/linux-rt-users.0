From: Juergen Borleis <jbe@pengutronix.de>
Subject: Re: PowerPC: massive "scheduling while atomic" reports
Date: Tue, 15 Sep 2015 10:53:15 +0200
Message-ID: <201509151053.16563.jbe@pengutronix.de>
References: <201509101106.56931.jbe@pengutronix.de> <alpine.DEB.2.11.1509142235440.3971@nanos>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56434 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbbIOIxD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2015 04:53:03 -0400
In-Reply-To: <alpine.DEB.2.11.1509142235440.3971@nanos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

On Tuesday 15 September 2015 00:05:31 Thomas Gleixner wrote:
> Please CC lkml on bug reports for RT.

Okay.

> > When running the system at least every other boot this kernel spits=
 out
> > massive "scheduling while atomic" reports.
>
> I doubt that this only happens on every other boot. This is a
> systematic failure.

That was one of the confusing things: we booted the machine and got a b=
unch=20
off "scheduling while atomic" reports and we re-booted it and it was si=
lent.=20
That's why we thought it might be a race instead of a systematic failur=
e.

> [...]
> If you encounter such a 'confusing' problem the next time, then look
> out for commonalities, AKA patterns. 99% of all problems can be
> decoded via patterns. And if you look at the other call chains you'll
> find more instances of those pte_*_lock() calls, which all end up in
> kmap_atomic().

Sounds easy. But we stared with two developers on the code and the bug =
traces=20
and were lost in the code. Seems you are in a pole position due to your=
=20
experience with the RT preempt code.

The good news: I tried your suggested change on my system and reboot it=
 again=20
and again since an hour now and no more "scheduling while atomic" repor=
ts=20
occur. \o/

Thank you very much
Juergen

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| htt=
p://www.pengutronix.de/ =A0|
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
