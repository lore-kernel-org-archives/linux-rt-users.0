From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] drivers/zram: fix zcomp_stream_get()
 smp_processor_id() use in preemptible code
Date: Thu, 31 Aug 2017 17:48:40 +0200
Message-ID: <20170831154840.qsk4sidcvhvzxk6d@linutronix.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
 <1503482249.4970.7.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503482249.4970.7.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-23 11:57:29 [+0200], Mike Galbraith wrote:
> 
> Use get_local_ptr() vs this_cpu_ptr().

applied.

> Signed-off-by: Mike Galbraith <efault@gmx.de>

Sebastian
