From: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Tue, 06 Dec 2011 02:39:04 +1300
Message-ID: <4EDCC978.3060401@cedwards.geek.nz>
References: <4ECCE979.5080109@cedwards.geek.nz>  <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos> <4EDAAEFD.9060209@ripples.dyndns.org> <alpine.LFD.2.02.1112041428560.2735@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:56862 "EHLO kinect.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932379Ab1LENj0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 08:39:26 -0500
In-Reply-To: <alpine.LFD.2.02.1112041428560.2735@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/12/11 02:32, Thomas Gleixner wrote:
> On Sun, 4 Dec 2011, Chris Edwards wrote:
>> On 04/12/11 05:29, Thomas Gleixner wrote:
>>> Ok, that tells us something. So there is something unhappy in your
>>> system about the way how the threaded irq handling works. Can you
>>> please provide the output of lspci -vvv and a full boot log (any
>>> 3.0/3.2 kernel you have handy)?
>> Attached. :)
> Could you disable the e1000 for a test? Just boot up and bring the
> interface down.
>
> Does that change the situation?

Yes - I tested with 3.2.0-rc4-rt5 (and it actually is an RT kernel this 
time - see below!) and with the Ethernet interface down, it seems to be 
working properly.  Even Pure Data didn't cause any crackling or 
stuttering (other than when starting up).

[    0.000000] Linux version 3.2.0-rc4-rt5 (root@babelfish) (gcc version 
4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP PREEMPT RT Tue Dec 6 01:22:11 
NZDT 2011
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.2.0-rc4-rt5 
root=UUID=ca21e0bf-b7f8-45c3-8fc9-066c4dd6052e ro quiet splash

What next?  Should I try moving the Ethernet card to other slots and see 
if anything changes?

Thanks,
Chris
