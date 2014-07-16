From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/3] Linux 3.10.47-rt50-rc1
Date: Wed, 16 Jul 2014 11:22:27 -0400
Message-ID: <20140716112227.7b8bc4bf@gandalf.local.home>
References: <20140714200420.805309842@goodmis.org>
	<53C4714C.8000103@mvista.com>
	<20140714205333.6d28ed1f@gandalf.local.home>
	<53C68CB5.4020002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53C68CB5.4020002@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 16 Jul 2014 09:31:17 -0500
Corey Minyard <cminyard@mvista.com> wrote:

 
> I originally did a patch that just always did the else clause (the
> schedule_work_on() and wait_for_completion()) on all CPUs.  That seemed
> to work just fine and simplifies the code a bit and gets rid of all the
> preempt/migrate calls.  You could try that approach, or I could submit
> something if you liked.

Yeah, perhaps that's the way to go. But it needs to go to mainline
before it goes to -rt.

Can you resend it against my for-next branch.

Thanks,

-- Steve
