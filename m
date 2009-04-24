From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH] cyclictest: Add tracing function about wakeup and
	wakeup_rt.
Date: Fri, 24 Apr 2009 10:40:58 +0900
Message-ID: <1240537258.30137.60.camel@centos51>
References: <1240298935.30137.33.camel@centos51>
	 <1240532011.30137.48.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-4nVJ1LVD/d76SxLExrfo"
Cc: tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:19452 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbZDXBlI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2009 21:41:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so526779ywb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Apr 2009 18:41:07 -0700 (PDT)
In-Reply-To: <1240532011.30137.48.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-4nVJ1LVD/d76SxLExrfo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Dear Clark williams,

I read "cyclictest: handle latest ftrace" log at the
http://git.kernel.org/?p=linux/kernel/git/clrkwllms/rt-tests.git;a=commit;h=9ba30e6ef2e2975ca27834e8968393ca5b07da29 webpage.
 
This is patch to support wakeup & wakeup_rt tracing at the argument of cyclictest additionally.
Currently, current cyclictest support three tracing like PREEMPTOFF, IRQSOFF, PREEMPTIRQSOFF just.

Please, Append WAKEUP & WAKEUP_RT tracing at the current cyclictest version.
This additional function will help wakeup related tracing about sleep api [ex: nanosleep() , usleep] 
of cyclictest.

After patching,
Fedora9#> cat /debug/tracing/available_tracers
syscall blk kmemtrace power branch function_graph mmiotrace wakeup_rt wakeup preemptirqsoff 
preemptoff irqsoff function sched_switch initcall nop
Fedora9#> cyclictest -t 5 -p 80 -b 1000 -w -D 10 [enter] <--- tracing wakeup
Fedora9#> cat /debug/tracing/trace

Fedora9#> cyclictest -t 5 -p 80 -b 1000 -W -D 10 [enter] <--- tracing wakeup-rt
Fedora9#> cat /debug/tracing/trace


# tracer: wakeup
#
# wakeup latency trace v1.1.5 on 2.6.29.1-rt7-ftrace
# --------------------------------------------------------------------
# latency: 1797 us, #4/4, CPU#3 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: desched/3-54 (uid:0 nice:-10 policy:0 rt_prio:0)
#    -----------------
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /                      
#                |||||     delay             
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||   \   |   /           
     gcc-29530   3d..4    0us :  29530:120:R   + [003]    54:110:D desched/3
     gcc-29530   3d..4    1us!: wake_up_process <-__mmdrop_delayed
     gcc-29530   3d..3 1797us : do_exit <-sys_exit_group
     gcc-29530   3d..3 1798us :  29530:120:? ==> [003]    54:110:R desched/3

    Fedora9#> cyclictest -t 5 -p 80 -b 1000 -W -D 10 [enter] <--- tracing wake up rt
    Fedora9#> cat /debug/tracing/trace

    Fedora9#> cat trace
# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 2.6.29.1-rt7-ftrace
# --------------------------------------------------------------------
# latency: 129 us, #86/86, CPU#2 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: sirq-timer/2-32 (uid:0 nice:-5 policy:1 rt_prio:50)
#    -----------------
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /                      
#                |||||     delay             
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||   \   |   /           
  <idle>-0       2d.h3    1us :      0:140:R   + [002]    32: 49:D sirq-timer/2
  <idle>-0       2d.h3    2us+: wake_up_process <-wakeup_softirqd
  <idle>-0       2d.h2    3us : check_preempt_curr_idle <-try_to_wake_up
  <idle>-0       2d.h2    5us : resched_task <-check_preempt_curr_idle
  <idle>-0       2dNh2    6us+: task_wake_up_rt <-try_to_wake_up
  <idle>-0       2dNh2    8us+: __spin_unlock_irqrestore <-try_to_wake_up
  <idle>-0       2dNh1   10us : preempt_schedule <-__spin_unlock_irqrestore
  <idle>-0       2dNh1   11us : softlockup_tick <-run_local_timers
  <idle>-0       2dNh1   12us+: __touch_softlockup_watchdog <-softlockup_tick
  <idle>-0       2dNh1   14us : rcu_pending <-update_process_times
  <idle>-0       2dNh1   15us : rcu_check_callbacks <-update_process_times
  <idle>-0       2dNh1   16us : idle_cpu <-rcu_check_callbacks
  <idle>-0       2dNh1   17us+: __spin_lock_irqsave <-rcu_check_callbacks
  <idle>-0       2dNh2   20us : __rcu_advance_callbacks <-rcu_check_callbacks
  <idle>-0       2dNh2   21us : __spin_unlock_irqrestore <-rcu_check_callbacks
  <idle>-0       2dNh1   22us : preempt_schedule <-__spin_unlock_irqrestore
  <idle>-0       2dNh1   23us+: run_posix_cpu_timers <-update_process_times
  <idle>-0       2dNh1   25us+: hrtimer_forward <-tick_sched_timer
  <idle>-0       2dNh1   26us : ktime_add_safe <-hrtimer_forward
  <idle>-0       2dNh1   28us : ktime_add_safe <-hrtimer_forward
  <idle>-0       2dNh1   29us+: __spin_lock <-__run_hrtimer
  <idle>-0       2dNh2   31us+: enqueue_hrtimer <-__run_hrtimer
  <idle>-0       2dNh2   33us : __spin_unlock <-hrtimer_interrupt
  <idle>-0       2dNh1   35us+: preempt_schedule <-__spin_unlock
  <idle>-0       2dNh1   36us+: tick_program_event <-hrtimer_interrupt
  <idle>-0       2dNh1   38us : tick_dev_program_event <-tick_program_event
  <idle>-0       2dNh1   39us : ktime_get <-tick_dev_program_event
  <idle>-0       2dNh1   40us+: ktime_get_ts <-ktime_get
  <idle>-0       2dNh1   41us+: getnstimeofday <-ktime_get_ts
  <idle>-0       2dNh1   44us+: set_normalized_timespec <-ktime_get_ts
  <idle>-0       2dNh1   45us : clockevents_program_event <-tick_dev_program_event
  <idle>-0       2dNh1   46us+: lapic_next_event <-clockevents_program_event
  <idle>-0       2dNh1   48us+: native_apic_mem_write <-lapic_next_event
  <idle>-0       2dNh1   50us+: perf_counter_unthrottle <-smp_apic_timer_interrupt
  <idle>-0       2dNh1   52us+: irq_exit <-smp_apic_timer_interrupt
  <idle>-0       2dN.2   54us+: do_softirq <-irq_exit
  <idle>-0       2d...   56us+: __do_softirq <-do_softirq
  <idle>-0       2d...   58us : trigger_softirqs <-__do_softirq
  <idle>-0       2d...   59us+: wakeup_softirqd <-trigger_softirqs
  <idle>-0       2dN.2   61us+: rcu_irq_exit <-irq_exit
  <idle>-0       2dN.2   62us+: idle_cpu <-irq_exit
  <idle>-0       2dN.1   64us+: tick_nohz_restart_sched_tick <-cpu_idle
  <idle>-0       2dN.1   66us : tick_nohz_stop_idle <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   68us : rcu_exit_nohz <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   69us+: select_nohz_load_balancer <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   70us+: ktime_get <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   72us+: ktime_get_ts <-ktime_get
  <idle>-0       2dN.1   74us+: getnstimeofday <-ktime_get_ts
  <idle>-0       2dN.1   76us+: set_normalized_timespec <-ktime_get_ts
  <idle>-0       2dN.1   78us+: tick_do_update_jiffies64 <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   80us : account_idle_ticks <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   80us : account_idle_time <-account_idle_ticks
  <idle>-0       2dN.1   81us : touch_softlockup_watchdog <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   82us : hrtimer_cancel <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   83us : hrtimer_try_to_cancel <-hrtimer_cancel
  <idle>-0       2dN.1   85us+: lock_hrtimer_base <-hrtimer_try_to_cancel
  <idle>-0       2dN.1   86us+: __spin_lock_irqsave <-lock_hrtimer_base
  <idle>-0       2dN.2   88us : __remove_hrtimer <-hrtimer_try_to_cancel
  <idle>-0       2dN.2   89us+: __spin_unlock_irqrestore <-hrtimer_try_to_cancel
  <idle>-0       2dN.1   91us : preempt_schedule <-__spin_unlock_irqrestore
  <idle>-0       2dN.1   92us : hrtimer_forward <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   94us+: ktime_add_safe <-hrtimer_forward
  <idle>-0       2dN.1   95us+: ktime_add_safe <-hrtimer_forward
  <idle>-0       2dN.1   97us : hrtimer_start_range_ns <-tick_nohz_restart_sched_tick
  <idle>-0       2dN.1   98us : __hrtimer_start_range_ns <-hrtimer_start_range_ns
  <idle>-0       2dN.1  100us : lock_hrtimer_base <-__hrtimer_start_range_ns
  <idle>-0       2dN.1  101us+: __spin_lock_irqsave <-lock_hrtimer_base
  <idle>-0       2dN.2  103us+: ktime_add_safe <-__hrtimer_start_range_ns
  <idle>-0       2dN.2  104us : enqueue_hrtimer <-__hrtimer_start_range_ns
  <idle>-0       2dN.2  106us : __spin_unlock_irqrestore <-__hrtimer_start_range_ns
  <idle>-0       2dN.1  107us : preempt_schedule <-__spin_unlock_irqrestore
  <idle>-0       2.N..  108us : __schedule <-cpu_idle
  <idle>-0       2.N..  110us+: rcu_qsctr_inc <-__schedule
  <idle>-0       2.N.1  112us+: __spin_lock_irq <-__schedule
  <idle>-0       2d..2  115us : put_prev_task_idle <-__schedule
  <idle>-0       2d..2  116us+: pick_next_task_rt <-__schedule
  <idle>-0       2d..2  119us : perf_counter_task_sched_out <-__schedule
  <idle>-0       2d..2  120us : perf_swcounter_event <-perf_counter_task_sched_out
  <idle>-0       2d..2  121us+: __perf_swcounter_event <-perf_swcounter_event
  <idle>-0       2d..3  123us : perf_swcounter_ctx_event <-__perf_swcounter_event
  <idle>-0       2d..3  124us : perf_swcounter_ctx_event <-__perf_swcounter_event
  <idle>-0       2d..2  125us : __perf_counter_sched_out <-perf_counter_task_sched_out
  <idle>-0       2d..2  126us : __spin_lock <-__perf_counter_sched_out
  <idle>-0       2d..3  128us+: __spin_unlock <-__perf_counter_sched_out
  <idle>-0       2d..3  129us : cpu_idle <-start_secondary
  <idle>-0       2d..3  130us :      0:140:R ==> [002]    32: 49:R sirq-timer/2
    Fedora9#> 
    Fedora9#> 
    Fedora9#> 

