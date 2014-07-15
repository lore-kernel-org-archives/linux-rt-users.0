From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/3] Linux 3.10.47-rt50-rc1
Date: Mon, 14 Jul 2014 20:53:33 -0400
Message-ID: <20140714205333.6d28ed1f@gandalf.local.home>
References: <20140714200420.805309842@goodmis.org>
	<53C4714C.8000103@mvista.com>
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
In-Reply-To: <53C4714C.8000103@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 14 Jul 2014 19:09:48 -0500
Corey Minyard <cminyard@mvista.com> wrote:

> Can we get:
> 
> tracing-use-migrate_disable-to-prevent-beeing-pushed.patch

Sure except that patch is buggy:

-               preempt_disable();
+               migrate_disable();
                /* The update must run on the CPU that is being updated. */
                if (cpu_id == smp_processor_id() || !cpu_online(cpu_id))
                        rb_update_pages(cpu_buffer);
                else {
-                       /*
-                        * Can not disable preemption for schedule_work_on()
-                        * on PREEMPT_RT.
-                        */
-                       preempt_enable();
                        schedule_work_on(cpu_id,
                                         &cpu_buffer->update_pages_work);
                        wait_for_completion(&cpu_buffer->update_done);
-                       preempt_disable();
                }
-               preempt_enable();
+               migrate_enable();

migrate_disable() on non-PREEMPT_RT is preempt_disable(). You can't
call wait_or_completion with preemption disabled.

When that gets fixed in mainline -rt, I'll add it to the stable
branches too.

-- Steve



> 
> into 3.10, also?
> 
