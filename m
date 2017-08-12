From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Sat, 12 Aug 2017 12:07:22 +0200
Message-ID: <4fdcdc0e-1b05-c510-8b20-1a871f440a48@jajcus.net>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:58566 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdHLKHa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 12 Aug 2017 06:07:30 -0400
In-Reply-To: <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

>> Most of the information I could find online is quite outdated or
>> incomplete, so I have really little idea what the proper configuration
>> of the RT kernel is or how to debug it.
> 
> usually people take their local distro's config (make localyesconfig),
> patch RT, enable PREEMPT-FULL (via make oldconfig) and tweak the config
> in what they think is best for them.

That was the first thing that I tried.


>> I have no idea how to properly debug the problem, even what data should
>> I collect to prepare a reasonable bug report.
> 
> This is probably -EDEADLK coming from task_blocks_on_rt_mutex(). I
> suspect that the following patch
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 78a6c4a223c1..59430ede6e89 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -524,6 +524,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
>  		}
>  		put_task_struct(task);
>  
> +		pr_err("EDEADLK #1\n");
>  		return -EDEADLK;
>  	}
>  
> @@ -639,6 +640,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
>  		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
>  		raw_spin_unlock(&lock->wait_lock);
>  		ret = -EDEADLK;
> +		pr_err("EDEADLK #2\n");
>  		goto out_unlock_pi;
>  	}
>  
> @@ -1081,6 +1083,8 @@ static void  noinline __sched rt_spin_lock_slowlock(struct rt_mutex *lock,
>  	raw_spin_unlock(&self->pi_lock);
>  
>  	ret = task_blocks_on_rt_mutex(lock, &waiter, self, RT_MUTEX_MIN_CHAINWALK);
> +	if (ret )
> +		pr_err("Crashing soon on %d (%p %p)\n", ret, rt_mutex_owner(lock), self);
>  	BUG_ON(ret);
>  
>  	for (;;) {
> 
> will return "EDEADLK #2". And we got rid of two instances of this error
> before v4.9 went into maintain mode.

Got it! I had to extract this from EFI pstore, as the disk was already dead.

<3>[  917.051362] EDEADLK #2
<3>[  917.051364] Crashing soon on -35 (ffff8e3906642000 ffff8e38f73d6000)
<4>[  917.051390] ------------[ cut here ]------------
<2>[  917.051390] kernel BUG at kernel/locking/rtmutex.c:1088!
<4>[  917.051391] invalid opcode: 0000 [#1] PREEMPT SMP
<4>[  917.051408] Modules linked in: snd_seq_dummy snd_seq fuse
ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter xt_tcpudp ipt_REJECT
nf_reject_ipv4 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute
bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6
ip6table_mangle ip6table_raw ip6table_security iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
iptable_mangle iptable_raw iptable_security ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep msr joydev acer_wmi
sparse_keymap coretemp hwmon intel_rapl efi_pstore snd_hda_codec_hdmi
intel_powerclamp intel_cstate snd_soc_skl snd_hda_codec_realtek
snd_soc_skl_ipc intel_uncore snd_hda_codec_generic snd_soc_sst_ipc
snd_soc_sst_dsp intel_rapl_perf snd_hda_ext_core snd_soc_sst_match
snd_soc_core snd_compress
<4>[  917.051429]  ac97_bus psmouse snd_pcm_dmaengine pcspkr
snd_hda_intel efivars snd_hda_codec snd_hda_core input_leds uvcvideo
r8169 btusb videobuf2_vmalloc mii videobuf2_memops btrtl videobuf2_v4l2
btbcm snd_usb_audio videobuf2_core btintel videodev snd_usbmidi_lib
snd_hwdep bluetooth media snd_rawmidi snd_seq_device snd_pcm mei_me mei
shpchp dell_smo8800 wmi pinctrl_sunrisepoint pinctrl_intel
intel_lpss_acpi idma64 evdev battery fjes tpm_crb intel_lpss_pci
acpi_pad intel_lpss ac intel_pch_thermal thermal sch_fq_codel ip_tables
x_tables ext4 crc16 jbd2 fscrypto mbcache dm_crypt algif_skcipher af_alg
sr_mod cdrom sd_mod hid_generic usbhid i915 rtsx_pci_sdmmc mmc_core
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_gtt ahci
i2c_algo_bit aesni_intel libahci drm_kms_helper aes_x86_64
glue_helperOops#1 Part4
 syscopyarea lrw sysfillrect libata gf128mul xhci_pci ablk_helper
sysimgblt cryptd fb_sys_fops xhci_hcd drm serio_raw scsi_mod i2c_hid
rtsx_pci usbcore hid i2c_core video button dm_mirror dm_region_hash
dm_log rpcsec_gss_krb5 auth_rpcgss sunrpc snd_hrtimer snd_timer snd
soundcore dm_cache_smq dm_cache dm_persistent_data libcrc32c
crc32c_generic crc32c_intel dm_bufio dm_bio_prison dm_mod efivarfs autofs4
<4>[  917.051442] CPU: 0 PID: 1213 Comm: zabbix_agentd Not tainted
4.9.37-rt25-1 #1
<4>[  917.051443] Hardware name: Acer Aspire E5-575/Ironman_SK  , BIOS
V1.25 03/03/2017
<4>[  917.051443] task: ffff8e38f73d6000 task.stack: ffff97dc022b4000
<4>[  917.051447] RIP: 0010:[<ffffffffb8656ad2>]  [<ffffffffb8656ad2>]
rt_spin_lock_slowlock+0x362/0x3e0
<4>[  917.051448] RSP: 0018:ffff97dc022b7c10  EFLAGS: 00010082
<4>[  917.051449] RAX: 0000000000000038 RBX: ffff97dc022b7c30 RCX:
0000000000000000
<4>[  917.051449] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000001
<4>[  917.051450] RBP: ffff97dc022b7cd0 R08: 0000000000000000 R09:
0000000000000038
<4>[  917.051450] R10: 0000000000000008 R11: 000000000002b23c R12:
ffff8e38f73d6000
Oops#1 Part2
<4>[  917.051451] R13: 0000000000000246 R14: ffff8e391000cdd8 R15:
ffff8e38f73d6000
<4>[  917.051452] FS:  00007f4f233d4780(0000) GS:ffff8e3910000000(0000)
knlGS:0000000000000000
<4>[  917.051452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  917.051453] CR2: 00007f4f22050f38 CR3: 00000002368ef000 CR4:
00000000003406f0
<4>[  917.051453] Stack:
<4>[  917.051456]  ffffffffb8586dd5 ffffffffb8cd4880 00ff8e3905410000
ffff8e38f73d6890
<4>[  917.051457]  0000000000000001 0000000000000000 0000000000000000
0000000000000001
<4>[  917.051458]  0000000000000000 0000000000000000 ffff8e38f73d6000
ffff8e391000cdd8
<4>[  917.051459] Call Trace:
<4>[  917.051461]  [<ffffffffb8586dd5>] ? ip_local_out+0x35/0x40
<4>[  917.051464]  [<ffffffffb8659220>] rt_spin_lock__no_mg+0x10/0x20
<4>[  917.051466]  [<ffffffffb806b1e6>] do_current_softirqs+0x116/0x370
<4>[  917.051468]  [<ffffffffb806b49b>] __local_bh_enable+0x5b/0x80
<4>[  917.051472]  [<ffffffffb85a5c6f>] tcp_v4_send_reset+0x3df/0x530
<4>[  917.051475]  [<ffffffffb859d400>] ? tcp_rcv_state_process+0x280/0xda0
<4>[  917.051481]  [<ffffffffb8090b57>] ? migrate_enable+0x1e7/0x360
<4>[  917.051483]  [<ffffffffb85a5f33>] tcp_v4_do_rcv+0x73/0x210
<4>[  917.051487]  [<ffffffffb852147b>] __release_sock+0x6b/0x110
<4>[  917.051489]  [<ffffffffb8521555>] release_sock+0x35/0xa0
<4>[  917.051493]  [<ffffffffb85be516>] inet_shutdown+0x86/0x100
<4>[  917.051494]  [<ffffffffb851e704>] SyS_shutdown+0x84/0x90
<4>[  917.051495]  [<ffffffffb8002ddf>] do_syscall_64+0x7f/0x190
<4>[  917.051496]  [<ffffffffb8659723>] entry_SYSCALL64_slow_path+0x25/0x25
<4>[  917.051508] Code: ff e9 27 fe ff ff e8 1e 42 a7 ff e9 2f fe ff ff
0f 0b 49 8b 56 18 4c 89 e1 89 c6 48 c7 c7 20 56 9b b8 48 83 e2 fe e8 42
c1 b2 ff <0f> 0b 31 d2 b9 01 00 00 00 4c 89 e6 4c 89 f7 e8 5a 30 a6 ff 85
<1>[  917.051509] RIP  [<ffffffffb8656ad2>]
rt_spin_lock_slowlock+0x362/0x3e0
<4>[  917.051510]  RSP <ffff97dc022b7c10>
<4>[  917.058528] ---[ end trace 0000000000000002 ]---

That was on 4.9.37-rt25-1

> 
>> Any idea what is the problem?
>> Any hints how to debug it?
> 
> The patch should confirm the origin of the return error code, not the
> reason.

So we have the origin confirmed. How can we find the reason?

> The backtrace comes from networking so with networking disabled,
> it should not get into this particular problem.

Unfortunately, I need the network here.

> One thing you could try, is to see if the latest v4.11 based RT kernel
> works more reliable.

I will compile it now and see.

Thanks.

Jacek
