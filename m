From: Ingo Molnar <mingo@elte.hu>
Subject: Re: appearance of /proc/interrupts ?
Date: Thu, 11 Jan 2007 10:50:55 +0100
Message-ID: <20070111095055.GA29844@elte.hu>
References: <45A608A0.1050407@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:57555 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030258AbXAKKrO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jan 2007 05:47:14 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A608A0.1050407@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Steven Scholz <steven.scholz@imc-berlin.de> wrote:

> with Linux 2.6.17-rt3 /proc/interrupts looks as described on
> 
> 	http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO
> 
>            CPU0
>   0:      11188  XT-PIC         [........N/  0]-level    pit
>   1:          8  XT-PIC         [........./  0]-level    i8042
>   2:          0  XT-PIC         [........N/  0]-level    cascade
>   4:        131  XT-PIC         [........./ 10]-level    serial
>  11:         10  XT-PIC         [........./  0]-level    eth0
>  14:       4087  XT-PIC         [........./  0]-level    ide0
> 
> But when using a Linux 2.6.19.1-rt15 it looks like
> 
>            CPU0
>   0:      15499   IO-APIC-edge      timer
>   1:          8   IO-APIC-edge      i8042
>   4:        161   IO-APIC-edge      serial
>   9:          0   IO-APIC-fasteoi   acpi
>  12:          3   IO-APIC-edge      i8042
>  14:       4082   IO-APIC-edge      ide0
>  16:         93   IO-APIC-fasteoi   eth0
> 
> which is pretty much the same as a vanilla 2.6.19.
> 
> What does it mean? Is RT PREEMPT not working correctly?

i restored it to be as compatible with upstream as possible. You have a 
PREEMPT_RT kernel if you have this message in the dmesg:

  Real-Time Preemption Support (C) 2004-2006 Ingo Molnar

	Ingo
