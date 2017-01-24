From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: RE: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Tue, 24 Jan 2017 09:15:59 +0000
Message-ID: <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:26719 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdAXJQD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Jan 2017 04:16:03 -0500
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
        by imta24.fe.bosch.de (Postfix) with ESMTP id 7FB00D80079
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Jan 2017 10:16:01 +0100 (CET)
Received: from SI-MBX1011.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
        by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 500DC1B8051D
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Jan 2017 10:16:01 +0100 (CET)
In-Reply-To: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> with the 4.9.0-rt1 and also the 4.9.4-rt2 kernel (x86, 64bit) I observe a strange issue
> when running my multithreaded real time executable within gdb.
> 
> Fairly often (in about 40% of all runs) the gdb stops executing with the message:
>   Thread 8 "MDL07-Acknowled" received signal SIGSTOP, Stopped (signal).
>   [Switching to Thread 0x7fffef141700 (LWP 9770)]
>   0x00007ffff535b24d in read () at ../sysdeps/unix/syscall-template.S:84
> 
> Often it helps to enter "continue" a couple of times to continue the debugging.
> However, sometimes it ends up in an endless loop of "continue" followed by a
> SIGSTOP, "continue", etc.
> If this issue occurs, the SIGSTOP is complained for all threads in the executable.
> Different system calls are affected: read, select, pselect, clone (via pthread_create),
> ...
> Debugging is more or less impossible due to this issue.
> No SIGSTOP is sent out by the application, the root cause for this signal is not clear
> to me.
> 
> When I reconfigured the kernel to use "Preemptible Kernel (Basic RT)" I do not
> observer this issue.
> Also with kernel 3.18.42-rt44 (Fully Preemptible) it works fine. I never see this issue
> there.
> 
> Any hints on how to solve the issue are highly appreciated.
I did an additional analysis.
The kernel version 4.1.37-rt43 is working fine, the kernel versions 4.4.39-rt50 and 4.8.11-rt7 show the same strange behavior as 4.9.0-rt1.
Something on the way between 4.1.37-rt43 and 4.4.39-rt50 seems to cause the trouble.

Regards

Mathias
