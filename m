From: John Kacur <jkacur@redhat.com>
Subject: Re: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 14:10:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1209111401450.5585@tycho>
References: <OFB52301AB.00D27859-ONC1257A76.003FE866-C1257A76.003FE86C@br-automation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52316 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab2IKMJH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 08:09:07 -0400
Received: by eaac11 with SMTP id c11so222544eaa.19
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Sep 2012 05:09:05 -0700 (PDT)
In-Reply-To: <OFB52301AB.00D27859-ONC1257A76.003FE866-C1257A76.003FE86C@br-automation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 11 Sep 2012, Wolfgang Wallner wrote:

> Hello all,
> 
> I have a few questions about the logging entry "sched: RT throttling activated" which I observe, and hope this is the correct place to ask :)
> I will start by describing how i come to see this logging entry:
> 
> I use an industrial PC with an 2.6.33 RT PREEMP kernel to run a real time application (based on the openPOWERLINK stack [1]), which consists of a kernel part and a user space part.
> My application uses the openPOWERLINK stack to exchange data with other real time nodes in the network (a good overview how this is done is given on wikipedia [2]).
> 
> When I let my application run overnight, I always see that it stops working after some hours, and the output of dmesg shows the following:
> 
> [  622.722690] EdrvInitOne waiting for link up...
> [  624.439269] EdrvInitOne finished with 0
> [  624.439334] EdrvInit local MAC = 00 60 65 06 B2 25 
> [  624.454662] EplApiProcessImageAlloc: Alloc(640, 1100, 2, 2)
> [  624.454672] EplApiProcessImageAlloc: Alloc(eeea2000, 640, eef36800, 1100)
> [  624.477242] ifconfig epl 192.168.100.240 returned 0
> [  635.058012] epl: no IPv6 routers present
> [60382.945209] sched: RT throttling activated
> [60382.945209] EplTimerHighResk: Continuous timer (handle 0x10000001) had to skip 836 interval(s)!
> 
> 
> The first 7 entries are the normal logging output from the powerlink stack as it starts up. I just copied them into the mail for completeness.
> The last line is debugging output of the powerlink stack as it complains that its timer was not handled for some time.
> 
> The line with "sched: RT throttling activated" is the one I'm interested in.
> I don't know what it means, and searching for this term did not turn up much.

What kind of a search? A grep of "RT\ throttling" would have found it.

> 
> My questions are now:
> 
> * What does this logging entry mean?
>    Could you please point me to some information about RT throttling so that I can understand what's it about?

in the kernel, look at Documentation/scheduler/sched-rt-group.txt

> 
> * How to debug this issue?
>    At the moment I don't know what is cause and what is effect.
>    I'm not sure if I have a misconfiguration somewhere on my linux system and this influences my application or vice versa.
> 
>    Any tips on how to find out what's going on are greatly appreciated :)
> 

It is considered a feature that allows non-RT tasks to make some progress, 
so that poorly written user space programs can't totally freeze your 
system - which would often be blamed on the rt kernel. You can shut this 
off for a harder kind of real-time - in which case, if your system is freezing, 
turning it back on could help to show whether the kernel is really 
freezing, or if it is a result of a problem with the user-space program.

John
