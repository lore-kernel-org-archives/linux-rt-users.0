From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Fri, 19 Oct 2007 10:14:54 +1000
Message-ID: <18199.63230.583536.307945@cargo.ozlabs.ibm.com>
References: <20070921032603.0D3EA32C887@thor>
	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161D79.6000003@ru.mvista.com>
	<18198.43687.44059.477047@cargo.ozlabs.ibm.com>
	<47177229.2030200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:58882 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbXJSAPB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 20:15:01 -0400
In-Reply-To: <47177229.2030200@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergei Shtylyov writes:

> > What problem do you see arising from this?
> 
>     Timers firing too early.

Only if the minimum interrupt latency is less than 1 decrementer
tick.  That seems pretty unlikely to me unless you have a very slow
timebase frequency.

In fact what we should program the decrementer to is:

	timeout - (is_booke? 0: 1) - min_interrupt_latency

I was assuming that min_interrupt_latency (measured in timebase ticks)
would be at least 1, but apparently some systems can have a timebase
frequency as low as 1kHz, so we'll have to have an ifdef or something.

Paul.
