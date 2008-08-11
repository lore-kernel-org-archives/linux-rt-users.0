From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: 2.6.26-rt1
Date: Mon, 11 Aug 2008 10:36:36 +0200
Message-ID: <200808111036.37998.jbe@pengutronix.de>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Carsten Emde <ce@ceag.ch>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56002 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189AbYHKIgt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2008 04:36:49 -0400
In-Reply-To: <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When CONFIG_GROUP_SCHED is enabled this compile error is back.

[...]
  CC      mm/bootmem.o
In file included from kernel/sched.c:1618:
kernel/sched_rt.c: In function 'inc_rt_tasks':
kernel/sched_rt.c:408: error: 'struct rq' has no member named 'online'

jbe
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
