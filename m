From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Deterministic behavior for TTY serial
Date: Fri, 4 May 2012 17:32:57 -0700
Message-ID: <20120505003257.GA5169@kroah.com>
References: <20120419001407.GA24710@kroah.com>
 <CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
 <20120419154609.GA9263@kroah.com>
 <CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
 <CAMSQXEGb9moJbCQwwXgEq7H-HvaSiuS5JBL55jr0ZhEEeAmqzw@mail.gmail.com>
 <20120501160456.3b0b5e34@pyramind.ukuu.org.uk>
 <CAMSQXEHAyPOF6YghsYmqqyx+N0oMgn5E=znhgFyspMUnaH78ig@mail.gmail.com>
 <CAMSQXEHHOHeNYPJZT0b4s62T3uuNXSt9WucSrGOTfjXOU_guzg@mail.gmail.com>
 <CAMSQXEG+O86t10AF5gN875RoEHkMcGFQE_-G6TdeYVc4NJoBLw@mail.gmail.com>
 <CAMSQXEEnvpBoq7m5hMTtYObj4FsMAtUbpEaiftZ1CDmF56LZAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44134 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758329Ab2EEAdB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 May 2012 20:33:01 -0400
Received: by pbbrp8 with SMTP id rp8so4436282pbb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 04 May 2012 17:33:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMSQXEEnvpBoq7m5hMTtYObj4FsMAtUbpEaiftZ1CDmF56LZAQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 03, 2012 at 05:28:47PM +0200, Ivo Sieben wrote:
> Hi,
> 
> >
> > The PREEMPT_RT uses mutexes for "normal" spin locks that do not
> > disable interrupts...
> > I'll try to use raw spinlocks in this code section and for the tty flip buffer
> > See if that can solve my problem.
> >
> > If you have other ideas... let me know!
> >
> > Regards,
> > Ivo
> 
> I've changed some small things to the tty layer (see my other 3 RFC
> patches I've send).
> Performance increased with my loopback stress test:
> - Old situation: average read call last for 50us, with peaks up to 230 us
> - New situation: average read call still 50us, peak up to 60 us
> - Write was stable in both situations: average of 90 us, peak up to 100 us
> 
> Only the very first read & write took extra time (128 us for read, 143
> for write)
> I'm still investigating that...
> 
> Feedback is very appreciated.

Why are raw spinlocks "faster" here?  I like the end-result of what you
have accomplished, but I had some questions on your patches, care to
answer them?

thanks,

greg k-h
