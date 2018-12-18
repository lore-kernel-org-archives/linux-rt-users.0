From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Date: Tue, 18 Dec 2018 12:02:09 +0100
Message-ID: <20181218110209.GD15430@hirez.programming.kicks-ass.net>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: zhe.he@windriver.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> thus cause the following BUG.

Hurm, I though we fixed all those long ago..

And no, the patch is horrible; that's what we have things like
x86_pmu::cpu_dead() for.
