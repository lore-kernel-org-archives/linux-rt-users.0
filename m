From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] futex: free_pi_state outside of hb->lock sections
Date: Mon, 12 Jul 2010 06:46:03 -0400
Message-ID: <1278931563.1537.184.camel@gandalf.stny.rr.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com>
	 <1278714780-788-4-git-send-email-dvhltc@us.ibm.com>
	 <alpine.LFD.2.00.1007121231290.2798@localhost.localdomain>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>, Mike Galbraith <efault@gmx.de>,
	linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1007121231290.2798@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2010-07-12 at 12:35 +0200, Thomas Gleixner wrote:
> On Fri, 9 Jul 2010, Darren Hart wrote:
> 
> > free_pi_state() calls kfree() and might sleep. To prepare for raw hb->locks,
> > get the calls to free_pi_state() out of the hb->lock() sections.
> > 
> > Signed-off-by: Darren Hart <dvhltc@us.ibm.com>

> >  	struct task_struct *task;
> > -	spinlock_t *lock_ptr;
> > +	raw_spinlock_t *lock_ptr;
> 
>  How is this related to the changelog ?

Read the reply to himself (V2) ;-)

-- Steve
