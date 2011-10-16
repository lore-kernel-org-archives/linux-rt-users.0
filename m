From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [RFC] [PATCH -rt 0/5] patchset focusing on cpu hotplug
Date: Sun, 16 Oct 2011 18:56:42 +0800
Message-ID: <1318762607-2261-1-git-send-email-yong.zhang0@gmail.com>
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When tring cpu hotplug, I get some warning. And these patches
are tring to fix them up.

BTW, I have marked some of them as RFC:
  patch#3: printk: don't call printk_tick in printk_needs_cpu()
    I don't think we need to call printk_tick() even in mainline
    kernel, fix me if I'm wrong.
  patch#5: cpufreq: get rid of get_online_cpus()/put_online_cpus
    IMHO, it's about lockdep false positive, but it's a little
    annoying. Maybe there is other way to fix it up.
    And the side effect is we introduce more latency than before
    though it's rare path.

More details in eatch patch :)

Thanks,
Yong

---
Yong Zhang (5):
  hotplug: sync_unplug: No '\n' in task name
  hotplug: Call cpu_unplug_begin() a little early
  printk: don't call printk_tick in printk_needs_cpu()
  workqueue: hotplug fix
  cpufreq: get rid of get_online_cpus()/put_online_cpus

 drivers/cpufreq/cpufreq.c |   20 +++++++-------------
 kernel/cpu.c              |   18 ++++++++----------
 kernel/printk.c           |    4 ++--
 kernel/workqueue.c        |   12 ++++++++----
 4 files changed, 25 insertions(+), 29 deletions(-)
