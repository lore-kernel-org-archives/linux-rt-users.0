From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel Oops caused by high uart write loads
Date: Mon, 4 Feb 2013 12:44:54 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302041152150.11905@ionos>
References: <5EC8D4ACC923FE4D871AFFACC976127959E18A@stwexdb.stww2k.local> <5EC8D4ACC923FE4D871AFFACC976127959E1A0@stwexdb.stww2k.local> <5EC8D4ACC923FE4D871AFFACC976127959E1C3@stwexdb.stww2k.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2045950771-1359978295=:11905"
Cc: "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>,
	linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org
To: Belser Florian <Florian.Belser@sensor-technik.de>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <5EC8D4ACC923FE4D871AFFACC976127959E1C3@stwexdb.stww2k.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2045950771-1359978295=:11905
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 30 Jan 2013, Belser Florian wrote:

> I'm running 3.4.17-rt28 on my mpc5200 based system.  The complete
> system works pretty good until I select the "Fully Preemptible
> Kernel" option in the kernel settings.  In that case, if I generate
> a high uart write load (sending a lot of stuff via Bluetooth) I get
> the following kernel Oops:

> # ------------[ cut here ]------------
> Kernel BUG at c03d1728 [verbose debug info unavailable]

I bet this is: BUG_ON(rt_mutex_owner(lock) == self);

> Oops: Exception in kernel mode, sig: 5 [#1]
> PREEMPT mpc5200-simple-platform
> Modules linked in:
> NIP: c03d1728 LR: c03d170c CTR: c01efc78
> REGS: c716fd30 TRAP: 0700   Not tainted  (3.4.17-rt28/STW-V3.00r0+)
> MSR: 00029032 <EE,ME,IR,DR,RI>  CR: 88002022  XER: 00000000
> TASK = c7125880[633] 'irq/129-mpc52xx' THREAD: c716e000
> GPR00: 00000001 c716fde0 c7125880 00000000 c7125880 00000000 00000001 00000000
> GPR08: c7125880 c7125880 c7125880 c7125881 88002022 fbfdffff 07fff000 00000004
> GPR16: 00000024 00000000 000000c0 00000000 c0537e70 00000004 00000000 00000004
> GPR24: c716ad5c c0537e8c c7a73000 00000000 c7bb2a00 c7125880 c78b9800 c0537e8c
> NIP [c03d1728] rt_spin_lock_slowlock+0x78/0x1e0
> LR [c03d170c] rt_spin_lock_slowlock+0x5c/0x1e0
> Call Trace:
> [c716fde0] [c03d170c] rt_spin_lock_slowlock+0x5c/0x1e0 (unreliable)
> [c716fe40] [c01efcd4] uart_write+0x5c/0x114
> [c716fe70] [c028f3f4] hci_uart_tx_wakeup+0xe0/0x1fc
> [c716fea0] [c01d3398] tty_wakeup+0x78/0xac
> [c716feb0] [c01ee9e0] uart_write_wakeup+0x24/0x34
> [c716fec0] [c01f1c38] mpc52xx_psc_handle_irq+0x3f8/0x4b0
> [c716ff20] [c01f13e4] mpc52xx_uart_int+0x38/0x60
> [c716ff30] [c005f660] irq_forced_thread_fn+0x38/0x9c
> [c716ff50] [c005f42c] irq_thread+0x13c/0x1c0
> [c716ff90] [c00391d4] kthread+0x8c/0x90
> [c716fff0] [c000dd4c] kernel_thread+0x4c/0x68
> Instruction dump:
> 7fe3fb78 7fa4eb78 38a00000 38c00001 4bc86591 2f830000 409e0134 801f0018
> 5400003c 7fa00278 7c000034 5400d97e <0f000000> 3bdd0418 3b810008 7fc3f378

> If I switch the preemption modelt o "Preemptible Kernel (Basic RT)"
> everything works fine.

By some definition of works. It works w/o RT_FULL because locks are
NOPs on uniprocessor, except you enable lock debugging.

This is a classic recursive dead lock. If you enable
CONFIG_PROVE_LOCKING, then you should see the same issue even on a
completely unpatched mainline kernel.

> Hope someone already had the same or similar problem and can help me solving it.
> Maybe a update to 3.4.27-rt39 helps?

No, wont help.

The problem is:

mpc52xx_uart_int()

  lock(port->lock);

    mpc52xx_psc_handle_irq()

      mpc52xx_uart_int_tx_chars()

        uart_write_wakeup()

          tty_wakeup()

            hci_uart_tx_wakeup()

              len = tty->ops->write(tty, skb->data, skb->len);

	      The associated write function is uart_write

	      uart_write()

		lock(port->lock)  --> deadlock

I have no idea how that bluetooth "uart" gets connected to the
physical uart, but the backtrace is pretty obvious. What are you doing
to reproduce this?

Thanks,

	tglx
--8323328-2045950771-1359978295=:11905--
