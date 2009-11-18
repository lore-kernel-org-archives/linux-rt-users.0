From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Wed, 18 Nov 2009 01:05:20 +0000
Message-ID: <20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	<20091107210147.3e754278@hyperion.delvare>
	<4AF7148C.9090706@thebigcorporation.com>
	<20091112211255.09cd884a@hyperion.delvare>
	<alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
	<20091116155606.GC29479@sirena.org.uk>
	<c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jean Delvare <khali@linux-fr.org>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-i2c@vger.kernel.org,
	rt-users <linux-rt-users@vger.kernel.org>,
	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756558AbZKRBEM@vger.kernel.org>
In-Reply-To: <c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> I think the yield()s in the device driver code means "I need a small
> delay before the hardware is ready" which might translate to some
> arbitrary "let me msleep()" or "do not select this task in the next
> scheduler run, EVEN IF this task is highest priority".

Yield() in a driver is almost always a bug. The reason for that is that
doing

	do {
		inb();
	} while(!something);

which is what yield can end up as being if there is nothing else on that
CPU is extremely bad for bus performance on most systems. It's almost
always better to be using msleep() or even mdelay + a check to see if a
reschedule is needed/schedule().

> I assume this is rather dirty and has too much overhead on the timer interfaces.

Our timers are very efficient and some day we will need to make jiffies a
function and stop the timer ticking for best performance. At that point
timers are probably the most efficient way to do much of this.

Be that as it may, yield() in a driver is almost always the wrong thing
to do.
