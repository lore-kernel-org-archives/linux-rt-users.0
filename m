From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Thu, 19 Apr 2012 17:37:56 +0200
Message-ID: <CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419001407.GA24710@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120419001407.GA24710@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Greg,

Op 19 april 2012 02:14 heeft Greg KH <gregkh@linuxfoundation.org> het
volgende geschreven:
> On Tue, Apr 17, 2012 at 04:38:30PM +0200, Ivo Sieben wrote:
>> Hello,
>>
>> We are currently using the TTY framework for serial communication.
>>
>> We are wondering if it is possible to give the TTY device in more
>> deterministic behavior (as in "less locks & no sleeping")
>
> What specifically are you looking for?
>

We run an application with a real-time thread, running on a high priori=
ty.
This thread does serial communication, using non blocking read/write
file I/O on a tty device, with small amounts of data (=3D 24 bytes).
This application runs on a AT2AM9261 processor, 200 MHz
The maximum execution time of both the read & write go up to 200 us

>> So in case of non blocking read/write behavior:
>> - We want directly write data to the serial_core transmit buffer and
>> return immediately.
>
> What is "immediately"?
>

We use non blocking read & write functions
We would like the read/write functions to always execute less than 100u=
s

>> - Incoming data should be buffered, on a read data is read directly
>> from that buffer and when no data available return immediately
>
> That doesn't happen today?
>
> What type of latencies are you seeing today that is bothering you? =A0=
What
> hardware are you expecting to work in this manner? =A0What exact UART=
 are
> you using? =A0What happens when the UART buffers data?
>
> thanks,
>
> greg k-h

We use a self written serial_core device uart driver that implements a
driver for a UART peripheral in a FPGA on our target board..
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
