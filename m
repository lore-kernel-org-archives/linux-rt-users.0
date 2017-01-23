From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Subject: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Mon, 23 Jan 2017 13:43:22 +0000
Message-ID: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:52503 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdAWNn0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Jan 2017 08:43:26 -0500
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
        by imta24.fe.bosch.de (Postfix) with ESMTP id 2357ED8022A
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jan 2017 14:43:24 +0100 (CET)
Received: from FE-MBX1011.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
        by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 016B41B80E97
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Jan 2017 14:43:24 +0100 (CET)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

with the 4.9.0-rt1 and also the 4.9.4-rt2 kernel (x86, 64bit) I observe a strange issue when running my multithreaded real time executable within gdb.

Fairly often (in about 40% of all runs) the gdb stops executing with the message:
  Thread 8 "MDL07-Acknowled" received signal SIGSTOP, Stopped (signal).
  [Switching to Thread 0x7fffef141700 (LWP 9770)]
  0x00007ffff535b24d in read () at ../sysdeps/unix/syscall-template.S:84

Often it helps to enter "continue" a couple of times to continue the debugging.
However, sometimes it ends up in an endless loop of "continue" followed by a SIGSTOP, "continue", etc.
If this issue occurs, the SIGSTOP is complained for all threads in the executable.
Different system calls are affected: read, select, pselect, clone (via pthread_create), ...
Debugging is more or less impossible due to this issue.
No SIGSTOP is sent out by the application, the root cause for this signal is not clear to me.

When I reconfigured the kernel to use "Preemptible Kernel (Basic RT)" I do not observer this issue.
Also with kernel 3.18.42-rt44 (Fully Preemptible) it works fine. I never see this issue there.

Any hints on how to solve the issue are highly appreciated. 

Thanks

Best regards

Mathias


