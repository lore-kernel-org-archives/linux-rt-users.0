From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Thu, 26 Apr 2012 16:27:56 +0200
Message-ID: <CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419001407.GA24710@kroah.com>
	<CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
	<20120419154609.GA9263@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120419154609.GA9263@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

>> We use a self written serial_core device uart driver that implements=
 a
>> driver for a UART peripheral in a FPGA on our target board..
>
> Do you have a pointer to the driver anywhere? =A0Why isn't it submitt=
ed
> for inclusion in the main kernel tree?

This driver is work in progress and not yet mature enough for
inclusion in the main kernel tree.

> Have you done profiling to determine exactly what it taking "too long=
"
> for you?  If so, what is the delay?  If not, you should do this :)
>

I did some analyses using the ftrace 'function_graph' tracer to find
out what causes the TTY read to take longer than expected.
I use a test application, running on RT prioirty 99 that writes bursts
of 24 Bytes data to a my TTY device. A loop back connector is used, so
the application also reads back these 24 bytes. Non blocking reads &
writes are used.

This analyses is still ongoing...
But I found two issues that you might can help me to explain (but  as
I said: I still need to "dive" further into the source)

1)
In some cases the tty_flush_to_ldisc() function (called by
drivers/tty/n_tty.c, line 1599) takes a rather long time than with
other TTY reads...
=46or trace see: http://pastebin.com/zXCYTLNj

If I understand it correctly, the TTY flip buffer uses a workqueue to
transfer receive read data from the TTY flip buffer into the buffer of
the line discipline. It seems like the N_TTY line discipline tries to
actively flush data from the TTY flip buffer into the line discipline
buffer. But my serial device drive initiates a tty_flip_buffer_push()
every time after a number of bytes were received (this is intiated
from threaded irq context by the way).

In the case of this trace: is the workqueue currently already busy
transferring data to the ldisc because of the UART receive interrupt
handling has queued that a new work item? So is the N_TTY read()
function actually waiting for that work item to be finished? I guess
in that case for non blocking reads you would like to return with an
EAGAIN, and try to read the data the next time you call the read
function... right?

2)
In some cases the tty_ldisc_deref() function (called by
drivers/tty/tty_io.c, line 977) takes a rather long time than with
other TTY reads
=46or trace see: http://pastebin.com/Nuh5cLGv

After a successful read from the N_TTY line discipline, the TTY
framework dereferences the line discipline.
Can the TTY read() block here because other processes are currently
try to get or release a reference to the N_TTY line discpline at the
same time?
So in that case: does the high priority TTY read has to wait for a
lower priority TTY read/write operation (e.g. from the terminal I/O).


Regards,
Ivo Sieben
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
