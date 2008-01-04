From: Gautham R Shenoy <ego@in.ibm.com>
Subject: __get_cpu_var() called from a preempt-unsafe context in
	__rcu_preempt_unboost() ?
Date: Fri, 4 Jan 2008 17:39:05 +0530
Message-ID: <20080104120905.GA15640@in.ibm.com>
References: <20071231060911.GB6461@in.ibm.com> <20080103163055.GB27651@Krystal>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "K. Prasad" <prasad@linux.vnet.ibm.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	dipankar@in.ibm.com,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Paul E McKenney <paulmck@us.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7]:45613 "EHLO
	e28esmtp07.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751225AbYADMJY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Jan 2008 07:09:24 -0500
Content-Disposition: inline
In-Reply-To: <20080103163055.GB27651@Krystal>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul, Steve,  

This is with reference to the preemptible rcu implementation in
2.6.24-rc5-rt1.

In __rcu_read_unlock(), we call __rcu_preempt_unboost() to unboost a
task's priority which had been bumped up when it was preempted out
while the rcu_read section.

The code path is as follows

__rcu_read_unlock()
	|
	|--> local_irq_restore(oldirq);
	|
	|--> __rcu_preempt_unboost();
		|
		|--> rcu_trace_boost_unboost_called(RCU_BOOST_ME)


where RCU_BOOST_ME is #defined as &__get_cpu_var(rcu_boost_data).

Is calling __get_cpu_var() safe in this context, since we've already
enabled the local interrupts and we're not in a preempt_disabled() ?

Thanks and Regards
gautham.

-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
