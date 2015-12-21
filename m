From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Hung task for proc_cgroup_show
Date: Mon, 21 Dec 2015 09:58:11 +0100
Message-ID: <CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
	<20150714150016.GC21820@linutronix.de>
	<CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
	<20151211161450.GA6720@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:32876 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbLUI6N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2015 03:58:13 -0500
Received: by mail-lb0-f169.google.com with SMTP id sv6so4685322lbb.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2015 00:58:12 -0800 (PST)
In-Reply-To: <20151211161450.GA6720@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Dec 11, 2015 at 5:14 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> This means css_release_work_fn() or css_killed_work_fn(). Can you issue
> a task dump which says what the tasks are doing?

Here is another of those lockups, this time with 3.18.24-rt22. I took
the liberty to remove everything not related to cgroups from the logs.

Seeing the memory control group inside one of the call stacks I tried
disabling this cgroup. I did not see the lockup again, but two system
freezes instead.

[ 1951.780283] SysRq : Show Locks Held
[ 1951.780288]
[ 1951.780288] Showing all locks held in the system:
[ 1951.780294] 1 lock held by kswork/69:
[ 1951.780295]  #0:  (cgroup_mutex){+.+.+.}, at: [<ffffffff810ea7bf>]
css_release_work_fn+0x2f/0xe0
[ 1951.780307] 4 locks held by cgmanager/349:
[ 1951.780308]  #0:  (sb_writers#9){.+.+.+}, at: [<ffffffff811da1c4>]
mnt_want_write+0x24/0x50
[ 1951.780313]  #1:  (&type->i_mutex_dir_key#3/1){+.+.+.}, at:
[<ffffffff811c7e7c>] do_rmdir+0x15c/0x220
[ 1951.780317]  #2:  (&type->i_mutex_dir_key#3){+.+.+.}, at:
[<ffffffff811c2017>] vfs_rmdir+0x57/0x150
[ 1951.780322]  #3:  (cgroup_mutex){+.+.+.}, at: [<ffffffff810ebd40>]
cgroup_kn_lock_live+0x50/0x180
[ 1951.780399] 3 locks held by kworker/2:2/3642:
[ 1951.780399]  #0:  ("cgroup_destroy"){.+.+.+}, at:
[<ffffffff8106b801>] process_one_work+0x171/0x5b0
[ 1951.780403]  #1:  ((&css->destroy_work)){+.+.+.}, at:
[<ffffffff8106b801>] process_one_work+0x171/0x5b0
[ 1951.780406]  #2:  (cgroup_mutex){+.+.+.}, at: [<ffffffff810ebf2f>]
css_killed_work_fn+0x1f/0x170


[ 2769.928061] SysRq : Show State
[ 2769.928065]   task                        PC stack   pid father

