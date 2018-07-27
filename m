From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: [PREEMPT_RT]: Using printk-rt-aware.patch in non-rt kernel
Date: Fri, 27 Jul 2018 11:05:31 +0200
Message-ID: <20180727090531.k3skngkw6qhr7utt@linutronix.de>
References: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
 <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com>
 <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
 <CAOuPNLgXNMm20nuPPDtUoy3qTF9MLDTRNmsOsocYYLrXtS0rBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
To: Pintu Kumar <pintu.ping@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOuPNLgXNMm20nuPPDtUoy3qTF9MLDTRNmsOsocYYLrXtS0rBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-26 23:38:05 [+0530], Pintu Kumar wrote:
> > > Is there a way we can fix this issue on non-rt kernel?
> > I would guess that a wakeup to klogd would fix it.
> >
> Sorry, can you elaborate more about "wakeup to klogd".
> I wanted to try it and check.

Something like this should do the work.

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 179ad787a08c..411f9ed5f051 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1927,6 +1927,8 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 	return log_store(facility, level, lflags, 0, dict, dictlen, text, text_len);
 }
 
+static void printk_flush_pending_output(void);
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const char *dict, size_t dictlen,
 			    const char *fmt, va_list args)
@@ -2026,6 +2028,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (may_trylock && console_trylock_spinning())
 			console_unlock();
+		else if (!may_trylock)
+			printk_flush_pending_output();
+
 		migrate_enable();
 	}
 
@@ -2987,6 +2992,13 @@ static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
 	.flags = IRQ_WORK_LAZY,
 };
 
+static void printk_flush_pending_output(void)
+{
+	/* preemption or interrupts need to be disabled */
+	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
+}
+
 void wake_up_klogd(void)
 {
 	preempt_disable();

Sebastian
