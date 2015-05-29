From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 28 May 2015 18:56:17 -0700
Message-ID: <5567C741.5010007@localhost>
References: <20150519213923.GA26363@linutronix.de>	<20150526083449.5357059b@sluggy>	<20150526093832.558e2e46@gandalf.local.home>	<20150526084802.2cfd055b@sluggy>	<20150526111924.20836deb@gandalf.local.home> <20150526104343.51fad474@sluggy> <5564CC80.3080101@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.stanford.edu ([171.67.219.82]:34990 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752190AbbE2B4i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2015 21:56:38 -0400
In-Reply-To: <5564CC80.3080101@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/26/2015 12:41 PM, Fernando Lopez-Lezcano wrote:
> On 05/26/2015 08:43 AM, Clark Williams wrote:
>> On Tue, 26 May 2015 11:19:24 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> On Tue, 26 May 2015 08:48:02 -0500
>>> Clark Williams <williams@redhat.com> wrote:
>>>
>>>
>>>> Change the WARN_ON to WARN_ON_NORT
>>>
>>> Do we have a WARN_ON_NORT? I see a WARN_ON_NONRT, but not a
>>> WARN_ON_NORT. Does this compile?
>>>
>>> -- Steve
>>
>> Sigh. Of course not. Reupdated patch (and yes this one compiles):
>
> Thanks! Seems to have fixed the problem (of course!)
> So far so good and nothing weird in the output of dmesg....

Oh well. Second time the machine hangs in two days in the same way 
(otherwise very stable running 3.18.x-rty)

(this is a bumblebee + bbswitch graphics laptop - argh, if I had known 
better...)

----
May 28 18:49:21 localhost kernel: ------------[ cut here ]------------
May 28 18:49:21 localhost kernel: kernel BUG at mm/memcontrol.c:5848!
May 28 18:49:21 localhost kernel: invalid opcode: 0000 [#1] PREEMPT SMP
May 28 18:49:21 localhost kernel: Modules linked in: ccm rfcomm fuse 
xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun 
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT 
nf_reje\
ct_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge stp llc 
ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 
nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_fi\
lter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 
nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw bnep 
bbswitch(OE) vfat fat iTCO_wdt iTCO_vendor_support arc4 intel\
_rapl iosf_mbi coretemp kvm_intel kvm uvcvideo crct10dif_pclmul 
videobuf2_vmalloc crc32_pclmul crc32c_intel videobuf2_core 
videobuf2_memops ghash_clmulni_intel v4l2_common iwlmvm videodev media 
mac80211 \
btusb bluetooth iwlwifi
May 28 18:49:21 localhost kernel: snd_hda_codec_realtek 
snd_hda_codec_hdmi lpc_ich snd_hda_codec_generic cfg80211 mfd_core 
i2c_i801 snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep 
snd_seq snd_se\
q_device snd_pcm thinkpad_acpi snd_timer rfkill tpm_tis snd mei_me 
ie31200_edac tpm mei edac_core soundcore shpchp nfsd auth_rpcgss nfs_acl 
lockd grace sunrpc serio_raw i915 sdhci_pci i2c_algo_bit sdhci \
e1000e drm_kms_helper mmc_core ptp drm pps_core wmi video
May 28 18:49:21 localhost kernel: CPU: 4 PID: 134 Comm: kswapd0 Tainted: 
G           OE   4.0.4-201.rt1.3.fc21.ccrma.x86_64+rt #1
May 28 18:49:21 localhost kernel: Hardware name: LENOVO 
20BGCTO1WW/20BGCTO1WW, BIOS GNET65WW (2.13 ) 06/20/2014
May 28 18:49:21 localhost kernel: task: ffff88046650e9a0 ti: 
ffff88046657c000 task.ti: ffff88046657c000
May 28 18:49:21 localhost kernel: RIP: 0010:[<ffffffff812164b8>] 
[<ffffffff812164b8>] mem_cgroup_swapout+0x118/0x120
May 28 18:49:21 localhost kernel: RSP: 0018:ffff88046657f998  EFLAGS: 
00010202
May 28 18:49:21 localhost kernel: RAX: 0000000000000246 RBX: 
ffffea0011150e80 RCX: 0000000000000000
May 28 18:49:21 localhost kernel: RDX: 000000000006a980 RSI: 
0000000000000001 RDI: ffff88046d413800
May 28 18:49:21 localhost kernel: RBP: ffff88046657f9a8 R08: 
ffffffff81c68700 R09: ffff88046657fba8
May 28 18:49:21 localhost kernel: R10: 000000000000000a R11: 
ffff88046657ffd8 R12: ffff88046d413800
May 28 18:49:21 localhost kernel: R13: ffffffff81c68718 R14: 
0000000000000001 R15: ffff88046657faa8
May 28 18:49:21 localhost kernel: FS:  0000000000000000(0000) 
GS:ffff88046da00000(0000) knlGS:0000000000000000
May 28 18:49:21 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
May 28 18:49:21 localhost kernel: CR2: 00007efd07eb8000 CR3: 
0000000001c0e000 CR4: 00000000001407e0
May 28 18:49:21 localhost kernel: Stack:
May 28 18:49:21 localhost kernel: ffffea0011150e80 0000000000196218 
ffff88046657f9e8 ffffffff811b8d8f
May 28 18:49:21 localhost kernel: 0000000000000000 ffff88046657fe48 
ffffea0011150e80 ffff88046657fbc0
May 28 18:49:21 localhost kernel: ffffea0011150ea0 ffff88046657faa8 
ffff88046657fb28 ffffffff811bba3f
May 28 18:49:21 localhost kernel: Call Trace:
May 28 18:49:21 localhost kernel: [<ffffffff811b8d8f>] 
__remove_mapping+0x12f/0x1a0
May 28 18:49:21 localhost kernel: [<ffffffff811bba3f>] 
shrink_page_list+0x5ef/0xc30
May 28 18:49:21 localhost kernel: [<ffffffff811bc709>] 
shrink_inactive_list+0x1e9/0x630
May 28 18:49:21 localhost kernel: [<ffffffff811bd50c>] 
shrink_lruvec+0x62c/0x830
May 28 18:49:21 localhost kernel: [<ffffffff81014610>] ? 
__switch_to+0x150/0x610
May 28 18:49:21 localhost kernel: [<ffffffff811bd804>] 
shrink_zone+0xf4/0x2d0
May 28 18:49:21 localhost kernel: [<ffffffff811bec37>] kswapd+0x587/0xa80
May 28 18:49:21 localhost kernel: [<ffffffff811be6b0>] ? 
mem_cgroup_shrink_node_zone+0x1f0/0x1f0
May 28 18:49:21 localhost kernel: [<ffffffff810bf4ba>] kthread+0xca/0xe0
May 28 18:49:21 localhost kernel: [<ffffffff810bf3f0>] ? 
kthread_worker_fn+0x180/0x180
May 28 18:49:21 localhost kernel: [<ffffffff817a2098>] 
ret_from_fork+0x58/0x90
May 28 18:49:21 localhost kernel: [<ffffffff810bf3f0>] ? 
kthread_worker_fn+0x180/0x180
May 28 18:49:21 localhost kernel: Code: a6 81 48 89 df e8 a9 ce fb ff 0f 
0b 0f 1f 80 00 00 00 00 48 c7 c6 f3 b7 a6 81 48 89 df e8 91 ce fb ff 0f 
0b 0f 1f 80 00 00 00 00 <0f> 0b 66 0f 1f 44 00 00 0f 1f 44\
  00 00 8b 05 f5 c2 b0 00 85 c0
May 28 18:49:21 localhost kernel: RIP  [<ffffffff812164b8>] 
mem_cgroup_swapout+0x118/0x120
May 28 18:49:21 localhost kernel: RSP <ffff88046657f998>
May 28 18:49:21 localhost kernel: ---[ end trace 0000000000000002 ]---
----

-- Fernando

