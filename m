From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Sat, 5 Jul 2014 21:55:42 -0700
Message-ID: <CANGgnMYhpEHWzfZd6WytoU_a3WVM9GqP15i+TNtLov=JrHAKEA@mail.gmail.com>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
 <CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
 <CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
 <CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
 <alpine.DEB.2.10.1406270027300.5170@nanos> <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
 <alpine.DEB.2.10.1406271249510.5170@nanos> <CANGgnMYcSoJa32CdGBxvj0c3NEnU=S=DD35YmZAtn8miCtK6kw@mail.gmail.com>
 <CANGgnMbhYB4VY+4L7qrWvRomi6tRjK+7hs7qBXzsDLND_sjpFA@mail.gmail.com> <alpine.DEB.2.10.1407052226300.22031@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62530 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbaGFE4E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 Jul 2014 00:56:04 -0400
Received: by mail-ie0-f169.google.com with SMTP id rl12so2676134iec.28
        for <linux-rt-users@vger.kernel.org>; Sat, 05 Jul 2014 21:56:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1407052226300.22031@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jul 5, 2014 at 1:26 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 30 Jun 2014, Austin Schuh wrote:
>> I think I might have an answer for my own question, but I would
>> appreciate someone else to double check.  If list_empty erroneously
>> returns that there is work to do when there isn't work to do, we wake
>> up an extra worker which then goes back to sleep.  Not a big loss.  If
>> list_empty erroneously returns that there isn't work to do when there
>> is, this should only be because someone is modifying the work list.
>> When they finish, as far as I can tell, all callers then check to see
>> if a worker needs to be started up, and start one.
>
> Precisely.

A comment there when you put together a polished patch for inclusion
would be awesome.  I'm assuming that you will put the patch together?
