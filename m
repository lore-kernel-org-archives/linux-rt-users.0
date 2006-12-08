From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Ethernet transmit timeouts, was: v2.6.19-rt6, yum/rpm
Date: Fri, 08 Dec 2006 20:40:54 +0100
Message-ID: <4579BFC6.6000605@gmail.com>
References: <20061205171114.GA25926@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:14065 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426165AbWLHTlC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Dec 2006 14:41:02 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1219325nfa
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Dec 2006 11:41:01 -0800 (PST)
In-Reply-To: <20061205171114.GA25926@elte.hu>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar wrote:
> this is a fixes-only release. Changes since -rt1:
...
>  - e1000: update to driver 7.3.15-k2 to fix latency problem

Any hint what the "latency problem" was here?

On ARM926 with patch-2.6.19-rt10 we use SMC91C94 ethernet 
(smc91x.c). With rt10 applied we get NETDEV WATCHDOG 
transmit timouts (see below) while using NFS. We don't get 
them without rt patch.

Dirk

Btw: Any idea why /proc/interrupts doesn't look like Figure 
8 of http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO ? 
The [........N/  0] info is missing here.


eth0: SMC91C94 (rev 9) at c2850300 IRQ 160 [nowait]
eth0: Ethernet addr: 00:0e:99:02:02:42

# cat /proc/interrupts
            CPU0
...
  93:          0         MPU  DMA
  94:          0         MPU  DMA
160:         28        GPIO  eth0
164:          1        GPIO  spi2.0
197:          0        GPIO  serial wakeup
...

# madplay /mnt/nfs/foo.mp3
...
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server 192.0.0.1 not responding, still trying
nfs: server 192.0.0.1 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server 192.0.0.1 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server 192.0.0.1 not responding, still trying
nfs: server 192.0.0.1 not responding, still trying
nfs: server 192.0.0.1 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
