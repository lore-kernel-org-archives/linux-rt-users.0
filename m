From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt1
Date: Sat, 23 Jul 2011 09:31:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107230930330.2702@ionos>
References: <alpine.LFD.2.02.1107222203400.2702@ionos> <CABcS5h01jpOSKcKtrJ65AqNNQDCAOutQADAE_pcRp-MPBoO-VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Rolando Martins <rolando.martins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52123 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab1GWHbf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 03:31:35 -0400
In-Reply-To: <CABcS5h01jpOSKcKtrJ65AqNNQDCAOutQADAE_pcRp-MPBoO-VA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Jul 2011, Rolando Martins wrote:

> Thanks for the great work!
> 
> Is it possible to have RT_GROUP_SCHED and PREEMPT_RT_FULL?

Not at the momenent. RT_GROUP_SCHED depends on !PREEMPT_RT_FULL
because it leads to yet undebugged hangs and failures.

Thanks,

	tglx
