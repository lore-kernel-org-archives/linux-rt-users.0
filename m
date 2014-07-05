From: Jan de Kruyf <jan.de.kruyf@gmail.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Sat, 5 Jul 2014 21:30:30 +0200
Message-ID: <CAA85NCiG8T2vWh2pBbTBUuoOCrHAkYqJXQ2LLMu0HSwYMWeCPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:35574 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965192AbaGETab (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 5 Jul 2014 15:30:31 -0400
Received: by mail-qc0-f175.google.com with SMTP id i8so2415803qcq.20
        for <linux-rt-users@vger.kernel.org>; Sat, 05 Jul 2014 12:30:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Good people,

Is it possible that the copy of the mail to the xfs mailinglist below
is connected to this problem?
If so, is there anything I can do to help? I am not a kernel developer
but I have run debugging stuff before, just give instructions.

Greetings from dark Africa

Jan de Kruijf.


---------- Forwarded message ----------
From: Jan de Kruyf <jan.de.kruyf@gmail.com>
Date: Sat, Jul 5, 2014 at 2:41 PM
Subject: Data loss XFS with RT kernel on Debian.
To: xfs@oss.sgi.com


Hallo,

While doing a reasonably high density job like rsynching a
subdirectory from one place to another, or tarring it to a pipe
and untarring it at the other end, I note that the cpu usage goes
practically to 100% and when I after 5 minutes or so I reset the
computer the writing has not finished at all. However on the
stock Debian kernel it works without a problem.

Could I still use this combination in an industrial environment
reading and writing reasonably short text files? So far I did not
experience this problem with normal day to day use. It stuck up
its head during installation of gnat-gpl-2014-x86_64-linux-bin
from the http://libre.adacore.com/download/ page. The offending
code is in the Makefile in the top directory page. The Xterm will
give you the place where it gets stuck.

Regards,

Jan de Kruijf.



Her are the details of the installation:

root@jan:~# xfs_info -V
xfs_info version 3.1.7

root@jan:~# xfs_info /usr
meta-data=/dev/sda3 isize=256 agcount=4, agsize=732416 blks
= sectsz=512 attr=2
data = bsize=4096 blocks=2929664, imaxpct=25
= sunit=0 swidth=0 blks
naming =version 2 bsize=4096 ascii-ci=0
log =internal bsize=4096 blocks=2560, version=2
= sectsz=512 sunit=0 blks, lazy-count=1
realtime =none extsz=4096 blocks=0, rtextents=0

This combination does not work:
root@jan:~# uname -a
Linux jan 3.14-0.bpo.1-rt-amd64 #1 SMP PREEMPT RT Debian
3.14.7-1~bpo70+1 (2014-06-21) x86_64 GNU/Linux

Also kernel 3.10-0.bpo.3-rt-amd64 does not work

But this combination works:
root@jan:~# uname -a
Linux jan 3.2.0-4-amd64 #1 SMP Debian 3.2.57-3+deb7u2 x86_64 GNU/Linux