-------------------------------------------------------

Author: Lim,GeunSik <leemgs1@gmail.com>
Date:   Fri Apr 24 10:13:55 2009 +0900

    [PATCH] cyclictest: Add tracing function about wakeup and wakeup_rt of ftrace.
    
    This is patch to support wakeup & wakeup_rt tracing at the argument of
    cyclictest additionally. Current cyclictest support three tracing
    like PREEMPTOFF, IRQSOFF, PREEMPTIRQSOFF just.
    
    This additional function will help wakeup related tracing
    about sleep api [ex: nanosleep() , usleep] of cyclictest.

    Practically speaking, wakeup(+wakeup-rt) tracing by steven rostedt is useful 
    in the linux based embedded product development.
    
    After patching,
    Fedora9#> cat /debug/tracing/available_tracers
    syscall blk kmemtrace power branch function_graph mmiotrace wakeup_rt wakeup \
    preemptirqsoff preemptoff irqsoff function sched_switch initcall nop
    Fedora9#> cyclictest -t 5 -p 80 -b 1000 -w -D 10 [enter] <--- tracing wakeup
    Fedora9#> cat /debug/tracing/trace
    
    Fedora9#> cyclictest -t 5 -p 80 -b 1000 -W -D 10 [enter] <--- tracing wakeup-rt
    Fedora9#> cat /debug/tracing/trace
    
        Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 884f2c3..93b895b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -93,6 +93,8 @@ enum {
 	IRQSOFF,
 	PREEMPTOFF,
 	IRQPREEMPTOFF,
+	WAKEUP,
+	WAKEUPRT,
 };
 
 #define HIST_MAX		1000000
@@ -415,6 +417,13 @@ static void setup_tracer(void)
 		case CTXTSWITCH:
 			ret = settracer("sched_switch");
 			break;
+               case WAKEUP:
+                       ret = settracer("wakeup");
+                       break;
+               case WAKEUPRT:
+                       ret = settracer("wakeup_rt");
+                       break;
+
 		default:
 			printf("cyclictest: unknown tracer!\n");
 			ret = 0;
@@ -711,6 +720,9 @@ static void display_help(void)
 	       "                           to modify value to minutes, hours or days\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
+               "-w       --wakeup          rt task wakeup tracing (used with -b)\n"
+               "-W       --wakeuprt        non_rt task wakeup_rt tracing (used with -b)\n"
+
 		);
 	exit(0);
 }
@@ -773,10 +785,12 @@ static void process_options (int argc, char *argv[])
 			{"threads", optional_argument, NULL, 't'},
 			{"verbose", no_argument, NULL, 'v'},
 			{"duration",required_argument, NULL, 'D'},
