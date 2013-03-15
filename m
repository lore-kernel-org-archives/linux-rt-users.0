From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: entry_32.S ret_from_intr and invocation of scheduler, v3.2-rt
Date: Fri, 15 Mar 2013 22:36:02 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303152225250.22263@ionos>
References: <CAO2z5Zi52q94xfmqRDwq5XSgD-VaVitnJ_JNnEpGOr9Spi4cWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: notgeorge burns <not.george.burns@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59884 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab3COVgD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Mar 2013 17:36:03 -0400
In-Reply-To: <CAO2z5Zi52q94xfmqRDwq5XSgD-VaVitnJ_JNnEpGOr9Spi4cWA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 15 Mar 2013, notgeorge burns wrote:
> Does the hardirq handler need to do something to make the TI_flags
> work properly against _TIF_WORK_MASK ?   _TIF_WORK_MASK doesn't
> include TIF_NEED_RESCHED so it seems that this wouldn't be the right
> way to do it?

To be honest I was puzzled for a second by that mysel after reading
your mail, but you got tricked by really obfuscated macro magic:

        andl $_TIF_WORK_MASK, %ecx      # is there any work to be done on
                                        # int/exception return?
        jne work_pending

So we jump to work_pending, if any bit of _TIF_WORK_MASK is set in ecx

#define _TIF_WORK_MASK                                                  \
        (0x0000FFFF &                                                   \
         ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|                       \
           _TIF_SINGLESTEP|_TIF_SECCOMP|_TIF_SYSCALL_EMU))

So we keep everything in 0xffff _except_ _TIF_SYSCALL_TRACE,
_TIF_SYSCALL_AUDIT, _TIF_SINGLESTEP, _TIF_SECCOMP, _TIF_SYSCALL_EMU

Note the "~" before (_TIF ...... EMU) !

So _TIF_NEED_RESCHED is preserved and checked and handled in
work_pending.

You made me worried for a second, but that code has been that way for
almost a decade, so RT would have stumbled over it at some point :)

Thanks,

	tglx
