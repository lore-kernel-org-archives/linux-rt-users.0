From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 7/9][RFC] [PATCH 7/9] cpu/rt: Rework cpu down for
 PREEMPT_RT
Date: Fri, 02 Mar 2012 10:40:54 -0500
Message-ID: <1330702854.25686.267.camel@gandalf.stny.rr.com>
References: <20120301185527.064629423@goodmis.org>
	 <20120301190346.172835662@goodmis.org>
	 <alpine.LFD.2.02.1203021518501.2742@ionos>
	 <1330701323.25686.260.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1203021618330.2742@ionos>
	 <1330702617.25686.265.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20836 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447Ab2CBPkz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 10:40:55 -0500
In-Reply-To: <1330702617.25686.265.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-03-02 at 10:36 -0500, Steven Rostedt wrote:
>  
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +# define hotplug_lock() spin_lock(&cpu_hotplug.lock)
> +# define hotplug_unlock() spin_unlock(&cpu_hotplug.lock)
> +#else
> +# define hotplug_lock() mutex_lock(&cpu_hotplug.lock)
> +# define hotplug_lock() mutex_unlock(&cpu_hotplug.lock)

# define hotplug_unlock() mutex_unlock(&cpu_hotplug.lock)

Proof it doesn't comply.

-- Steve

> +#endif



