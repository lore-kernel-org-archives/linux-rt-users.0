From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.7-rt3
Date: Thu, 29 Jun 2017 04:55:13 +0200
Message-ID: <1498704913.6128.21.camel@gmx.de>
References: <20170627135750.dezrobqd4twryeeb@linutronix.de>
         <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Bernhard Landauer <oberon@manjaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79973421-cb21-aa5c-29f7-d05dd57283cc@manjaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-06-29 at 02:30 +0200, Bernhard Landauer wrote:
> I'm unable to compile the ndiswrapper extramodule against 4.11.7-rt3
> 
> I get lots of errors of the kind
> 
> 'struct task_struct' has no member named 'cpus_allowed'; did you mean 
> 'nr_cpus_allowed'?
> 
> What can I do?

cpus_allowed became cpus_mask.  Anything (crash.. hohum, yet again)
that rummages around in the kernels gizzard will have to adapt.

	-Mike
