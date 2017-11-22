From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] 4.4.x-rt - memcg: refill_stock() use get_cpu_light() has
 data corruption issue
Date: Tue, 21 Nov 2017 22:50:02 -0500
Message-ID: <20171121225002.0704d679@vmware.local.home>
References: <05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "'umgwanakikbuti@gmail.com'" <umgwanakikbuti@gmail.com>,
        "'bigeasy@linutronix.de'" <bigeasy@linutronix.de>,
        "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Tong Tong3 Li <litong3@lenovo.com>,
        Feng Feng24 Liu <liufeng24@lenovo.com>,
        Jianqiang1 Lu <lujq1@lenovo.com>,
        Hongyong HY2 Zang <zanghy2@lenovo.com>
To: Haiyang HY1 Tan <tanhy1@lenovo.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05AA4EC5C6EC1D48BE2CDCFF3AE0B8A637F78A15@CNMAILEX04.lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 22 Nov 2017 03:18:45 +0000
Haiyang HY1 Tan <tanhy1@lenovo.com> wrote:

> Dear RT experts,
> 
> I have a x86 server mainly used as qemu-kvm hypervisor that is installed with linux-RT kernel, the linux kernel and RT patch set are respectively get from:
> Linux kernel: https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.97.tar.xz
> RT patch set: https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patches-4.4.97-rt110.tar.gz

Thanks for the report.

