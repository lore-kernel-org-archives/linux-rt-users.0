From: Jean Delvare <khali@linux-fr.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Wed, 18 Nov 2009 17:52:02 +0100
Message-ID: <20091118175202.490989d8@hyperion.delvare>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	<20091107210147.3e754278@hyperion.delvare>
	<4AF7148C.9090706@thebigcorporation.com>
	<20091112211255.09cd884a@hyperion.delvare>
	<alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
	<20091116155606.GC29479@sirena.org.uk>
	<c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
	<20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
	<c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-i2c@vger.kernel.org,
	rt-users <linux-rt-users@vger.kernel.org>,
	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757908AbZKRQwC@vger.kernel.org>
In-Reply-To: <c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 18 Nov 2009 17:28:53 +0100, Leon Woestenberg wrote:
> On Wed, Nov 18, 2009 at 2:05 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Our timers are very efficient and some day we will need to make jiffies a
> > function and stop the timer ticking for best performance. At that point
> > timers are probably the most efficient way to do much of this.
>
> The problem with I2C bitbanged is the stringent timing, we need a way
> to have fine-grained sleeping
> mixed with real-time tasks in order to make this work.

FWIW, the problem that was initially reported has nothing to do with
this. i2c-algo-bit used mdelay() during transactions, not yield().
yield() is used only in once place, _between_ transactions attempts.
There are no strict timing constraints there.

-- 
Jean Delvare
