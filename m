From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: syslog(3) blocks when local socket is full
Date: Tue, 13 Nov 2007 15:14:58 -0200
Message-ID: <20071113171458.GP6086@unix.sh>
References: <4739B6CB.4070903@free.fr> <20071113154659.GN6086@unix.sh> <4739CD85.1020808@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sr02-09.mta.terra.com.br ([200.154.152.38]:53398 "EHLO
	sr02-09.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757672AbXKMRPB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 12:15:01 -0500
Content-Disposition: inline
In-Reply-To: <4739CD85.1020808@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Nov 13, 2007 at 05:15:01PM +0100, John Sigler wrote:
| Luis Claudio R. Goncalves wrote:
| 
| >John Sigler wrote:
| >
| >>My platform: Linux 2.6.22.1-rt9 + glibc 2.3.6
| >>
| >>I'm writing a "real-time" application that runs with high priority
| >>(40 or 80 in SCHED_FIFO). I use syslog(3) to log.
| >>
| >>As far as I can see, syslog(3) blocks when the local socket becomes
| >>full (11 messages on my system).
| >>
| >>Consider the following program.
| >>
| >>#include <syslog.h>
| >>int main(void)
| >>{
| >>  int i;
| >>  for (i=0; i < 500; ++i) syslog(LOG_INFO, "I=%d", i);
| >>  return 0;
| >>}
| >
| >John, I use glibc-2.6-4 and your test program worked fine. Probably
| 
| When you write "your test program worked fine" do you mean that
| the process ran and exited with 0?

Sorry, I wrote that in a hurry and have eatean some words :)

Yes, after running the test program I ended up with 500 messages in syslog
and 0 as the return code. 
 
| >your man page (3) for syslog may have details on this feature.
| 
| What feature are you referring to?

Syslog manpage (3), glibc 2.6-4, talks about the possibility of a DoS in
the system using syslog as the weapon to do that. It also describes some
known ways to protect your system of this possible DoS.

Checking the manpage (man 3 syslog) may give you hints on whether the
behavior you observed is a rate limit imposed by syslog, a "feature" of
your system or nothing related to syslog.

| >You probably have reached one of the old approaches to avoid DoS via
| >syslog. Limited message rate would be a reasonable assumption.
| 
| Did you kill syslogd before running the test program?

Nope. I booted my machine 10 days ago and just compiled and ran the test
code you sent in your email.

| >One way to better understand what's going on is to either setup
| >syslogd or your client program (via openlog) to enter in debug mode
| >an print to stderr.
| 
| In my example, syslogd is not running. See below.

Ugh! I missed that.

I did some more testing, now with syslog turned off. The return code is
always 0, the program runs to completition - without hanging or without
waiting for any event. Turning syslog on, no singe log message from the
test program appears.

strace:

500 repetitions of:

 socket(PF_FILE, SOCK_DGRAM, 0)          = 3
 fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
 connect(3, {sa_family=AF_FILE, path="/dev/log"}, 110) = -1 ENOENT (No such
 file or directory)
 close(3)                                = 0

Anyway, the default for syslog is to be LOG_ODELAY, so it waits until the
conection is made before going on. That can be changed using LOG_NDELAY in
openlog().

 
| >>I kill syslogd, then start the above program. It blocks.
| >>I kill it, then start syslogd, which grabs the following messages.
| >>
| >>Nov 13 11:18:57 venus a.out: I=0
| >>Nov 13 11:18:57 venus a.out: I=1
| >>Nov 13 11:18:57 venus a.out: I=2
| >>Nov 13 11:18:57 venus a.out: I=3
| >>Nov 13 11:18:57 venus a.out: I=4
| >>Nov 13 11:18:57 venus a.out: I=5
| >>Nov 13 11:18:57 venus a.out: I=6
| >>Nov 13 11:18:57 venus a.out: I=7
| >>Nov 13 11:18:57 venus a.out: I=8
| >>Nov 13 11:18:57 venus a.out: I=9
| >>Nov 13 11:18:57 venus a.out: I=10
| >>
| >>(The process managed to write 11 messages before being blocked.)
| >>
| >>I expected a local socket to buffer way more than 11 messages.
| >>I expected a local socket to discard new messages when it is full.
| >>Apparently, these expectations are incorrect.
| >>
| >>I can see how this behavior can become a problem:
| >>
| >>Consider process A with prio 80 in SCHED_FIFO and process B with prio 10
| >>in SCHED_FIFO, i.e. process B only runs when A does not want the CPU.
| >>(syslogd is in SCHED_OTHER.)
| >>
| >>'A' runs, starts logging, and reaches the 11-message limit. The call to
| >>write() blocks, and 'A' is put to sleep. The scheduler then picks 'B'
| >>because it has higher priority than syslogd. If B runs "forever", 'A'
| >>will never get the CPU back.
| >>
| >>Is this scenario possible?
| >>
| >>Is this what is called priority inversion?
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
