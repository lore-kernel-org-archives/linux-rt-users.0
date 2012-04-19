From: Alan Cox <alan@linux.intel.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Thu, 19 Apr 2012 12:19:38 +0100
Message-ID: <20120419121938.1215b8c1@bob.linux.org.uk>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> We are wondering if it is possible to give the TTY device in more
> deterministic behavior (as in "less locks & no sleeping")
> So in case of non blocking read/write behavior:
> - We want directly write data to the serial_core transmit buffer and
> return immediately.

If you have the tty in raw mode then that is basically what the ldisc
code does (plus any flow control you may have selected).

> - Incoming data should be buffered, on a read data is read directly
> from that buffer and when no data available return immediately

Ditto in raw mode, and you can use O_NDELAY or the VMIN/VTIME fields to
optimise block transfer behaviour. We do actually do an additional
memcpy but memory copies of cached memory are so cheap it should be
irrelevant unless trying to do megabit speeds on low end embedded
processors.

> We have the idea that the default N_TTY line discipline introduces too

Based upon what analysis ?

> much overhead & locking behavior what makes it less suitable for
> deterministic serial communication on a PREEMT_RT platform.

Are you using USB ports ?

Alan
