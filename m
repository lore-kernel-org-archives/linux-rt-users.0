From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: {patch-rt] cpuset: Convert callback_lock to raw_spinlock_t
Date: Wed, 25 Jan 2017 16:45:29 +0100
Message-ID: <20170125154529.urt45mgz4igm6x53@linutronix.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
 <1483864345.5676.3.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483864345.5676.3.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-01-08 09:32:25 [+0100], Mike Galbraith wrote:
> 
> The two commits below add up to a cpuset might_sleep() splat for RT:
…

> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Cc: stable-rt@vger.kernel.org

applied.

Sebastian
