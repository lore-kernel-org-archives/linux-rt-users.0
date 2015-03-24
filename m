From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Tue, 24 Mar 2015 19:15:20 +0100
Message-ID: <20150324181520.GE1321@linutronix.de>
References: <20150317163541.080310081@goodmis.org>
 <20150317163617.218582800@goodmis.org>
 <20150317163551.3093b6c2@gandalf.local.home>
 <1426753029.4168.80.camel@gmail.com>
 <20150319122611.0d002d48@gandalf.local.home>
 <550AFC6A.4050901@hp.com>
 <1426960943.4677.34.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48408 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbCXSPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Mar 2015 14:15:25 -0400
Content-Disposition: inline
In-Reply-To: <1426960943.4677.34.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2015-03-21 19:02:23 [+0100]:

>> Steve, I'm still working on the fix we discussed using dummy irq_tas=
k.
>> I should be able to submit some time next week, if still interested.
>>=20
>> Either that, or I think we should remove the function
>> spin_do_trylock_in_interrupt() to prevent any possibility of running
>> into similar problems in the future.
>
>Why can't we just Let swapper be the owner when in irq with no dummy?

so you abuse the owner to be swapper and mask it out everywhere. It doe=
s
not look like a final solution. I'm more inclined to take you other
patch. In the end I hope we get a timer re-work and do not need any
hackary around it=E2=80=A6

>I have "don't raise timer unconditionally" re-applied, the check for a
>running callback bits of my nohz_full fixlet, and the below on top of
>that, and all _seems_ well.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
