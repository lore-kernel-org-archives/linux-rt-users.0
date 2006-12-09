From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Ethernet transmit timeouts
Date: Sat, 09 Dec 2006 08:53:23 +0100
Message-ID: <457A6B73.2060904@gmail.com>
References: <20061205171114.GA25926@elte.hu>  <4579BFC6.6000605@gmail.com> <1165608924.24604.342.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:30802 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760502AbWLIHxb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Dec 2006 02:53:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1356694nfa
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Dec 2006 23:53:30 -0800 (PST)
To: tglx@linutronix.de
In-Reply-To: <1165608924.24604.342.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2006-12-08 at 20:40 +0100, Dirk Behme wrote:
> 
>>eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
>>eth0: Ethernet addr: 00:0e:99:02:02:42
>>
>>nfs: server 192.0.0.1 not responding, still trying
>>NETDEV WATCHDOG: eth0: transmit timed out
> 
> 
> That's not a latency. The transmit side of the driver seems not to work.
> Can you please enable debugging in the SMC driver and provide the
> output, maybe it's possible to deduce the cause of the problem from
> that. 

Seems that enabling SMC debugging slows down system in a way 
that my testcase (playing MP3 via NFS) doesn't work any more.

> Also please enable CONFIG_PROVE_LOCKING in the kernel hacking
> section.

Looks like CONFIG_PROVE_LOCKING isn't available on ARM? 
PROVE_LOCKING depens on STACKTRACE_SUPPORT && 
LOCKDEP_SUPPORT. These are available only on i386, x86_64 
and MIPS?

Will now try Bruces' proposal and play with IRQ flags.

Thanks

Dirk
