From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH-v2] tty: Use raw spin lock to protect RX flip buffer
Date: Tue, 16 Oct 2012 08:55:40 +0200
Message-ID: <CAMSQXEF8peQofy5bbgT5aW2eYoR7KVb8neoK34ZZS+uwjubPNA@mail.gmail.com>
References: <1348478680-11505-1-git-send-email-meltedpianoman@gmail.com>
	<1349781313-8670-1-git-send-email-meltedpianoman@gmail.com>
	<alpine.LFD.2.02.1210091934010.10988@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1210091934010.10988@ionos>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

2012/10/9 Thomas Gleixner <tglx@linutronix.de>:
>
> __tty_buffer_flush() can call tty_buffer_free() which in turn can call
> kfree(), which is a nono on RT with preemption and interrupts
> disabled. Enabling CONFIG_DEBUG_ATOMIC_SLEEP and extensive testing
> should have told you that.
>
> I did not look at the other places where this lock is used, but I
> suspect there is more fallout lurking.
>
> Thanks,
>
>         tglx

OK, this is a big lesson for me to start using the Kernel Hacking
options more in the future, and especially before sending patches to
the mailing list... Sorry for bothering you with a patch that I could
find out myself was incorrect.

After your remarks, I had some more discussion & reviews with a
colleague of mine. And we finally came to the point where we figured
out that this patch actually tries to solve an issue that is not there
at all... All RX flip buffer handling is initiated from the threaded
IRQ handling: filling the buffer, pushing the buffer and in case of
the low_latency handling (always enabled for PREEMP_RT) also the
copying of the buffer to the line discipline. Therefore the spin lock
was only locked/unlocked by the RX irq thread during "normal" read
operation.

So I skrewed up: I thought I had seen measurements that this patch
improved performance, but after reverting this changeset and redoing
the measurements it proves it has no performance impact at all.

I'll abandon this patch
Thank you very much for reviewing

Regards,
Ivo Sieben
