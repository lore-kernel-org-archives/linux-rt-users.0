From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] preempt: Define preempt_check_resched_rt() for non
 PREEMPT config
Date: Tue, 13 Mar 2012 14:13:42 -0400
Message-ID: <1331662422.25686.662.camel@gandalf.stny.rr.com>
References: <1331607058.25686.660.camel@gandalf.stny.rr.com>
	 <CAONaPpEFOrYFH9=HX+QUweGKqxXw2GUmj9+BAzwmxFtyJX=p+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAONaPpEFOrYFH9=HX+QUweGKqxXw2GUmj9+BAzwmxFtyJX=p+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2012-03-13 at 14:32 +0100, John Kacur wrote:

> This is the same patch I sent for v3.2.9-rt17. (where you complained
> because I gave clark a SOB instead of a Tested-by:) I see that
> #define preempt_check_resched()
> without the _rt has been shuffled to a more logical spot which is the
> only way I recognized that you mean this for v3.0.23-rt.

Actually it should be for 3.2-rt, my mistake to have done it against
3.0-rt, as the only person with the bug in 3.0-rt is me (It failed my
initial tests).

> 
> Could we please start to specify the rt-kernel version in these patches?

The fix was for Thomas.

-- Steve
