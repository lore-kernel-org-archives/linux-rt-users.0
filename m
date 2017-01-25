From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Wed, 25 Jan 2017 10:56:29 +0100
Message-ID: <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45086 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbdAYJ4d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2017 04:56:33 -0500
Content-Disposition: inline
In-Reply-To: <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-24 09:15:59 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> The kernel version 4.1.37-rt43 is working fine, the kernel versions 4.4.39-rt50 and 4.8.11-rt7 show the same strange behavior as 4.9.0-rt1.
> Something on the way between 4.1.37-rt43 and 4.4.39-rt50 seems to cause the trouble.

can you check if one of the earlier v4.4-RT releases (maybe start with
-rt2 or -rt1) also shows this behaviour?
If not, would you have a testcase?

> Regards
> 
> Mathias

Sebastian
