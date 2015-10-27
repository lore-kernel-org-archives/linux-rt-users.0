From: John Kacur <jkacur@redhat.com>
Subject: Re: numa.h for rt-test
Date: Tue, 27 Oct 2015 10:18:51 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1510271018100.5915@riemann.fritz.box>
References: <CAOLSsAxE8ppH2_wVjMOxskOGKtporbwaztG8GzfvN88gJyO20Q@mail.gmail.com> <CAOLSsAwhY1OnTHKfHW2_es4mbGrum5+s5iioNyLmem4SGMPcyw@mail.gmail.com> <alpine.LFD.2.20.1510270946570.5915@riemann.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
To: Javier Sanz <jsanza@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35486 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbbJ0JSy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Oct 2015 05:18:54 -0400
Received: by wicll6 with SMTP id ll6so149930800wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Oct 2015 02:18:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1510270946570.5915@riemann.fritz.box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 27 Oct 2015, John Kacur wrote:

> 
> 
> On Mon, 26 Oct 2015, Javier Sanz wrote:
> 
> > Sorry,
> > 
> > make NUMA=0
> > 
> > Tx
> > 
> > 2015-10-26 11:56 GMT+01:00 Javier Sanz <jsanza@gmail.com>:
> > > Hello,
> > >
> > > I am trying to compile rt-tests-0.96 and i got :
> > >
> > > root@darkstar rt-tests-0.96]# make
> > > gcc -D VERSION=0.96 -c src/cyclictest/cyclictest.c -Wall -Wno-nonnull
> > > -O2 -DNUMA -D_GNU_SOURCE -Isrc/include -o bld/cyclictest.o
> > > In file included from src/cyclictest/cyclictest.c:39:0:
> > > src/cyclictest/rt_numa.h:29:18: fatal error: numa.h: No such file or directory
> > > compilation terminated.
> > > Makefile:87: recipe for target 'bld/cyclictest.o' failed
> > > make: *** [bld/cyclictest.o] Error 1
> > > [root@darkstar rt-tests-0.96]#
> > >
> > >
> > > why do i need to get numa.h ??
> > >
> > > Tx
> > --
> 
> I think the original thinking was that it is a trivial thing to install 
> the numa libs even if you are not going to use them, but I have personally 

Should read, "I have NEVER liked this" :)
> liked this. I could imagine that this requirement is not 
> always so simple in the embedded space. I'll look into seeing if I can 
> remove this. (or try yourself, and send me a patch.)
> 
> Thanks
> 
> John
> 

