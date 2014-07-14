From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/2] NOCB kthread economization patches
Date: Mon, 14 Jul 2014 04:21:50 -0700
Message-ID: <20140714112149.GA14508@thin>
References: <20140714100604.GA9905@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
	laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org,
	rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
	dvhart@linux.intel.com, fweisbec@gmail.com, oleg@redhat.com,
	sbw@mit.edu, linux-rt-users@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50310 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaGNLWF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jul 2014 07:22:05 -0400
Content-Disposition: inline
In-Reply-To: <20140714100604.GA9905@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 14, 2014 at 03:06:04AM -0700, Paul E. McKenney wrote:
> This series provides a couple of patches that reduce the number of rcuo
> kthreads in cases where nr_cpu_ids is larger than the actual number of
> online CPUs.
> 
> 1.	Preparation patch that rationalizes RCU's creation of early-boot
> 	kthreads.
> 
> 2.	Instead of creation rcuo kthreads for each possible CPU, create
> 	them only for those CPUs that have come online at least once
> 	since boot.

For both:

Reviewed-by: Josh Triplett <josh@joshtriplett.org>
