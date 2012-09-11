From: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Subject: Question regarding 'sched: RT throttling activated'
Date: Tue, 11 Sep 2012 13:38:02 +0200
Message-ID: <OFB52301AB.00D27859-ONC1257A76.003FE866-C1257A76.003FE86C@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Josef Baumgartner <Josef.Baumgartner@br-automation.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:47140 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759047Ab2IKLxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Sep 2012 07:53:07 -0400
In-Reply-To: 
References: 
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all,

I have a few questions about the logging entry "sched: RT throttling activated" which I observe, and hope this is the correct place to ask :)
I will start by describing how i come to see this logging entry:

I use an industrial PC with an 2.6.33 RT PREEMP kernel to run a real time application (based on the openPOWERLINK stack [1]), which consists of a kernel part and a user space part.
My application uses the openPOWERLINK stack to exchange data with other real time nodes in the network (a good overview how this is done is given on wikipedia [2]).

When I let my application run overnight, I always see that it stops working after some hours, and the output of dmesg shows the following:

[  622.722690] EdrvInitOne waiting for link up...
[  624.439269] EdrvInitOne finished with 0
[  624.439334] EdrvInit local MAC = 00 60 65 06 B2 25 
[  624.454662] EplApiProcessImageAlloc: Alloc(640, 1100, 2, 2)
[  624.454672] EplApiProcessImageAlloc: Alloc(eeea2000, 640, eef36800, 1100)
[  624.477242] ifconfig epl 192.168.100.240 returned 0
[  635.058012] epl: no IPv6 routers present
[60382.945209] sched: RT throttling activated
[60382.945209] EplTimerHighResk: Continuous timer (handle 0x10000001) had to skip 836 interval(s)!


The first 7 entries are the normal logging output from the powerlink stack as it starts up. I just copied them into the mail for completeness.
The last line is debugging output of the powerlink stack as it complains that its timer was not handled for some time.

The line with "sched: RT throttling activated" is the one I'm interested in.
I don't know what it means, and searching for this term did not turn up much.


My questions are now:

* What does this logging entry mean?
   Could you please point me to some information about RT throttling so that I can understand what's it about?

* How to debug this issue?
   At the moment I don't know what is cause and what is effect.
   I'm not sure if I have a misconfiguration somewhere on my linux system and this influences my application or vice versa.

   Any tips on how to find out what's going on are greatly appreciated :)


Regards,
Wolfgang Wallner

[1] http://sourceforge.net/projects/openpowerlink/
[2] http://en.wikipedia.org/wiki/Ethernet_Powerlink