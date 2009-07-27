From: Denis Richard <denis.richard@alcatel-lucent.fr>
Subject: SCHED_RR preempted by SCHED_OTHER
Date: Mon, 27 Jul 2009 13:57:31 +0200
Message-ID: <4A6D962B.20408@alcatel-lucent.fr>
Reply-To: denis.richard@alcatel-lucent.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smail3.alcatel.fr ([64.208.49.56]:54639 "EHLO smail3.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbZG0MUV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jul 2009 08:20:21 -0400
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail3.alcatel.fr (8.13.8/8.13.8/ICT) with ESMTP id n6RBvWrw031309
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 13:57:32 +0200
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id NAA10313
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 13:57:32 +0200 (MET DST)
Received: from [172.25.51.2] (frilln0l015383.emea.lucent.com [172.25.51.2])
	by mail (8.8.8p2+Sun/) with ESMTP id NAA10303
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 13:57:32 +0200 (MET DST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,
We work on powerpc board with kernel 2.6.29.6-rt23.
The kernel is configured with  "Complete Preemption (Real-Time)".
Working on our software, we have a strange behavior.
A real time thread (SCHED_RR) can be preempted by non real time one 
(SCHED_OTHER).

We wrote a little test program (at the end of  this mail).
This program creates 2 threads, a SCHED_RR one which processes during 
about 12s
(long for a real time, but just for test), and a SCHED_OTHER one, 
started after the first one,
which just modifies a global variable. The second one should not run 
during the execution of
the first one. But it appends, the global variable is modified.

 > rr_other
Create thread
OTHER ran during RR
The end
 >

Is it normal, a non real time thread preempts a real time one ? (we 
think, it is not)
Or is there something wrong in the test program, the kernel 
configuration, ... ?

PS: We have the same behavior with SCHED_FIFO.
      We tried the same test program on a kernel without the rt patch, 
it seesms to work well.

Thanks

Denis

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sched.h>
#include <sys/mman.h>
#include <pthread.h>

#define MAX_SAFE_STACK    (8*1024) /* The maximum stack size which is
                    guaranteed safe to access without faulting */

pthread_t pthid_rr, pthid_other;
volatile int global_var = 0, global_modified = 0;

void stack_prefault(void)
{
    unsigned char dummy[MAX_SAFE_STACK];

    memset(&dummy, 0, MAX_SAFE_STACK);
    return;
}

void* thr_rr(void * arg)
{
    int i, j, local_var;

    sleep(2);    /* Let main continue */
    local_var = global_var;
    /* Processing for ~ 12s */
    for (j = 0; j < 120 ; j++) {
        for (i = 0; i < 5000000; i++); /* ~ 100ms on our powerpc */
    }
    if (global_var != local_var) {
        global_modified = 1;
    }
    pthread_exit(NULL);
}

void* thr_other(void * arg)
{
    int    i;

    sleep(4);    /* Start after RR thread */
    /* Loop 6 s */
    for (i = 0; i < 6; i++) {
        global_var = i;
        sleep(1);
    }
    pthread_exit(NULL);
}

void create_th(void)
{
    pthread_attr_t thread_attr_id;
    int status;
    struct sched_param schedparam;

    /* SCHED_RR thread */
    if ((status = pthread_attr_init(&thread_attr_id)) != 0) {
        fprintf(stderr, "Error pthread_attr_init() for periodic: 
0x%x\n", status);
        exit(-1);
    }
    if ((status = pthread_attr_setschedpolicy(&thread_attr_id, 
SCHED_RR)) != 0) {
        fprintf(stderr, "Error pthread_attr_setschedpolicy() for 
periodic: 0x%x\n", status);
        exit(-1);
    }
    if ((status = pthread_attr_setinheritsched(&thread_attr_id, 
PTHREAD_EXPLICIT_SCHED)) != 0) {
        fprintf(stderr, "Error pthread_attr_setinheritsched() for 
periodic: 0x%x\n", status);
        exit(-1);
    }
    schedparam.sched_priority = 60;
    if ((status = pthread_attr_setschedparam(&thread_attr_id, 
&schedparam)) != 0) {
        fprintf(stderr, "Error pthread_attr_setschedparam() for 
periodic: 0x%x\n", status);
        exit(-1);
    }
    if ((status = pthread_create(&pthid_rr, &thread_attr_id, thr_rr, 
(void *) 0)) != 0) {
        fprintf(stderr, "Error pthread_create() for periodic: 0x%x\n", 
status);
        exit(-1);
    }
    if ((status = pthread_attr_destroy(&thread_attr_id)) != 0) {
        fprintf(stderr, "Error pthread_attr_destroy() for periodic: 
0x%x\n", status);
        exit(-1);
    }
    /* SCHED_OTHER thread */
    if ((status = pthread_attr_init(&thread_attr_id)) != 0) {
        fprintf(stderr, "Error pthread_attr_init() for other: 0x%x\n", 
status);
        exit(-1);
    }
    if ((status = pthread_attr_setschedpolicy(&thread_attr_id, 
SCHED_OTHER)) != 0) {
        fprintf(stderr, "Error pthread_attr_setschedpolicy() for other: 
0x%x\n", status);
        exit(-1);
    }
    if ((status = pthread_attr_setinheritsched(&thread_attr_id, 
PTHREAD_EXPLICIT_SCHED)) != 0) {
        fprintf(stderr, "Error pthread_attr_setinheritsched() for other: 
0x%x\n", status);
        exit(-1);
    }
    if ((status = pthread_create(&pthid_other, &thread_attr_id, 
thr_other, (void *) 0)) != 0) {
        fprintf(stderr, "Error pthread_create() for other: 0x%x\n", status);
        exit(-1);
    }
    if ((status = pthread_attr_destroy(&thread_attr_id)) != 0) {
        fprintf(stderr, "Error pthread_attr_destroy() for other: 
0x%x\n", status);
        exit(-1);
    }
}

int main(int argc, char* argv[])
{
    /* Lock memory */
    if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
            perror("mlockall failed");
            exit(-2);
    }
    /* Pre-fault our stack */
    stack_prefault();

    printf("Create thread\n");  
    create_th();
    /* Wait end of thread_other */
    if (pthread_join(pthid_other, NULL) != 0) {
        fprintf(stderr, "Error pthread_join() for periodic\n");
        exit(-1);
    }
    /* Wait end of thread_rr */
    if (pthread_join(pthid_rr, NULL) != 0) {
        fprintf(stderr, "Error pthread_join() for periodic\n");
        exit(-1);
    }
    if (global_modified) {
        printf("OTHER ran during RR\n");
    }
    printf("The end\n");
}

