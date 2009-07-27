From: Stefan Agner <stefan.agner@yahoo.com>
Subject: Re: Doubt: Does RT patch reduce interrupt latency?
Date: Mon, 27 Jul 2009 03:47:15 -0700 (PDT)
Message-ID: <776909.49461.qm@web59812.mail.ac4.yahoo.com>
References: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>  <4A6A30B2.5070709@us.ibm.com> <4cd511390907252328h4d82225cy2ae02d230fddbe61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Sbs <sbs.pub@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web59812.mail.ac4.yahoo.com ([76.13.12.204]:23693 "HELO
	web59812.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756045AbZG0Kxz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jul 2009 06:53:55 -0400
In-Reply-To: <4cd511390907252328h4d82225cy2ae02d230fddbe61@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,



> Thank you for this clarification. This really made me think. In
> mainline kernel, my interrupt will not be affected by other processes.
> But, it can be affected by other interrupts in the system, right? So,
> I still gain something from rt patch where I can scale down the
> priority of other interrupts so that they don't come in the way of my
> 1 ms interrupt.
Yes this is correct...

> Now, if I got it correct, what I will have to see is whether this
> advantage outweighs the disadvantage of context switching delays. A
> quick search showed me http://choices.cs.uiuc.edu/ExpCS07.pdf. In page
> 25 they have listed time for context switches and interrupts. Those
> figures are rather dismal (~few milli seconds). Can someone familiar
> with ARM here tell me whether these numbers can be trusted? From the
> rt wiki I see that, on ARM, worst case latency is less than 300us. I
> will anyway repeat the tests that we did so far and will post the
> results again.
I did such messures in my diploma work, its written in german but you should 
be able to read the figures (the messures are done on an arm cpu):
http://www.agner.ch/linuxrealtime/Linux-Realtime-Faehigkeiten.pdf

PDF Page 47 and following are interessting. You can see the 
"Durchschnittslatenzzeiten" (average latencies) rt compared with mainline

Bye
Stefan



      
