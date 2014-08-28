From: Vincent Legout <vincent@legout.info>
Subject: Re: set_schedattr + cpuset issue
Date: Thu, 28 Aug 2014 17:07:48 -0400
Message-ID: <871ts0s4pn.fsf@cecht.legt.fr>
References: <CAMLzMweCcxPBJExGsY-2oHK6sdF6EVgBsa1XVxQT0=kzNRZAJQ@mail.gmail.com>
	<20140710122033.58bdd366fe3f869a71b1c05e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Kevin Burns <kevinpb@vt.edu>, linux-rt-users@vger.kernel.org
To: Juri Lelli <juri.lelli@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cethen.legt.fr ([92.243.2.98]:56103 "EHLO cethen.legt.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbaH1VSB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Aug 2014 17:18:01 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Hello,

Juri Lelli <juri.lelli@gmail.com> writes:

> On Wed, 2 Jul 2014 17:08:47 -0400
> Kevin Burns <kevinpb@vt.edu> wrote:
>
>> Here's the issue:
>> 
>> I am able to allocate a bandwidth with a ratio of .1 to two processes using
>> the sched_setattr() system call.
>> 
>> I then am able to add said tasks to a cpuset (with one physical processor)
>> using cset.
>> 
>> However, when I then try to update the runtime or period of either task,
>> sched_setattr returns a -EBUSY error.
>> 
>> Now, if I repeat the above experiment with just one task, I am able to
>> update the runtime or period without issue. I ran trace-cmd and kernelshark
>> to verify that the bandwidths were indeed being updated correctly. That and
>> htop was reporting a higher percentage of CPUusage, which correlated to the
>> ratios of my task's bandwidth.
>> 
>> Any ideas as to why cpuset would cause this behaviour?
>> 
>
> Could you create a script that I can use to run your setup and reproduce
> the problem?

Sorry for the delayed answer. I'm working with Kevin and the problem can
be reproduced using the attached files, also available here:

 http://legout.info/~vincent/sd/

On a Ubuntu 14.04 system running Linux 3.16, when running run.sh for the
2nd time, the 2nd call to sched_setattr() returns EBUSY. Uncommenting
line 41 of run.sh fixes this by returning to SCHED_OTHER before moving
the task to the cpuset.

The problem arises when using both cpusets and SCHED_DEADLINE. The
process described in section 5.1 of the SCHED_DEADLINE documentation
works fine if the process stays on the same cpuset, but I think their
are some issues when moving a process already in the SCHED_DEADLINE
policy from one cpuset to another.

According to our experiments, it seems that some fields are not updated
during this process, and it thus fails. When a task moves from one
cpuset to another, the total_bw fields of both cpusets doesn't seem to
be updated. Thus, in the next sched_setattr() call, __dl_overflow()
returns 1 because it thinks total_bw is 0 in the new cpuset. Then,
dl_overflow() returns -1 and we have a EBUSY error.

The total_bw field may also overflow because __dl_clear and __dl_add are
called while the task whose bandwidth is tsk_bw is not in the cpu
represented by dl_b.

We can get around this by moving the process back to another scheduling
policy before moving it to another cpuset. But we also had to apply the
following patch in order to be sure that the bandwith is always updated
(on top of v3.16). I'd think this condition has been added to skip all
the tests if the bandwith doesn't change. But there is an issue because
then, the total_bw field is not going to be updated for the new cpu. I'd
think the problem comes from the fact that p->dl.dl_bw is not updated
when a task leaves or returns the SCHED_DEADLINE policy.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bc1638b..0df3008 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2031,9 +2031,6 @@ static int dl_overflow(struct task_struct *p, int policy,
        u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
        int cpus, err = -1;
 
-       if (new_bw == p->dl.dl_bw)
-               return 0;
-
        /*
         * Either if a task, enters, leave, or stays -deadline but changes
         * its parameters, we may need to update accordingly the total

I hope the above explanations make sense and I didn't miss anything
trivial. I'd be happy to provide more information or test anything if
needed.

Thanks,
Vincent


--=-=-=
Content-Type: text/x-sh
Content-Disposition: inline; filename=run.sh

#!/bin/sh

CPUSET_DIR=/dev/cpuset

if [ ! -d ${CPUSET_DIR} ]
then
        mkdir ${CPUSET_DIR}
        mount -t cgroup -o cpuset cpuset ${CPUSET_DIR}
        mkdir ${CPUSET_DIR}/cpu0
fi

/bin/echo 1 > ${CPUSET_DIR}/cpuset.cpu_exclusive
/bin/echo 0 > ${CPUSET_DIR}/cpuset.sched_load_balance

/bin/echo 2 >  ${CPUSET_DIR}/cpu0/cpuset.cpus
/bin/echo 0 > ${CPUSET_DIR}/cpu0/cpuset.mems
/bin/echo 1 > ${CPUSET_DIR}/cpu0/cpuset.cpu_exclusive
/bin/echo 1 > ${CPUSET_DIR}/cpu0/cpuset.mem_exclusive

gcc -Wall -O2 -o sched_setattr sched_setattr.c
gcc -Wall -O2 -o reset reset.c
gcc -Wall -O2 -o burn burn.c

echo "Launch 1 process"

./burn &
PID1=$!

echo "PID: $PID1"

echo "Moving $PID1 to SCHED_DEADLINE"

# budget 10ms, period 20ms
#
./sched_setattr $PID1 20000000 10000000

sleep 2

# Moving task to SCHED_OTHER

# ./reset $PID1

echo "Activate cpuset"

/bin/echo $PID1 > $CPUSET_DIR/cpu0/tasks

cat $CPUSET_DIR/cpu0/tasks

sleep 2

echo "Trying to update the budget of process 1"

# budget 6ms, same period 20ms
#
./sched_setattr $PID1 20000000 6000000

# It may fail

kill $PID1

exit 0

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=burn.c


int main(void)
{
        while(1);

        return 0;
}

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=sched_setattr.c

#include <sched.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <inttypes.h>
#include <sched.h>
#include <time.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

struct sched_attr {
        u_int32_t size;

        u_int32_t sched_policy;
        u_int64_t sched_flags;

        /* SCHED_NORMAL, SCHED_BATCH */
        int32_t sched_nice;

        /* SCHED_FIFO, SCHED_RR */
        u_int32_t sched_priority;

        /* SCHED_DEADLINE */
        u_int64_t sched_runtime;
        u_int64_t sched_deadline;
        u_int64_t sched_period;
};

#ifdef __x86_64__
#define __NR_sched_setattr              314
#define __NR_sched_getattr              315
#endif

#ifndef SCHED_DEADLINE
#define SCHED_DEADLINE          6
#endif

        static int
sched_setattr(pid_t pid, const struct sched_attr *attr, unsigned int flags)
{
        return syscall(__NR_sched_setattr, pid, attr, flags);
}

__attribute__ ((unused))
        static int
sched_getattr(pid_t pid, const struct sched_attr *attr, unsigned int size, unsigned int flags)
{
        return syscall(__NR_sched_getattr, pid, attr, flags);
}

int main(int argc, char *argv[])
{
        int ret = 0;

        if (argc != 4) {
                printf("usage: sched_dead_test <pid> <deadline> <runtime>\n");
                return 0;
        }

        struct sched_attr *attr = malloc(sizeof(struct sched_attr));

        memset(attr, 0, sizeof(struct sched_attr));

        pid_t pid = (pid_t)(atoi(argv[1]));

        printf("running sched_dead_test for %d\n", pid);

        attr->size = sizeof(struct sched_attr);
        attr->sched_policy = SCHED_DEADLINE;
        attr->sched_deadline = atol(argv[2]);
        attr->sched_period = atol(argv[2]);
        attr->sched_runtime = atol(argv[3]);

        ret = sched_setattr(pid, attr, 0);

        if (ret){
                printf("ret=%d for sched_setattr (%s)\n", ret, strerror(errno));
                return ret;
        }

        printf("\targs: %d,%p,%u\n", pid, attr, 0);

        ret = 0;

        free(attr);

        return 0;
}

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=reset.c

#include <sched.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <inttypes.h>
#include <sched.h>
#include <time.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

struct sched_attr {
        u_int32_t size;

        u_int32_t sched_policy;
        u_int64_t sched_flags;

        /* SCHED_NORMAL, SCHED_BATCH */
        int32_t sched_nice;

        /* SCHED_FIFO, SCHED_RR */
        u_int32_t sched_priority;

        /* SCHED_DEADLINE */
        u_int64_t sched_runtime;
        u_int64_t sched_deadline;
        u_int64_t sched_period;
};

#ifdef __x86_64__
#define __NR_sched_setattr              314
#define __NR_sched_getattr              315
#endif

#ifndef SCHED_DEADLINE
#define SCHED_DEADLINE          6
#endif

        static int
sched_setattr(pid_t pid, const struct sched_attr *attr, unsigned int flags)
{
        return syscall(__NR_sched_setattr, pid, attr, flags);
}

__attribute__ ((unused))
        static int
sched_getattr(pid_t pid, const struct sched_attr *attr, unsigned int size, unsigned int flags)
{
        return syscall(__NR_sched_getattr, pid, attr, flags);
}

int main(int argc, char *argv[])
{
        int ret = 0;

        if (argc != 2) {
                printf("usage: reset <pid>\n");
                return 0;
        }

        struct sched_attr *attr = malloc(sizeof(struct sched_attr));

        memset(attr, 0, sizeof(struct sched_attr));

        pid_t pid = (pid_t)(atoi(argv[1]));

        printf("running reset for %d\n", pid);

        attr->size = sizeof(struct sched_attr);
        attr->sched_policy = SCHED_OTHER;

        ret = sched_setattr(pid, attr, 0);

        if (ret){
                printf("ret=%d for sched_setattr FIFO (%s)\n", ret, strerror(errno));
                return ret;
        }

        sleep(1);

        ret = 0;

        free(attr);

        return 0;
}


--=-=-=--
