Return-Path: <SRS0=sGjS=XI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED9C49ED7
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5E206BB
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfIMNhC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:37:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbfIMNhB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Sep 2019 09:37:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i8lkt-0000VM-Q9; Fri, 13 Sep 2019 15:36:55 +0200
Date:   Fri, 13 Sep 2019 15:36:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Martin.Wirth@dlr.de
Cc:     linux-rt-users@vger.kernel.org, austin.linux@gmail.com
Subject: Re: Long latencies during disk-io
Message-ID: <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-10 12:04:45 [+0000], Martin.Wirth@dlr.de wrote:
> Thanks to Austin's suggestion I was able to get a race which looks suspicious.
> # tracer: function
> #
> # entries-in-buffer/entries-written: 39893/219671100   #P:4
> #
> #                              _-----=> irqs-off
> #                             / _----=> need-resched
> #                            | / _----=> need-resched
> #                            || / _---=> hardirq/softirq
> #                            ||| / _--=> preempt-depth
> #                            ||||/     delay
> #           TASK-PID   CPU#  |||||   TIMESTAMP  FUNCTION
> #              | |       |   |||||      |         |
> irq/35-ahci[000-121   [002] ....113 28719.098051: preempt_count_sub <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] .....13 28719.098051: preempt_count_add <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] ....113 28719.098052: preempt_count_sub <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] .....13 28719.098052: preempt_count_add <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] ....113 28719.098052: _raw_spin_lock_irqsave <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] d...113 28719.098052: preempt_count_add <-_raw_spin_lock_irqsave
>  irq/35-ahci[000-121   [002] d...213 28719.098052: _raw_spin_unlock_irqrestore <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] ....213 28719.098052: preempt_count_sub <-_raw_spin_unlock_irqrestore
>  irq/35-ahci[000-121   [002] ....113 28719.098052: preempt_count_sub <-percpu_counter_add_batch
>  irq/35-ahci[000-121   [002] .....13 28719.098052: preempt_count_add <-percpu_counter_add_batch

so until here AHCI threaded handler runs. Then the hard-IRQ triggers…

>  irq/35-ahci[000-121   [002] d..h313 28719.098053: handle_irq <-do_IRQ
>  irq/35-ahci[000-121   [002] d..h313 28719.098053: handle_fasteoi_irq <-handle_irq
>  irq/35-ahci[000-121   [002] d..h313 28719.098053: _raw_spin_lock <-handle_fasteoi_irq
>  irq/35-ahci[000-121   [002] d..h313 28719.098053: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] d..h413 28719.098054: mask_irq.part.36 <-handle_fasteoi_irq
>  irq/35-ahci[000-121   [002] d..h413 28719.098054: mask_ioapic_irq <-mask_irq.part.36
>  irq/35-ahci[000-121   [002] d..h413 28719.098054: _raw_spin_lock_irqsave <-mask_ioapic_irq
>  irq/35-ahci[000-121   [002] d..h413 28719.098054: preempt_count_add <-_raw_spin_lock_irqsave
>  irq/35-ahci[000-121   [002] d..h513 28719.098054: io_apic_modify_irq <-mask_ioapic_irq
>  irq/35-ahci[000-121   [002] d..h513 28719.098055: io_apic_sync <-io_apic_modify_irq
>  irq/35-ahci[000-121   [002] d..h513 28719.098056: _raw_spin_unlock_irqrestore <-mask_irq.part.36
>  irq/35-ahci[000-121   [002] d..h513 28719.098056: preempt_count_sub <-_raw_spin_unlock_irqrestore
>  irq/35-ahci[000-121   [002] d..h413 28719.098057: handle_irq_event <-handle_fasteoi_irq
>  irq/35-ahci[000-121   [002] d..h413 28719.098057: preempt_count_sub <-handle_irq_event
>  irq/35-ahci[000-121   [002] d..h313 28719.098057: handle_irq_event_percpu <-handle_irq_event
>  irq/35-ahci[000-121   [002] d..h313 28719.098057: __handle_irq_event_percpu <-handle_irq_event_percpu
>  irq/35-ahci[000-121   [002] d..h313 28719.098057: irq_default_primary_handler <-__handle_irq_event_percpu

The primary handler does a wake of the threaded handler which is still
ongoing…

>  irq/35-ahci[000-121   [002] d..h313 28719.098057: __irq_wake_thread <-__handle_irq_event_percpu
>  irq/35-ahci[000-121   [002] d..h313 28719.098057: wake_up_process <-__handle_irq_event_percpu
>  irq/35-ahci[000-121   [002] d..h313 28719.098058: try_to_wake_up <-__handle_irq_event_percpu
>  irq/35-ahci[000-121   [002] d..h313 28719.098058: _raw_spin_lock_irqsave <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d..h313 28719.098058: preempt_count_add <-_raw_spin_lock_irqsave
>  irq/35-ahci[000-121   [002] d..h413 28719.098058: _raw_spin_lock <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d..h413 28719.098058: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] d..h513 28719.098058: update_rq_clock <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d..h513 28719.098058: update_irq_load_avg <-update_rq_clock
>  irq/35-ahci[000-121   [002] d..h513 28719.098058: __accumulate_pelt_segments <-update_irq_load_avg
>  irq/35-ahci[000-121   [002] d..h513 28719.098059: ttwu_do_activate <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d..h513 28719.098059: activate_task <-ttwu_do_activate
>  irq/35-ahci[000-121   [002] d..h513 28719.098059: enqueue_task_rt <-activate_task
>  irq/35-ahci[000-121   [002] d..h513 28719.098059: dequeue_rt_stack <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098059: dequeue_top_rt_rq <-dequeue_rt_stack
>  irq/35-ahci[000-121   [002] d..h513 28719.098059: cpupri_set <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: update_rt_migration <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: _raw_spin_lock <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] d..h613 28719.098060: preempt_count_sub <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: enqueue_top_rt_rq <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: intel_pstate_update_util <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: ttwu_do_wakeup <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d..h513 28719.098060: check_preempt_curr <-ttwu_do_wakeup
>  irq/35-ahci[000-121   [002] d..h513 28719.098061: check_preempt_curr_rt <-check_preempt_curr
>  irq/35-ahci[000-121   [002] d..h513 28719.098061: resched_curr <-check_preempt_curr
>  irq/35-ahci[000-121   [002] dN.h513 28719.098061: task_woken_rt <-ttwu_do_wakeup
The scheduler decided that another needs to run on this CPU. This is
denoted by the capital N (as in need-resched) here.

>  irq/35-ahci[000-121   [002] dN.h413 28719.098061: _raw_spin_unlock_irqrestore <-try_to_wake_up
>  irq/35-ahci[000-121   [002] dN.h413 28719.098061: preempt_count_sub <-_raw_spin_unlock_irqrestore
>  irq/35-ahci[000-121   [002] dN.h313 28719.098061: note_interrupt <-handle_irq_event_percpu
>  irq/35-ahci[000-121   [002] dN.h313 28719.098062: _raw_spin_lock <-handle_irq_event
>  irq/35-ahci[000-121   [002] dN.h313 28719.098062: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] dN.h413 28719.098062: ioapic_ack_level <-handle_fasteoi_irq
>  irq/35-ahci[000-121   [002] dN.h413 28719.098062: irqd_cfg <-ioapic_ack_level
>  irq/35-ahci[000-121   [002] dN.h413 28719.098062: apic_chip_data.part.17 <-ioapic_ack_level
>  irq/35-ahci[000-121   [002] dN.h413 28719.098062: irq_complete_move <-ioapic_ack_level
>  irq/35-ahci[000-121   [002] dN.h413 28719.098062: __irq_complete_move <-ioapic_ack_level
>  irq/35-ahci[000-121   [002] dN.h413 28719.098062: preempt_count_sub <-handle_fasteoi_irq
>  irq/35-ahci[000-121   [002] dN.h313 28719.098063: irq_exit <-do_IRQ
>  irq/35-ahci[000-121   [002] dN.h313 28719.098063: irqtime_account_irq <-irq_exit
>  irq/35-ahci[000-121   [002] dN.h313 28719.098063: preempt_count_sub <-irq_exit
>  irq/35-ahci[000-121   [002] .N..113 28719.098063: preempt_count_sub <-percpu_counter_add_batch

The CPU is back from hard-IRQ and can't switch right away to the other
task due to the preempt-disable section. But this happens just one line
later

>  irq/35-ahci[000-121   [002] dN..113 28719.098064: rcu_note_context_switch <-__schedule
>  irq/35-ahci[000-121   [002] dN..113 28719.098064: rcu_preempt_deferred_qs <-rcu_note_context_switch
>  irq/35-ahci[000-121   [002] dN..113 28719.098064: _raw_spin_lock <-__schedule
>  irq/35-ahci[000-121   [002] dN..113 28719.098064: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] dN..213 28719.098064: update_rq_clock <-__schedule
>  irq/35-ahci[000-121   [002] dN..213 28719.098064: pick_next_task_stop <-__schedule
>  irq/35-ahci[000-121   [002] dN..213 28719.098064: pick_next_task_dl <-__schedule
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: pick_next_task_rt <-__schedule
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: update_curr_rt <-pick_next_task_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: __rcu_read_lock <-update_curr_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: __rcu_read_unlock <-update_curr_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: _raw_spin_lock <-update_curr_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] dN..313 28719.098065: preempt_count_sub <-update_curr_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: put_prev_task_rt <-pick_next_task_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098065: update_curr_rt <-put_prev_task_rt
>  irq/35-ahci[000-121   [002] dN..213 28719.098066: update_rt_rq_load_avg <-put_prev_task_rt
>  irq/35-ahci[000-121   [002] d...213 28719.098066: enter_lazy_tlb <-__schedule
>     irq/21-spec_-292   [002] d...2.. 28719.098067: finish_task_switch <-__schedule
>     irq/21-spec_-292   [002] d...2.. 28719.098067: _raw_spin_unlock_irq <-finish_task_switch
>     irq/21-spec_-292   [002] ....2.. 28719.098067: preempt_count_sub <-_raw_spin_unlock_irq
>     irq/21-spec_-292   [002] ....... 28719.098067: kthread_should_stop <-irq_thread
>     irq/21-spec_-292   [002] ....... 28719.098068: irq_thread_check_affinity <-irq_thread
>     irq/21-spec_-292   [002] ....... 28719.098068: irq_forced_thread_fn <-irq_thread
>     irq/21-spec_-292   [002] ....... 28719.098068: __local_bh_disable_ip <-irq_forced_thread_fn

before the threaded function of your handler is invoked, it does
local_bh_disable(). This is required because the hard-irq would not be
interrupted by the softirq so "this" must be preserved for the handler
in force-threaded mode.
However, the lock is held by the ahci thread so what follows is PI-boost
and a switch to the owner of the lock…

>     irq/21-spec_-292   [002] ....... 28719.098068: migrate_disable <-__local_bh_disable_ip
>     irq/21-spec_-292   [002] ....11. 28719.098068: pin_current_cpu <-migrate_disable
>     irq/21-spec_-292   [002] ....11. 28719.098068: __read_rt_trylock <-pin_current_cpu
>     irq/21-spec_-292   [002] ....11. 28719.098068: task_rq_lock <-migrate_disable
>     irq/21-spec_-292   [002] ....11. 28719.098069: _raw_spin_lock_irqsave <-task_rq_lock
>     irq/21-spec_-292   [002] d...11. 28719.098069: preempt_count_add <-_raw_spin_lock_irqsave
>     irq/21-spec_-292   [002] d...21. 28719.098069: _raw_spin_lock <-task_rq_lock
>     irq/21-spec_-292   [002] d...21. 28719.098069: preempt_count_add <-_raw_spin_lock
>     irq/21-spec_-292   [002] d...21. 28719.098069: _raw_spin_unlock_irqrestore <-migrate_disable
>     irq/21-spec_-292   [002] ....21. 28719.098069: preempt_count_sub <-_raw_spin_unlock_irqrestore
>     irq/21-spec_-292   [002] .....11 28719.098069: rt_spin_lock <-__local_bh_disable_ip
>     irq/21-spec_-292   [002] .....11 28719.098069: migrate_disable <-rt_spin_lock
>     irq/21-spec_-292   [002] .....12 28719.098070: rt_spin_lock_slowlock <-__local_bh_disable_ip
…
>  irq/35-ahci[000-121   [002] .....13 28719.098080: rt_spin_unlock <-test_clear_page_writeback
>  irq/35-ahci[000-121   [002] .....13 28719.098080: migrate_enable <-rt_spin_unlock
>  irq/35-ahci[000-121   [002] .....12 28719.098081: mod_node_page_state <-test_clear_page_writeback
>  irq/35-ahci[000-121   [002] .....12 28719.098081: dec_zone_page_state <-test_clear_page_writeback
>  irq/35-ahci[000-121   [002] .....12 28719.098081: inc_node_page_state <-test_clear_page_writeback
>  irq/35-ahci[000-121   [002] .....12 28719.098081: rt_spin_lock <-ext4_finish_bio
>  irq/35-ahci[000-121   [002] .....12 28719.098081: migrate_disable <-rt_spin_lock
>  irq/35-ahci[000-121   [002] .....13 28719.098081: rt_spin_unlock <-ext4_finish_bio
>  irq/35-ahci[000-121   [002] .....13 28719.098082: migrate_enable <-rt_spin_unlock
>  irq/35-ahci[000-121   [002] .....12 28719.098082: end_page_writeback <-ext4_finish_bio
>  irq/35-ahci[000-121   [002] .....12 28719.098082: test_clear_page_writeback <-end_page_writeback
>  irq/35-ahci[000-121   [002] .....12 28719.098082: page_mapping <-test_clear_page_writeback
>  irq/35-ahci[000-121   [002] .....12 28719.098082: rt_spin_lock <-test_clear_page_writeback
>  irq/35-ahci[000-121   [002] .....12 28719.098082: migrate_disable <-rt_spin_lock
…

> irq/35-ahci[000-121   [002] ....112 28719.100176: __wake_up_q <-rt_mutex_postunlock

so slightly before this, local_bh_enable() is invoked which drops the
lock in question. This leads to a de-boost and the lock is obtained by
the irq-21 threaded handler.

>  irq/35-ahci[000-121   [002] ....112 28719.100176: __wake_up_q <-rt_mutex_postunlock
>  irq/35-ahci[000-121   [002] ....112 28719.100176: try_to_wake_up <-__wake_up_q
>  irq/35-ahci[000-121   [002] ....112 28719.100176: _raw_spin_lock_irqsave <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d...112 28719.100176: preempt_count_add <-_raw_spin_lock_irqsave
>  irq/35-ahci[000-121   [002] d...212 28719.100176: _raw_spin_lock <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d...212 28719.100176: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] d...312 28719.100177: update_rq_clock <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d...312 28719.100177: update_irq_load_avg <-update_rq_clock
>  irq/35-ahci[000-121   [002] d...312 28719.100177: ttwu_do_activate <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d...312 28719.100177: activate_task <-ttwu_do_activate
>  irq/35-ahci[000-121   [002] d...312 28719.100177: enqueue_task_rt <-activate_task
>  irq/35-ahci[000-121   [002] d...312 28719.100177: dequeue_rt_stack <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100177: dequeue_top_rt_rq <-dequeue_rt_stack
>  irq/35-ahci[000-121   [002] d...312 28719.100178: cpupri_set <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100178: update_rt_migration <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100178: _raw_spin_lock <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100178: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] d...412 28719.100178: preempt_count_sub <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100178: enqueue_top_rt_rq <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100178: intel_pstate_update_util <-enqueue_task_rt
>  irq/35-ahci[000-121   [002] d...312 28719.100178: ttwu_do_wakeup <-try_to_wake_up
>  irq/35-ahci[000-121   [002] d...312 28719.100178: check_preempt_curr <-ttwu_do_wakeup
>  irq/35-ahci[000-121   [002] d...312 28719.100179: check_preempt_curr_rt <-check_preempt_curr
>  irq/35-ahci[000-121   [002] d...312 28719.100179: resched_curr <-check_preempt_curr
>  irq/35-ahci[000-121   [002] dN..312 28719.100179: task_woken_rt <-ttwu_do_wakeup
>  irq/35-ahci[000-121   [002] dN..212 28719.100179: _raw_spin_unlock_irqrestore <-try_to_wake_up
>  irq/35-ahci[000-121   [002] .N..212 28719.100179: preempt_count_sub <-_raw_spin_unlock_irqrestore
>  irq/35-ahci[000-121   [002] .N..112 28719.100179: preempt_count_sub <-rt_mutex_postunlock
>  irq/35-ahci[000-121   [002] dN..112 28719.100179: rcu_note_context_switch <-__schedule
>  irq/35-ahci[000-121   [002] dN..112 28719.100180: rcu_preempt_deferred_qs <-rcu_note_context_switch
>  irq/35-ahci[000-121   [002] dN..112 28719.100180: _raw_spin_lock <-__schedule
>  irq/35-ahci[000-121   [002] dN..112 28719.100180: preempt_count_add <-_raw_spin_lock
>  irq/35-ahci[000-121   [002] dN..212 28719.100180: update_rq_clock <-__schedule
>  irq/35-ahci[000-121   [002] dN..212 28719.100180: pick_next_task_stop <-__schedule
>  irq/35-ahci[000-121   [002] dN..212 28719.100180: pick_next_task_dl <-__schedule
>  irq/35-ahci[000-121   [002] dN..212 28719.100180: pick_next_task_rt <-__schedule
>  irq/35-ahci[000-121   [002] dN..212 28719.100180: update_curr_rt <-pick_next_task_rt
>  irq/35-ahci[000-121   [002] dN..212 28719.100180: put_prev_task_rt <-pick_next_task_rt
>  irq/35-ahci[000-121   [002] dN..212 28719.100181: update_curr_rt <-put_prev_task_rt
>  irq/35-ahci[000-121   [002] dN..212 28719.100181: update_rt_rq_load_avg <-put_prev_task_rt
>  irq/35-ahci[000-121   [002] d...212 28719.100181: enter_lazy_tlb <-__schedule
>     irq/21-spec_-292   [002] d...212 28719.100181: finish_task_switch <-__schedule
>     irq/21-spec_-292   [002] d...212 28719.100182: _raw_spin_unlock_irq <-finish_task_switch
>     irq/21-spec_-292   [002] ....212 28719.100182: preempt_count_sub <-_raw_spin_unlock_irq
>     irq/21-spec_-292   [002] .....12 28719.100182: _raw_spin_lock_irqsave <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d....12 28719.100182: preempt_count_add <-_raw_spin_lock_irqsave
>     irq/21-spec_-292   [002] d...112 28719.100182: _raw_spin_lock <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d...112 28719.100182: preempt_count_add <-_raw_spin_lock
>     irq/21-spec_-292   [002] d...212 28719.100182: preempt_count_sub <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d...112 28719.100183: __try_to_take_rt_mutex <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d...112 28719.100183: _raw_spin_lock <-__try_to_take_rt_mutex
>     irq/21-spec_-292   [002] d...112 28719.100183: preempt_count_add <-_raw_spin_lock
>     irq/21-spec_-292   [002] d...212 28719.100183: preempt_count_sub <-__try_to_take_rt_mutex
>     irq/21-spec_-292   [002] d...112 28719.100183: _raw_spin_lock <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d...112 28719.100183: preempt_count_add <-_raw_spin_lock
>     irq/21-spec_-292   [002] d...212 28719.100183: preempt_count_sub <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d...112 28719.100183: fixup_rt_mutex_waiters.part.6 <-rt_spin_lock_slowlock_locked
>     irq/21-spec_-292   [002] d...112 28719.100184: _raw_spin_unlock_irqrestore <-rt_spin_lock_slowlock
>     irq/21-spec_-292   [002] ....112 28719.100184: preempt_count_sub <-_raw_spin_unlock_irqrestore
>     irq/21-spec_-292   [002] .....12 28719.100184: vInterruptService <-irq_forced_thread_fn

lock is owned, the threaded handler (vInterruptService()) can be
invoked.

>     irq/21-spec_-292   [002] .....12 28719.100185: ktime_get_real_ts64 <-vInterruptService
>     irq/21-spec_-292   [002] .....12 28719.100189: __wake_up <-vInterruptService
>     irq/21-spec_-292   [002] .....12 28719.100189: __wake_up_common_lock <-vInterruptService
> .....
> 
> Now suddenly the spec handler is running again and this time the driver supplied IRQ-routine (vInterruptService) 
> is called, but with the 2 ms of delay. 
> 
> Unfortunately I'm not able to interpret the flags correctly. Especially since the ones described in the header 
> do not match the number of fields in the output...

So this delay is caused by the softirq rework. I didn't think about this
but now that you show the trace it is obvious.

If you use
	request_threaded_irq(, NULL, vInterruptService, …);

instead of
	request_irq(, vInterruptService, …);

then the IRQ will not be force threaded (but threaded on request) and
there will be no local_bh_disable() before the thread is invoked. So no
waiting until the AHCI thread is done.

If vInterruptService() does nothing else than just wake up userland then
you could use swait_event_…() / swake_up_one() instead of the
wait_event_… / wake_up() combo. That would be allowed from the primary
handler and you could avoid the switch to the threaded-handler.

> Martin

Sebastian
