From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 18:46:03 +0200
Message-ID: <1497890763.5483.8.camel@gmx.de>
References: <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
         <1497867291.19618.52.camel@gmx.de>
         <20170619104459.prmicsbbmljc6smb@linutronix.de>
         <1497871888.19618.90.camel@gmx.de>
         <20170619115019.6zpsoiwubl22mjqs@linutronix.de>
         <1497876935.19618.122.camel@gmx.de>
         <20170619140603.dbdpqz2pw2vf6y3x@linutronix.de>
         <1497882982.7751.6.camel@gmx.de>
         <20170619150332.oiqxjlrfcekaye6b@linutronix.de>
         <1497888892.15817.5.camel@gmx.de>
         <20170619162726.crna4j45t2gik2r2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170619162726.crna4j45t2gik2r2@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-06-19 at 18:27 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-06-19 18:14:52 [+0200], Mike Galbraith wrote:
> > 
> > BTW back, I reran virgin 4.9-rt21 on desktop box while off doing the
> > have something resembling a life thing, and it did not stall in 50
> > iterations of performance/run.sh (bloody fickle thing).  Hohum, take it
> > for whatever you think it's worth.
> 
> that sounds good because I tried your config on three boxes with the
> same result.
> So the issue remains on the DLxxx box which is 8socket NUMA box with
> only one memory node, right?

Yes.  Now _I_ think (having spent days chasing) that it is in fact
generic, but yes, all else aside, my highly utilized and very reliable
up until now (and crippled) DL980 G7 very clearly states that we have a
bug lurking.

	-Mike 
