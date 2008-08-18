From: Gilles Carry <gilles.carry@bull.net>
Subject: [PATCH 0/2][RT] hrtimers stuck in waitqueue
Date: Mon, 18 Aug 2008 16:42:30 +0200
Message-ID: <1219070552-30783-1-git-send-email-gilles.carry@bull.net>
Cc: tglx@linutronix.de, mingo@elte.hu, tinytim@us.ibm.com,
	jean-pierre.dion@bull.net, sebastien.dugue@bull.net,
	gilles.carry@bull.net
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38132 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYHROmu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Aug 2008 10:42:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Hello,

These patches are to fix a bug for high resolution timers initialized by
hrtimer_init_sleeper (nanosleep and futexes) which can get stuck on a
wait queue.
They apply onto 2.6.26-rt1

The below test shows up the bug. Though the test hangs immediately on
my ppc64 (8 CPU), it can takes tens of minutes on my x86_64 (8 CPU).
(kernel must feature: CONFIG_HIGH_RES_TIMERS=y)

#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define NUM_THREADS     30
#define NUM_LOOPS       10000

void *worker_thread(void *arg)
{
        long id = (long)arg;
        int i;

        for (i = 0; i < NUM_LOOPS; i++) {
                usleep(1000);
        }

        printf("thread %02ld done\n", id+1);

        return NULL;
}

int main(int argc, char* argv[])
{
        int i;
        struct sched_param param;
        pthread_attr_t attr;
        pthread_t *threads;

        if ((threads = malloc(NUM_THREADS * sizeof(pthread_t))) == NULL)
{
                perror("Failed to allocate threads\n");
                return 1;
        }

        param.sched_priority = sched_get_priority_min(SCHED_FIFO);
        pthread_attr_init(&attr);
        pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
        pthread_attr_setschedparam(&attr, &param);
        pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

        /* start threads */
        for (i = 0; i < NUM_THREADS; i++) {
                if (pthread_create(&threads[i], &attr,
                                   worker_thread, (void *)(long)i))
                        perror("Failed to create thread\n");
        }

        pthread_attr_destroy(&attr);

        for (i = 0; i < NUM_THREADS; i++)
                pthread_join(threads[i], NULL);

        free(threads);

        return 0;
}


This occurs when hrtimer_interrupt is very busy and some awakened
threads enter hrtimer_cancel before hrtimer_interrupt has changed the
timer status. These threads are queued on a wait queue and are almost
never awakened since HRTIMER_CB_IRQSAFE_NO_SOFTIRQ timers are not supposed
to raise a softirq.
They would sometimes be awakened and only when another timer awakes and
uses a softirq call back set on the same CPU!!!
Before the patch, I could unlock them all by flooding the system with the
below program in order to run softirq timers with the same CB mode
on all CPUs.

#include <unistd.h>

main() {
	alarm(1);
	pause();
}

Adding traces (not included in this patch) to /proc/timer_list did
help to track the bug.


The second patch is a code cleanup that makes the code more readable.

I have run flawlessly the above test with the patched kernel for
~100 hours on two 8-way systems: x86_64 and ppc64 (power 6)
