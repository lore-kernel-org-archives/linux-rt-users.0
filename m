From: Qiang Huang <h.huangqiang@huawei.com>
Subject: Re: cgroup_fj tests will stick the nort kernel
Date: Sat, 20 Apr 2013 10:00:19 +0800
Message-ID: <5171F6B3.1020907@huawei.com>
References: <5170F28F.3060002@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Li Zefan <lizefan@huawei.com>, zhangwei <jovi.zhangwei@huawei.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:24894 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965470Ab3DTCAd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Apr 2013 22:00:33 -0400
In-Reply-To: <5170F28F.3060002@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2013/4/19 15:30, Qiang Huang wrote:
> Hi,
> 
> I ran cgroup_fj tests on RT kernel with PREEMPT_RT_FULL disabled, it will
> stick the system when ran cpuset stress tests, it happens everytime.

Here let me explain something, cgroup_fj is a test suit in ltp, which will do
some functionality and pressure test on cgroup.

And the script I give below is a very simple version of cgroup_fj which only
do one type of pressure test on cpuset subsystem.
What he did is:
1. Create /dev/cgroup and mount cpuset subsystem on it.
2. Create 100 dir under /dev/cgroup named subgroup_1..subgroup_100.
3. Attach all tasks in /dev/cgroup/tasks to /dev/cgroup/subgroup_1/tasks, then
from /dev/cgroup/subgroup_1/tasks to /dev/cgroup/subgroup_2/tasks and so on,
finally from /dev/cgroup/subgroup_100/tasks to /dev/cgroup/tasks, then end.

And the system will stuck in step 3.

