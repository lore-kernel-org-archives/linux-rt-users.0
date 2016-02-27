From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH RT 07/12] dump stack: dont disable preemption during trace
Date: Sat, 27 Feb 2016 11:32:06 +0100
Message-ID: <20160227103206.GA2337@breakpoint.cc>
References: <20160226213235.253312067@goodmis.org>
 <20160226213341.100625803@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160226213341.100625803@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-02-26 16:32:42 [-0500], Steven Rostedt wrote:
> 3.18.27-rt26-rc1 stable review patch.
> If anyone has any objections, please let me know.

Please merge this one along with "kernel: migrate_disable() do fastpath
in atomic & irqs-off". Otherwise we might get recursive with lockdep and
CPU-hotplug (if we go after hp->lock in pin_current_cpu()).

Sebastian
