From: "Tim Sander" <tim.sander@hbm.com>
Subject: hardirq ->tasklet ->usermode vs softirq -> usermode
Date: Mon, 8 Aug 2011 18:09:38 +0200
Message-ID: <201108081809.38521.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway.hbm.com ([213.157.30.2]:49716 "EHLO hbmntx5.hbm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477Ab1HHQJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2011 12:09:54 -0400
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I am currently evaluating the RT Kernel. We are running a interrupt with 
9.6khz on an arm1136jfs (pcm043) with 533Mhz. When using an softirq
we are missing interrupts since the scheduler fails to schedule the softirq in 
time :-(.

So i implemented an hardiq which then schedules an tasklet and then triggers
usermode with an adjustable wakeup divider. The solution with the tasklet 
seems to be even slower than the softirqs from the kernel and the load makes 
the system so slow that it's a pain working on it.

So my question is: is there a more efficient way than a tasklet? 

The softirq solution misses some irqs but it doesn't seem as if the missed 
interrupts account for all the load difference between these two solutions.

When comparing the 3.0 vs 3.0-rt7 i can make the general observations:
* the load seems to be at least twice as high.
* usermode seems to be scheduled at 2.4khz which is nice.
* the softirq looses some interrupts at a rate of 9.6khz.

Best regards
Tim 

Hottinger Baldwin Messtechnik GmbH, Im Tiefen See 45, 64293 Darmstadt, Germany | www.hbm.com 

Registered as GmbH (German limited liability corporation) in the commercial register at the local court of Darmstadt, HRB 1147  
Company domiciled in Darmstadt | CEO: Andreas Huellhorst | Chairman of the board: James Charles Webster

Als Gesellschaft mit beschraenkter Haftung eingetragen im Handelsregister des Amtsgerichts Darmstadt unter HRB 1147 
Sitz der Gesellschaft: Darmstadt | Geschaeftsfuehrung: Andreas Huellhorst | Aufsichtsratsvorsitzender: James Charles Webster

The information in this email is confidential. It is intended solely for the addressee. If you are not the intended recipient, please let me know and delete this email.

Die in dieser E-Mail enthaltene Information ist vertraulich und lediglich fur den Empfaenger bestimmt. Sollten Sie nicht der eigentliche Empfaenger sein, informieren Sie mich bitte kurz und loeschen diese E-Mail.

