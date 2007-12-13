From: "Florent BOUDET" <fboudet@eurilogic.fr>
Subject: Re: 2.6.23.8-rt11, tasks freezing
Date: Thu, 13 Dec 2007 06:33:38 +0100
Message-ID: <A2E861E2828FF949AE40EA2AEDCD89FD246A16@MAIL-4-1.eurilogic.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eurilogic.fr ([80.118.132.234]:61864 "EHLO
	SPAM-1-1.dmz.eurilogic.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750830AbXLMFdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 00:33:39 -0500
Received: from eurilogic.fr (mail-1-2.eurilogic.fr [192.168.6.20])
	by SPAM-1-1.dmz.eurilogic.fr  with ESMTP id lBD5XcMc032568
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Dec 2007 05:33:38 GMT
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 21 Nov 2007, Juuso Alasuutari wrote:
 
> Hi,
> 
> I use vanilla kernels with realtime-preempt patches on a Core 2 E6600
running
> 32-bit Linux. Kernels up to 2.6.22.1-rt9 work fine, but I'm
experiencing
> strange freezing of some tasks with 2.6.23.8-rt11. (Actually all
2.6.23
> rt-kernels I've so far tried hang the same way.)
> 
> The system boots up nicely and seems to be running properly, until
something
> tips it off and some commands begin to get "jammed". What seems to
trigger it
> is accessing the hard disk, for instance doing something like `grep -r
> foo /var`. When it happens the desktop seems mostly responsive, but
trying to
> run commands like `ls` will freeze the terminal. Other commands will
succeed,
> for instance `ps aux` works as usual.
> 
> Alt-SysRq-w shows more than one blocked pdflush task, as well as
metalog and
> whatever commands have become "jammed" so far, like `ls`.
> 
> I'll be happy to post more information, I just need to know what. I'd
attach
> my .config here, but I can't access the computer from where I'm at the
> moment.
 

Hi,
 
I think I am experiencing the same symptoms using 2.6.23.9-rt12 on a
Core 2 T7400 running 32 bits Linux (National Instrument PXI 8106
controller).
The .config used is the untouched default configuration as provided in
the 2.6.23.9-rt12 kernel sources.
Has there been any solution/workaround found on this subject since the
last message in this thread?

Thank you,

Florent Boudet
