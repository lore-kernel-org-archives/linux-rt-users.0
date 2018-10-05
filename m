From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] tty: serial: pl011: fix warning about uninitialized
 variable
Date: Fri, 5 Oct 2018 16:35:30 +0200
Message-ID: <20181005143530.o5g6kuh5i3ym44os@linutronix.de>
References: <20180924082901.21191-1-kurt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Kurt Kanzenbach <kurt@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924082901.21191-1-kurt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-09-24 10:29:01 [+0200], Kurt Kanzenbach wrote:
> Silence the following gcc warning:
> 
> drivers/tty/serial/amba-pl011.c: In function ‘pl011_console_write’:
> ./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/amba-pl011.c:2214:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~
> 
> The code is correct. Thus, initializing flags to zero doesn't change the
> behavior and resolves the warning.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

applied.

Sebastian
