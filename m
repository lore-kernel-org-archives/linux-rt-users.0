From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Date: Tue, 18 Dec 2018 14:59:53 +0100
Message-ID: <20181218135953.h7dcelbbaxg4q32a@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
 <20181218113700.GC16284@hirez.programming.kicks-ass.net>
 <20181218114708.p6fpz447brob4kzz@linutronix.de>
 <b8f1f75c-bb8e-3b07-b113-32d1ff70fd3e@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        bp@alien8.de, hpa@zytor.com, jolsa@kernel.org, jolsa@redhat.com,
        kan.liang@linux.intel.com, mingo@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: He Zhe <zhe.he@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8f1f75c-bb8e-3b07-b113-32d1ff70fd3e@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-18 20:45:32 [+0800], He Zhe wrote:
> This works in my environment, taking CPUs offline and online many times.

thank you.

> Zhe
> 
> >
Sebastian