> 
> Here stick the system means there are almost no response from the system and
> we can hardly do anything on the terminal, but kernel isn't crash nor deadlocked
> (according to the lockdep message), and it may do some response sometimes.
> 
> The problem exists on all RT versions from 3.4.18-rt29 to 3.4.37-rt51 AFAIK, but
> without RT patches or with PREEMPT_RT_FULL enabled, the problem isn't exists.
> 
> When the system is stuck, we will get the following message:
> # dmesg
> ...
> [96967.772181] NOHZ: local_softirq_pending 200
> [96967.776398] NOHZ: local_softirq_pending 200
> [96967.780212] NOHZ: local_softirq_pending 200
> [96967.781215] NOHZ: local_softirq_pending 200
> [96967.784152] NOHZ: local_softirq_pending 200
> [96967.784310] NOHZ: local_softirq_pending 200
> [96967.788239] NOHZ: local_softirq_pending 200
> [96967.796092] NOHZ: local_softirq_pending 200
> [96967.800089] NOHZ: local_softirq_pending 200
> [96967.800225] NOHZ: local_softirq_pending 200
> [97112.950055] ------------[ cut here ]------------
> [97112.950068] WARNING: at /usr/src/packages/BUILD/kernel-default-3.4.24.03/linux-3.4/kernel/workqueue.c:1208 worker_enter_idle+0x1d3/0x200()
> [97112.950073] Hardware name: Tecal RH2285
> [97112.950076] Modules linked in: reiserfs minix hfs vfat fat tun xt_limit xt_tcpudp nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 x_tables dummy edd cpufreq_conservative cpufreq_userspace
> cpufreq_powersave acpi_cpufreq mperf loop dm_mod coretemp crc32c_intel igb ghash_clmulni_intel aesni_intel cryptd aes_x86_64 aes_generic iTCO_wdt bnx2 iTCO_vendor_support i7core_edac pcspkr i2c_i801
> dca edac_core button rtc_cmos microcode serio_raw i2c_core ses enclosure sg mptctl ext3 jbd mbcache usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10dif processor thermal_sys hwmon
> scsi_dh_alua scsi_dh_emc scsi_dh_hp_sw scsi_dh_rdac scsi_dh ata_generic ata_piix libata mptsas mptscsih mptbase scsi_transport_sas scsi_mod [last unloaded: ip_tables]
> [97112.950178] Pid: 5331, comm: kworker/0:2 Tainted: GF       WC   3.4.24.03-0.1.2-default #1
> [97112.950182] Call Trace:
> [97112.950191]  [<ffffffff8105e2d2>] warn_slowpath_common+0xb2/0x120
> [97112.950196]  [<ffffffff8105e365>] warn_slowpath_null+0x25/0x30
> [97112.950202]  [<ffffffff81085593>] worker_enter_idle+0x1d3/0x200
> [97112.950207]  [<ffffffff81084a95>] ? need_to_create_worker+0x15/0x50
> [97112.950213]  [<ffffffff8108a308>] worker_thread+0x2a8/0x4f0
> [97112.950218]  [<ffffffff8108a060>] ? rescuer_thread+0x320/0x320
> [97112.950226]  [<ffffffff81091d86>] kthread+0xc6/0xe0
> [97112.950233]  [<ffffffff81720454>] kernel_thread_helper+0x4/0x10
> [97112.950239]  [<ffffffff81091cc0>] ? __init_kthread_worker+0x50/0x50
> [97112.950244]  [<ffffffff81720450>] ? gs_change+0x13/0x13
> [97112.950248] ---[ end trace 61f48fadbd018007 ]---
> 
> 
> 
> Here is a sample version of cgroup_fj which can trigger this problem everytime:
> (make sure we have CONFIG_CGROUPS and CONFIG_CPUSET endabled :))
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> # cat cgroup_fj.sh
> #! /bin/sh
> 
> LOGFILE=./cgroup_fj-output.txt
> TMPFILE=/tmp/cgroup_fj_tempfile.txt
> 
> subsystem=2
> subsystem_name="cpuset"
> 
> subgroup_num=100
> 
> cur_subgroup_path1=""
> 
> get_subgroup_path1()
> {
>         cur_subgroup_path1=""
>         if [ "$#" -ne 1 ] || [ "$1" -lt 1 ] ; then
>                 return;
>         fi
> 
>         cur_subgroup_path1="/dev/cgroup/subgroup_$1/"
> }
> 
> cleanup()
> {
>         mount_str="`mount -l | grep /dev/cgroup`"
>         if [ "$mount_str" != "" ]; then
>                 umount /dev/cgroup
>         fi
> 
>         if [ -e /dev/cgroup ]; then
>                 rmdir /dev/cgroup
>         fi
> }
> 
> setup()
> {
>         mkdir /dev/cgroup
>         mount -t cgroup -o $subsystem_name cgroup /dev/cgroup
> }
> 
> reclaim_foundling()
> {
>         cat `find /dev/cgroup/subgroup_* -name "tasks"` > $TMPFILE
>         nlines=`cat "$TMPFILE" | wc -l`
>         for k in `seq 1 $nlines`
>         do
>                 cur_pid=`sed -n "$k""p" $TMPFILE`
>                 if [ -e /proc/$cur_pid/ ];then
>                         echo "pid $cur_pid reclaimed"
>                         echo "$cur_pid" > "/dev/cgroup/tasks"
>                 fi
>         done
> }
> 
> ##########################  main   #######################
> echo "-------------------------------------------------------------------------" >> $LOGFILE
> 
> cleanup;
> 
> setup;
> 
> if [ $subsystem -eq 2 ]; then
>         cpus=`cat /dev/cgroup/cpuset.cpus`
>         mems=`cat /dev/cgroup/cpuset.mems`
> fi
> 
> count=0
> pathes[1]=""
> for i in `seq 1 $subgroup_num`
> do
>         get_subgroup_path1 $i
>         mkdir $cur_subgroup_path1
> 
>         if [ $subsystem -eq 2 ]; then
>                 echo "$cpus" > "$cur_subgroup_path1""cpuset.cpus"
>                 echo "$mems" > "$cur_subgroup_path1""cpuset.mems"
>         fi
> 
>         let "count = $count + 1"
>         pathes[$count]="$cur_subgroup_path1"
> done
> 
> echo "...mkdired $count times" >> $LOGFILE
> 
> sleep 1
> 
> count2=$count
> let "count2 = $count2 + 1"
> pathes[0]="/dev/cgroup/"
> pathes[$count2]="/dev/cgroup/"
> for i in `seq 0 $count`
> do
>         j=$i
>         let "j = $j + 1"
>         cat "${pathes[$i]}tasks" > $TMPFILE
>         nlines=`cat "$TMPFILE" | wc -l`
>         for k in `seq 1 $nlines`
>         do
>                 cur_pid=`sed -n "$k""p" $TMPFILE`
>                 if [ -e /proc/$cur_pid/ ];then
>                         echo "$cur_pid" > "${pathes[$j]}tasks"
>                         echo "task: $cur_pid" >> $LOGFILE
>                         echo "target: ${pathes[$j]}tasks}" >> $LOGFILE
>                 fi
>         done
> done
> 
> reclaim_foundling;
> 
> for i in `seq 1 $count`
> do
>         j=i
>         let "j = $count - $j + 1"
>         rmdir ${pathes[$j]}
> done
> 
> sleep 1
> 
> cleanup;
> 
> exit 0;
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


