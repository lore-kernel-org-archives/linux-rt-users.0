From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 5/3] tracing: Add smi counting to HWLAT
Date: Tue, 9 Aug 2016 23:25:58 +0200
Message-ID: <20160809212558.GJ30192@twins.programming.kicks-ass.net>
References: <20160804145708.158968389@goodmis.org>
 <20160809140543.2e5c83b5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160809140543.2e5c83b5@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Aug 09, 2016 at 02:05:43PM -0400, Steven Rostedt wrote:
> +int arch_smi_count(void)
> +{
> +	unsigned long long count;
> +	int err;
> +
> +	err = rdmsrl_safe(MSR_SMI_COUNT, &count);
> +	if (err)
> +		return 0;

That's really yucky, relying on _safe() to detect availability.

Also, I just found AMD Fam15h has this counter through PMCs (event
0x2b).

> +
> +	return count;
> +}
