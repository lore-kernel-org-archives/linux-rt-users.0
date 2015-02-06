From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] sched/rt: Use IPI to trigger RT task push migration
 instead of pulling
Date: Fri, 6 Feb 2015 14:59:45 +0100
Message-ID: <20150206135945.GM24151@twins.programming.kicks-ass.net>
References: <20150204143906.742287b4@gandalf.local.home>
 <20150205152144.GM21418@twins.programming.kicks-ass.net>
 <20150205115501.1da27f32@gandalf.local.home>
 <20150206132341.GO21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150206132341.GO21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 06, 2015 at 02:23:41PM +0100, Peter Zijlstra wrote:
> A more advanced version might use an LFSR to iterate the mask, where we
> give each cpu a different seed (say its cpuid) -- be careful to
> artificially insert 0 when we loop.

And since I already stared at this longer than I should have... its got
a few quirks and is slower than the regular iteration but it should
still have bounded behaviour.


static unsigned long lfsr_taps;

void __init lfsr_init(void)
{
	int bits = ilog2(nr_cpu_ids) + 1;

	switch (bits) {
		case  1: lfsr_taps = 0x0001; break;
		case  2: lfsr_taps = 0x0001; break;
		case  3: lfsr_taps = 0x0003; break;
		case  4: lfsr_taps = 0x0009; break;
		case  5: lfsr_taps = 0x0012; break;
		case  5: lfsr_taps = 0x0012; break;
		case  6: lfsr_taps = 0x0021; break;
		case  7: lfsr_taps = 0x0041; break;
		case  8: lfsr_taps = 0x008E; break;
		case  9: lfsr_taps = 0x0108; break;
		case 10: lfsr_taps = 0x0204; break;
		case 11: lfsr_taps = 0x0402; break;
		case 12: lfsr_taps = 0x0829; break;
		case 13: lfsr_taps = 0x100D; break;
		case 14: lfsr_taps = 0x2015; break;

		default:
			BUG_ON(1); /* add more numbers */
	}
}

static inline int __lfsr_next(int lfsr)
{
	unsigned int bit = lfsr & 1;
	lfsr >>= 1;
	if (bit)
		lfsr ^= lfsr_taps;
	return lfsr;
}

int cpumask_next_lfsr(int cpu, const struct cpumask *mask, int seed)
{
	seed |= 1; /* must not be 0 */

	/* kick-start, avoid the termination condition */
	if (cpu == -1) {
		cpu = seed;
		goto test;
	}

again:
	/* when we cycle, we're done, test cpu 0 last */
	if (cpu == seed)
		cpu = 0;
	/* if we just tested cpu 0, we're done */
	else if (cpu == 0)
		return nr_cpu_ids;
	/* otherwise, next please! */
	else
		cpu = __lfsr_next(cpu);

test:
	/* cycle through the unused space; <= 2^(n-1) loops */
	if (cpu >= nr_cpu_ids)
		goto again;

	if (!cpumask_test_cpu(cpu), mask)
		goto again;

	return cpu;
}

#define for_each_cpu_lfsr(cpu, mask, seed)				  \
	for ((cpu) = -1; (cpu) = cpumask_next_lfsr((cpu), (mask), (seed)), \
			 (cpu) < nr_cpu_ids;)
