From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Deterministic behavior for TTY serial
Date: Thu, 19 Apr 2012 08:46:09 -0700
Message-ID: <20120419154609.GA9263@kroah.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
 <20120419001407.GA24710@kroah.com>
 <CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:63160 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab2DSPqN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Apr 2012 11:46:13 -0400
Received: by dake40 with SMTP id e40so11546872dak.11
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Apr 2012 08:46:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 19, 2012 at 05:37:56PM +0200, Ivo Sieben wrote:
> Hi Greg,
> 
> Op 19 april 2012 02:14 heeft Greg KH <gregkh@linuxfoundation.org> het
> volgende geschreven:
> > On Tue, Apr 17, 2012 at 04:38:30PM +0200, Ivo Sieben wrote:
> >> Hello,
> >>
> >> We are currently using the TTY framework for serial communication.
> >>
> >> We are wondering if it is possible to give the TTY device in more
> >> deterministic behavior (as in "less locks & no sleeping")
> >
> > What specifically are you looking for?
> >
> 
> We run an application with a real-time thread, running on a high priority.
> This thread does serial communication, using non blocking read/write
> file I/O on a tty device, with small amounts of data (= 24 bytes).
> This application runs on a AT2AM9261 processor, 200 MHz
> The maximum execution time of both the read & write go up to 200 us
> 
> >> So in case of non blocking read/write behavior:
> >> - We want directly write data to the serial_core transmit buffer and
> >> return immediately.
> >
> > What is "immediately"?
> >
> 
> We use non blocking read & write functions
> We would like the read/write functions to always execute less than 100us

Ok, and are you sure that your processor can even do something like
this?  Where is the time being spent when you make these calls?  A read
function should never hit the hardware, only retrieving data from a
buffer in memory, so if your processor can go this fast, it should be
fine.

Have you done profiling to determine exactly what it taking "too long"
for you?  If so, what is the delay?  If not, you should do this :)

> We use a self written serial_core device uart driver that implements a
> driver for a UART peripheral in a FPGA on our target board..

Do you have a pointer to the driver anywhere?  Why isn't it submitted
for inclusion in the main kernel tree?

thanks,

greg k-h
