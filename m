From: Raz <raziebe@gmail.com>
Subject: From vxworks to linux
Date: Fri, 2 Sep 2011 15:56:35 +0300
Message-ID: <CAPB=Z-oZNZxKg4qKJMmPy_TPBVAy4vXc4fAwnRfUvG4jPnazFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rasty@axi-systems.com, Torsten Scherer <TScherer@manz.com>,
	lbrafman@manz.com
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52879 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1IBM45 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Sep 2011 08:56:57 -0400
Received: by bke11 with SMTP id 11so2628587bke.19
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Sep 2011 05:56:56 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello rt

I am working on porting a vxworks application from vxworks to linux
preempt-rt. this application
is hard real time application as it controls a robot.

here are the current difficulties i face, and i hope to get this
community views:

1. vxworks rt priority range scales up to 255 and not 100 which is not =
enough.

=A0=A0=A0=A0=A0=A0=A0 Compiling kernel with RT_MAX_PRIO set to 255 ( 3.=
0 even
without preemprt rt ) and executing cyclictest crashes kernel
=A0=A0=A0=A0=A0=A0=A0 ( NULL pointer in pick_next_task_rt +0x88 ).=A0 S=
o naive
approach doesn't work.

=A0=A0=A0=A0=A0=A0=A0 How do i increase MAX_RT_PRIO to higher value, ev=
en in the
cost of recompiling an entire system ( all os user space
=A0=A0=A0=A0=A0=A0 code is recompiled with a sanitized kernel headers )=
=2E


2. global critical section

=A0=A0=A0=A0=A0=A0=A0 vxworks does not have the notion of a virtual add=
ress space.
so code that is "user space"
=A0=A0=A0=A0=A0=A0=A0 oriented is executing side by side to an interrup=
t , this
leads to "cli"-like global locks
=A0=A0=A0=A0=A0=A0=A0 in a vxworks world.

=A0=A0=A0=A0=A0=A0=A0 so in linux..
=A0=A0=A0=A0=A0=A0=A0 one solution is to "iopl(3)" and then "sti/cli" i=
n user space
, this is good for UNI processors machines,
=A0=A0=A0=A0=A0=A0=A0 but assuming preempt-rt will run smp machines it =
is not good.
also, disabling interrupts is considered bad
=A0=A0=A0=A0=A0=A0=A0 practice in preempt-rt.
=A0=A0=A0=A0=A0=A0=A0 another solution is to increase the executing thr=
ead priority
to the highest value possible, i believe it is
=A0=A0=A0=A0=A0=A0=A0 theoretically correct assuming i have full contro=
l over the
entire operating system.

=A0=A0=A0=A0=A0=A0=A0 anyone experienced with sort of problems ? or tri=
ed any of the
above with success ?

3. vxworks target shell.

=A0=A0=A0=A0=A0=A0=A0 vxworks provides a shell-like access to its syste=
m, and since
all tasks share address space it is possible
=A0=A0=A0=A0=A0=A0=A0 to access all globals in the c code just like in =
gdb, examine
stacks and so on without disturbing the
=A0=A0=A0=A0=A0=A0=A0 rt task=A0 whatsoever.

=A0=A0=A0=A0=A0=A0=A0 I need this feature in linux per-process.
=A0=A0=A0=A0=A0=A0=A0 At the moment i did not find anything like vx-tar=
get shell in
linux. gdb/ptrace is out of the question as
=A0=A0=A0=A0=A0=A0=A0 they influence the rt task behavior.
=A0=A0=A0=A0=A0=A0=A0 Currently I think to create a thread that is part=
 of to the
process address space. this thread is based on libcli,
=A0=A0=A0=A0=A0=A0=A0 and it it means should integrate it with pstack c=
ode and nm code.

=A0=A0=A0=A0=A0=A0=A0 so before i start writing piles of code, any othe=
r ideas ?

=A0=A0=A0=A0=A0=A0=A0 thank you
=A0=A0=A0=A0=A0=A0=A0 raz
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
