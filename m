From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Markers: multi-probe locking fun (was: Re: [PATCH 0/2] Markers Implementation
 for RCU Tracing - Ver II)
Date: Tue, 19 Feb 2008 17:27:40 +0100
Message-ID: <47BB037C.6060306@siemens.com>
References: <20071231060911.GB6461@in.ibm.com> <20080103163055.GB27651@Krystal> <20080104105858.GA13865@in.ibm.com> <20080105124632.GA16576@Krystal> <20080107195038.GA5119@in.ibm.com> <47B97E63.3070205@siemens.com> <20080218194825.GF10471@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: prasad@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	mingo@elte.hu, Gautham R Shenoy <ego@in.ibm.com>,
	mathieu.desnoyers@polymtl.ca, linux-rt-users@vger.kernel.org,
	dipankar@in.ibm.com
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lizzard.sbs.de ([194.138.37.39]:15406 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbYBSQ2g (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Feb 2008 11:28:36 -0500
In-Reply-To: <20080218194825.GF10471@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Paul E. McKenney wrote:
> On Mon, Feb 18, 2008 at 01:47:31PM +0100, Jan Kiszka wrote:
>> K. Prasad wrote:
>>> Hi Ingo,
>>> 	Please accept these patches into the rt tree which convert the
>>> existing RCU tracing mechanism for Preempt RCU and RCU Boost into
>>> markers.
>>>  
>>> These patches are based upon the 2.6.24-rc5-rt1 kernel tree.
>>>  
>>> Along with marker transition, the RCU Tracing infrastructure has also
>>> been modularised to be built as a kernel module, thereby enabling
>>> runtime changes to the RCU Tracing infrastructure.
>>>  
>>> Patch [1/2] - Patch that converts the Preempt RCU tracing in
>>> rcupreempt.c into markers.
>>>  
>>> Patch [1/2] - Patch that converts the Preempt RCU Boost tracing in
>>> rcupreempt-boost.c into markers.
>>>  
>> I have a technical problem with marker-based RCU tracing: It causes
>> nasty recursions with latest multi-probe marker patches (sorry, no link
>> at hand, can be found in latest LTTng, maybe also already in -mm). Those
>> patches introduce a marker probe trampoline like this:
>>
>> void marker_probe_cb(const struct marker *mdata, void *call_private,
>> 	const char *fmt, ...)
>> {
>> 	va_list args;
>> 	char ptype;
>>
>> 	/*
>> 	 * rcu_read_lock does two things : disabling preemption to make sure the
>> 	 * teardown of the callbacks can be done correctly when they are in
>> 	 * modules and they insure RCU read coherency.
>> 	 */
>> 	rcu_read_lock();
>> 	preempt_disable();
>> 	...
>>
>> Can we do multi-probe with pure preempt_disable/enable protection? I
>> guess it's fine with classic RCU, but what about preemptible RCU? Any
>> suggestion appreciated!
> 
> If you substitute synchronize_sched() for synchronize_rcu(), this should
> work fine.  Of course, this approach would cause RCU tracing to degrade
> latencies somewhat in -rt.
> 
> If tracing is using call_rcu(), we will need to add a call_sched()
> or some such.

You mean something like "#define call_sched call_rcu_classic"?

I just learned that there is another reason for killing
rcu_read_lock&friends from the marker probes: It can deadlock on -rt
with PREEMPT_RCU_BOOST (hit probe inside rq-lock protected region =>
rcu_read_unlock triggers unboost => stuck on rq_lock :( ).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
