From: "Bruce Ashfield" <bruce.ashfield@windriver.com>
Subject: Re: Ethernet transmit timeouts, was: v2.6.19-rt6, yum/rpm
Date: Fri, 8 Dec 2006 23:26:18 -0500
Message-ID: <3bd6b93c0612082026q76616271p3c236f148066a115@mail.gmail.com>
References: <20061205171114.GA25926@elte.hu> <4579BFC6.6000605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:11517 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395AbWLIE0U (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Dec 2006 23:26:20 -0500
Received: by wx-out-0506.google.com with SMTP id h27so994084wxd
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Dec 2006 20:26:18 -0800 (PST)
To: "Dirk Behme" <dirk.behme@googlemail.com>
In-Reply-To: <4579BFC6.6000605@gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12/8/06, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Ingo Molnar wrote:
> > this is a fixes-only release. Changes since -rt1:
> ...
> >  - e1000: update to driver 7.3.15-k2 to fix latency problem
>
> Any hint what the "latency problem" was here?
>
> On ARM926 with patch-2.6.19-rt10 we use SMC91C94 ethernet
> (smc91x.c). With rt10 applied we get NETDEV WATCHDOG
> transmit timouts (see below) while using NFS. We don't get
> them without rt patch.

I've seen the same problem on the ARM versatile926 with the
2.6.14 vintage RT patches. My problem was due to the generic
IRQ changes and I could reproduce the problem with just those
patches applied.

A brew of the following two patches got the versatile's TX
interrupts firing again:

http://lkml.org/lkml/2005/12/12/69
http://lkml.org/lkml/2005/12/12/72

Obviously those are a bit old now and I haven't gotten around
to trying the board with the 2.6.19-rt patches (no suitable
counter for instrumentation), so I haven't checked for myself
to see if the problem still exists.

>
> Dirk
>
> Btw: Any idea why /proc/interrupts doesn't look like Figure
> 8 of http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO ?
> The [........N/  0] info is missing here.
>
>
> eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
> eth0: Ethernet addr: 00:0e:99:02:02:42
>
> # cat /proc/interrupts
>             CPU0
> ...
>   93:          0         MPU  DMA
>   94:          0         MPU  DMA
> 160:         28        GPIO  eth0
> 164:          1        GPIO  spi2.0
> 197:          0        GPIO  serial wakeup
> ...
>
> # madplay /mnt/nfs/foo.mp3
> ...
> NETDEV WATCHDOG: eth0: transmit timed out
> NETDEV WATCHDOG: eth0: transmit timed out
> NETDEV WATCHDOG: eth0: transmit timed out
> nfs: server 192.0.0.1 not responding, still trying
> nfs: server 192.0.0.1 not responding, still trying
> NETDEV WATCHDOG: eth0: transmit timed out
> nfs: server 192.0.0.1 not responding, still trying
> NETDEV WATCHDOG: eth0: transmit timed out
> nfs: server 192.0.0.1 not responding, still trying
> nfs: server 192.0.0.1 not responding, still trying
> nfs: server 192.0.0.1 not responding, still trying
> NETDEV WATCHDOG: eth0: transmit timed out
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
