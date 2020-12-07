Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B948AC4361B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 12:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76514233F7
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 12:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgLGMoe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:44:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33718 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgLGMob (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 07:44:31 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kmFro-0004do-D8; Mon, 07 Dec 2020 12:43:48 +0000
To:     linux-rt-users@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: RT kernel testing with stress-ng and scheduling while in atomic bugs.
Message-ID: <b9317e8c-d5d9-e440-6c32-f9c26ad4ef10@canonical.com>
Date:   Mon, 7 Dec 2020 12:43:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I've recently been exercising the 5.10-rc6 kernel with the latest RT
patches from linux-rt-devel (v5.10-rc6-rt13) using stress-ng V0.12.00
[1][2] to see rugged the RT kernel is and I'm getting quite a few
"scheduling while atomic:" bugs in various stress-tests.

While I realize this is a rc6 kernel, I was surprised to be able to trip
these issues so easily [3]

Questions:

1. Are these issues expected?
2. Is there an official way to report my bug findings?
3. I am keen to debug and fix these issues, have RT folk got some advice
on how to start debugging these kind of issues?

On an 8 CPU SMP test box stress-ng is hitting these issues on the
following stress tests:

daemon enosys exec fork fstat madvise prctl pthread session sigpipe vfork

..it seems fork/clone + scheduling is the common feature in the stress
tests that is triggering this issue.

How to reproduce:

git clone https://github.com/ColinIanKing/stress-ng.git
cd stress-ng
make clean
make fast-test-all


..stress-ng is tool I've been developing for quite a few years for
kernel testing. Quite a few folk are now using for kernel CI integration
testing as it does shake kernel bugs such as timing issues, locking
problems and race conditions. Hence I was curious to see how well it
finds issues in RT kernels.  In the past I have found and fixed various
issues in the non-RT kernels, so I'm keen to do the same for RT.

Colin

References:

[1] https://kernel.ubuntu.com/~cking/stress-ng/
[2] https://github.com/ColinIanKing/stress-ng
[3] Failures such as:

Dec  7 11:41:14 skylake kernel: [  308.800476] BUG: scheduling while
atomic: stress-ng-fstat/47271/0x00000002
Dec  7 11:41:14 skylake kernel: [  308.800479] Modules linked in:
dccp_ipv4 dccp atm fcrypt sm4_generic md4 michael_mic nhpoly1305_avx2
nhpoly1305_sse2 nhpoly1305 poly1305_generic libpoly1305 poly1305_x86_64
rmd128 rmd160 rmd256 rmd320 sha3_generic sm3_generic streebog_generic
tgr192 wp512 xxhash_generic algif_hash blowfish_generic blowfish_x86_64
blowfish_common cast5_avx_x86_64 cast5_generic des_generic
des3_ede_x86_64 libdes salsa20_generic chacha_generic chacha_x86_64
libchacha camellia_generic camellia_aesni_avx2 camellia_aesni_avx_x86_64
camellia_x86_64 cast6_avx_x86_64 cast6_generic cast_common serpent_avx2
serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic twofish_generic
twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 twofish_common
algif_skcipher af_alg xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
nf_reject_ipv4 xt_tcpudp nft_compat nft_counter nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bridge
stp llc binfmt_misc nls_iso8859_1 dm_multipath scsi_dh_rdac
Dec  7 11:41:14 skylake kernel: [  308.800516]  scsi_dh_emc scsi_dh_alua
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
ledtrig_audio snd_hda_intel x86_pkg_temp_thermal snd_intel_dspcfg
intel_powerclamp soundwire_intel soundwire_generic_allocation
soundwire_cadence snd_hda_codec coretemp snd_hda_core snd_hwdep
soundwire_bus snd_soc_core snd_compress ac97_bus kvm_intel mei_hdcp
snd_pcm_dmaengine kvm snd_pcm ppdev intel_rapl_msr input_leds
processor_thermal_device rapl intel_cstate 8250_dw intel_rapl_common
ee1004 snd_timer mei_me mei parport_pc snd parport int340x_thermal_zone
soundcore intel_soc_dts_iosf intel_pch_thermal intel_hid
intel_wmi_thunderbolt intel_vbtn mac_hid acpi_pad sparse_keymap
serio_raw sch_fq_codel msr ip_tables x_tables autofs4 btrfs
blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel i915 aesni_intel
crypto_simd cryptd glue_helper i2c_algo_bit
Dec  7 11:41:14 skylake kernel: [  308.800555]  drm_kms_helper
syscopyarea sysfillrect sysimgblt dwc3 fb_sys_fops ulpi cec udc_core
i2c_i801 intel_lpss_pci rc_core e1000e i2c_smbus intel_lpss ahci idma64
xhci_pci drm libahci virt_dma dwc3_pci xhci_pci_renesas wmi video
pinctrl_sunrisepoint
Dec  7 11:41:14 skylake kernel: [  308.800569] CPU: 4 PID: 47271 Comm:
stress-ng-fstat Not tainted 5.10.0-6-realtime #7
Dec  7 11:41:14 skylake kernel: [  308.800571] Hardware name: Intel
Corporation Skylake Client platform/Skylake DT DDR4 RVP8, BIOS
SKLSE2R1.R00.B089.B00.1506160228 06/16/2015
Dec  7 11:41:14 skylake kernel: [  308.800572] Call Trace:
Dec  7 11:41:14 skylake kernel: [  308.800574]  show_stack+0x52/0x58
Dec  7 11:41:14 skylake kernel: [  308.800579]  dump_stack+0x70/0x8b
Dec  7 11:41:14 skylake kernel: [  308.800581]
__schedule_bug.cold+0x4a/0x5b
Dec  7 11:41:14 skylake kernel: [  308.800584]  __schedule+0x50d/0x6b0
Dec  7 11:41:14 skylake kernel: [  308.800587]  ?
task_blocks_on_rt_mutex+0x29a/0x390
Dec  7 11:41:14 skylake kernel: [  308.800590]
preempt_schedule_lock+0x24/0x50
Dec  7 11:41:14 skylake kernel: [  308.800592]
rt_spin_lock_slowlock_locked+0x11b/0x2c0
Dec  7 11:41:14 skylake kernel: [  308.800596]
rt_spin_lock_slowlock+0x57/0x90
Dec  7 11:41:14 skylake kernel: [  308.800599]  rt_spin_lock+0x30/0x40
Dec  7 11:41:14 skylake kernel: [  308.800600]  alloc_pid+0x1bc/0x400
Dec  7 11:41:14 skylake kernel: [  308.800603]  copy_process+0x9f0/0x15e0
Dec  7 11:41:14 skylake kernel: [  308.800607]  kernel_clone+0x9d/0x350
Dec  7 11:41:14 skylake kernel: [  308.800609]  ? do_prlimit+0x12a/0x1e0
Dec  7 11:41:14 skylake kernel: [  308.800612]  __do_sys_clone+0x5d/0x80
Dec  7 11:41:14 skylake kernel: [  308.800615]  __x64_sys_clone+0x25/0x30
Dec  7 11:41:14 skylake kernel: [  308.800617]  do_syscall_64+0x38/0x90
Dec  7 11:41:14 skylake kernel: [  308.800619]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec  7 11:41:14 skylake kernel: [  308.800621] RIP: 0033:0x7f7480802035
Dec  7 11:41:14 skylake kernel: [  308.800622] Code: 48 85 ff 74 3d 48
85 f6 74 38 48 83 ee 10 48 89 4e 08 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8
4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58
5f ff d0 48 89 c7 b8 3c 00 00 00
Dec  7 11:41:14 skylake kernel: [  308.800624] RSP:
002b:00007ffca63524e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
Dec  7 11:41:14 skylake kernel: [  308.800625] RAX: ffffffffffffffda
RBX: 00007f747f473640 RCX: 00007f7480802035
Dec  7 11:41:14 skylake kernel: [  308.800626] RDX: 00007f747f473910
RSI: 00007f747f472ef0 RDI: 00000000003d0f00
Dec  7 11:41:14 skylake kernel: [  308.800627] RBP: 00007ffca63525a0
R08: 00007f747f473640 R09: 00007f747f473640
Dec  7 11:41:14 skylake kernel: [  308.800627] R10: 00007f747f473910
R11: 0000000000000206 R12: 00007ffca635259e
Dec  7 11:41:14 skylake kernel: [  308.800628] R13: 00007ffca635259f
R14: 0000000000000000 R15: 00007f747f473640

