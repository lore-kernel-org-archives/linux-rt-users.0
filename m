From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Wed, 29 Mar 2017 23:12:00 +0200
Message-ID: <20170329211159.GA23895@lerouge>
References: <20170323165512.60945ac6@redhat.com>
 <20170329130447.GB8306@lerouge>
 <1490793272.28917.5.camel@redhat.com>
 <20170329092357.2ca784c2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Wanpeng Li <kernellwp@gmail.com>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170329092357.2ca784c2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Mar 29, 2017 at 09:23:57AM -0400, Luiz Capitulino wrote:
> 
> There are various reproducers actually. I started off with the simple
> loop above, then wrote the attach program and then wrote the one
> you're mentioning:
> 
>  http://people.redhat.com/~lcapitul/real-time/acct-bug.c
> 
> All of them reproduce the issue 100% of the time for me.

> #define _GNU_SOURCE
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sched.h>
> #include <sys/types.h>
> 
> static int move_to_cpu(int cpu)
> {
>         cpu_set_t set;
> 
>         CPU_ZERO(&set);
>         CPU_SET(cpu, &set);
>         return sched_setaffinity(0, sizeof(set), &set);
> }
> 
> static void loop(void)
> {
>         for (;;) ;
> }
> 
> static int fork_hog(int cpu)
> {
>         int pid;
> 
>         pid = (int) fork();
>         if (pid == 0) {
>                 move_to_cpu(cpu);
>                 loop();
>                 exit(0);
>         }
> 
>         return pid;
> }
> 
> int main(int argc, char *argv[])
> {
>         int i, pid, cpu, nr_procs;
> 
> 		if (argc != 3) {
> 			printf("usage: hog < nr-procs > < CPU >\n");
> 			exit(1);
> 		}
> 
> 		cpu = atoi(argv[2]);
> 		nr_procs = atoi(argv[1]);
> 
>         for (i = 0; i < nr_procs; i++) {
>                 pid = fork_hog(cpu);
>                 fprintf(stderr, "created hog%d pid=%d\n", i, pid);
>         }
> 
>         fprintf(stderr, "pausing...\n");
>         pause();
> 
>         return 0;
> }

I just tried both of these and none seem to show incorrect cputime :-/
I'm wondering if that bug depends on some hardware.
