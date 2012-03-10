From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: timer signal loss on RT
Date: Sat, 10 Mar 2012 05:26:24 -0500
Message-ID: <4F5B2C50.2090907@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020307040801070806030007"
Cc: Mark Hounschell <markh@compro.net>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:27754 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab2CJK01 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 Mar 2012 05:26:27 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020307040801070806030007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to run one of our applications while using the RT kernel. I am 
having a problem receiving timer signals in a RT thread pinned to a 
processor. The thread is a spinning cpu hog. I am not able to provide 
source for this application but have written a simple test case that 
_seems_ to fail the same way.  This works fine on a non-RT kernel. I have 
attached the test case. It basically sets up a 60Hz repeating timer, runs 
for 10 seconds, then displays how many signals the RT thread caught. Should 
be around 600. And it is on a vanilla kernel but not on an RT kernel. It 
does require an SMP box to run. It will NOT lockup your machine if you run 
it. Worse case would be for 10 seconds. The 2 RT priorities in use are less 
than 50 BTW.

I'm sure you can find many things wrong with this test case but I'm not 
sending it for discussion on the merits, or certainly the lack of, an 
application that contains a cpu hog, but only to show what I think is a 
problem with RT kernels.

compile with "cc rtc.c -o rtc -lrt -lpthread"

run it and in 10 seconds it should stop and indicate 600 timers signals 
were caught by the RT thread. On RT, I usually get 0 but often I get some, 
just not 600.

Thanks in advance
Mark


--------------020307040801070806030007
Content-Type: text/x-csrc;
 name="rtc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rtc.c"

#include <signal.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <sys/time.h>
#include <sched.h>

#define __NR_sched_set_affinity 241     
#define __NR_sched_get_affinity 242     

int32_t sig_occured = 0;
int32_t sig_count   = 0;
int32_t Sig;
int32_t exit_flg = 0;
int32_t thread_running = 0;

uint32_t pri_mask = 0x01;
uint32_t sec_mask = 0x02;

sigset_t pri_sset;
sigset_t sec_sset;
timer_t timerid;
pthread_t thread_id;

struct itimerspec RTC_value;
struct sigevent  sig_event;
struct sigaction sigaction_block;
struct sched_param sparam;

void RTC_isr() 
{
    sig_occured = 1;
}

void *thread_code(void *args)
{
    uint64_t nsecs;

    //
    // Pin self to a different processor 
    //
    syscall(__NR_sched_set_affinity, 0, sizeof(sec_mask), &sec_mask);

    //
    // Set self to SCHED_FIFO
    //
    sparam.sched_priority = 30;
    pthread_setschedparam(thread_id, SCHED_FIFO, &sparam);

    Sig = SIGRTMIN;
    sigaction_block.sa_handler = (__sighandler_t)RTC_isr;
    sigaction_block.sa_flags = SA_RESTART;

    if (sigaction(Sig, &sigaction_block, NULL) < 0) {
        perror("sigaction failed: ");
        goto out;
    }

    sig_event.sigev_signo  = Sig;
    sig_event.sigev_notify = SIGEV_SIGNAL;

    if (timer_create(CLOCK_MONOTONIC, &sig_event, &timerid) < 0) {
        perror("timer_create failed: ");
        goto out;
    }

    //
    // UNBlock signals
    //
    sigfillset(&sec_sset);
    pthread_sigmask(SIG_UNBLOCK, &sec_sset, NULL);

    //
    // start the 60 Hz repeating timer running
    //
    nsecs = (uint64_t) (1000000000LL / 60); 

    RTC_value.it_value.tv_sec     = nsecs / 1000000000LL;
    RTC_value.it_value.tv_nsec    = nsecs % 1000000000LL;
    RTC_value.it_interval.tv_sec  = RTC_value.it_value.tv_sec;
    RTC_value.it_interval.tv_nsec = RTC_value.it_value.tv_nsec;

    if (timer_settime(timerid, 0, &RTC_value, NULL) < 0) {
        perror("timer_settime failed: ");
        goto out;
    }

    thread_running = 1;

    while (!exit_flg) {
        if (sig_occured) {
            sig_occured = 0;
            sig_count++;
    }}

  out:

    if (timerid)
        timer_delete(timerid);

    return (0);
}

int32_t main(int argc, char **argv)
{
    int32_t i = 0;
    int32_t sleep_cnt = 0;

    //
    // Pin self to a processor 
    //
    syscall(__NR_sched_set_affinity, 0, sizeof(pri_mask), &pri_mask);

    //
    // Set self to SCHED_FIFO
    //
    sparam.sched_priority = 35;
    sched_setscheduler(0, SCHED_FIFO, &sparam);

    //
    // Block signals to self
    //
    sigfillset(&pri_sset);
    sigprocmask(SIG_BLOCK, &pri_sset, NULL);

    pthread_create(&thread_id, NULL, thread_code, NULL);

    while(!thread_running)
        usleep(100);

    while (sleep_cnt < 10) {
        sleep(1);
        sleep_cnt++;
    }

    exit_flg = 1;
    pthread_cancel(thread_id);

    printf("Thread process received %d signals\n", sig_count);

    exit (0);
}


--------------020307040801070806030007--
