From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Sat, 16 Jan 2016 15:09:28 +0100
Message-ID: <1452953368.3759.1.camel@gmail.com>
References: <20151223225755.GA21121@linutronix.de>
	 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
	 <1451632781.9800.22.camel@gmail.com> <20160113175845.GK29964@linutronix.de>
	 <20160114141744.GB17776@linutronix.de>
	 <1452781751.3460.102.camel@gmail.com>
	 <alpine.DEB.2.11.1601141528550.3575@nanos>
	 <1452783422.3611.8.camel@gmail.com>
	 <alpine.DEB.2.11.1601141606260.3575@nanos>
	 <1452787507.15549.16.camel@gmail.com> <1452950602.13755.9.camel@gmail.com>
	 <alpine.DEB.2.11.1601161441530.3575@nanos>
	 <1452952320.13755.13.camel@gmail.com>
	 <alpine.DEB.2.11.1601161455560.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601161455560.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2016-01-16 at 14:59 +0100, Thomas Gleixner wrote:

> All scheduler classes except deadline merily call set_cpus_allowed_common()
> and deadline does not do the 'change root domain' dance either.
> 
> So we can simplify the whole business a lot.

Goody.  Seeing if I could avoid mostly useless function call was next.
