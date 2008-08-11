From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] BUG: using smp_processor_id() in preemptible
 [00000000] code: caller is __qdisc_run
Date: Mon, 11 Aug 2008 14:00:14 -0700 (PDT)
Message-ID: <20080811.140014.94581847.davem@davemloft.net>
References: <520f0cf10808110611y62f6a4e2v94a0d0cde1d5d79d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu, tglx@linutronix.de, rostedt@goodmis.org,
	a.p.zijlstra@chello.nl
To: jkacur@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39272
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751966AbYHKVAN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Aug 2008 17:00:13 -0400
In-Reply-To: <520f0cf10808110611y62f6a4e2v94a0d0cde1d5d79d@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "John Kacur" <jkacur@gmail.com>
Date: Mon, 11 Aug 2008 15:11:46 +0200

> __qdisc_run() calls qdisc_restart() which calls
> handle_dev_cpu_collision(skb, dev, q); and then the problem shows up
> here:
> __get_cpu_var(netdev_rx_stat).cpu_collision++;
> 
> The solution is to disable interrupts around the above increment. Here
> is an attached patch to do so. (Thank's to Peter Zijlstra for help in
> the analysis and dropping the answer in my lap, so if I got it right
> it is due to his help, but if I messed it up, then I did that part all
> by myself.)

__qdisc_run() always runs in software interrupt context,
so I guess this is some problem with the -rt stuff running
software interrupts in threads?
