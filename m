From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH documentation 1/2] nohz1: Add documentation.
Date: Thu, 11 Apr 2013 11:27:27 -0700
Message-ID: <20130411182727.GM29861@linux.vnet.ibm.com>
References: <20130411160524.GA30384@linux.vnet.ibm.com>
 <1365696359-30958-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <5166EF74.4030106@linux.intel.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, laijs@cn.fujitsu.com,
	dipankar@in.ibm.com, akpm@linux-foundation.org,
	mathieu.desnoyers@polymtl.ca, josh@joshtriplett.org,
	niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org,
	rostedt@goodmis.org, Valdis.Kletnieks@vt.edu, dhowells@redhat.com,
	edumazet@google.com, darren@dvhart.com, fweisbec@gmail.com,
	sbw@mit.edu, Borislav Petkov <bp@alien8.de>,
	Kevin Hilman <khilman@linaro.org>,
	Christoph Lameter <cl@linux.com>, arnd@arndb.de,
	Robin.Randhawa@arm.com, linux-rt-users@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:42762 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3DKS2B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Apr 2013 14:28:01 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 11 Apr 2013 12:27:59 -0600
Content-Disposition: inline
In-Reply-To: <5166EF74.4030106@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 11, 2013 at 10:14:28AM -0700, Arjan van de Ven wrote:
> >+2.	Many architectures will place dyntick-idle CPUs into deep sleep
> >+	states, which further degrades from-idle transition latencies.
> >+
> I think this part should just be deleted.
> On x86, the deeper idle states are even used with non-tickless system (the break even times are
> quite a bit less than even 1 msec).
> I can't imagine that ARM is worse on this, at which point the statement above is highly dubious

Interesting point, and I freely admit that I don't have full knowledge
of the energy-consumption characteristics of all the architectures that
Linux supports.  Adding a few of the ARM guys on CC for their take,
plus linux-rt-users.

If there are no objections, I will delete point 2 above as Arjan suggests.

							Thanx, Paul