> 
> kernel crash or hung occur occasionally on this server, a typical backtrace is shown blow:
> 
> （13:55:23）[167112.371909] BUG: unable to handle kernel NULL pointer dereference at 00000000000003b0
> （13:55:23）[167112.371914] IP: [<ffffffff811a6a37>] mem_cgroup_page_lruvec+0x47/0x60
> （13:55:23）[167112.371915] PGD 0 
> （13:55:23）[167112.371916] Oops: 0000 [#1] PREEMPT SMP 
> （13:55:23）[167112.371938] Modules linked in: xt_mac xt_physdev xt_set ip_set_hash_net ip_set vfio_pci vfio_virqfd ip6table_raw ip6table_mangle iptable_nat nf_nat_ipv4 nf_nat xt_connmark iptable_mangle 8021q garp mrp ebtable_filter ebtables ip6table_filter ip6_tables openvswitch xt_tcpudp xt_multiport xt_conntrack iptable_filter xt_comment xt_CT iptable_raw igb_uio(O) uio intel_rapl iosf_mbi intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel mxm_wmi mei_me aesni_intel aes_x86_64 glue_helper lrw ablk_helper ipmi_devintf mei lpc_ich mfd_core cryptd sb_edac edac_core ipmi_si ipmi_msghandler acpi_pad shpchp acpi_power_meter wmi tpm_tis vhost_net vhost macvtap macvlan nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 ip_table
 s x_tables raid1 megaraid_sas
> （13:55:23）[167112.371942] CPU: 5 PID: 775963 Comm: qemu-kvm Tainted: G           O    4.4.70-thinkcloud-nfv #1
> （13:55:23）[167112.371943] Hardware name: LENOVO System x3650 M5: -[8871AC1]-/01GR174, BIOS -[TCE124M-2.10]- 06/23/2016
> （13:55:23）[167112.371944] task: ffff88022d246a00 ti: ffff88022d3b0000 task.ti: ffff88022d3b0000
> （13:55:23）[167112.371946] RIP: 0010:[<ffffffff811a6a37>]  [<ffffffff811a6a37>] mem_cgroup_page_lruvec+0x47/0x60
> （13:55:23）[167112.371947] RSP: 0018:ffff88022d3b3bc0  EFLAGS: 00010202
> （13:55:23）[167112.371947] RAX: 0000000000000340 RBX: 0000000000000001 RCX: 0000000000000000
> （13:55:23）[167112.371948] RDX: ffff88114ac02400 RSI: ffff88107fffc000 RDI: 0000000000000006
> （13:55:23）[167112.371948] RBP: ffff88022d3b3bc0 R08: 0000000000000001 R09: 0000000000000000
> （13:55:23）[167112.371949] R10: ffffea00405de800 R11: 0000000000000000 R12: ffffea0004c14900
> （13:55:23）[167112.371949] R13: ffff88103fb50320 R14: ffff88107fffc000 R15: ffff88107fffc000
> （13:55:23）[167112.371950] FS:  00007fe24404ac80(0000) GS:ffff88103fb40000(0000) knlGS:0000000000000000
> （13:55:23）[167112.371951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> （13:55:23）[167112.371951] CR2: 00000000000003b0 CR3: 0000000001df1000 CR4: 00000000003426e0
> （13:55:23）[167112.371952] Stack:
> （13:55:23）[167112.371953]  ffff88022d3b3c08 ffffffff81156fed 0000000000000000 ffffffff81157760
> （13:55:23）[167112.371954]  0000000000000005 ffff88103fb50520 ffff88022d246a00 00007fe23ed9a000
> （13:55:24）[167112.371955]  0000000000000008 ffff88022d3b3c40 ffffffff811581ca 00000000000103a0
> （13:55:24）[167112.371955] Call Trace:
> （13:55:24）[167112.371964]  [<ffffffff81156fed>] pagevec_lru_move_fn+0x8d/0xf0
> （13:55:24）[167112.371966]  [<ffffffff81157760>] ? __pagevec_lru_add_fn+0x190/0x190
> （13:55:24）[167112.371967]  [<ffffffff811581ca>] lru_add_drain_cpu+0x8a/0x130
> （13:55:24）[167112.371969]  [<ffffffff811583ea>] lru_add_drain+0x5a/0x90
> （13:55:24）[167112.371971]  [<ffffffff81188bdd>] free_pages_and_swap_cache+0x1d/0x90
> （13:55:24）[167112.371973]  [<ffffffff81173b66>] tlb_flush_mmu_free+0x36/0x60
> （13:55:24）[167112.371974]  [<ffffffff81175d8d>] unmap_single_vma+0x70d/0x7c0
> （13:55:24）[167112.371976]  [<ffffffff81176507>] unmap_vmas+0x47/0x90
> （13:55:24）[167112.371978]  [<ffffffff8117ea88>] exit_mmap+0x98/0x150
> （13:55:24）[167112.371982]  [<ffffffff8105ea43>] mmput+0x23/0xc0
> （13:55:24）[167112.371984]  [<ffffffff81064990>] do_exit+0x240/0xbb0
> （13:55:24）[167112.371987]  [<ffffffff81424eb7>] ? debug_smp_processor_id+0x17/0x20
> （13:55:24）[167112.371989]  [<ffffffff810620a6>] ? unpin_current_cpu+0x16/0x70
> （13:55:24）[167112.371990]  [<ffffffff8106538c>] do_group_exit+0x4c/0xc0
> （13:55:24）[167112.371991]  [<ffffffff81065414>] SyS_exit_group+0x14/0x20
> （13:55:24）[167112.371995]  [<ffffffff81a9ab2e>] entry_SYSCALL_64_fastpath+0x12/0x71
> （13:55:24）[167112.372007] Code: d2 48 89 c1 48 0f 44 15 50 6b da 00 48 c1 e8 38 48 c1 e9 3a 83 e0 03 48 8d 3c 40 48 8d 04 b8 48 c1 e0 05 48 03 84 ca d0 03 00 00 <48> 3b 70 70 75 02 5d c3 48 89 70 70 5d c3 48 8d 86 10 06 00 00 
> （13:55:24）[167112.372008] RIP  [<ffffffff811a6a37>] mem_cgroup_page_lruvec+0x47/0x60
> （13:55:24）[167112.372008]  RSP <ffff88022d3b3bc0>
> （13:55:24）[167112.372008] CR2: 00000000000003b0
> （14:05:24）[167112.777349] ---[ end trace 0000000000000002 ]---
> 
> 
> 
> I have review the RT patch set and I think the following patch has a bug. It is shown as blow:

What's the bug?

Does it work if you revert the patch?

Anyway, this patch should be reverted (for 4.9-rt as well) as the
upstream stable code merged in makes the problem it was fixing go away
anyway.

-- Steve

> 
> Patch: 0250-memcontrol-Prevent-scheduling-while-atomic-in-cgroup
> 
> From 9fa927a8204bbb41c887abff7355c205aa32fb20 Mon Sep 17 00:00:00 2001
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> Date: Sat, 21 Jun 2014 10:09:48 +0200
> Subject: [PATCH 250/376] memcontrol: Prevent scheduling while atomic in cgroup
> code
> 
> mm, memcg: make refill_stock() use get_cpu_light()
> 
> Nikita reported the following memcg scheduling while atomic bug:
> 
> Call Trace:
> [e22d5a90] [c0007ea8] show_stack+0x4c/0x168 (unreliable)
> [e22d5ad0] [c0618c04] __schedule_bug+0x94/0xb0
> [e22d5ae0] [c060b9ec] __schedule+0x530/0x550
> [e22d5bf0] [c060bacc] schedule+0x30/0xbc
> [e22d5c00] [c060ca24] rt_spin_lock_slowlock+0x180/0x27c
> [e22d5c70] [c00b39dc] res_counter_uncharge_until+0x40/0xc4
> [e22d5ca0] [c013ca88] drain_stock.isra.20+0x54/0x98
> [e22d5cc0] [c01402ac] __mem_cgroup_try_charge+0x2e8/0xbac
> [e22d5d70] [c01410d4] mem_cgroup_charge_common+0x3c/0x70
> [e22d5d90] [c0117284] __do_fault+0x38c/0x510
> [e22d5df0] [c011a5f4] handle_pte_fault+0x98/0x858
> [e22d5e50] [c060ed08] do_page_fault+0x42c/0x6fc
> [e22d5f40] [c000f5b4] handle_page_fault+0xc/0x80
> 
> What happens:
> 
>    refill_stock()
>       get_cpu_var()
>       drain_stock()
>          res_counter_uncharge()
>             res_counter_uncharge_until()
>                spin_lock() <== boom
> 
> Fix it by replacing get/put_cpu_var() with get/put_cpu_light().
> 
> 
> Reported-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> mm/memcontrol.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4a020497561..1c619267d9da 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1925,14 +1925,17 @@ static void drain_local_stock(struct work_struct *dummy)
>   */
> static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> {
> -                  struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
> +                  struct memcg_stock_pcp *stock;
> +                  int cpu = get_cpu_light();
> +
> +                  stock = &per_cpu(memcg_stock, cpu);
> 
>                    if (stock->cached != memcg) { /* reset if necessary */
>                                        drain_stock(stock);
>                                        stock->cached = memcg;
>                   }
>                   stock->nr_pages += nr_pages;
> -                  put_cpu_var(memcg_stock);
> +                  put_cpu_light();
> }
> 
>  /*
