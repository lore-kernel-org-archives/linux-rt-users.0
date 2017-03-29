From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Wed, 29 Mar 2017 09:23:57 -0400
Message-ID: <20170329092357.2ca784c2@redhat.com>
References: <20170323165512.60945ac6@redhat.com>
        <20170329130447.GB8306@lerouge>
        <1490793272.28917.5.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/VnTC34nrF2nX6Xsaw90i5U3"
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Wanpeng Li <kernellwp@gmail.com>
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753680AbdC2NYA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Mar 2017 09:24:00 -0400
In-Reply-To: <1490793272.28917.5.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--MP_/VnTC34nrF2nX6Xsaw90i5U3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 29 Mar 2017 09:14:32 -0400
Rik van Riel <riel@redhat.com> wrote:

> > I failed to reproduce with your config. I'm still getting 99%
> > userspace
> > cputime. So I'm wondering if the hogging style plays a role.
> >=20
> > I run pure user loops:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0int main(int argc, char **argv)
> > =C2=A0=C2=A0=C2=A0=C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (;;);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0
> > =C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > Does your user program perform syscalls or IOs of some sort? =20
>=20
> Luiz's program makes a syscall every millisecond,
> if started with the arguments he gave as his
> reproducer.

There are various reproducers actually. I started off with the simple
loop above, then wrote the attach program and then wrote the one
you're mentioning:

 http://people.redhat.com/~lcapitul/real-time/acct-bug.c

All of them reproduce the issue 100% of the time for me.

--MP_/VnTC34nrF2nX6Xsaw90i5U3
Content-Type: text/x-c++src
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hog.c

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sched.h>
#include <sys/types.h>

static int move_to_cpu(int cpu)
{
        cpu_set_t set;

        CPU_ZERO(&set);
        CPU_SET(cpu, &set);
        return sched_setaffinity(0, sizeof(set), &set);
}

static void loop(void)
{
        for (;;) ;
}

static int fork_hog(int cpu)
{
        int pid;

        pid = (int) fork();
        if (pid == 0) {
                move_to_cpu(cpu);
                loop();
                exit(0);
        }

        return pid;
}

int main(int argc, char *argv[])
{
        int i, pid, cpu, nr_procs;

		if (argc != 3) {
			printf("usage: hog < nr-procs > < CPU >\n");
			exit(1);
		}

		cpu = atoi(argv[2]);
		nr_procs = atoi(argv[1]);

        for (i = 0; i < nr_procs; i++) {
                pid = fork_hog(cpu);
                fprintf(stderr, "created hog%d pid=%d\n", i, pid);
        }

        fprintf(stderr, "pausing...\n");
        pause();

        return 0;
}

--MP_/VnTC34nrF2nX6Xsaw90i5U3--
