From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Sat, 28 Jun 2014 06:51:15 +0200
Message-ID: <1403931075.5930.4.camel@marge.simpson.net>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
	 <CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
	 <CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
	 <CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
	 <alpine.DEB.2.10.1406270027300.5170@nanos>
	 <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
	 <alpine.DEB.2.10.1406271249510.5170@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Austin Schuh <austin@peloton-tech.com>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1406271249510.5170@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-06-27 at 16:24 +0200, Thomas Gleixner wrote:

> Completely untested patch below.

It's no longer completely untested, killer_module is no longer a killer.
I'll let box (lockdep etc is enabled) chew on it a while, no news is
good news as usual.

-Mike
