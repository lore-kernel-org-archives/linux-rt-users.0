From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2 Resend 0/4] Create sched_select_cpu() and use it for
 workqueues and timers
Date: Mon, 26 Nov 2012 12:35:52 -0500
Message-ID: <1353951352.6276.43.camel@gandalf.local.home>
References: <cover.1352196505.git.viresh.kumar@linaro.org>
	 <CAKohponTxs983vVQV=6Q8zyesC1W1FhFkzfmpAVeEwU-cQXohA@mail.gmail.com>
	 <1353948027.6276.38.camel@gandalf.local.home>
	 <20121126170358.GE2474@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar@linaro.org>, pjt@google.com,
	paul.mckenney@linaro.org, tglx@linutronix.de, tj@kernel.org,
	suresh.b.siddha@intel.com, venki@google.com, mingo@redhat.com,
	peterz@infradead.org, Arvind.Chauhan@arm.com,
	linaro-dev@lists.linaro.org, patches@linaro.org,
	pdsw-power-team@arm.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:12240 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933715Ab2KZRfy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Nov 2012 12:35:54 -0500
In-Reply-To: <20121126170358.GE2474@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-11-26 at 09:03 -0800, Paul E. McKenney wrote:


> If I understand correctly (though also suffering turkey OD), the idea is
> to offload work to more energy-efficient CPUs.

This is determined by a CPU that isn't running the idle task? Is it
because a CPU that just woke up may be running at a lower freq, and thus
not as efficient? But pushing off to another CPU may cause cache misses
as well. Wouldn't that also be a factor in efficiencies, if a CPU is
stalled waiting for memory to be loaded?

I should also ask the obvious. Has these patches shown real world
efficiencies or is this just a theory? Do these patches actually improve
battery life when applied?

Just asking.

-- Steve


