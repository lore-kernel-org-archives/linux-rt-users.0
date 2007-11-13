From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: syslog(3) blocks when local socket is full
Date: Tue, 13 Nov 2007 13:46:59 -0200
Message-ID: <20071113154659.GN6086@unix.sh>
References: <4739B6CB.4070903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from marova.hst.terra.com.br ([200.176.10.215]:34533 "EHLO
	marova.hst.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXKMPtH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 10:49:07 -0500
Received: from sr05-08.mta.terra.com.br (sr05-08.mta.terra.com.br [200.154.152.67])
	by marova.hst.terra.com.br (Postfix) with ESMTP id CD41B11E03C3
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2007 13:49:03 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <4739B6CB.4070903@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Nov 13, 2007 at 03:38:03PM +0100, John Sigler wrote:
| [ This message has also been posted to comp.unix.programmer ]
| 
| Hello everyone,
| 
| My platform: Linux 2.6.22.1-rt9 + glibc 2.3.6
| 
| I'm writing a "real-time" application that runs with high priority
| (40 or 80 in SCHED_FIFO). I use syslog(3) to log.
| 
| As far as I can see, syslog(3) blocks when the local socket becomes
| full (11 messages on my system).
| 
| Consider the following program.
| 
| #include <syslog.h>
| int main(void)
| {
|   int i;
|   for (i=0; i < 500; ++i) syslog(LOG_INFO, "I=%d", i);
|   return 0;
| }

John, I use glibc-2.6-4 and you test program worked fine. Probably your
manpage (3) for syslog may have details on this feature. You probably have
reached one of the old approaches to avoid DoS via syslog. Limited message
rate would be a reasonable assumption.

One way to better understand what's going on is to either setup syslogd or
your client program (via openlog) to enter in debug mode an print to
stderr.

Luis

| 
| I kill syslogd, then start the above program. It blocks.
| I kill it, then start syslogd, which grabs the following messages.
| 
| Nov 13 11:18:57 venus a.out: I=0
| Nov 13 11:18:57 venus a.out: I=1
| Nov 13 11:18:57 venus a.out: I=2
| Nov 13 11:18:57 venus a.out: I=3
| Nov 13 11:18:57 venus a.out: I=4
| Nov 13 11:18:57 venus a.out: I=5
| Nov 13 11:18:57 venus a.out: I=6
| Nov 13 11:18:57 venus a.out: I=7
| Nov 13 11:18:57 venus a.out: I=8
| Nov 13 11:18:57 venus a.out: I=9
| Nov 13 11:18:57 venus a.out: I=10
| 
| (The process managed to write 11 messages before being blocked.)
| 
| I expected a local socket to buffer way more than 11 messages.
| I expected a local socket to discard new messages when it is full.
| Apparently, these expectations are incorrect.
| 
| I can see how this behavior can become a problem:
| 
| Consider process A with prio 80 in SCHED_FIFO and process B with prio 10
| in SCHED_FIFO, i.e. process B only runs when A does not want the CPU.
| (syslogd is in SCHED_OTHER.)
| 
| 'A' runs, starts logging, and reaches the 11-message limit. The call to
| write() blocks, and 'A' is put to sleep. The scheduler then picks 'B'
| because it has higher priority than syslogd. If B runs "forever", 'A'
| will never get the CPU back.
| 
| Is this scenario possible?
| 
| Is this what is called priority inversion?
| 
| Regards.
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
