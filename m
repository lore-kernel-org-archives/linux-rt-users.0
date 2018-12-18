From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Date: Tue, 18 Dec 2018 12:16:37 +0100
Message-ID: <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218110209.GD15430@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-18 12:02:09 [+0100], Peter Zijlstra wrote:
> On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> > Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> > thus cause the following BUG.
> 
> Hurm, I though we fixed all those long ago..
> 
> And no, the patch is horrible; that's what we have things like
> x86_pmu::cpu_dead() for.

ehm, you say we keep memory allocation +free on CPU up/down?

Sebastian
