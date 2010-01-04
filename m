From: Cameron Elliott <garapa1@gmail.com>
Subject: Embedded programmer new to rt-linux, what distribution / release to
	start with?
Date: Mon, 4 Jan 2010 14:40:25 -0800
Message-ID: <1fb80681001041440k3769b02aodf9358d72465e2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:45891 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab0ADWkZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2010 17:40:25 -0500
Received: by pwj9 with SMTP id 9so9651926pwj.21
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jan 2010 14:40:25 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Please excuse me if this is not welcome here, if you know a better
location to ask,
please tell me.

I'm an experienced embedded programmer new to the rt-linux world.

My main task will to be to receive a high volume of UDP packets and
handle TCP streams with minimum latency and jitter.

I am mainly interested in off the shelf kernels and distributions, and
so far think RH or SUSE  would probably be my best bet.

My goal at this point is to determine which distribution and release
to start with.

Here is what I'm confused about:

1. Just to confirm the RH MRG kernel is not the same as the SUSE
realtime kernel?


Does RH MRG use the standard linux kernel?


3.
If I should to decide to go with SUSE, should I start with SLES 11.2
or, instead use SLES 10 SP2 with the Real time extension
(SLERT 10 SP2) ?
The current Novell web pages indicate that SUSE 10 SP2 is what to use
with the realtime extensions, although I understand
a realtime kernel was included in the 11.2 distribution. (This is the
source of my confusion)
http://www.novell.com/products/realtime/eval.html


4.
If I decide to go with RH MRG, is the realtime package available at no
cost or low-cost (<200US)?
Some RH links indicate the MRG package sets maybe avaialbe via 'yum'
at no cost (I have not been able to test this yet):
http://www.redhat.com/docs/en-US/Red_Hat_Enterprise_MRG/1.2/html/Realtime_Installation_Guide/sect-Realtime_Installation_Guide-Download-Installing_RT_using_Yum.html



5. Any idea whether RH or SUSE whould have any advantages for high
volume bursty UDP traffic while minimizing latency (&jitter) ?


Thanks for your feedback,
Cameron
