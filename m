From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT]  rt,ipc,sem: fix -rt livelock
Date: Sat, 31 Aug 2013 07:27:30 +0200
Message-ID: <1377926850.6234.22.camel@marge.simpson.net>
References: <20130819213324.405942342@goodmis.org>
	 <1377842245.5422.7.camel@marge.simpson.net>
	 <1377873580.5422.25.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-p1NAvRcm2/eAslmWLRmg"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60182 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab3HaF1l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Aug 2013 01:27:41 -0400
In-Reply-To: <1377873580.5422.25.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-p1NAvRcm2/eAslmWLRmg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The attached proggy (Manfred Spraul) is one reproducer. 

./osim 16 32 1000000 0 0 on my little Q6600 box produced instant
gratification.  IIRC, you don't need that many tasks, fiddle with it,
you'll see the livelock pretty quickly.

There's perhaps a more subtle way to fix it up than loop-ectomy with an
axe, but patient does survive when so treated.

-Mike


Box playing osim unkillable forever-loop.

   PerfTop:    5592 irqs/sec  kernel:97.6%  exact:  0.0% [4000Hz cycles],  (all, 4 CPUs)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                            

    13.90%  [kernel]               [k] _raw_spin_lock_irqsave        
     8.28%  [kernel]               [k] add_preempt_count.part.78     
     6.76%  [kernel]               [k] _raw_spin_lock                
     6.69%  [kernel]               [k] sub_preempt_count             
     6.45%  [kernel]               [k] _raw_spin_unlock_irqrestore   
     5.12%  [kernel]               [k] rt_spin_unlock                
     5.10%  [kernel]               [k] rt_spin_lock                  
     5.04%  [kernel]               [k] add_preempt_count             
     4.01%  [kernel]               [k] get_parent_ip                 
     3.33%  [kernel]               [k] __try_to_take_rt_mutex        
     3.18%  [kernel]               [k] in_lock_functions             
     2.88%  [kernel]               [k] migrate_enable                
     2.24%  [kernel]               [k] debug_smp_processor_id        
     2.23%  [kernel]               [k] pin_current_cpu               
     2.14%  [kernel]               [k] wakeup_next_waiter            
     2.00%  [kernel]               [k] migrate_disable               
     1.94%  [kernel]               [k] __try_to_take_rt_mutex.part.10
     1.48%  [kernel]               [k] rt_spin_lock_slowlock         
     1.42%  [kernel]               [k] __raw_spin_unlock             
     1.15%  [kernel]               [k] plist_del                     
     1.15%  [kernel]               [k] unpin_current_cpu             
     1.14%  [kernel]               [k] SYSC_semtimedop               
     0.94%  [kernel]               [k] try_to_wake_up                
     0.94%  [kernel]               [k] rt_spin_lock_slowunlock       
     0.79%  [kernel]               [k] plist_add                     
     0.73%  [kernel]               [k] __schedule

   PerfTop:    5776 irqs/sec  kernel:97.6%  exact:  0.0% [4000Hz cycles],  (all, 4 CPUs)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                            
Showing cycles for SYSC_semtimedop
  Events  Pcnt (>=5%)
 Percent |      Source code & Disassembly of vmlinux
