From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] Makefile: Add CROSS_COMPILE for Makefile
Date: Mon, 5 Oct 2015 20:25:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510052023000.14006@riemann>
References: <20150929015811.GA1519@debian.debian> <alpine.LFD.2.20.1509291415100.8405@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org
To: Yuanbin Zhou <hduffddybz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32998 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbJESZu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 14:25:50 -0400
Received: by wiclk2 with SMTP id lk2so133624714wic.0
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 11:25:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1509291415100.8405@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm really sorry to do this, after signing-off on it, but I have taken a 
closer look at this patch, and I have to reverse it.

You've added a lot of cross compiling options for things we don't use like 
AS. CONFIG_CROSS_COMPILE looks like something out of the kernel.

Thanks for your efforts anyway, but in the future if you want to send me 
patches you are going to have to include examples, of what is not working 
for you (with output), and then output demonstrating how your patch 
corrects the problem. Thanks

On Tue, 29 Sep 2015, John Kacur wrote:

> 
> 
> On Mon, 28 Sep 2015, Yuanbin Zhou wrote:
> 
> > Signed-off-by: Yuanbin Zhou <hduffddybz@gmail.com>
> > ---
> >  Makefile | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 87946fb..35a7d5a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,6 +1,15 @@
> >  VERSION = 0.94
> > -CC=$(CROSS_COMPILE)gcc
> > -AR=$(CROSS_COMPILE)ar
> > +
> > +CROSS_COMPILE ?= $(CONFIG_CROSS_COMPILE:"%"=%)
> > +AS = $(CROSS_COMPILE)as
> > +LD = $(CROSS_COMPILE)ld
> > +CC = $(CROSS_COMPILE)gcc
> > +CPP = $(CC) -E
> > +AR = $(CROSS_COMPILE)ar
> > +NM = $(CROSS_COMPILE)nm
> > +STRIP = $(CROSS_COMPILE)strip
> > +OBJCOPY = $(CROSS_COMPILE)objcopy
> > +OBJDUMP = $(CROSS_COMPILE)objdump
> >  
> >  OBJDIR = bld
> >  
> > -- 
> > 2.1.4
> > 
> > 
> > --
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Thanks!
> 