+                        {"wakeup", no_argument, NULL, 'w'},
+                        {"wakeuprt", no_argument, NULL, 'W'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:p:Pmqrst::vD:",
+		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:p:Pmqrst::vD:wW:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -821,8 +835,9 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'v': verbose = 1; break;
 		case 'm': lockall = 1; break;
-		case 'D': duration = parse_time_string(optarg);
-			break;
+		case 'D': duration = parse_time_string(optarg); break;
+                case 'w': tracetype = WAKEUP; break;
+                case 'W': tracetype = WAKEUPRT; break;
 		case '?': error = 1; break;
 		}
 	}


Best regards,
GeunSik Lim.

-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim (ELS - OS Group - S/W Lab - SAIT - SAMSUNG)
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://intomail.dnip.net/invain/me/
-----------------------------------------------

--=-4nVJ1LVD/d76SxLExrfo
Content-Disposition: attachment; filename=wakeup-wakeuprt-tracing-support.patch
Content-Type: text/x-patch; name=wakeup-wakeuprt-tracing-support.patch; charset=euckr
Content-Transfer-Encoding: 7bit

Author: Lim,GeunSik <leemgs1@gmail.com>
Date:   Fri Apr 24 10:13:55 2009 +0900

    [PATCH] cyclictest: Add tracing function about wakeup and wakeup_rt of ftrace.
    
    This is patch to support wakeup & wakeup_rt tracing at the argument of
    cyclictest additionally. Current cyclictest support three tracing
    like PREEMPTOFF, IRQSOFF, PREEMPTIRQSOFF just.
    
    This additional function will help wakeup related tracing
    about sleep api [ex: nanosleep() , usleep] of cyclictest.

    Practically speaking, wakeup(+wakeup-rt) tracing by steven rostedt is useful 
    in the linux based embedded product development.
    
    After patching,
    Fedora9#> cat /debug/tracing/available_tracers
    syscall blk kmemtrace power branch function_graph mmiotrace wakeup_rt wakeup \
    preemptirqsoff preemptoff irqsoff function sched_switch initcall nop
    Fedora9#> cyclictest -t 5 -p 80 -b 1000 -w -D 10 [enter] <--- tracing wakeup
    Fedora9#> cat /debug/tracing/trace
    
    Fedora9#> cyclictest -t 5 -p 80 -b 1000 -W -D 10 [enter] <--- tracing wakeup-rt
    Fedora9#> cat /debug/tracing/trace
    
        Signed-off-by: GeunSik Lim <geunsik.lim@samsung.com>

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 884f2c3..93b895b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -93,6 +93,8 @@ enum {
 	IRQSOFF,
 	PREEMPTOFF,
 	IRQPREEMPTOFF,
+	WAKEUP,
+	WAKEUPRT,
 };
 
 #define HIST_MAX		1000000
@@ -415,6 +417,13 @@ static void setup_tracer(void)
 		case CTXTSWITCH:
 			ret = settracer("sched_switch");
 			break;
+               case WAKEUP:
+                       ret = settracer("wakeup");
+                       break;
+               case WAKEUPRT:
+                       ret = settracer("wakeup_rt");
+                       break;
+
 		default:
 			printf("cyclictest: unknown tracer!\n");
 			ret = 0;
@@ -711,6 +720,9 @@ static void display_help(void)
 	       "                           to modify value to minutes, hours or days\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
+               "-w       --wakeup          rt task wakeup tracing (used with -b)\n"
+               "-W       --wakeuprt        non_rt task wakeup_rt tracing (used with -b)\n"
+
 		);
 	exit(0);
 }
@@ -773,10 +785,12 @@ static void process_options (int argc, char *argv[])
 			{"threads", optional_argument, NULL, 't'},
 			{"verbose", no_argument, NULL, 'v'},
 			{"duration",required_argument, NULL, 'D'},
+                        {"wakeup", no_argument, NULL, 'w'},
+                        {"wakeuprt", no_argument, NULL, 'W'},
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:p:Pmqrst::vD:",
+		int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:p:Pmqrst::vD:wW:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -821,8 +835,9 @@ static void process_options (int argc, char *argv[])
 			break;
 		case 'v': verbose = 1; break;
 		case 'm': lockall = 1; break;
-		case 'D': duration = parse_time_string(optarg);
-			break;
+		case 'D': duration = parse_time_string(optarg); break;
+                case 'w': tracetype = WAKEUP; break;
+                case 'W': tracetype = WAKEUPRT; break;
 		case '?': error = 1; break;
 		}
 	}

--=-4nVJ1LVD/d76SxLExrfo--