[ 2769.944889] kworker/2:2     D ffff8803dccba580     0  3642      2 0x00000000
[ 2769.944900] Workqueue: cgroup_destroy css_killed_work_fn
[ 2769.944901]  ffff8803cae47a38 0000000000000096 ffff8803cae47a88
ffff8803cae47fd8
[ 2769.944902]  ffff8803cae47fd8 ffff8803cae47fd8 ffff8803cae47fd8
000000000000002b
[ 2769.944903]  ffff8803fe2ecc60 ffff8803dcdacc60 0000000000000005
ffff8803dcdacc60
[ 2769.944904] Call Trace:
[ 2769.944906]  [<ffffffff8174e044>] schedule+0x34/0xa0
[ 2769.944907]  [<ffffffff81750494>] schedule_timeout+0x1f4/0x260
[ 2769.944908]  [<ffffffff8109e325>] ? mark_held_locks+0x75/0xa0
[ 2769.944909]  [<ffffffff81751720>] ? _raw_spin_unlock_irq+0x30/0x60
[ 2769.944910]  [<ffffffff8109e44d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
[ 2769.944911]  [<ffffffff8174f394>] wait_for_completion+0xb4/0xf0
[ 2769.944912]  [<ffffffff810bdde0>] ? __call_rcu.constprop.69+0x240/0x240
[ 2769.944913]  [<ffffffff810bad06>] wait_rcu_gp+0x46/0x50
[ 2769.944914]  [<ffffffff810baca0>] ?
ftrace_raw_output_rcu_utilization+0x50/0x50
[ 2769.944916]  [<ffffffff8174f316>] ? wait_for_completion+0x36/0xf0
[ 2769.944917]  [<ffffffff810be33f>] synchronize_rcu.part.67+0x1f/0x40
[ 2769.944918]  [<ffffffff810be378>] synchronize_rcu+0x18/0x20
[ 2769.944919]  [<ffffffff811a4c65>] mem_cgroup_start_move+0x15/0x20
[ 2769.944920]  [<ffffffff811aa603>] mem_cgroup_reparent_charges+0x73/0x3f0
[ 2769.944921]  [<ffffffff811aaafb>] mem_cgroup_css_offline+0x14b/0x3e0
[ 2769.944922]  [<ffffffff810ebf5e>] css_killed_work_fn+0x4e/0x170
[ 2769.944924]  [<ffffffff8106b89c>] process_one_work+0x20c/0x5b0
[ 2769.944925]  [<ffffffff8106b801>] ? process_one_work+0x171/0x5b0
[ 2769.944926]  [<ffffffff8106bdab>] worker_thread+0x16b/0x4c0
[ 2769.944927]  [<ffffffff8106bc40>] ? process_one_work+0x5b0/0x5b0
[ 2769.944928]  [<ffffffff81070fc9>] kthread+0xd9/0xf0
[ 2769.944929]  [<ffffffff8109e51d>] ? trace_hardirqs_on+0xd/0x10
[ 2769.944931]  [<ffffffff81070ef0>] ? kthread_create_on_node+0x240/0x240
[ 2769.944932]  [<ffffffff817528c8>] ret_from_fork+0x58/0x90
[ 2769.944933]  [<ffffffff81070ef0>] ? kthread_create_on_node+0x240/0x240

[ 2769.930980] cgmanager       D ffff8803f7ce7080     0   349      1 0x00000000
[ 2769.930988]  ffff8803f998bc18 0000000000000092 ffff8803f998bbe8
ffff8803f998bfd8
[ 2769.930990]  ffff8803f998bfd8 ffff8803f998bfd8 ffff8803f998bfd8
ffff8803f998bce0
[ 2769.930992]  ffffffff81c224c0 ffff8803f7c4cc60 ffff8803f998bc38
ffff8803f7c4cc60
[ 2769.930995] Call Trace:
[ 2769.930998]  [<ffffffff8174e044>] schedule+0x34/0xa0
[ 2769.930999]  [<ffffffff8174f865>] __rt_mutex_slowlock+0x55/0x1c0
[ 2769.931001]  [<ffffffff8174fad5>] rt_mutex_slowlock+0x105/0x320
[ 2769.931003]  [<ffffffff8174fd28>] rt_mutex_lock+0x38/0x40
[ 2769.931004]  [<ffffffff81751d5c>] _mutex_lock+0x3c/0x50
[ 2769.931006]  [<ffffffff810ebd40>] ? cgroup_kn_lock_live+0x50/0x180
[ 2769.931008]  [<ffffffff810ebd40>] cgroup_kn_lock_live+0x50/0x180
[ 2769.931010]  [<ffffffff810ebd60>] ? cgroup_kn_lock_live+0x70/0x180
[ 2769.931011]  [<ffffffff810efe84>] cgroup_rmdir+0x14/0x40
[ 2769.931013]  [<ffffffff8123308e>] kernfs_iop_rmdir+0x4e/0x80
[ 2769.931016]  [<ffffffff811c208e>] vfs_rmdir+0xce/0x150
[ 2769.931017]  [<ffffffff811c7f1b>] do_rmdir+0x1fb/0x220
[ 2769.931018]  [<ffffffff817536d1>] ? retint_swapgs+0xe/0x13
[ 2769.931020]  [<ffffffff8109e44d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
[ 2769.931021]  [<ffffffff8139edac>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[ 2769.931023]  [<ffffffff811c9256>] SyS_rmdir+0x16/0x20
[ 2769.931024]  [<ffffffff81752976>] system_call_fastpath+0x16/0x1b

[ 2769.929671] kswork          D ffff8803fa6df080     0    69      2 0x00000000
[ 2769.929676]  ffff8803fda23be8 0000000000000092 ffff8803fda23bb8
ffff8803fda23fd8
[ 2769.929677]  ffff8803fda23fd8 ffff8803fda23fd8 ffff8803fda23fd8
ffff8803fda23cb0
[ 2769.929678]  ffff8803fe2ea630 ffff8803fda02630 ffff8803fda23c08
ffff8803fda02630
[ 2769.929679] Call Trace:
[ 2769.929681]  [<ffffffff8174e044>] schedule+0x34/0xa0
[ 2769.929683]  [<ffffffff8174f865>] __rt_mutex_slowlock+0x55/0x1c0
[ 2769.929684]  [<ffffffff8174fad5>] rt_mutex_slowlock+0x105/0x320
[ 2769.929686]  [<ffffffff8174fd28>] rt_mutex_lock+0x38/0x40
[ 2769.929687]  [<ffffffff81751d5c>] _mutex_lock+0x3c/0x50
[ 2769.929689]  [<ffffffff810ea7bf>] ? css_release_work_fn+0x2f/0xe0
[ 2769.929689]  [<ffffffff8109e44d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
[ 2769.929691]  [<ffffffff810ea7bf>] css_release_work_fn+0x2f/0xe0
[ 2769.929692]  [<ffffffff81093eba>] swork_kthread+0xfa/0x150
[ 2769.929693]  [<ffffffff81093dc0>] ? swork_readable+0x40/0x40
[ 2769.929694]  [<ffffffff81070fc9>] kthread+0xd9/0xf0
[ 2769.929695]  [<ffffffff8109e51d>] ? trace_hardirqs_on+0xd/0x10
[ 2769.929697]  [<ffffffff81070ef0>] ? kthread_create_on_node+0x240/0x240
[ 2769.929698]  [<ffffffff817528c8>] ret_from_fork+0x58/0x90
[ 2769.929700]  [<ffffffff81070ef0>] ? kthread_create_on_node+0x240/0x240


> What is it that you are doing exactly?

My test script (see below) has two processes that each start and stop
a Linux Container (linuxcontainers.org). There are two other processes
that try to get information about the state of the containers (running
or not, IP).

#!/bin/bash

set -e
set -u

cont1=test1
cont2=test2

create_container()
{
    local container=$1
    if [ -z "$(sudo lxc-ls | grep $container)" ] ; then
        sudo lxc-create -n $container -t ubuntu -- --release=precise
    fi
}

start_stop_container_forever()
{
    local container=$1
    while true ; do
        sudo lxc-start -n $container -d
        sleep 1
        sudo lxc-stop -n $container
    done
}

list_container_forever()
{
    set +e
    while true ; do
        sudo lxc-ls -f
        sleep 1;
    done
}

create_container $cont1
create_container $cont2

(start_stop_container_forever $cont1) &
(start_stop_container_forever $cont2) &
(list_container_forever) &
(list_container_forever) &
wait

The following is just my current idea of how lxc works: When the
container is started (lxc-start), cgroups for different resource kinds
are created and init of the containerized Linux is started into a new
namespaces and attached to the cgroups created before. Init will start
more processes that inherit its namespace and cgroups. When the
container is stopped (lxc-stop), the init process inside the container
is sent a signal to shutdown. After the shutdown, all cgroups are
removed. The processes gathering information (lxc-ls) about the
containers attach themselves to the namespace of the containers init.
