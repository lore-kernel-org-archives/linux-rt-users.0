From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] slab: Fix up stable merge of slab init_lock_keys()
Date: Fri, 19 Oct 2012 11:29:17 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210191127320.9958@localhost.localdomain>
References: <1350567601.19292.69.camel@pippen.local.home> <1350656961.2768.20.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350656961.2768.20.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Fri, 19 Oct 2012, Peter Zijlstra wrote:

>> Could you just confirm that my fix is correct.
>
> We forever keep getting that issue wrong it seems.. so I'd not put too
> much trust into whatever my sleep addled brain thinks today :/

I wasn't expecting a reply till next week ;-)

>
> Looks about right, but who knows ;-)
>

Heh, OK, the worse thing that can happen is that I revert it for the next 
-rt stable release. I wont hold off the releases to 3.2-rt and 3.4-rt over 
this.

Thanks,

-- Steve
