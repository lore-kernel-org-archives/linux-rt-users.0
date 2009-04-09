From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [patch 0/3] Patches for KVM & RT
Date: Thu, 09 Apr 2009 23:44:44 +0200
Message-ID: <49DE6C4C.3070308@osadl.org>
References: <20090407235853.309888494@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030303040602040100080507"
Cc: rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:56602 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757570AbZDJF1l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Apr 2009 01:27:41 -0400
In-Reply-To: <20090407235853.309888494@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030303040602040100080507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan,

> Here are some patches that are necessary to get KVM running with the -rt4
> patchset.
Thanks a lot.

Unfortunaately, there is still a last one at kernel/smp.c:288
        /* Can deadlock when called with interrupts disabled */
        WARN_ON_ONCE(irqs_disabled() && !oops_in_progress);

Do we get another fix?

	Carsten.

--------------030303040602040100080507
Content-Type: text/plain;
 name="warn-kvm-2.6.29.1-rt5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-kvm-2.6.29.1-rt5"

Apr  9 22:57:55 deliv1 kernel: ------------[ cut here ]------------
Apr  9 22:57:55 deliv1 kernel: WARNING: at kernel/smp.c:289 smp_call_func=
tion_single+0x5a/0x11c()
Apr  9 22:57:55 deliv1 kernel: Hardware name: SD37V10
Apr  9 22:57:55 deliv1 kernel: Modules linked in: tun fuse radeon drm nfs=
d lockd nfs_acl auth_rpcgss exportfs sco bridge stp bnep l2cap bluetooth =
coretemp it87 hwmon_vid hwmon sunrpc zd1211rw mac80211 cfg80211 ipt_MASQU=
ERADE iptable_nat nf_nat ipt_REJECT ipt_LOG nf_conntrack_ipv4 nf_defrag_i=
pv4 iptable_filter ip_tables nf_conntrack_netbios_ns ip6t_REJECT xt_tcpud=
p nf_conntrack_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables x_ta=
bles ipv6 cpufreq_ondemand acpi_cpufreq dm_mirror dm_region_hash dm_log d=
m_multipath scsi_dh dm_mod kvm_intel kvm uinput snd_hda_codec_realtek snd=
_hda_intel snd_hda_codec snd_usb_audio snd_usb_lib snd_rawmidi snd_hwdep =
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_p=
cm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore iTCO_wdt i2c_i801 tg=
3 i82975x_edac ohci1394 snd_page_alloc iTCO_vendor_support i2c_core libph=
y edac_core ieee1394 auerswald sr_mod sg button cdrom pcspkr ata_generic =
pata_acpi ata_piix libata sd_mod scsi_mod raid456 async_xor async_memcpy =
async
Apr  9 22:57:55 deliv1 kernel: _tx xor raid1 ext3 jbd mbcache uhci_hcd oh=
ci_hcd ehci_hcd [last unloaded: microcode]
Apr  9 22:57:55 deliv1 kernel: Pid: 4085, comm: qemu-kvm Not tainted 2.6.=
29.1-rt5-32bit #39
Apr  9 22:57:55 deliv1 kernel: Call Trace:
Apr  9 22:57:55 deliv1 kernel: [<c022e89e>] warn_slowpath+0x76/0xad
Apr  9 22:57:55 deliv1 kernel: [<c0227688>] ? sub_preempt_count+0x94/0xa3=

Apr  9 22:57:55 deliv1 kernel: [<f8352622>] ? set_spte+0xe/0x5dd [kvm]
Apr  9 22:57:55 deliv1 kernel: [<c048757f>] ? __schedule+0x9b0/0x9f9
Apr  9 22:57:55 deliv1 kernel: [<f834a626>] ? unalias_gfn+0xe/0x54 [kvm]
Apr  9 22:57:55 deliv1 kernel: [<c026c4cc>] ? __rcu_read_unlock+0x6e/0x7d=

