From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: hrtimer problem on AT91RM9200
Date: Thu, 10 Sep 2009 11:51:28 +0200
Message-ID: <20090910095128.GA1967@pengutronix.de>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>, Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43601 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZIJJvr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2009 05:51:47 -0400
Content-Disposition: inline
In-Reply-To: <4AA8A03B.2050804@newtec.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Bo,

On Thu, Sep 10, 2009 at 08:44:11AM +0200, Bo Hansen wrote:
> Hi Uwe,
>
> Sorry for my late reply.
>
> I only get the initialization line:
> ************** at91rm9200_timer_init: shift=3D32, mult=3D140737,
> min_delta_ns=3D61036, minclc=3D2 =20
OK, that corresponds to my calculation.

Strange, with my patch lr is at rt_mutex_unlock in the oops, before it
was at clockevents_program_event.  I don't understand that.
Can you try changing the pr_info to pr_emerg?
If that doesn't help, do you have CONFIG_DEBUG_LL available?  If so can
you change the pr_info (now pr_emerg) to something like:

	void printch(char);
	void printhex8(unsigned);
	void printascii(const char *);
	printascii("**************");
	printhex8(dev->shift);
	printch(':');
	printhex8(dev->mult);
	printch(':');
	printhex8(dev->min_delta_ns);
	printch('\n');

and enable CONFIG_DEBUG_LL of course?

jstultz, tglx: there shouldn't be anything that fiddles around with
shift, mult and min_delta, should it?  (Well, increasing min_delta is
OK.)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
