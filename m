From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 0/2] Markers Implementation for RCU Tracing - Ver II
Date: Mon, 18 Feb 2008 13:47:31 +0100
Message-ID: <47B97E63.3070205@siemens.com>
References: <20071231060911.GB6461@in.ibm.com> <20080103163055.GB27651@Krystal> <20080104105858.GA13865@in.ibm.com> <20080105124632.GA16576@Krystal> <20080107195038.GA5119@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
	Gautham R Shenoy <ego@in.ibm.com>,
	mathieu.desnoyers@polymtl.ca, linux-rt-users@vger.kernel.org,
	dipankar@in.ibm.com, paulmck@linux.vnet.ibm.com
To: prasad@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gecko.sbs.de ([194.138.37.40]:23724 "EHLO gecko.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755956AbYBRMs2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2008 07:48:28 -0500
In-Reply-To: <20080107195038.GA5119@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

K. Prasad wrote:
> Hi Ingo,
> 	Please accept these patches into the rt tree which convert the
> existing RCU tracing mechanism for Preempt RCU and RCU Boost into
> markers.
>  
> These patches are based upon the 2.6.24-rc5-rt1 kernel tree.
>  
> Along with marker transition, the RCU Tracing infrastructure has also
> been modularised to be built as a kernel module, thereby enabling
> runtime changes to the RCU Tracing infrastructure.
>  
> Patch [1/2] - Patch that converts the Preempt RCU tracing in
> rcupreempt.c into markers.
>  
> Patch [1/2] - Patch that converts the Preempt RCU Boost tracing in
> rcupreempt-boost.c into markers.
>  

I have a technical problem with marker-based RCU tracing: It causes
nasty recursions with latest multi-probe marker patches (sorry, no link
at hand, can be found in latest LTTng, maybe also already in -mm). Those
patches introduce a marker probe trampoline like this:

void marker_probe_cb(const struct marker *mdata, void *call_private,
	const char *fmt, ...)
{
	va_list args;
	char ptype;

	/*
	 * rcu_read_lock does two things : disabling preemption to make sure the
	 * teardown of the callbacks can be done correctly when they are in
	 * modules and they insure RCU read coherency.
	 */
	rcu_read_lock();
	preempt_disable();
	...

Can we do multi-probe with pure preempt_disable/enable protection? I
guess it's fine with classic RCU, but what about preemptible RCU? Any
suggestion appreciated!

Jan

PS: You will run into this issue if you try to marry latest -rt with
latest LTTng. Straightforward workaround is to comment-out any RCU
trace_mark occurrences.

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