Apr  9 22:57:55 deliv1 kernel: [<c022185b>] ? cpuacct_charge+0x52/0x58
Apr  9 22:57:55 deliv1 kernel: [<c0221f0b>] ? update_curr+0x136/0x177
Apr  9 22:57:55 deliv1 kernel: [<c0207f87>] ? sched_clock+0x44/0x64
Apr  9 22:57:55 deliv1 kernel: [<c026c4cc>] ? __rcu_read_unlock+0x6e/0x7d=

Apr  9 22:57:55 deliv1 kernel: [<c022185b>] ? cpuacct_charge+0x52/0x58
Apr  9 22:57:55 deliv1 kernel: [<c024fc95>] smp_call_function_single+0x5a=
/0x11c
Apr  9 22:57:55 deliv1 kernel: [<f81cc72f>] ? __vcpu_clear+0x0/0xbc [kvm_=
intel]
Apr  9 22:57:55 deliv1 kernel: [<f81cf19d>] vmx_vcpu_load+0x46/0x191 [kvm=
_intel]
Apr  9 22:57:55 deliv1 kernel: [<c0489067>] ? __spin_unlock+0x14/0x28
Apr  9 22:57:55 deliv1 kernel: [<f834db41>] kvm_arch_vcpu_load+0x14/0x1e =
[kvm]
Apr  9 22:57:55 deliv1 kernel: [<f83481d7>] kvm_sched_in+0x10/0x12 [kvm]
Apr  9 22:57:55 deliv1 kernel: [<c02275a5>] finish_task_switch+0x97/0xe6
Apr  9 22:57:55 deliv1 kernel: [<c0487570>] __schedule+0x9a1/0x9f9
Apr  9 22:57:55 deliv1 kernel: [<c024430f>] ? hrtimer_interrupt+0x18a/0x1=
92
Apr  9 22:57:55 deliv1 kernel: [<c0202c9d>] ? restore_nocheck_notrace+0x0=
/0xe
Apr  9 22:57:55 deliv1 kernel: [<f834e7c3>] ? kvm_arch_vcpu_ioctl_run+0x4=
06/0x634 [kvm]
Apr  9 22:57:55 deliv1 kernel: [<c048774f>] ? preempt_schedule+0x3e/0x67
Apr  9 22:57:55 deliv1 kernel: [<c048775e>] preempt_schedule+0x4d/0x67
Apr  9 22:57:55 deliv1 kernel: [<f834e7c3>] kvm_arch_vcpu_ioctl_run+0x406=
/0x634 [kvm]
Apr  9 22:57:55 deliv1 kernel: [<f834740d>] kvm_vcpu_ioctl+0xf4/0x659 [kv=
m]
Apr  9 22:57:55 deliv1 kernel: [<c048757f>] ? __schedule+0x9b0/0x9f9
Apr  9 22:57:55 deliv1 kernel: [<c024b232>] ? tick_dev_program_event+0x2d=
/0x9a
Apr  9 22:57:55 deliv1 kernel: [<f8347319>] ? kvm_vcpu_ioctl+0x0/0x659 [k=
vm]
Apr  9 22:57:55 deliv1 kernel: [<c02b8a8d>] vfs_ioctl+0x27/0x6e
Apr  9 22:57:55 deliv1 kernel: [<c02b9038>] do_vfs_ioctl+0x49b/0x4d4
Apr  9 22:57:55 deliv1 kernel: [<c0335058>] ? trace_hardirqs_on_thunk+0xc=
/0x10
Apr  9 22:57:55 deliv1 kernel: [<c02ae507>] ? fget_light+0x85/0x9a
Apr  9 22:57:55 deliv1 kernel: [<c02b90b6>] sys_ioctl+0x45/0x5f
Apr  9 22:57:55 deliv1 kernel: [<c0202b88>] sysenter_do_call+0x12/0x27
Apr  9 22:57:55 deliv1 kernel: ---[ end trace ea071060aeca7fc5 ]---

--------------030303040602040100080507--
