From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] timer: really raise softirq if there is irq_work
 to do
Date: Fri, 31 Jan 2014 20:48:45 +0100
Message-ID: <52EBFE1D.4020201@linutronix.de>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>	<1391178845-15837-2-git-send-email-bigeasy@linutronix.de>	<20140131120757.594e24d6@gandalf.local.home>	<20140131174227.GN9012@linux.vnet.ibm.com>	<20140131125719.73340f6e@gandalf.local.home>	<52EBF8FE.3080608@linutronix.de> <20140131143441.478f79ee@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, paulmck@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140131143441.478f79ee@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 01/31/2014 08:34 PM, Steven Rostedt wrote:
> There's flags that determine when the next call should be invoked. The
> irq_work_run() should return immediately if it was already done by the
> arch specific call. The work wont be called twice.

Well, it is called twice. It just does nothing because the list is
empty & returns.

> As I have worked on code that uses irq_work() I can say that we want
> the arch specific interrupts. For those architectures that don't have
> it will experience larger latencies for the work required. It's
> basically, a "too bad" for them.

How "bad" is it? Is this something generic or just not getting
perf events fast enough out? Most users don't seem to require small
latencies.

> But to answer your question, no we want the immediate response.
> 
> -- Steve

Sebastian
