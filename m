From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Date: Thu, 25 Oct 2007 09:55:30 +1000
Message-ID: <18207.56178.634571.444117@cargo.ozlabs.ibm.com>
References: <20070921032603.0D3EA32C887@thor>
	<4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161C38.2070305@ru.mvista.com>
	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>
	<471777BD.8090800@ru.mvista.com>
	<18200.3600.459275.823335@cargo.ozlabs.ibm.com>
	<47189EF3.7010103@ru.mvista.com>
	<18200.42194.853246.935329@cargo.ozlabs.ibm.com>
	<4718B287.20306@ru.mvista.com>
	<471F358D.7070300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38769 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbXJYAJ0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 20:09:26 -0400
In-Reply-To: <471F358D.7070300@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sergei Shtylyov writes:

>     I've just realized that I've missed the call to account_process_time() in 
> the new timer_interrupt(). :-<

Which is bogus.  I had removed it in the version of the patch that I
posted in early September, but apparently it crept back in.

>     Anyway, this leads to each tick being accounted twice if the deterministic 
> accounting is not enabled -- first by timer_interrupt() and then by the 
> hrtimers core, doesn't it?

Yep.

Actually, I thought I was told that with CFS, the total process time
was accounted accurately using sched_clock(), then apportioned between
utime and stime (using counts of ticks in user/system state, which are
somewhat inaccurate).  At the time I thought that would be OK, but now
I'm not so sure.

Paul.
