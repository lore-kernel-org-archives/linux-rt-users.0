From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/6] RCU: Preemptible-RCU
Date: Thu, 13 Dec 2007 15:56:37 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712131555130.16714@gandalf.stny.rr.com>
References: <20071213170348.GA25981@in.ibm.com> <Pine.LNX.4.58.0712131230220.3369@gandalf.stny.rr.com>
 <20071213204219.GF25130@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Paul E McKenney <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39384 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697AbXLMU4o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 15:56:44 -0500
In-Reply-To: <20071213204219.GF25130@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 13 Dec 2007, Ingo Molnar wrote:
> Steve, if you went with a fine comb over the code and have done a
> thorough review, could you send me your Reviewed-by line for this
> patchset?

Sure thing. And here's the thread that contains a lot of my review (and I
had some with Paul on IRC).

http://lkml.org/lkml/2007/9/10/213

Reviewed-by: Steven Rostedt <srostedt@redhat.com>
