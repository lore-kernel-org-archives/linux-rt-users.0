From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Fri, 1 Jul 2016 12:49:26 +0200
Message-ID: <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jens Koehler <jenskxxx@googlemail.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50949 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcGALJ7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Jul 2016 07:09:59 -0400
In-Reply-To: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/13/2016 11:16 AM, Jens Koehler wrote:
> I found now out that the problem with RT throttling could happen when
> my application sends UDP broadcasts (and receive its own broadcast).
> 
> Is this an already known problem?

Not to my knowledge. Could you please send a (small) testcase and your
kernel config? I then would take look a check how serious it is :)

> [137482.258011] hrtimer: interrupt took 9434 ns
> [178458.961966] NOHZ: local_softirq_pending 102
> [178458.967583] NOHZ: local_softirq_pending 102
> [178458.973295] NOHZ: local_softirq_pending 102
> [178458.980249] NOHZ: local_softirq_pending 102
> [178458.984994] NOHZ: local_softirq_pending 102
> [178458.990582] NOHZ: local_softirq_pending 102
> [178458.996292] NOHZ: local_softirq_pending 102
> [178459.000348] [sched_delayed] sched: RT throttling activated
> 
> Jens
> 
Sebastian