-----------------------------------------------------
         :                       * If sma->complex_count was set while we were spinning,
         :                       * we may need to look at things we did not lock here.
         :                       */
         :                      if (unlikely(sma->complex_count)) {
    5.27 :        ffffffff811c8072:       mov    0x9c(%r14),%eax
         :                       */
         :                      if (unlikely(sma->complex_count)) {
    4.82 :        ffffffff811c8285:       mov    -0x258(%rbp),%rax
    2.76 :        ffffffff811c828c:       mov    0x9c(%rax),%ecx
    7.58 :        ffffffff811c8292:       test   %ecx,%ecx
         :                      if (unlikely(spin_is_locked(&sma->sem_perm.lock))) {
         :                              spin_unlock(&sem->lock);
    3.21 :        ffffffff811c860b:       mov    %r15,%rdi
    0.00 :        ffffffff811c860e:       callq  ffffffff814be060 <rt_spin_unlock>
    6.36 :        ffffffff811c8613:       callq  ffffffff81069170 <migrate_enable>
         :              int locknum;
         :       again:
         :              if (nsops == 1 && !sma->complex_count) {
    2.12 :        ffffffff811c8660:       mov    -0x258(%rbp),%rax
    5.53 :        ffffffff811c8667:       cmpl   $0x0,0x9c(%rax)
   10.41 :        ffffffff811c866e:       je     ffffffff811c825c <SYSC_semtimedop+0x4cc>


--=-p1NAvRcm2/eAslmWLRmg
Content-Disposition: attachment; filename="osim.c"
Content-Type: text/x-csrc; name="osim.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/*
 * Copyright (C) 1999,2001 by Manfred Spraul.
 * 
 * Redistribution of this file is permitted under the terms of the GNU 
 * General Public License (GPL)
 */

#include <sys/sem.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <assert.h>
#include <signal.h>
#include <unistd.h>

#define TRUE	1
#define FALSE	0

union semun {
	int val;
	struct semid_ds *buf;
	unsigned short int *array;
	struct seminfo* __buf;
};

#define barrier()	__asm__ __volatile__("": : : "memory")

int g_loops;
int g_busy_in;
int g_busy_out;
int g_sem;
int g_completedsem;

static void thread_fnc(int id)
{
	int i;
	volatile int j;
	int res;
	struct sembuf sop[1];

	for (i=0;i<g_loops;i++) {

		sop[0].sem_num=id;
		sop[0].sem_op=-1;
		sop[0].sem_flg=0;
		res = semop(g_sem,sop,1);
		if(res==-1) {
			printf("semop -1 failed, errno %d.\n", errno);
			return;
		}
		for(j=0;j<g_busy_in;j++);
			barrier();
		sop[0].sem_num=id;
		sop[0].sem_op=1;
		sop[0].sem_flg=0;
		res = semop(g_sem,sop,1);
		if(res==-1) {
			printf("semop +1 failed, errno %d.\n", errno);
			return;
		}
		for(j=0;j<g_busy_out;j++);
			barrier();
	}

	sop[0].sem_num=g_completedsem;
	sop[0].sem_op=-1;
	sop[0].sem_flg=IPC_NOWAIT;
	res = semop(g_sem,sop,1);
	if(res==-1) {
		printf("semop -1 on completedsem returned %d, errno %d.\n", res, errno);
		return;
	}
	return;
}

int main(int argc,char** argv)
{
	int nsems;
	int tasks;
	int res;
	pid_t *pids;
	unsigned short *psems;
	struct timeval t_before, t_after;
	unsigned long long delta;
	union semun arg;
	int i;

	printf("osim <sems> <tasks> <loops> <busy-in> <busy-out>\n");
	if(argc != 6) {
		printf("Invalid parameters.\n");
		return 1;
	}
	nsems=atoi(argv[1]);
	tasks=atoi(argv[2]);
	g_loops=atoi(argv[3]);
	g_loops = (g_loops+tasks-1)/tasks;
	g_busy_in=atoi(argv[4]);
	g_busy_out=atoi(argv[5]);
	g_completedsem = nsems;

	res = semget(IPC_PRIVATE, nsems+1, 0777 | IPC_CREAT);
	if(res == -1) {
		printf(" create failed.\n");
		return 1;
	}
	g_sem = res;
	fflush(stdout);

	pids = malloc(sizeof(pid_t)*tasks);
	for (i=0;i<tasks;i++) {
		res = fork();
		if (res == 0) {
			thread_fnc(i%nsems);
			exit(0);
		} 
		if (res == -1) {
			printf("fork() failed, errno now %d.\n", errno);
			return 1;
		}
		pids[i] = res;
	}

	printf("osim: using a semaphore array with %d semaphores.\n", nsems);
	printf("osim: using %d tasks.\n", tasks);
	printf("osim: each thread loops %d times\n", g_loops);
	printf("osim: each thread busyloops %d loops outside and %d loops inside.\n", g_busy_out, g_busy_in);
	fflush(stdout);

	psems = malloc(sizeof(unsigned short)*nsems);
	for (i=0;i<nsems;i++)
		psems[i] = 1;
	psems[i] = tasks;

	{
		struct sembuf sop[1];

		gettimeofday(&t_before, NULL);
		arg.array = psems;
		semctl(g_sem, 0, SETALL, arg);

		sop[0].sem_num=g_completedsem;
		sop[0].sem_op=0;
		sop[0].sem_flg=0;
		res = semop(g_sem,sop,1);
		if(res==-1) {
			printf("semop 0 failed, errno %d.\n", errno);
			return 1;
		}
		gettimeofday(&t_after, NULL);
	}
	for (i=0;i<tasks;i++) {
		res = waitpid(pids[i], NULL, 0);
		if (res != pids[i]) {
			printf("waitpid() failed, errno now %d.\n", errno);
			return 1;
		}
	}

	delta = t_after.tv_sec - t_before.tv_sec;
	delta = delta*1000000L;
	delta += t_after.tv_usec - t_before.tv_usec;

	printf("total execution time: %Ld.%03Ld%03Ld seconds for %d loops\n",
		(delta/1000000),
		(delta/1000)%1000,
		(delta)%1000,
		tasks*g_loops);

	delta = delta*1000;
	delta = delta/(tasks*g_loops);

	printf("per loop execution time: %Ld.%03Ld usec\n",
		(delta/1000),
		(delta)%1000);

	res = semctl(g_sem, 1, IPC_RMID, arg);
	if(res == -1) {
		printf(" semctl failed.\n");
		return 1;
	}
	return 0;
}

--=-p1NAvRcm2/eAslmWLRmg--

