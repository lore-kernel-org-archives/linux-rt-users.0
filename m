From: John Sigler <linux.kernel@free.fr>
Subject: Re: syslog(3) blocks when local socket is full
Date: Wed, 14 Nov 2007 10:04:45 +0100
Message-ID: <473ABA2D.6060009@free.fr>
References: <4739B6CB.4070903@free.fr> <20071113154659.GN6086@unix.sh> <4739CD85.1020808@free.fr> <20071113171458.GP6086@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:43378 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbXKNJEs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Nov 2007 04:04:48 -0500
In-Reply-To: <20071113171458.GP6086@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

(You're using a weird quote character.)

Luis Claudio R. Goncalves wrote:

> I did some more testing, now with syslog turned off. The return code is
> always 0, the program runs to completion - without hanging or without
> waiting for any event. Turning syslog on, no singe log message from the
> test program appears.
> 
> strace:
> 
> 500 repetitions of:
> 
>  socket(PF_FILE, SOCK_DGRAM, 0)          = 3
>  fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
>  connect(3, {sa_family=AF_FILE, path="/dev/log"}, 110) = -1 ENOENT
>    (No such file or directory)
>  close(3)                                = 0

The /dev/log file does not exist because syslogd removed it.
(A process must bind that "address" for the file to exist.)
The program tries to connect, and fails, 500 times.

My description of the setup was incorrect.

#include <syslog.h>
int main(void)
{
   int i;
   for (i=1; i <= 1000; ++i)
   {
     printf("Sending I=%d\n", i);
     syslog(LOG_INFO, "I=%d", i);
   }
   return 0;
}

1. start syslogd (the syslog daemon)
2. send syslogd the STOP signal
3. run the test program (it will block)
4. kill the test program
5. send syslogd the CONT signal

syslogd binds "/dev/log" which "creates" the socket:
$ ls -l /dev/log
srw-rw-rw- 1 root root 0 2007-10-08 09:36 /dev/log=

> Anyway, the default for syslog is to be LOG_ODELAY, so it waits until the
> connection is made before going on. That can be changed using LOG_NDELAY in
> openlog().

LOG_NDELAY and LOG_ODELAY are a different matter.

Regards.
