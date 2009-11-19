From: Jean Delvare <khali@linux-fr.org>
Subject: Re: yield() in i2c non-happy paths hits BUG under -rt patch
Date: Thu, 19 Nov 2009 15:00:08 +0100
Message-ID: <20091119150008.6e757c26@hyperion.delvare>
References: <c384c5ea0911071101u7415d37o2611c542e5fae309@mail.gmail.com>
	<20091107210147.3e754278@hyperion.delvare>
	<4AF7148C.9090706@thebigcorporation.com>
	<20091112211255.09cd884a@hyperion.delvare>
	<alpine.LFD.2.00.0911132139560.24119@localhost.localdomain>
	<20091116155606.GC29479@sirena.org.uk>
	<c384c5ea0911171650t1c441dc4v746d31e4154fcb30@mail.gmail.com>
	<20091118010520.4cd397d4@lxorguk.ukuu.org.uk>
	<c384c5ea0911180828x7c857189w3316c93bb78100ab@mail.gmail.com>
	<20091118175202.490989d8@hyperion.delvare>
	<alpine.LFD.2.00.0911182127040.24119@localhost.localdomain>
	<20091119130526.23a69b85@hyperion.delvare>
	<20091119125906.6ad00edd@lxorguk.ukuu.org.uk>
	<1258636014.4372.328.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	linux-i2c@vger.kernel.org,
	rt-users <linux-rt-users@vger.kernel.org>,
	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752697AbZKSOAI@vger.kernel.org>
In-Reply-To: <1258636014.4372.328.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,

On Thu, 19 Nov 2009 14:06:54 +0100, Peter Zijlstra wrote:
> On Thu, 2009-11-19 at 12:59 +0000, Alan Cox wrote:
> > > Well, I guess only people monitoring system latency would notice, as
> > > this is the only thing yield() was supposed to help with in the first
> > > place.
> > 
> > 	if (need_resched())
> > 		schedule();
> 
> aka.
> 
> 	cond_resched();

Are you saying that most calls to yield() should be replaced with calls
to cond_resched()?

I admit I a little skeptical. While the description of cond_resched()
("latency reduction via explicit rescheduling in places that are safe")
sounds promising, following the calls leads me to:

static inline int need_resched(void)
{
	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
}

So apparently the condition for need_resched() to do anything is
considered unlikely... suggesting that cond_resched() is a no-op in
most cases? I don't quite get the point of moving away from sched()
because it is a no-op, if we end up with a no-op under a different name.

-- 
Jean Delvare
