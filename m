From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Kernel 2.6.19-rt1 question
Date: Thu, 30 Nov 2006 13:08:17 +0100
Message-ID: <456EC9B1.2090407@stud.feec.vutbr.cz>
References: <20061130125136.28d2e5d3@tkielan.ente.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:43249 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S936209AbWK3MI1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Nov 2006 07:08:27 -0500
To: Tymoteusz Kielan <t.kielan@ente.com.pl>
In-Reply-To: <20061130125136.28d2e5d3@tkielan.ente.local>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Tymoteusz Kielan wrote:
> Hello,
> I'm new here, and I don't know how to start.
> 
> I'm trying to setup an x86 costom platform on Linux RT branch.
> 
> Today, I was able to get 2.6.19-rt1 and run some tests.
> 
> I wrote some module that uses RT API an during modprobe, some thing unexpexted happened:
> 
> root@test:~# modprobe someModule
> [  257.391000] softirq-tasklet/8[CPU#0]: BUG in rt_mutex_debug_task_free at kernel/rtmutex-debug.c:66
> [  257.391000]  [<c0103e68>] dump_trace+0x82/0x20d
> [  257.391000]  [<c01040cb>] show_trace_log_lvl+0x34/0x4a
> [  257.391000]  [<c010410d>] show_trace+0x2c/0x2e
> [  257.391000]  [<c010422a>] dump_stack+0x2b/0x2d
> [  257.391000]  [<c011930b>] __WARN_ON+0x65/0x77
> [  257.391000]  [<c0139c6a>] rt_mutex_debug_task_free+0x4b/0x88
> [  257.391000]  [<c01151e4>] free_task+0x21/0x37
> [  257.391000]  [<c01152bf>] __put_task_struct_cb+0xc5/0xcb
> [  257.391000]  [<c0144c61>] rcu_process_callbacks+0x53/0x5e
> [  257.391000]  [<c011d4fc>] __tasklet_action+0xc9/0xfc
> [  257.391000]  [<c011d565>] tasklet_action+0x36/0x3b
> [  257.391000]  [<c011d71c>] ksoftirqd+0xef/0x177
> [  257.391000]  [<c012beb7>] kthread+0x90/0xb8
> [  257.391000]  [<c0103d2f>] kernel_thread_helper+0x7/0x10
> [  257.391000]  =======================

Looks to me like a task has exited while still holding a mutex.

> This bug is not critical, but I don't know what to expect from kernel giving me such
> messages.
> Is it my fault? This trace do not show any function calling from my someModule.

It probably is. We would know for sure if you showed us your module's 
source.

Michal Schmidt
