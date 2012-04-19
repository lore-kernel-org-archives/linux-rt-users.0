From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Deterministic behavior for TTY serial
Date: Wed, 18 Apr 2012 17:14:07 -0700
Message-ID: <20120419001407.GA24710@kroah.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34207 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab2DSAOL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Apr 2012 20:14:11 -0400
Received: by pbcun15 with SMTP id un15so9555595pbc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Apr 2012 17:14:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 17, 2012 at 04:38:30PM +0200, Ivo Sieben wrote:
> Hello,
> 
> We are currently using the TTY framework for serial communication.
> 
> We are wondering if it is possible to give the TTY device in more
> deterministic behavior (as in "less locks & no sleeping")

What specifically are you looking for?

> So in case of non blocking read/write behavior:
> - We want directly write data to the serial_core transmit buffer and
> return immediately.

What is "immediately"?

> - Incoming data should be buffered, on a read data is read directly
> from that buffer and when no data available return immediately

That doesn't happen today?

What type of latencies are you seeing today that is bothering you?  What
hardware are you expecting to work in this manner?  What exact UART are
you using?  What happens when the UART buffers data?

thanks,

greg k-h
