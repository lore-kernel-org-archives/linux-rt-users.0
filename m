From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: deterministic usage of JIFFIES and how to relocate the clock
Date: Sun, 24 Jan 2016 09:40:33 +0100
Message-ID: <CA+Owze7+=vMDaqX25OVQ6ZrRgGj9j2BZjEZt_GyG+9+6+6ELWA@mail.gmail.com>
References: <CA+Owze7GnFYrpVMWSuPd=qXj8auf3fL-mPsZNPVMeP=FQtZsPg@mail.gmail.com>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: jkraehemann-guest@users.alioth.debian.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34968 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbcAXIke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Jan 2016 03:40:34 -0500
Received: by mail-yk0-f171.google.com with SMTP id u68so2622348ykd.2
        for <linux-rt-users@vger.kernel.org>; Sun, 24 Jan 2016 00:40:34 -0800 (PST)
In-Reply-To: <CA+Owze7GnFYrpVMWSuPd=qXj8auf3fL-mPsZNPVMeP=FQtZsPg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

At my opinion I was thinking at a lower level than needed. The
application runs at least aside the kernel.
Probably I want to control PC (program counter) and redeclare the
longjump function as macro. To gain control
over throughput rate and thus being able to grain loading and unloading=
 thread.

int sched_setaffinity(pid_t pid, size_t cpusetsize,
                             const cpu_set_t *mask);

void longjmp(jmp_buf env, int val);

cheers,
Jo=C3=ABl


On Fri, Jan 22, 2016 at 10:37 AM, Jo=C3=ABl Kr=C3=A4hemann <jkraehemann=
@gmail.com> wrote:
> Hi all
>
> Since I'm hardware newbie I just ask in my very own words, how to
> relocate the clock. I want to play around with the clock modulator in
> GNU/Linux. Is there any interface to relocate it?
>
> What must do a user-space application do to change underlaying cipher=
?
> I don't care about gdb or valgrind issues or trap-points. Might be in
> further sense interrupts.
>
> Is possible to have a VM in userspace? Once I have seen different VMs
> available in the kernel. Does even have the VM control of
> clock-modulator? Do I need some knowledge about ACPI to do so?
>
> Are there some good books about that thematics I could start with?
> Since I like math it would be fun to do so.
>
> bests,
> Jo=C3=ABl Kr=C3=A4hemann
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
