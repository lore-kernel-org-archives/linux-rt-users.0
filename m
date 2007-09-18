From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: rc4-rt1: powerpc compile errors
Date: Tue, 18 Sep 2007 16:06:32 +0200
Message-ID: <200709181606.33267.jbe@pengutronix.de>
References: <f87351060709030423t1ac14f3cqd0cd224ba7dba9c5@mail.gmail.com> <3bd6b93c0709030710o21cab1b5y9c8438c40c53560e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:36054 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753248AbXIROGk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Sep 2007 10:06:40 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1IXdik-00027k-5o
	for linux-rt-users@vger.kernel.org; Tue, 18 Sep 2007 16:06:38 +0200
In-Reply-To: <3bd6b93c0709030710o21cab1b5y9c8438c40c53560e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Bruce,

On Monday 03 September 2007 16:10, Bruce Ashfield wrote:
> On 9/3/07, Pradyumna Sampath <pradyumna.sampath@gmail.com> wrote:
> > Hi everyone,
> >
> > Here are some compile errors from the latest -rt patchset for powerpc
> > (mpc5200).
> >
> > arch/powerpc/kernel/entry_32.S: Assembler messages:
> > arch/powerpc/kernel/entry_32.S:231: Error: operand out of range
> > (0x00023d87 is not between 0x00000000 and 0x0000ffff)
> > arch/powerpc/kernel/entry_32.S:644: Error: operand out of range
> > (0x00022006 is not between 0x00000000 and 0x0000ffff)
> > arch/powerpc/kernel/entry_32.S:866: Error: operand out of range
> > (0x00020004 is not between 0x00000000 and 0x0000ffff)
> > arch/powerpc/kernel/entry_32.S:880: Error: operand out of range
> > (0x00020004 is not between 0x00000000 and 0x0000ffff)
> >
> > Im not sure whether this is the right thing to do but we got around
> > this by replacing the linux/include/asm-powerpc/thread_info.h with an
> > older version of the same file from 2.6.21-rt3.
>
> I don't have the code in front of me, but you can also shuffle
> the flags to make sure that macro being used in entry_32.S
> has all the flags within 16 bits (so the immediate operations
> will successfully assemble). That's the route I took. The flags
> have expanded past that threshold just recently.

Yes, there are 17 bits now. Can you provide a patch, how to handle 17 bits
now in arch/powerpc/kernel/entry_32.S? I haven't the experience to modify
the assembler code, so I have no idea how to change this line:

andi. r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)

without using an additional register (I don't know, what register I can use).
Can it look like this?

  lis r?,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@h
  ori r?, r?, (_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)@l
  and. r0, r9, r?

Regards,
Juergen
