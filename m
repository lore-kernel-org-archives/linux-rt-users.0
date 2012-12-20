From: Simon Falsig <simon@newtec.dk>
Subject: RE: Real-time kernel thread performance and optimization
Date: Thu, 20 Dec 2012 09:21:54 +0100
Message-ID: <32844ba58ef36b5032ce5aa08ca2a985@mail.gmail.com>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com>
 <50B933A5.3020400@am.sony.com> <d27143389b68c615c242b56c7cd4dd22@mail.gmail.com>
 <50CF9A1E.5000902@am.sony.com> <50D257BF.2060803@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com
To: Darren Hart <dvhart@infradead.org>, frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:59139 "HELO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751155Ab2LTIV5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 03:21:57 -0500
Received: by mail-ee0-f72.google.com with SMTP id c13so2447581eek.3
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Dec 2012 00:21:55 -0800 (PST)
In-Reply-To: <50D257BF.2060803@infradead.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/20/2012 01:12 AM, Darren Hart wrote:
> On 12/17/2012 02:18 PM, Frank Rowand wrote:
> > On 12/11/12 06:30, Simon Falsig wrote:
> >
> > < snip >
> >
> >>>> Once I get this finished up, I'll be happy to do a complete
> >>>> write-up of the timer-thread code, if anyone is interested. I
> >>>> remember looking for something similar (but without success), when
> >>>> I wrote the code earlier this year.
> >>>
> >>> It would be very useful to add your results to the wiki.
> >>>
> >>> -Frank
> >>
> >> Cool - is there any particular place it should go? A how-to, FAQ
> >> entry, etc? Just so I know how to do the write-up...
> >
> > https://rt.wiki.kernel.org/index.php/Main_Page would be my default
> > suggestion.  I'm not quite sure where on the wiki would be good
> > though.  Maybe under "Tips and Techniques"?
> >
> > I added the rtwiki maintainers to the cc: list.
>
> I don't have all the context, but this sounds a bit more like something
for
> linux/Documentation (possibly for the preempt-rt patch set). If not, the
> Documentation section on the wiki is a possibility.
> --
> Darren Hart
> Intel Open Source Technology Center
> Yocto Project - Technical Lead - Linux Kernel

As I see it, the write-up could be done in two ways - 1) as a simple code
example of a real-time loop in a kernel module, 2) as a blog-like post of
the process I went through, investigating the performance, and optimizing
my code.

In the case of 1), I guess it could be added to
https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO, as a kernel version
of the realtime example, or possibly to
https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application under
"Building Device Drivers"? In the case of 2) though, it could maybe be on
its own page under "Tips and techniques"?

Best regards,
Simon Falsig
