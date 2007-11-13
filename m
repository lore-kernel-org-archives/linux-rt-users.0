From: John Sigler <linux.kernel@free.fr>
Subject: Re: syslog(3) blocks when local socket is full
Date: Tue, 13 Nov 2007 17:15:01 +0100
Message-ID: <4739CD85.1020808@free.fr>
References: <4739B6CB.4070903@free.fr> <20071113154659.GN6086@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:46546 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421AbXKMQPD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 11:15:03 -0500
In-Reply-To: <20071113154659.GN6086@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Luis Claudio R. Goncalves wrote:

> John Sigler wrote:
> 
>> My platform: Linux 2.6.22.1-rt9 + glibc 2.3.6
>> 
>> I'm writing a "real-time" application that runs with high priority
>> (40 or 80 in SCHED_FIFO). I use syslog(3) to log.
>> 
>> As far as I can see, syslog(3) blocks when the local socket becomes
>> full (11 messages on my system).
>> 
>> Consider the following program.
>> 
>> #include <syslog.h>
>> int main(void)
>> {
>>   int i;
>>   for (i=0; i < 500; ++i) syslog(LOG_INFO, "I=%d", i);
>>   return 0;
>> }
> 
> John, I use glibc-2.6-4 and your test program worked fine. Probably

When you write "your test program worked fine" do you mean that
the process ran and exited with 0?

> your man page (3) for syslog may have details on this feature.

What feature are you referring to?

> You probably have reached one of the old approaches to avoid DoS via
> syslog. Limited message rate would be a reasonable assumption.

Did you kill syslogd before running the test program?

> One way to better understand what's going on is to either setup
> syslogd or your client program (via openlog) to enter in debug mode
> an print to stderr.

In my example, syslogd is not running. See below.

>> I kill syslogd, then start the above program. It blocks.
>> I kill it, then start syslogd, which grabs the following messages.
>> 
>> Nov 13 11:18:57 venus a.out: I=0
>> Nov 13 11:18:57 venus a.out: I=1
>> Nov 13 11:18:57 venus a.out: I=2
>> Nov 13 11:18:57 venus a.out: I=3
>> Nov 13 11:18:57 venus a.out: I=4
>> Nov 13 11:18:57 venus a.out: I=5
>> Nov 13 11:18:57 venus a.out: I=6
>> Nov 13 11:18:57 venus a.out: I=7
>> Nov 13 11:18:57 venus a.out: I=8
>> Nov 13 11:18:57 venus a.out: I=9
>> Nov 13 11:18:57 venus a.out: I=10
>> 
>> (The process managed to write 11 messages before being blocked.)
>> 
>> I expected a local socket to buffer way more than 11 messages.
>> I expected a local socket to discard new messages when it is full.
>> Apparently, these expectations are incorrect.
>> 
>> I can see how this behavior can become a problem:
>> 
>> Consider process A with prio 80 in SCHED_FIFO and process B with prio 10
>> in SCHED_FIFO, i.e. process B only runs when A does not want the CPU.
>> (syslogd is in SCHED_OTHER.)
>> 
>> 'A' runs, starts logging, and reaches the 11-message limit. The call to
>> write() blocks, and 'A' is put to sleep. The scheduler then picks 'B'
>> because it has higher priority than syslogd. If B runs "forever", 'A'
>> will never get the CPU back.
>> 
>> Is this scenario possible?
>> 
>> Is this what is called priority inversion?
