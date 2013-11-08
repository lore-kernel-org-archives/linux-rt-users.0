From: Tom Cook <tom.k.cook@gmail.com>
Subject: Re: UDP jitter
Date: Fri, 8 Nov 2013 10:50:54 +0000
Message-ID: <CAFSh4UxAwF6fnxR82BcjxeMuxp-qgNJCpfW86YhcaYYyPoF4+Q@mail.gmail.com>
References: <20130429222238.2b440d8c@sanja.asnn.org>
	<517FE1A5.1090702@osadl.org>
	<20130430192653.5c6c08b6@sanja.asnn.org>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
	<20131106125709.2e091182@sth491dt.servo.net>
	<alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
	<20131107103325.65938975@sanja.asnn.org>
	<alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
	<527CB16D.3040909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55790 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436Ab3KHKuz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 05:50:55 -0500
Received: by mail-pd0-f177.google.com with SMTP id p10so1976446pdj.36
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Nov 2013 02:50:54 -0800 (PST)
In-Reply-To: <527CB16D.3040909@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 8, 2013 at 9:39 AM, Stanislav Meduna <stano@meduna.org> wrote:
>
> On 08.11.2013 03:07, Thomas Gleixner wrote:
> > Just for the record. I'm really frightened by the phrase "UDP
> > realtime" which was mentioned in this thread more than once. Looking
> > at the desperation level of these posts I fear, that there are going
> > to be real world products out already or available in the near future
> > which are based on the profound lack of understanding of the
> > technology they are based on.
>
> Yes there are real-world product using real-time ethernet - not
> necessarily UDP but for example anything EtherCAT based absolutely
> needs to be able to send certain packets cyclically no more than
> 100 ms (or 10 ms or 2 ms) apart otherwise all hell breaks loose
> with real-world connected hardware. The room for jitter is the
> limit minus cycle the packets are being sent, which can be pretty
> tight.

EtherCAT is a rather different case - you're never going to get mixed
RT and non-RT traffic on an EtherCAT link (though you can carry
Ethernet traffic over EtherCAT, but that's different).  An Ethernet
port that's being used for EtherCAT is simply not able to also carry
IP traffic.  Even given those restrictions, there is, IIRC, only one
Ethernet chipset that can be used for deterministic IO interfacing.

ProfiNet is a slightly more on-topic example, though that is only RT
given special hardware and drivers that are able to prioritise the
ProfiNet traffic over non-RT traffic.

UDP realtime is indeed rather a pipe dream unless the whole system is
very carefully controlled - which at minimum means not mixing RT and
non-RT traffic.

T
