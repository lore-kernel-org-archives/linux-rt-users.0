From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] writeback: call writeback tracepoints withoud holding
 list_lock in wb_writeback()
Date: Thu, 25 Feb 2016 19:09:40 -0500
Message-ID: <20160225190940.35553f4e@grimm.local.home>
References: <1456354043-31420-1-git-send-email-yang.shi@linaro.org>
	<20160224214042.71c3493b@grimm.local.home>
	<56CF5848.7050806@linaro.org>
	<20160225145432.3749e5ec@gandalf.local.home>
	<56CF8B66.8070108@linaro.org>
	<20160225183107.1902d42b@gandalf.local.home>
	<56CF9288.5010406@linaro.org>
	<56CF9425.20106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tj@kernel.org, jack@suse.cz, axboe@fb.com, fengguang.wu@intel.com,
 tglx@linutronix.de, bigeasy@linutronix.de, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rt-users@vger.kernel.org, linaro-kernel@lists.linaro.org
To: "Shi, Yang" <yang.shi@linaro.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <56CF9425.20106@linaro.org>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 25 Feb 2016 15:54:13 -0800
"Shi, Yang" <yang.shi@linaro.org> wrote:


> Can we disable irqs in tracepoints since spin_lock_irqsave is used by 
> kernfs_* functions.

Disabling preemption or irqs is fine a tracepoint. You just can't
sleep, which spin_lock_irqsave() would do on the -rt kernel.

-- Steve

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
