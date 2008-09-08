From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Convert tlbstate_lock spin_lock to raw_spin_lock
Date: Mon, 8 Sep 2008 11:04:31 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0809081056530.23508@gandalf.stny.rr.com>
References: <2c6d8d720809071806i54e58093vf87bec5175d9b074@mail.gmail.com>  <20080908073732.GC5798@linux.vnet.ibm.com> <921ca19c0809080715m6379b322x79edb239f6971560@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	xavier droubay <xavier.droubay@gmail.com>,
	Chirag Jog <chirag@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Sujit Karataparambil <sjt.kar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:35094 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYIHPEe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Sep 2008 11:04:34 -0400
In-Reply-To: <921ca19c0809080715m6379b322x79edb239f6971560@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


[ Refrain from using "unlisted-recipients" please! ]


On Mon, 8 Sep 2008, Sujit Karataparambil wrote:

> Chirag,
> 
>   Kindly understand what xavier is trying to do. He is Trying to disable smp.
> The RT - Linux Code is dependent on the mutex lock to perform some
> soft/hard real time processing. This is an problem with the mutex lock.

It is not a problem with the mutex lock.

> 
> Kindly check with some one before signing off patches.

The patch is legit.

The problem is simply that functions like flush_tlb_current_task and 
flush_tlb_mm disable preemption and then call flush_tlb_others.
This function locks the tlbstate_lock which is currently a rtmutex. An 
rtmutex can not be called with preemption disabled. The tlbstate_lock is 
static, small and confined. I'm not sure we can change this code (flushing 
the TLB) in a way where we can allow preemption. This may just be a 
latency that we must hit.

-- Steve
