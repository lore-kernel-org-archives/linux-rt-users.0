From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Kernel 4.9.x-rt Fully Preemptible Kernel: Issue with gdb and
 unexpected SIGSTOP signals
Date: Fri, 27 Jan 2017 16:33:41 +0100
Message-ID: <20170127153341.6er3av4saygdzr7o@linutronix.de>
References: <6bec5da671344b7e862ee74dafacb3b5@FE-MBX1012.de.bosch.com>
 <39174b3e2e7a47c48b3688a2b28ab83e@FE-MBX1012.de.bosch.com>
 <20170125095628.pcuxqk7l4xnvbsve@linutronix.de>
 <f8526e600a9a45dc959ddf5d12bc430b@FE-MBX1012.de.bosch.com>
 <87521e75b64f4b84b2ecd8b47bb7fe72@FE-MBX1012.de.bosch.com>
 <20170125134016.ffj6xpissz4iy7ph@linutronix.de>
 <ef2c680e3ed541c4b0df5e0715ca8264@FE-MBX1012.de.bosch.com>
 <3c9395f9c6b944978c1f420276bde0ee@FE-MBX1012.de.bosch.com>
 <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755039AbdA0Qok (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 11:44:40 -0500
Content-Disposition: inline
In-Reply-To: <61f913336df14059bc409249f0e70ea3@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-27 14:04:35 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Sebastian,
Hi Mathias,

> In all the successful loops the lines in the trace look like the lines in the successful (2nd) example below.
> In the error case there is an additional sched_waking and sched_wakeup in the trace.
> Also there is always "prev_state=S" within the forked process.
> In the error case, there is "prev_state=T|K".

That T|K is probably some kind of debug state the program remains until
the debugger puts it back on track. I think the interesting
part ist figure out what decided to send this signal or put the program
into stop-state. Usually a breakpoint, invalid opcode, … causes this
kind of action but my understanding is that you use none of those.

> Thanks
> 
> Best regards
> 
> Mathias

Sebastian
