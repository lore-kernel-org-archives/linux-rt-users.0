From: Wolfgang Wallner <Wolfgang.Wallner@br-automation.com>
Subject: SV: Configuration of real-time tasks in PREEMPT_RT kernels > 2.6.33
Date: Tue, 27 Aug 2013 11:14:14 +0200
Message-ID: <OF3014B0BA.8A20857D-ONC1257BD4.00319A82-C1257BD4.0032BE2A@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Simon Falsig <simon@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:42013 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab3H0JOR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Aug 2013 05:14:17 -0400
In-Reply-To: 
References: 
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Simon,
> From the openPOWERLINK documentation (linux-x86.txt):

Thanks for the answer, but I already knew this documentation :)
I have applied the described steps, and I think they work as expected.
My box has two cores, and I can see in htop that nothing is running on the second cpu, except my tasks which I start with the tool taskset.
Also in /proc/interrupts I can see that all IRQs are handled by the first cpu, except the POWERLINK-related ones, which are handled by the second cpu.
So as far as I know everything is configured as expected, however, I still see non-satisfying results with kernel 3.2-rt.

I have uploaded two images with measurements results for easy comparison:
2.6.33-rt: http://imageshack.us/photo/my-images/818/q4de.png/
3.2-rt: http://imageshack.us/photo/my-images/845/nqdw.png/

Both images show the reaction of the openPOWERLINK-stack on different workloads on the two kernels.
Any further hints on how to improve the 3.2-rt results are greatly appreciated :)

kind regards, Wolfgang Wallner
