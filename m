From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Status of -rt for linux-2.6.20/arch/powerpc
Date: Sun, 11 Feb 2007 13:39:44 +0100
Message-ID: <45CF0E90.2080806@grandegger.com>
References: <45CEF997.3020101@grandegger.com> <20070211112933.GN29553@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080003010409040000000501"
Cc: linux-rt-users@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60622 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740AbXBKMj1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Feb 2007 07:39:27 -0500
In-Reply-To: <20070211112933.GN29553@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------080003010409040000000501
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robert,

Robert Schwebel wrote:
> Hello Wolfgang,
> 
> On Sun, Feb 11, 2007 at 12:10:15PM +0100, Wolfgang Grandegger wrote:
>> what is the status of the Preemptive Kernel and the High Resolution 
>> Timers for Linux 2.6.20 for PowerPC (arch/powerpc or arch/ppc)?
>>
>> I realized build problems when trying to get it working for my Lite5200 
>> (MPC5200) board with patch-2-6-20-rt5. The patch seems to contain 
>> reminders of merge conflicts, e.g.:
>>
>>   +++ linux/include/asm-powerpc/hw_irq.h
>>   ...
>>   +<<<<<<< delete extern unsigned long local_get_flags(void);
>>   +<<<<<<< delete extern unsigned long local_irq_disable(void);
>>
>> and the make fails in arch/powerpc/kernel/time.c as well (see attachment).
> 
> We have 2.6.20-rt3 running on the phyCORE-MPC5200B, so that one should
> work and the merge problems did probably come in later (don't have the
> time to look right now because of the Embedded World activities for next
> week).

As I see it, 2.6.20-rt3 has the same issues (have now attached the 
missing make output). I fixed them manually and are now able to boot and 
run the 2.6.20-rt5 on my Icecube board. Nevertheless, cyclictest returns 
high values of around 8000-10000 (8-10ms). The fact that the unknown 
field 'is_continuous' in arch/powerpc/kernel/time.c is still present 
gives me the impression, that the code in there is not up-to-date. See 
you next week on the Embedded World.

Thanks.

Wolfgang.


--------------080003010409040000000501
Content-Type: text/x-log;
 name="make.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make.log"

  CC      arch/powerpc/kernel/time.o
In file included from arch/powerpc/kernel/time.c:924:
include/linux/clocksource.h: In function 'ns2cyc':
include/linux/clocksource.h:174: warning: comparison of distinct pointer types lacks a cast
include/linux/clocksource.h:174: warning: right shift count >= width of type
include/linux/clocksource.h:174: warning: passing argument 1 of '__div64_32' from incompatible pointer type
arch/powerpc/kernel/time.c: At top level:
arch/powerpc/kernel/time.c:938: error: unknown field 'is_continuous' specified in initializer
make[1]: *** [arch/powerpc/kernel/time.o] Error 1
make[1]: Target `__build' not remade because of errors.
make: *** [arch/powerpc/kernel] Error 2

--------------080003010409040000000501--
