From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Thu, 3 Jul 2014 16:08:11 -0700
Message-ID: <CANGgnMYq+QHaic1pRugDbudDAd8985KxSoUKRTbfnhwrZ5zSBQ@mail.gmail.com>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
 <CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
 <CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
 <CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
 <alpine.DEB.2.10.1406270027300.5170@nanos> <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
 <alpine.DEB.2.10.1406271249510.5170@nanos> <CANGgnMZ8qemTgzoiq96=YvTnz-h945b8zSw1VtmDMSrbY3kcUg@mail.gmail.com>
 <CANGgnMZBXbBnr1J+HDtDTo3TD-KgjerLA7BH9x6tmsdDfrNWbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANGgnMZBXbBnr1J+HDtDTo3TD-KgjerLA7BH9x6tmsdDfrNWbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 1, 2014 at 12:32 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> On Mon, Jun 30, 2014 at 8:01 PM, Austin Schuh <austin@peloton-tech.com> wrote:
>> On Fri, Jun 27, 2014 at 7:24 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> Completely untested patch below.

I've tested it and looked it over now, and feel pretty confident in
the patch.  Thanks Thomas!

I've been running this fix with my extra lock steps for a couple days
now on 3 machines, and haven't seen any issues.  On each of the
machines, I've got a CAN card generating about 1 CPU worth of load
from interrupts, and the rest of the cores are tied up putting work on
the work queues with the killer_module.

What next?

Austin
