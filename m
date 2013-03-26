From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Question on RCU_BOOST option
Date: Tue, 26 Mar 2013 13:13:46 -0400
Message-ID: <5151D74A.2040909@windriver.com>
References: <F9467A784CC48947B1D879F07370839E0EBE9986@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60261 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3CZRNN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Mar 2013 13:13:13 -0400
In-Reply-To: <F9467A784CC48947B1D879F07370839E0EBE9986@fe20099s.ecn.etasgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-03-25 06:35 AM, Koehrer Mathias (ETAS/ESS2) wrote:
> Hi all,
> 
> my x86 PC (32bit, Intel core i7,  8 cores)  is started with "isolcpus=1-15".
> Kernel: 3.6.11-rt31
> 
> I have an  application having a real time thread bound to one CPU core (core 2).
> This threads runs in an endless loop with real time priority (prio 80).
> This leads to RCU stalls after a while. 

Hi Mathias,

Perhaps you might want to have a look at this thread, about RCU stalls
and a possible common root cause for some of them.

http://marc.info/?l=linux-rt-users&m=136258510132233&w=2

Paul.
--

> I was now looking at the RCU_BOOST feature to see if this is a way to get rid of the RCU stalls.
> My understanding is now, if I enable RCU_BOOST, set the RCU_BOOST_PRIO to "97" this should avoid the issue with the RCU stalls.
> However, this works not as I expected.
> Please see the following test-application,
> --------- BEGIN CODE ---------
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <string.h>
> #include <pthread.h>
> #include <unistd.h>
> #include <math.h>
> #include <sys/time.h>
> 
> volatile int end=0;
> 
> int set_rt_prio_and_core(int prio, int core)
> {
>     {
>         int rc;
>         struct sched_param param;
>         memset(&param, 0, sizeof(param));
>         param.sched_priority = prio;
>         rc = sched_setscheduler(0, SCHED_FIFO, &param);
>         if (rc)
>         {
>             perror("sched_setscheduler");
>         }
>     }
>     {
>         int rc;
>         cpu_set_t mask;
>         CPU_ZERO(&mask);
>         CPU_SET(core, &mask);
>         rc = sched_setaffinity(0, sizeof(mask), &mask);
>         if (rc)
>         {
>             perror("sched_setaffinity");
>         }
>     }
>     return 0;
> }
> 
> void *thread_func(void *arg)
> {
>     int i;
>     volatile double f = 0.0;
>     set_rt_prio_and_core(80,2);
> 
>     for (i=0; !end; i++)
>     {
>         f = f + sin(2.3*i); // Some dummy load...
>     }
>     return NULL;
> }
> 
> int main(void)
> {
>     pthread_t thr;
> 
>     pthread_create(&thr, NULL, thread_func, NULL);
>     sleep(1000);
>     end = 1;
>     pthread_join(thr, NULL);
>     return 0;
> }
> --------- END CODE ---------
> 
> When I start this application it runs as expected with roughly 100% CPU load on this thread.
> However after one minute, I got the following dmesg:
> 
> -------- BEGIN DMESG ---------
> INFO: rcu_preempt self-detected stall on CPU { 2}  (t=6000 jiffies)
> Pid: 5312, comm: full-load Not tainted 3.6.11-rt31-1 #2
> Call Trace:
>  [<c106e298>] rcu_check_callbacks+0x150/0x4a5
>  [<c1032a1e>] update_process_times+0x37/0x43
>  [<c10585cb>] tick_sched_timer+0x19f/0x1d0
>  [<c104232e>] __run_hrtimer+0xf6/0x1e4
>  [<c105842c>] ? tick_init_highres+0x14/0x14
>  [<c1042f49>] hrtimer_interrupt+0x1c6/0x34f
>  [<c101a92a>] smp_apic_timer_interrupt+0x6c/0x7f
>  [<c13a651a>] apic_timer_interrupt+0x2a/0x30
> -------- END DMESG ---------
> 
> What does this mean? 
> Is it just an informational message that the boost worked? If yes: How can I switch off this message.
> 
> Looking at the RCU kernel threads I see the following:
> ps ax -o cmd,rtprio,lastcpu | grep rcu
> [rcuc/0]                         1   0
> [rcun/0]                        99   0
> [rcub/0]                        97   0
> [rcun/1]                        99   0
> [rcub/1]                        97   0
> [rcuc/1]                         1   1
> [rcuc/2]                         1   2
> [rcuc/3]                         1   3
> [rcuc/4]                         1   4
> [rcuc/5]                         1   5
> [rcuc/6]                         1   0
> [rcuc/7]                         1   7
> 
> What is really unclear to me is the fact that there is a [rcun/0] and [rcun/1] but no /2 ,  /3, ... (the same with rcub).
> Also, the "lastcpu" of [rcun/1] and [rcub/1] is 0 which is fairly surprising to me (I expected the CPU 1 here).
> 
> Any help or feedback on this is welcome.
> 
> Best regards
> 
> Mathias
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
