From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Thu, 19 Apr 2012 17:42:54 +0200
Message-ID: <CAMSQXEFv0FHoBkKzLAnY87H1bkQOds6HK4=3JK+iBW-CCtrJZg@mail.gmail.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419121938.1215b8c1@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
To: Alan Cox <alan@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120419121938.1215b8c1@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Alan,

Op 19 april 2012 13:19 heeft Alan Cox <alan@linux.intel.com> het
volgende geschreven:
>> We are wondering if it is possible to give the TTY device in more
>> deterministic behavior (as in "less locks & no sleeping")
>> So in case of non blocking read/write behavior:
>> - We want directly write data to the serial_core transmit buffer and
>> return immediately.
>
> If you have the tty in raw mode then that is basically what the ldisc
> code does (plus any flow control you may have selected).
>
>> - Incoming data should be buffered, on a read data is read directly
>> from that buffer and when no data available return immediately
>
> Ditto in raw mode, and you can use O_NDELAY or the VMIN/VTIME fields to
> optimise block transfer behaviour. We do actually do an additional
> memcpy but memory copies of cached memory are so cheap it should be
> irrelevant unless trying to do megabit speeds on low end embedded
> processors.
>

I assume we use raw mode:
- We call the cfmakeraw() function.
- We also set the O_NDELAY flag, VMIN = 1, VTIME = 0

>> We have the idea that the default N_TTY line discipline introduces too
>
> Based upon what analysis ?
>

I think you are right: I did not yet do "real" analysis on the N_TTY
line discipline apart from source code analysis.
I will do some extra ftrace tests, to find out what causes the delays
in the execution time.
I'll come back to that...

>> much overhead & locking behavior what makes it less suitable for
>> deterministic serial communication on a PREEMT_RT platform.
>
> Are you using USB ports ?
>

No, it is a UART peripheral in a FPGA on our target board.
We use a self written serial_core base driver

> Alan

Thanks,
Ivo Sieben
