From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.10-rt1 not compiling
Date: Mon, 12 Aug 2013 17:22:33 +0200
Message-ID: <5208FDB9.3060801@linutronix.de>
References: <loom.20130809T204344-6@post.gmane.org> <20130812114447.GE23040@linutronix.de> <004601ce976e$8889ebe0$999dc3a0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Matthew Henschel <henschel@capaccess.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44732 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798Ab3HLPWf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 11:22:35 -0400
In-Reply-To: <004601ce976e$8889ebe0$999dc3a0$@org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/12/2013 05:13 PM, Matthew Henschel wrote:
> Sebastian--

Hi Matthew,

> 	Same config as before, in fact, copied it from my original email, ra=
n it through fromdos, and:

=E2=80=A6

> kernel/built-in.o: In function `__tick_nohz_idle_enter':
> tick-sched.c:(.text+0x40db8): undefined reference to `softirq_check_p=
ending_idle'
> make: *** [vmlinux] Error 1

Hmm. I'm cooking v3.10.6-rt3 right now. If you see it there as well
please gimme a ping and take another look. As of now I assume that the
issue is gone somewhere between -rt1 and -rt3.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
