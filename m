From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Thu, 26 Jul 2007 09:53:53 +0200
Message-ID: <20070726075353.GA19885@elte.hu>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com> <1184615557.2698.3.camel@laptopd505.fenrus.org> <20070726072858.GC13061@in.ibm.com> <20070726073520.GA12206@elte.hu> <20070726074957.GA19398@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjan van de Ven <arjan@infradead.org>, linux@bohmer.net,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	mathieu.desnoyers@polymtl.ca
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932810AbXGZHyW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070726074957.GA19398@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Ankita Garg <ankita@in.ibm.com> wrote:

> > I'd suggest to not put a probe into a preempt-off section - put it 
> > to the beginning and to the end of schedule() to capture 
> > context-switches. _stp_print_flush() is in the systemtap-generated 
> > module, right? Maybe the problem is resolved by changing that 
> > spinlock to use raw_spinlock_t / DEFINE_RAW_SPIN_LOCK.
> 
> Yes, _stp_print_flush is in the systemtap-generated kprobe module. 
> Placing the probe at the beginning of schedule() also has the same 
> effect. Will try by changing the spinlock to raw_spinlock_t...

could you send us that module source ST generates? Perhaps there are 
preempt_disable() (or local_irq_disable()) calls in it too.

	Ingo
