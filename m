From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 3/9][RFC] [PATCH 3/9] lglock/rt: Use non-rt
 for_each_cpu() in -rt code
Date: Fri, 02 Mar 2012 09:20:48 -0500
Message-ID: <1330698048.25686.246.camel@gandalf.stny.rr.com>
References: <20120301185527.064629423@goodmis.org>
	 <20120301190345.374756214@goodmis.org>
	 <4F5075D5.9090201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	"mingo@elte.hu" <mingo@elte.hu>, Andi Kleen <ak@linux.intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rusty@rustcorp.com.au" <rusty@rustcorp.com.au>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F5075D5.9090201@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2012-03-02 at 12:55 +0530, Srivatsa S. Bhat wrote:
> On 03/02/2012 12:25 AM, Steven Rostedt wrote:
>  	}								\
> > +	register_hotcpu_notifier(&name##_lg_cpu_notifier);		\
> > +	get_online_cpus();						\
> > +	for_each_online_cpu(i)						\
> > +		cpu_set(i, name##_cpus);				\
> 
> 
> This can be further improved. We don't really need this loop. We can replace
> it with:
> 
> cpumask_copy(&name##_cpus, cpu_online_mask);
> 
> (as pointed out by Ingo. See: https://lkml.org/lkml/2012/2/29/93 and
> https://lkml.org/lkml/2012/2/29/153).
> 
> I will try sending a patch for this to non-RT after the numerous patches
> currently flying around this code (in non-RT) settle down..
> 
> 

Yeah, I thought that was funny too, but I wanted RT to be close to
mainline. My thoughts were to fix the broken hotplug code at the time
and I wasn't thinking too much on improving mainline ;-)

-- Steve
