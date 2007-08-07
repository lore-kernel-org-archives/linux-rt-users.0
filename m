From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/4 RFC] RCU: preemptible RCU
Date: Tue, 07 Aug 2007 21:18:29 +0200
Message-ID: <1186514309.11797.171.camel@lappy>
References: <20070807183946.GA32110@linux.vnet.ibm.com>
	 <20070807184812.GC10068@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, akpm@linux-foundation.org, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:33440 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbXHGTTM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 15:19:12 -0400
In-Reply-To: <20070807184812.GC10068@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-08-07 at 11:48 -0700, Paul E. McKenney wrote:
> This patch implements a new version of RCU which allows its read-side
> critical sections to be preempted. It uses a set of counter pairs
> to keep track of the read-side critical sections and flips them
> when all tasks exit read-side critical section. The details
> of this implementation can be found in this paper -
> 
> http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf
> 
> This patch was developed as a part of the -rt kernel development and
> meant to provide better latencies when read-side critical sections of
> RCU don't disable preemption.  As a consequence of keeping track of RCU
> readers, the readers have a slight overhead (optimizations in the paper).
> This implementation co-exists with the "classic" RCU implementations
> and can be switched to at compiler.
> 
> Also includes RCU tracing summarized in debugfs and RCU_SOFTIRQ for
> the preemptible variant of RCU.

Whickedly complex but very cool stuff!

Unfortunately I have nothing to contribute other than praise at the
complex yet elegant way you dodged the need for synchronisation.
