Return-Path: <SRS0=njtg=DA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6BAC4727E
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B6321D7D
	for <linux-rt-users@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFYRljhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWPT6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgIWPTz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Sep 2020 11:19:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC872C0613CE
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2020 08:19:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x69so339164lff.3
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2020 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WaOrdGylbGjdd/NN7bCnfhHA1wEJIeYQ6mpyH30QCP0=;
        b=YFYRljhLxnM5CeYvsZrGp6wpzo1PleMrmn4EbasER14YaItcuTfYzlrwT6CLNwmghX
         YEEypXPKmN1g9ChJEtU4vmhI0E1wnHxgppDapfFYLIohz9R4F82XC347WEd+q8zI2udq
         BFhwQGjxcq8zBfZOog3pbCrPSGK8ckXQ7GDfiKt+qi9lXfJbN9J959pAaYV8+8d2O2PI
         VADK9gsB0SQKEM3aC7mbHk8taPfCKWlGHyqzLm39iobyxp5TQ2yqkP+3F5oWiU5tXLd5
         ExbvEQ5Gt3KPw4wlP071vSOLSyvffXdkgDNlAlXuVlszxzphk5ivOof6f1gEnewvFGCh
         lX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WaOrdGylbGjdd/NN7bCnfhHA1wEJIeYQ6mpyH30QCP0=;
        b=GGx6isi2oZ3mWI5LFTGJJ9djF+whbpPOZUaXOUPjJ0oVmA2FKfW3hii55MqOVj+7/a
         2o7pviVIPOaDjWw30uNnOjAVD8aBxrV74HQs62Eo7Lkj48yXuUuN8VstzKyCVnO3pex/
         RtjmTrowenOP1hX8FzvkDPaVKw99KW1VCPFiT439EvHwGpb3KKfFk3rGARYBWY93ZwcL
         z7FXSuX4VfPxl2KMpksQr0WTnqIm1//szRQZS3/v7VqsmphM24WL6BYKsTH054XrVNTD
         rnkHdP/DiOzyOvj7sVedASiM+yeUK2QVfLnmJk51WkH95VTZ+NdxBZ1fCYH164oDiHCG
         PJAg==
X-Gm-Message-State: AOAM53383js2+/ahPz1MpkGD9ScG2lsUMLLWK0ZwezRH9/AXutEeELTF
        lrcG9AlPvwCAouVIRHvdwnB7eWAWb+NKTB5zRefP+ZfIG08=
X-Google-Smtp-Source: ABdhPJz0+wZcTW0E1eSFFPuTLtUJaYkQdA/xzPUQs8Sh7VrTEYhAYVTNaqpdJcBAwoVRlqvOdHspeen8LJ2hOqN3a7U=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr93578lfl.573.1600874391184;
 Wed, 23 Sep 2020 08:19:51 -0700 (PDT)
MIME-Version: 1.0
From:   Marcos Tadeu <mtadeu.von@gmail.com>
Date:   Wed, 23 Sep 2020 12:19:39 -0300
Message-ID: <CAL6cx4xXeVpA4zSmFzgUVp+i7TUsO=0bhhi9yEyXoS+4=wAnWw@mail.gmail.com>
Subject: Virtualbox - BUG: using smp_processor_id() in preemptible [00000000]
 code: modprobe/11395
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

HI!

Great job. I use RT kernel with ardour, kdenlive and audacity.
Much better with RT kernel!
The linux distribution is  Slackware 14.2

Problem: Real Time vs VirtualBox.
The VM machines do not run.
has use 5.4.61, and now, 5.4.66

dmesg below
has difference "vboxdrv: version magic '5.4.66-rt38 SMP preempt
mod_unload ' should be '5.4.66-rt38 SMP preempt_rt mod_unload '"
Then, I recompile (vboxdrv setup), after [ 2525... ] in dmesg

[    0.000000] Linux version 5.4.66-rt38 (root@mtnb5) (gcc version
5.5.0 (GCC)) #2 SMP PREEMPT_RT Tue Sep 22 23:48:45 -03 2020
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.66-rt38
root=UUID=3035d629-4f36-4229-996d-acb055773c9b ro
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is
960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006a3c2fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006a3c3000-0x000000006a3c3fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006a3c4000-0x000000006a3edfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006a3ee000-0x000000006a449fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006a44a000-0x000000006abf9fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006abfa000-0x0000000076c10fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076c11000-0x0000000077627fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077628000-0x0000000077f98fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000077f99000-0x0000000077ffdfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000077ffe000-0x0000000077ffefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000078000000-0x00000000780fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000482ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ACPI=0x77fd4000  ACPI 2.0=0x77fd4000
SMBIOS=0xf05e0  ESRT=0x76fe7598  MPS=0xfcbd0
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. Inspiron 5557/0WT51R, BIOS 1.1.7 02/23/2016
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2599.992 MHz TSC
[    0.003342] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003343] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.003348] last_pfn = 0x483000 max_arch_pfn = 0x400000000
[    0.003350] MTRR default type: write-back
 .......
[   10.588697] ath: Regpair used: 0x6c
[   10.633287] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xd40123/0x840300/0x126800/0x0, board id: 3024, fw
id: 1693264
[   10.666993] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input8
[   10.766764] input: Dell WMI hotkeys as
/devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input11
[   11.252325] i2c_hid i2c-DLLA70A:00: i2c-DLLA70A:00 supply vdd not
found, using dummy regulator
[   11.252355] i2c_hid i2c-DLLA70A:00: i2c-DLLA70A:00 supply vddl not
found, using dummy regulator
[   11.584246] i2c /dev entries driver
[   11.618984] intel_rapl_common: Found RAPL domain package
[   11.618988] intel_rapl_common: Found RAPL domain core
[   11.618989] intel_rapl_common: Found RAPL domain uncore
[   11.618990] intel_rapl_common: Found RAPL domain dram
[   11.722029] input: DLLA70A:00 06CB:7621 Mouse as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DLLA70A:00/0018:06CB:7621.0001/input/input12
[   11.722235] input: DLLA70A:00 06CB:7621 Touchpad as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DLLA70A:00/0018:06CB:7621.0001/input/input13
[   11.722416] hid-generic 0018:06CB:7621.0001: input,hidraw0: I2C HID
v1.00 Mouse [DLLA70A:00 06CB:7621] on i2c-DLLA70A:00
[   11.762827] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[   11.834358] input: DLLA70A:00 06CB:7621 Mouse as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DLLA70A:00/0018:06CB:7621.0001/input/input15
[   11.834495] input: DLLA70A:00 06CB:7621 Touchpad as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-4/i2c-DLLA70A:00/0018:06CB:7621.0001/input/input16
[   11.834608] hid-multitouch 0018:06CB:7621.0001: input,hidraw0: I2C
HID v1.00 Mouse [DLLA70A:00 06CB:7621] on i2c-DLLA70A:00
[   11.961587] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
ALC3234: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   11.961592] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   11.961594] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1
(0x21/0x0/0x0/0x0/0x0)
[   11.961596] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   11.961598] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   11.961600] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
[   11.961602] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
[   11.961603] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   12.059233] input: HDA Intel PCH Headphone Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   12.059492] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   12.059645] input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   12.059803] input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input21
[   12.059962] input: HDA Intel PCH HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[   12.061160] input: HDA Intel PCH HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input23
[   12.096141] usbcore: registered new interface driver rtsx_usb
[   12.228178] Bluetooth: Core ver 2.22
[   12.228230] NET: Registered protocol family 31
[   12.228232] Bluetooth: HCI device and connection manager initialized
[   12.228239] Bluetooth: HCI socket layer initialized
[   12.228242] Bluetooth: L2CAP socket layer initialized
[   12.228250] Bluetooth: SCO socket layer initialized
[   12.255134] mc: Linux media interface: v0.10
[   12.357423] videodev: Linux video capture interface: v2.00
[   12.487744] usbcore: registered new interface driver btusb
[   12.624178] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (1bcf:28b0)
[   12.625670] uvcvideo: Failed to query (GET_INFO) UVC control 3 on
unit 1: -32 (exp. 1).
[   12.646067] uvcvideo 1-5:1.0: Entity type for entity Extension 4
was not initialized!
[   12.646075] uvcvideo 1-5:1.0: Entity type for entity Extension 3
was not initialized!
[   12.646078] uvcvideo 1-5:1.0: Entity type for entity Processing 2
was not initialized!
[   12.646081] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was
not initialized!
[   12.646379] input: Integrated_Webcam_HD: Integrate as
/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input24
[   12.646573] usbcore: registered new interface driver uvcvideo
[   12.646576] USB Video Class driver (1.1.1)
[   13.873235] i2c_designware i2c_designware.1: controller timed out
[   14.265258] Adding 16553980k swap on /dev/sda4.  Priority:-2
extents:1 across:16553980k FS
[   14.356746] fuse: init (API version 7.31)
[   15.032508] EXT4-fs (sda6): re-mounted. Opts: (null)
[   19.826707] EXT4-fs (sda7): mounted filesystem with ordered data
mode. Opts: (null)
[   19.882294] FAT-fs (sda1): Volume was not properly unmounted. Some
data may be corrupt. Please run fsck.
[   26.239434] ath10k_pci 0000:02:00.0: unsupported HTC service id: 1536
[   30.163728] ath10k_pci 0000:02:00.0: unsupported HTC service id: 1536
[   35.160949] wlan0: authenticate with 00:27:22:b3:e7:bb
[   35.233889] wlan0: send auth to 00:27:22:b3:e7:bb (try 1/3)
[   35.246239] wlan0: authenticated
[   35.247260] wlan0: associate with 00:27:22:b3:e7:bb (try 1/3)
[   35.262850] wlan0: RX AssocResp from 00:27:22:b3:e7:bb (capab=0x431
status=0 aid=3)
[   35.266239] wlan0: associated
[   41.433801] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   41.433806] Bluetooth: BNEP filters: protocol multicast
[   41.433818] Bluetooth: BNEP socket layer initialized
[   42.711773] wlan0: deauthenticating from 00:27:22:b3:e7:bb by local
choice (Reason: 3=DEAUTH_LEAVING)
[   42.947772] NET: Registered protocol family 10
[   42.957055] Segment Routing with IPv6
[   47.871866] vboxdrv: version magic '5.4.66-rt38 SMP preempt
mod_unload ' should be '5.4.66-rt38 SMP preempt_rt mod_unload '
[   88.091243] vboxdrv: loading out-of-tree module taints kernel.
[   88.112349] vboxdrv: Found 4 processor cores
[   88.128117] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.128119] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[   88.128146] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.128148] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.128149] Call Trace:
[   88.128152]  dump_stack+0x66/0x8b
[   88.128156]  debug_smp_processor_id+0xbc/0xc0
[   88.128159]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[   88.128173]  VBoxHost_RTMpOnSpecific+0x85/0xf0 [vboxdrv]
[   88.128187]  ? supdrvTscDeltaSync2_Before+0x280/0x280 [vboxdrv]
[   88.128199]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.128212]  supdrvGipInitMeasureTscFreq+0x190/0x380 [vboxdrv]
[   88.128224]  supdrvGipCreate+0x5e2/0xab0 [vboxdrv]
[   88.128235]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.128248]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.128259]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.128269]  ? 0xffffffffc0ef7000
[   88.128270]  do_one_initcall+0x56/0x2a4
[   88.128274]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.128276]  ? do_init_module+0x22/0x22e
[   88.128279]  do_init_module+0x5b/0x22e
[   88.128281]  load_module+0x22a3/0x2a00
[   88.128285]  ? vfs_read+0x11c/0x130
[   88.128288]  ? __do_sys_finit_module+0xce/0xe0
[   88.128290]  __do_sys_finit_module+0xce/0xe0
[   88.128293]  do_syscall_64+0x71/0x250
[   88.128295]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.128298] RIP: 0033:0x7f4921c2ff99
[   88.128300] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.128302] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.128303] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.128304] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.128305] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.128306] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.128306] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.128309] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.128310] caller is VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[   88.128323] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.128324] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.128325] Call Trace:
[   88.128326]  dump_stack+0x66/0x8b
[   88.128328]  debug_smp_processor_id+0xbc/0xc0
[   88.128330]  VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[   88.128342]  ? supdrvTscDeltaSync2_Before+0x280/0x280 [vboxdrv]
[   88.128353]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.128365]  supdrvGipInitMeasureTscFreq+0x190/0x380 [vboxdrv]
[   88.128377]  supdrvGipCreate+0x5e2/0xab0 [vboxdrv]
[   88.128387]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.128399]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.128409]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.128420]  ? 0xffffffffc0ef7000
[   88.128421]  do_one_initcall+0x56/0x2a4
[   88.128423]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.128425]  ? do_init_module+0x22/0x22e
[   88.128427]  do_init_module+0x5b/0x22e
[   88.128429]  load_module+0x22a3/0x2a00
[   88.128432]  ? vfs_read+0x11c/0x130
[   88.128435]  ? __do_sys_finit_module+0xce/0xe0
[   88.128436]  __do_sys_finit_module+0xce/0xe0
[   88.128439]  do_syscall_64+0x71/0x250
[   88.128441]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.128443] RIP: 0033:0x7f4921c2ff99
[   88.128444] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.128446] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.128447] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.128448] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.128449] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.128449] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.128450] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.128479] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.128480] caller is VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[   88.128493] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.128495] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.128495] Call Trace:
[   88.128496]  dump_stack+0x66/0x8b
[   88.128498]  debug_smp_processor_id+0xbc/0xc0
[   88.128500]  VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[   88.128513]  VBoxHost_RTMpOnSpecific+0xad/0xf0 [vboxdrv]
[   88.128525]  ? supdrvTscDeltaSync2_Before+0x280/0x280 [vboxdrv]
[   88.128536]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.128548]  supdrvGipInitMeasureTscFreq+0x190/0x380 [vboxdrv]
[   88.128559]  supdrvGipCreate+0x5e2/0xab0 [vboxdrv]
[   88.128569]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.128581]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.128591]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.128601]  ? 0xffffffffc0ef7000
[   88.128602]  do_one_initcall+0x56/0x2a4
[   88.128605]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.128607]  ? do_init_module+0x22/0x22e
[   88.128609]  do_init_module+0x5b/0x22e
[   88.128611]  load_module+0x22a3/0x2a00
[   88.128614]  ? vfs_read+0x11c/0x130
[   88.128616]  ? __do_sys_finit_module+0xce/0xe0
[   88.128618]  __do_sys_finit_module+0xce/0xe0
[   88.128621]  do_syscall_64+0x71/0x250
[   88.128623]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.128625] RIP: 0033:0x7f4921c2ff99
[   88.128626] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.128628] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.128629] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.128630] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.128630] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.128631] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.128632] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.128637] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.128638] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[   88.128651] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.128652] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.128653] Call Trace:
[   88.128654]  dump_stack+0x66/0x8b
[   88.128656]  debug_smp_processor_id+0xbc/0xc0
[   88.128658]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[   88.128670]  VBoxHost_RTMpOnSpecific+0x85/0xf0 [vboxdrv]
[   88.128683]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[   88.128695]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.128707]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[   88.128719]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[   88.128730]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.128742]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.128753]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.128763]  ? 0xffffffffc0ef7000
[   88.128764]  do_one_initcall+0x56/0x2a4
[   88.128767]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.128768]  ? do_init_module+0x22/0x22e
[   88.128771]  do_init_module+0x5b/0x22e
[   88.128772]  load_module+0x22a3/0x2a00
[   88.128775]  ? vfs_read+0x11c/0x130
[   88.128778]  ? __do_sys_finit_module+0xce/0xe0
[   88.128779]  __do_sys_finit_module+0xce/0xe0
[   88.128782]  do_syscall_64+0x71/0x250
[   88.128784]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.128786] RIP: 0033:0x7f4921c2ff99
[   88.128787] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.128789] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.128790] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.128791] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.128791] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.128792] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.128793] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.128795] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.128796] caller is VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[   88.128808] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.128809] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.128810] Call Trace:
[   88.128811]  dump_stack+0x66/0x8b
[   88.128813]  debug_smp_processor_id+0xbc/0xc0
[   88.128815]  VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[   88.128826]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[   88.128839]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.128851]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[   88.128863]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[   88.128874]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.128887]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.128897]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.128908]  ? 0xffffffffc0ef7000
[   88.128909]  do_one_initcall+0x56/0x2a4
[   88.128911]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.128913]  ? do_init_module+0x22/0x22e
[   88.128915]  do_init_module+0x5b/0x22e
[   88.128917]  load_module+0x22a3/0x2a00
[   88.128919]  ? vfs_read+0x11c/0x130
[   88.128922]  ? __do_sys_finit_module+0xce/0xe0
[   88.128924]  __do_sys_finit_module+0xce/0xe0
[   88.128927]  do_syscall_64+0x71/0x250
[   88.128929]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.128931] RIP: 0033:0x7f4921c2ff99
[   88.128932] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.128933] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.128934] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.128935] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.128936] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.128936] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.128937] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.128939] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.128940] caller is rtmpLinuxWrapper+0x28/0x40 [vboxdrv]
[   88.128952] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.128953] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.128954] Call Trace:
[   88.128955]  dump_stack+0x66/0x8b
[   88.128957]  debug_smp_processor_id+0xbc/0xc0
[   88.128959]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[   88.128970]  rtmpLinuxWrapper+0x28/0x40 [vboxdrv]
[   88.128983]  VBoxHost_RTMpOnSpecific+0xde/0xf0 [vboxdrv]
[   88.128994]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[   88.129006]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.129018]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[   88.129029]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[   88.129041]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.129053]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.129064]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.129074]  ? 0xffffffffc0ef7000
[   88.129075]  do_one_initcall+0x56/0x2a4
[   88.129077]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.129079]  ? do_init_module+0x22/0x22e
[   88.129081]  do_init_module+0x5b/0x22e
[   88.129083]  load_module+0x22a3/0x2a00
[   88.129086]  ? vfs_read+0x11c/0x130
[   88.129089]  ? __do_sys_finit_module+0xce/0xe0
[   88.129090]  __do_sys_finit_module+0xce/0xe0
[   88.129093]  do_syscall_64+0x71/0x250
[   88.129095]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.129097] RIP: 0033:0x7f4921c2ff99
[   88.129098] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.129100] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.129101] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.129101] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.129102] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.129103] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.129104] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.129120] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.129121] caller is VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[   88.129133] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.129135] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.129135] Call Trace:
[   88.129136]  dump_stack+0x66/0x8b
[   88.129138]  debug_smp_processor_id+0xbc/0xc0
[   88.129140]  VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[   88.129152]  VBoxHost_RTMpOnSpecific+0xad/0xf0 [vboxdrv]
[   88.129165]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[   88.129177]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[   88.129189]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[   88.129200]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[   88.129211]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.129224]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.129235]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.129246]  ? 0xffffffffc0ef7000
[   88.129247]  do_one_initcall+0x56/0x2a4
[   88.129249]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.129250]  ? do_init_module+0x22/0x22e
[   88.129253]  do_init_module+0x5b/0x22e
[   88.129255]  load_module+0x22a3/0x2a00
[   88.129257]  ? vfs_read+0x11c/0x130
[   88.129260]  ? __do_sys_finit_module+0xce/0xe0
[   88.129262]  __do_sys_finit_module+0xce/0xe0
[   88.129265]  do_syscall_64+0x71/0x250
[   88.129266]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.129268] RIP: 0033:0x7f4921c2ff99
[   88.129269] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.129271] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.129272] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.129273] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.129274] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.129274] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.129275] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.129359] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.129361] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[   88.129374] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.129375] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.129376] Call Trace:
[   88.129377]  dump_stack+0x66/0x8b
[   88.129379]  debug_smp_processor_id+0xbc/0xc0
[   88.129381]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[   88.129393]  VBoxHost_RTMpOnAll+0x72/0x1b0 [vboxdrv]
[   88.129405]  ? supdrvGipMpEventOnlineOrInitOnCpu+0x300/0x300 [vboxdrv]
[   88.129417]  ? migrate_enable+0x10c/0x340
[   88.129419]  ? preempt_count_add+0x49/0xa0
[   88.129420]  ? migrate_enable+0x10c/0x340
[   88.129422]  ? __kmalloc+0x54/0x2d0
[   88.129424]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.129436]  ? preempt_count_add+0x49/0xa0
[   88.129437]  ? migrate_enable+0x10c/0x340
[   88.129438]  ? migrate_disable+0x38/0xc0
[   88.129440]  ? supdrvGipInitOnCpu+0x20/0x20 [vboxdrv]
[   88.129450]  ? rt_spin_unlock+0x28/0x40
[   88.129452]  ? VBoxHost_RTMpNotificationRegister+0xc3/0x190 [vboxdrv]
[   88.129464]  supdrvGipCreate+0x4fd/0xab0 [vboxdrv]
[   88.129475]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.129487]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.129497]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.129508]  ? 0xffffffffc0ef7000
[   88.129509]  do_one_initcall+0x56/0x2a4
[   88.129511]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.129513]  ? do_init_module+0x22/0x22e
[   88.129515]  do_init_module+0x5b/0x22e
[   88.129517]  load_module+0x22a3/0x2a00
[   88.129520]  ? vfs_read+0x11c/0x130
[   88.129522]  ? __do_sys_finit_module+0xce/0xe0
[   88.129524]  __do_sys_finit_module+0xce/0xe0
[   88.129527]  do_syscall_64+0x71/0x250
[   88.129529]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.129531] RIP: 0033:0x7f4921c2ff99
[   88.129532] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.129534] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.129535] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.129536] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.129536] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.129537] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.129538] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.129541] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.129542] caller is VBoxHost_RTMpOnAll+0x86/0x1b0 [vboxdrv]
[   88.129554] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.129556] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.129556] Call Trace:
[   88.129557]  dump_stack+0x66/0x8b
[   88.129559]  debug_smp_processor_id+0xbc/0xc0
[   88.129561]  VBoxHost_RTMpOnAll+0x86/0x1b0 [vboxdrv]
[   88.129573]  ? supdrvGipMpEventOnlineOrInitOnCpu+0x300/0x300 [vboxdrv]
[   88.129584]  ? preempt_count_add+0x49/0xa0
[   88.129586]  ? migrate_enable+0x10c/0x340
[   88.129587]  ? migrate_disable+0x38/0xc0
[   88.129589]  ? supdrvGipInitOnCpu+0x20/0x20 [vboxdrv]
[   88.129598]  ? rt_spin_unlock+0x28/0x40
[   88.129600]  ? VBoxHost_RTMpNotificationRegister+0xc3/0x190 [vboxdrv]
[   88.129612]  supdrvGipCreate+0x4fd/0xab0 [vboxdrv]
[   88.129622]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.129634]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.129644]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.129654]  ? 0xffffffffc0ef7000
[   88.129655]  do_one_initcall+0x56/0x2a4
[   88.129658]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.129659]  ? do_init_module+0x22/0x22e
[   88.129662]  do_init_module+0x5b/0x22e
[   88.129664]  load_module+0x22a3/0x2a00
[   88.129666]  ? vfs_read+0x11c/0x130
[   88.129669]  ? __do_sys_finit_module+0xce/0xe0
[   88.129671]  __do_sys_finit_module+0xce/0xe0
[   88.129674]  do_syscall_64+0x71/0x250
[   88.129676]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.129678] RIP: 0033:0x7f4921c2ff99
[   88.129679] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.129680] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[   88.129681] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.129682] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.129683] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.129683] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.129684] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.129689] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/5538
[   88.129690] caller is supdrvGipMpEventOnlineOrInitOnCpu+0x5a/0x300 [vboxdrv]
[   88.129691] BUG: scheduling while atomic: klogd/982/0x00010001
[   88.129700] CPU: 0 PID: 5538 Comm: modprobe Tainted: G           O
    5.4.66-rt38 #2
[   88.129703] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.129704] Call Trace:
[   88.129706]  dump_stack+0x66/0x8b
[   88.129708]  debug_smp_processor_id+0xbc/0xc0
[   88.129711]  supdrvGipMpEventOnlineOrInitOnCpu+0x5a/0x300 [vboxdrv]
[   88.129721]  VBoxHost_RTMpOnAll+0xf1/0x1b0 [vboxdrv]
[   88.129734]  ? supdrvGipMpEventOnlineOrInitOnCpu+0x300/0x300 [vboxdrv]
[   88.129746]  ? preempt_count_add+0x49/0xa0
[   88.129748]  ? migrate_enable+0x10c/0x340
[   88.129749]  ? migrate_disable+0x38/0xc0
[   88.129751]  ? supdrvGipInitOnCpu+0x20/0x20 [vboxdrv]
[   88.129760]  ? rt_spin_unlock+0x28/0x40
[   88.129763]  ? VBoxHost_RTMpNotificationRegister+0xc3/0x190 [vboxdrv]
[   88.129775]  supdrvGipCreate+0x4fd/0xab0 [vboxdrv]
[   88.129784]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[   88.129797]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[   88.129809]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[   88.129820]  ? 0xffffffffc0ef7000
[   88.129822]  do_one_initcall+0x56/0x2a4
[   88.129824]  ? kmem_cache_alloc_trace+0x34/0x280
[   88.129826]  ? do_init_module+0x22/0x22e
[   88.129829]  do_init_module+0x5b/0x22e
[   88.129831]  load_module+0x22a3/0x2a00
[   88.129834]  ? vfs_read+0x11c/0x130
[   88.129836]  ? __do_sys_finit_module+0xce/0xe0
[   88.129838]  __do_sys_finit_module+0xce/0xe0
[   88.129841]  do_syscall_64+0x71/0x250
[   88.129843]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.129845] RIP: 0033:0x7f4921c2ff99
[   88.129847] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[   88.129703] Modules linked in: vboxdrv(O+) ipv6 cmac bnep vfat fat
fuse uvcvideo videobuf2_vmalloc videobuf2_memops btusb videobuf2_v4l2
videobuf2_common btrtl btbcm videodev btintel mc rtsx_usb_ms bluetooth
rtsx_usb_sdmmc memstick mmc_core ecdh_generic ecc rtsx_usb
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
hid_multitouch hid_generic joydev intel_rapl_msr i2c_dev
dell_smm_hwmon snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
snd_soc_sst_dsp snd_soc_sst_ipc intel_xhci_usb_role_switch
snd_soc_acpi_intel_match roles snd_soc_acpi i2c_designware_platform
dell_wmi snd_soc_core i2c_designware_core sparse_keymap wmi_bmof
mxm_wmi mei_hdcp snd_compress
[   88.129849] RSP: 002b:00007ffe0a17b0c8 EFLAGS: 00000202
[   88.129850]  snd_pcm_dmaengine
[   88.129850]  ORIG_RAX: 0000000000000139
[   88.129851] RAX: ffffffffffffffda RBX: 0000000001c881d0 RCX: 00007f4921c2ff99
[   88.129852] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[   88.129852] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[   88.129853] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[   88.129854] R13: 0000000001c87ad0 R14: 0000000000040000 R15: 0000000001c881d0
[   88.129855]  ac97_bus snd_hda_intel coretemp intel_rapl_common
snd_intel_nhlt dell_laptop snd_hda_codec ledtrig_audio dell_smbios
x86_pkg_temp_thermal snd_hda_core intel_powerclamp dell_wmi_descriptor
dcdbas kvm_intel kvm snd_hwdep ath10k_pci ath10k_core irqbypass
snd_pcm_oss ath i915 crct10dif_pclmul crc32_pclmul snd_mixer_oss
ghash_clmulni_intel mac80211 aesni_intel snd_pcm cfg80211 evdev hwmon
crypto_simd cec psmouse rc_core snd_seq_dummy serio_raw snd_seq_oss
rapl intel_cstate drm_kms_helper i2c_hid tpm_crb tpm_tis hid thermal
snd_seq_midi snd_seq_midi_event snd_rawmidi drm snd_seq xhci_pci
intel_gtt dell_rbtn battery fan agpgart snd_seq_device rfkill
i2c_algo_bit tpm_tis_core xhci_hcd snd_timer i2c_core tpm snd wmi
soundcore intel_lpss_pci video intel_lpss acpi_pad ac mei_me idma64
button virt_dma pinctrl_sunrisepoint mei pinctrl_intel
intel_pch_thermal loop
[   88.129881] Preemption disabled at:
[   88.129881] [<ffffffffb9c0295b>] smp_call_function_interrupt+0xb/0x180
[   88.129884] CPU: 3 PID: 982 Comm: klogd Tainted: G           O
5.4.66-rt38 #2
[   88.129885] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.129885] Call Trace:
[   88.129886]  <IRQ>
[   88.129887]  dump_stack+0x66/0x8b
[   88.129889]  ? smp_call_function_interrupt+0xb/0x180
[   88.129890]  __schedule_bug+0x73/0xc0
[   88.129893]  __schedule+0x650/0x820
[   88.129894]  ? _raw_spin_lock+0x13/0x40
[   88.129896]  schedule+0x43/0xd0
[   88.129896]  rt_spin_lock_slowlock_locked+0x10d/0x2e0
[   88.129898]  rt_spin_lock_slowlock+0x50/0x80
[   88.129900]  VBoxHost_RTSpinlockAcquire+0x25/0x30 [vboxdrv]
[   88.129912]  supdrvGipMpEventOnlineOrInitOnCpu+0x6c/0x300 [vboxdrv]
[   88.129921]  rtmpLinuxAllWrapper+0x47/0x60 [vboxdrv]
[   88.129931]  flush_smp_call_function_queue+0x4b/0x100
[   88.129933]  smp_call_function_interrupt+0x4b/0x180
[   88.129934]  call_function_interrupt+0xf/0x20
[   88.129936]  </IRQ>
[   88.129936] RIP: 0033:0x7fa80a84b922
[   88.129937] Code: ba ff ff ff ff be 00 80 00 00 e8 59 51 00 00 48
8d 05 92 bb 34 00 48 89 df 48 89 e9 4c 89 e2 48 89 ee 48 89 84 24 d8
00 00 00 <c6> 45 00 00 e8 d5 65 00 00 48 89 df 4c 89 f2 4c 89 ee e8 97
67 fd
[   88.129939] RSP: 002b:00007ffd8819ce80 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff03
[   88.129940] RAX: 00007fa80ab974a0 RBX: 00007ffd8819ce80 RCX: 00007fa80ab9aa20
[   88.129940] RDX: 0000000000000071 RSI: 00007fa80ab9aa20 RDI: 00007ffd8819ce80
[   88.129941] RBP: 00007fa80ab9aa20 R08: 0000000000000000 R09: 0000000000000017
[   88.129941] R10: 000000000000000c R11: 0000000000000011 R12: 0000000000000071
[   88.129942] R13: 00007fa80a968980 R14: 00007ffd8819cfe8 R15: 0000000000405463
[   88.129946] ------------[ cut here ]------------
[   88.129946] DEBUG_LOCKS_WARN_ON(val > preempt_count())
[   88.129949] WARNING: CPU: 3 PID: 982 at kernel/sched/core.c:4031
preempt_count_sub+0x5a/0x90
[   88.129951] Modules linked in: vboxdrv(O+) ipv6 cmac bnep vfat fat
fuse uvcvideo videobuf2_vmalloc videobuf2_memops btusb videobuf2_v4l2
videobuf2_common btrtl btbcm videodev btintel mc rtsx_usb_ms bluetooth
rtsx_usb_sdmmc memstick mmc_core ecdh_generic ecc rtsx_usb
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic
hid_multitouch hid_generic joydev intel_rapl_msr i2c_dev
dell_smm_hwmon snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
snd_soc_sst_dsp snd_soc_sst_ipc intel_xhci_usb_role_switch
snd_soc_acpi_intel_match roles snd_soc_acpi i2c_designware_platform
dell_wmi snd_soc_core i2c_designware_core sparse_keymap wmi_bmof
mxm_wmi mei_hdcp snd_compress snd_pcm_dmaengine ac97_bus snd_hda_intel
coretemp intel_rapl_common snd_intel_nhlt dell_laptop snd_hda_codec
ledtrig_audio dell_smbios x86_pkg_temp_thermal snd_hda_core
intel_powerclamp dell_wmi_descriptor dcdbas kvm_intel kvm snd_hwdep
ath10k_pci ath10k_core irqbypass snd_pcm_oss ath i915 crct10dif_pclmul
crc32_pclmul snd_mixer_oss
[   88.129970]  ghash_clmulni_intel mac80211 aesni_intel snd_pcm
cfg80211 evdev hwmon crypto_simd cec psmouse rc_core snd_seq_dummy
serio_raw snd_seq_oss rapl intel_cstate drm_kms_helper i2c_hid tpm_crb
tpm_tis hid thermal snd_seq_midi snd_seq_midi_event snd_rawmidi drm
snd_seq xhci_pci intel_gtt dell_rbtn battery fan agpgart
snd_seq_device rfkill i2c_algo_bit tpm_tis_core xhci_hcd snd_timer
i2c_core tpm snd wmi soundcore intel_lpss_pci video intel_lpss
acpi_pad ac mei_me idma64 button virt_dma pinctrl_sunrisepoint mei
pinctrl_intel intel_pch_thermal loop
[   88.129983] CPU: 3 PID: 982 Comm: klogd Tainted: G        W  O
5.4.66-rt38 #2
[   88.129984] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[   88.129984] RIP: 0010:preempt_count_sub+0x5a/0x90
[   88.129985] Code: 4c f5 46 c3 e8 77 c4 41 00 85 c0 74 20 8b 15 6d
9c 6b 01 85 d2 75 16 48 c7 c6 cd 44 2f ba 48 c7 c7 40 2f 2e ba e8 16
09 fd ff <0f> 0b c3 f3 c3 84 d2 75 c7 e8 48 c4 41 00 85 c0 74 f1 8b 05
3e 9c
[   88.129987] RSP: 0000:ffffc39d00198fe8 EFLAGS: 00010086
[   88.129988] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   88.129988] RDX: ffffffffba653190 RSI: 0000000000000000 RDI: 00000000ffffffff
[   88.129989] RBP: 0000000000000000 R08: 00000000001a38e0 R09: 00000000001a38e0
[   88.129989] R10: ffffa01e2f1c9248 R11: ffffffffba653120 R12: 0000000000000000
[   88.129990] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   88.129990] FS:  00007fa80ad6b700(0000) GS:ffffa01e32b80000(0000)
knlGS:0000000000000000
[   88.129991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.129992] CR2: 00007ffe0a178fe8 CR3: 0000000466180005 CR4: 00000000003606e0
[   88.129993] Call Trace:
[   88.129993]  <IRQ>
[   88.129994]  irq_exit+0x16/0xa0
[   88.129996]  call_function_interrupt+0xf/0x20
[   88.129998]  </IRQ>
[   88.129998] RIP: 0033:0x7fa80a84b922
[   88.129999] Code: ba ff ff ff ff be 00 80 00 00 e8 59 51 00 00 48
8d 05 92 bb 34 00 48 89 df 48 89 e9 4c 89 e2 48 89 ee 48 89 84 24 d8
00 00 00 <c6> 45 00 00 e8 d5 65 00 00 48 89 df 4c 89 f2 4c 89 ee e8 97
67 fd
[   88.130000] RSP: 002b:00007ffd8819ce80 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff03
[   88.130001] RAX: 00007fa80ab974a0 RBX: 00007ffd8819ce80 RCX: 00007fa80ab9aa20
[   88.130001] RDX: 0000000000000071 RSI: 00007fa80ab9aa20 RDI: 00007ffd8819ce80
[   88.130002] RBP: 00007fa80ab9aa20 R08: 0000000000000000 R09: 0000000000000017
[   88.130002] R10: 000000000000000c R11: 0000000000000011 R12: 0000000000000071
[   88.130003] R13: 00007fa80a968980 R14: 00007ffd8819cfe8 R15: 0000000000405463
[   88.130005] ---[ end trace 0000000000000002 ]---
[   88.130045] vboxdrv: TSC mode is Invariant, tentative frequency 2591930824 Hz
[   88.130047] vboxdrv: Successfully loaded version 6.1.14 (interface
0x002e0000)
[   88.335060] VBoxNetFlt: Successfully started.
[   88.337278] VBoxNetAdp: Successfully started.
[   88.868696] ath10k_pci 0000:02:00.0: unsupported HTC service id: 1536
[   93.776103] wlan0: authenticate with 00:27:22:5f:50:71
[   93.826486] wlan0: send auth to 00:27:22:5f:50:71 (try 1/3)
[   93.834165] wlan0: authenticated
[   93.835028] wlan0: associate with 00:27:22:5f:50:71 (try 1/3)
[   93.845055] wlan0: RX AssocResp from 00:27:22:5f:50:71 (capab=0x431
status=0 aid=2)
[   93.848176] wlan0: associated
[ 2129.542309] EXT4-fs (dm-0): mounted filesystem with ordered data
mode. Opts: (null)
[ 2525.254854] check_preemption_disabled: 24 callbacks suppressed
[ 2525.254858] BUG: using smp_processor_id() in preemptible [00000000]
code: rmmod/7209
[ 2525.254861] caller is VBoxHost_RTThreadPreemptIsEnabled+0xe/0x40 [vboxdrv]
[ 2525.254885] CPU: 1 PID: 7209 Comm: rmmod Tainted: G        W  O
 5.4.66-rt38 #2
[ 2525.254888] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2525.254889] Call Trace:
[ 2525.254893]  dump_stack+0x66/0x8b
[ 2525.254899]  debug_smp_processor_id+0xbc/0xc0
[ 2525.254903]  VBoxHost_RTThreadPreemptIsEnabled+0xe/0x40 [vboxdrv]
[ 2525.254920]  rtSemSpinMutexEnter+0x1e/0x90 [vboxdrv]
[ 2525.254935]  VBoxHost_RTSemSpinMutexRequest+0x93/0x270 [vboxdrv]
[ 2525.254951]  ? VBoxHost_RTSemFastMutexDestroy+0x56/0x60 [vboxdrv]
[ 2525.254967]  VBoxHost_RTLogDestroy+0xca/0x170 [vboxdrv]
[ 2525.254983]  supdrvDeleteDevExt+0xfa/0x110 [vboxdrv]
[ 2525.254994]  VBoxDrvLinuxUnload+0x40/0xc61 [vboxdrv]
[ 2525.255008]  __x64_sys_delete_module+0x138/0x270
[ 2525.255013]  ? get_vtime_delta+0x13/0xd0
[ 2525.255019]  do_syscall_64+0x71/0x250
[ 2525.255024]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2525.255029] RIP: 0033:0x7fef993723f7
[ 2525.255032] Code: 73 01 c3 48 8b 0d a1 ba 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 ba 2b 00 f7 d8 64 89
01 48
[ 2525.255037] RSP: 002b:00007fffb2986998 EFLAGS: 00000202 ORIG_RAX:
00000000000000b0
[ 2525.255038] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef993723f7
[ 2525.255040] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000000000076d258
[ 2525.255042] RBP: 000000000076d1f0 R08: 00007fffb2985931 R09: 0000000000000000
[ 2525.255044] R10: 0000000000000883 R11: 0000000000000202 R12: 00007fffb2986bb0
[ 2525.255046] R13: 00007fffb2987336 R14: 0000000000000000 R15: 000000000076d1f0
[ 2525.255051] BUG: using smp_processor_id() in preemptible [00000000]
code: rmmod/7209
[ 2525.255053] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2525.255074] CPU: 1 PID: 7209 Comm: rmmod Tainted: G        W  O
 5.4.66-rt38 #2
[ 2525.255077] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2525.255078] Call Trace:
[ 2525.255080]  dump_stack+0x66/0x8b
[ 2525.255085]  debug_smp_processor_id+0xbc/0xc0
[ 2525.255089]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2525.255110]  rtSemSpinMutexEnter+0x5e/0x90 [vboxdrv]
[ 2525.255132]  VBoxHost_RTSemSpinMutexRequest+0x93/0x270 [vboxdrv]
[ 2525.255153]  ? VBoxHost_RTSemFastMutexDestroy+0x50/0x60 [vboxdrv]
[ 2525.255175]  VBoxHost_RTLogDestroy+0xca/0x170 [vboxdrv]
[ 2525.255196]  supdrvDeleteDevExt+0xfa/0x110 [vboxdrv]
[ 2525.255213]  VBoxDrvLinuxUnload+0x40/0xc61 [vboxdrv]
[ 2525.255228]  __x64_sys_delete_module+0x138/0x270
[ 2525.255233]  ? get_vtime_delta+0x13/0xd0
[ 2525.255238]  do_syscall_64+0x71/0x250
[ 2525.255242]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2525.255246] RIP: 0033:0x7fef993723f7
[ 2525.255249] Code: 73 01 c3 48 8b 0d a1 ba 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 ba 2b 00 f7 d8 64 89
01 48
[ 2525.255253] RSP: 002b:00007fffb2986998 EFLAGS: 00000202 ORIG_RAX:
00000000000000b0
[ 2525.255255] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef993723f7
[ 2525.255256] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000000000076d258
[ 2525.255258] RBP: 000000000076d1f0 R08: 00007fffb2985931 R09: 0000000000000000
[ 2525.255259] R10: 0000000000000883 R11: 0000000000000202 R12: 00007fffb2986bb0
[ 2525.255261] R13: 00007fffb2987336 R14: 0000000000000000 R15: 000000000076d1f0
[ 2525.255265] BUG: using smp_processor_id() in preemptible [00000000]
code: rmmod/7209
[ 2525.255267] caller is VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[ 2525.255281] CPU: 1 PID: 7209 Comm: rmmod Tainted: G        W  O
 5.4.66-rt38 #2
[ 2525.255283] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2525.255284] Call Trace:
[ 2525.255285]  dump_stack+0x66/0x8b
[ 2525.255288]  debug_smp_processor_id+0xbc/0xc0
[ 2525.255291]  VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[ 2525.255306]  VBoxHost_RTSemSpinMutexRelease+0xad/0x110 [vboxdrv]
[ 2525.255320]  ? VBoxHost_RTR0MemObjFree+0x260/0x2b0 [vboxdrv]
[ 2525.255333]  ? VBoxHost_RTR0MemObjFree+0x260/0x2b0 [vboxdrv]
[ 2525.255345]  VBoxHost_RTLogDestroy+0x128/0x170 [vboxdrv]
[ 2525.255359]  supdrvDeleteDevExt+0xfa/0x110 [vboxdrv]
[ 2525.255370]  VBoxDrvLinuxUnload+0x40/0xc61 [vboxdrv]
[ 2525.255381]  __x64_sys_delete_module+0x138/0x270
[ 2525.255384]  ? get_vtime_delta+0x13/0xd0
[ 2525.255387]  do_syscall_64+0x71/0x250
[ 2525.255390]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2525.255393] RIP: 0033:0x7fef993723f7
[ 2525.255395] Code: 73 01 c3 48 8b 0d a1 ba 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 ba 2b 00 f7 d8 64 89
01 48
[ 2525.255397] RSP: 002b:00007fffb2986998 EFLAGS: 00000202 ORIG_RAX:
00000000000000b0
[ 2525.255398] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef993723f7
[ 2525.255399] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000000000076d258
[ 2525.255400] RBP: 000000000076d1f0 R08: 00007fffb2985931 R09: 0000000000000000
[ 2525.255401] R10: 0000000000000883 R11: 0000000000000202 R12: 00007fffb2986bb0
[ 2525.255402] R13: 00007fffb2987336 R14: 0000000000000000 R15: 000000000076d1f0
[ 2576.433936] vboxdrv: Found 4 processor cores
[ 2576.449480] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.449485] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2576.449516] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.449519] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.449521] Call Trace:
[ 2576.449525]  dump_stack+0x66/0x8b
[ 2576.449531]  debug_smp_processor_id+0xbc/0xc0
[ 2576.449536]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2576.449562]  VBoxHost_RTMpOnSpecific+0x85/0xf0 [vboxdrv]
[ 2576.449585]  ? supdrvTscDeltaSync2_Before+0x280/0x280 [vboxdrv]
[ 2576.449606]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.449628]  supdrvGipInitMeasureTscFreq+0x190/0x380 [vboxdrv]
[ 2576.449650]  supdrvGipCreate+0x5e2/0xab0 [vboxdrv]
[ 2576.449669]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.449692]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.449711]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.449729]  ? 0xffffffffc0f18000
[ 2576.449731]  do_one_initcall+0x56/0x2a4
[ 2576.449736]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.449740]  ? do_init_module+0x22/0x22e
[ 2576.449745]  do_init_module+0x5b/0x22e
[ 2576.449748]  load_module+0x22a3/0x2a00
[ 2576.449754]  ? vfs_read+0x11c/0x130
[ 2576.449759]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.449762]  __do_sys_finit_module+0xce/0xe0
[ 2576.449767]  do_syscall_64+0x71/0x250
[ 2576.449771]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.449776] RIP: 0033:0x7f442e5acf99
[ 2576.449779] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.449783] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.449784] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.449786] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.449788] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.449789] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.449790] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.449794] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.449796] caller is VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[ 2576.449819] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.449821] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.449822] Call Trace:
[ 2576.449824]  dump_stack+0x66/0x8b
[ 2576.449828]  debug_smp_processor_id+0xbc/0xc0
[ 2576.449831]  VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[ 2576.449852]  ? supdrvTscDeltaSync2_Before+0x280/0x280 [vboxdrv]
[ 2576.449871]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.449893]  supdrvGipInitMeasureTscFreq+0x190/0x380 [vboxdrv]
[ 2576.449914]  supdrvGipCreate+0x5e2/0xab0 [vboxdrv]
[ 2576.449931]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.449952]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.449970]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.449988]  ? 0xffffffffc0f18000
[ 2576.449990]  do_one_initcall+0x56/0x2a4
[ 2576.449994]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.449997]  ? do_init_module+0x22/0x22e
[ 2576.450001]  do_init_module+0x5b/0x22e
[ 2576.450004]  load_module+0x22a3/0x2a00
[ 2576.450009]  ? vfs_read+0x11c/0x130
[ 2576.450013]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.450016]  __do_sys_finit_module+0xce/0xe0
[ 2576.450022]  do_syscall_64+0x71/0x250
[ 2576.450025]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.450028] RIP: 0033:0x7f442e5acf99
[ 2576.450030] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.450034] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.450035] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.450037] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.450038] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.450039] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.450040] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.450076] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.450078] caller is VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[ 2576.450101] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.450103] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.450104] Call Trace:
[ 2576.450106]  dump_stack+0x66/0x8b
[ 2576.450109]  debug_smp_processor_id+0xbc/0xc0
[ 2576.450112]  VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[ 2576.450135]  VBoxHost_RTMpOnSpecific+0xad/0xf0 [vboxdrv]
[ 2576.450156]  ? supdrvTscDeltaSync2_Before+0x280/0x280 [vboxdrv]
[ 2576.450174]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.450195]  supdrvGipInitMeasureTscFreq+0x190/0x380 [vboxdrv]
[ 2576.450215]  supdrvGipCreate+0x5e2/0xab0 [vboxdrv]
[ 2576.450232]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.450254]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.450273]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.450290]  ? 0xffffffffc0f18000
[ 2576.450292]  do_one_initcall+0x56/0x2a4
[ 2576.450296]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.450299]  ? do_init_module+0x22/0x22e
[ 2576.450303]  do_init_module+0x5b/0x22e
[ 2576.450306]  load_module+0x22a3/0x2a00
[ 2576.450311]  ? vfs_read+0x11c/0x130
[ 2576.450316]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.450318]  __do_sys_finit_module+0xce/0xe0
[ 2576.450324]  do_syscall_64+0x71/0x250
[ 2576.450327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.450330] RIP: 0033:0x7f442e5acf99
[ 2576.450332] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.450335] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.450337] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.450338] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.450339] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.450341] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.450342] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.450352] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.450354] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2576.450376] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.450378] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.450379] Call Trace:
[ 2576.450381]  dump_stack+0x66/0x8b
[ 2576.450385]  debug_smp_processor_id+0xbc/0xc0
[ 2576.450388]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2576.450409]  VBoxHost_RTMpOnSpecific+0x85/0xf0 [vboxdrv]
[ 2576.450431]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[ 2576.450452]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.450473]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[ 2576.450493]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[ 2576.450512]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.450533]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.450552]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.450570]  ? 0xffffffffc0f18000
[ 2576.450571]  do_one_initcall+0x56/0x2a4
[ 2576.450575]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.450578]  ? do_init_module+0x22/0x22e
[ 2576.450582]  do_init_module+0x5b/0x22e
[ 2576.450586]  load_module+0x22a3/0x2a00
[ 2576.450591]  ? vfs_read+0x11c/0x130
[ 2576.450595]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.450598]  __do_sys_finit_module+0xce/0xe0
[ 2576.450603]  do_syscall_64+0x71/0x250
[ 2576.450606]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.450610] RIP: 0033:0x7f442e5acf99
[ 2576.450612] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.450615] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.450617] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.450618] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.450619] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.450621] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.450622] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.450633] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.450635] caller is VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[ 2576.450656] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.450658] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.450659] Call Trace:
[ 2576.450661]  dump_stack+0x66/0x8b
[ 2576.450665]  debug_smp_processor_id+0xbc/0xc0
[ 2576.450668]  VBoxHost_RTMpOnSpecific+0x8a/0xf0 [vboxdrv]
[ 2576.450689]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[ 2576.450710]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.450730]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[ 2576.450751]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[ 2576.450770]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.450791]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.450810]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.450828]  ? 0xffffffffc0f18000
[ 2576.450830]  do_one_initcall+0x56/0x2a4
[ 2576.450833]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.450836]  ? do_init_module+0x22/0x22e
[ 2576.450840]  do_init_module+0x5b/0x22e
[ 2576.450843]  load_module+0x22a3/0x2a00
[ 2576.450848]  ? vfs_read+0x11c/0x130
[ 2576.450852]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.450855]  __do_sys_finit_module+0xce/0xe0
[ 2576.450861]  do_syscall_64+0x71/0x250
[ 2576.450864]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.450867] RIP: 0033:0x7f442e5acf99
[ 2576.450869] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.450872] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.450873] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.450875] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.450876] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.450877] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.450879] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.450882] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.450884] caller is rtmpLinuxWrapper+0x28/0x40 [vboxdrv]
[ 2576.450905] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.450907] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.450908] Call Trace:
[ 2576.450909]  dump_stack+0x66/0x8b
[ 2576.450913]  debug_smp_processor_id+0xbc/0xc0
[ 2576.450916]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[ 2576.450937]  rtmpLinuxWrapper+0x28/0x40 [vboxdrv]
[ 2576.450958]  VBoxHost_RTMpOnSpecific+0xde/0xf0 [vboxdrv]
[ 2576.450979]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[ 2576.450999]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.451020]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[ 2576.451040]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[ 2576.451059]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.451080]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.451099]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.451117]  ? 0xffffffffc0f18000
[ 2576.451118]  do_one_initcall+0x56/0x2a4
[ 2576.451122]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.451125]  ? do_init_module+0x22/0x22e
[ 2576.451129]  do_init_module+0x5b/0x22e
[ 2576.451132]  load_module+0x22a3/0x2a00
[ 2576.451137]  ? vfs_read+0x11c/0x130
[ 2576.451142]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.451144]  __do_sys_finit_module+0xce/0xe0
[ 2576.451150]  do_syscall_64+0x71/0x250
[ 2576.451153]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.451156] RIP: 0033:0x7f442e5acf99
[ 2576.451158] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.451161] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.451162] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.451163] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.451165] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.451166] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.451167] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.451186] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.451188] caller is VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[ 2576.451209] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.451212] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.451213] Call Trace:
[ 2576.451215]  dump_stack+0x66/0x8b
[ 2576.451218]  debug_smp_processor_id+0xbc/0xc0
[ 2576.451222]  VBoxHost_RTThreadPreemptRestore+0x12/0x30 [vboxdrv]
[ 2576.451242]  VBoxHost_RTMpOnSpecific+0xad/0xf0 [vboxdrv]
[ 2576.451263]  ? VBoxHost_RTTimerStart+0x190/0x190 [vboxdrv]
[ 2576.451284]  ? VBoxHost_RTTimeSystemNanoTS+0x25/0x50 [vboxdrv]
[ 2576.451305]  VBoxHost_RTTimerStart+0x12d/0x190 [vboxdrv]
[ 2576.451326]  supdrvGipCreate+0x686/0xab0 [vboxdrv]
[ 2576.451348]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.451371]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.451392]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.451412]  ? 0xffffffffc0f18000
[ 2576.451413]  do_one_initcall+0x56/0x2a4
[ 2576.451418]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.451421]  ? do_init_module+0x22/0x22e
[ 2576.451425]  do_init_module+0x5b/0x22e
[ 2576.451429]  load_module+0x22a3/0x2a00
[ 2576.451434]  ? vfs_read+0x11c/0x130
[ 2576.451439]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.451442]  __do_sys_finit_module+0xce/0xe0
[ 2576.451448]  do_syscall_64+0x71/0x250
[ 2576.451451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.451455] RIP: 0033:0x7f442e5acf99
[ 2576.451457] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.451461] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.451462] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.451464] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.451466] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.451468] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.451469] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.451592] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.451594] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2576.451616] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.451618] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.451619] Call Trace:
[ 2576.451621]  dump_stack+0x66/0x8b
[ 2576.451625]  debug_smp_processor_id+0xbc/0xc0
[ 2576.451629]  VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]
[ 2576.451649]  VBoxHost_RTMpOnAll+0x72/0x1b0 [vboxdrv]
[ 2576.451672]  ? supdrvGipMpEventOnlineOrInitOnCpu+0x300/0x300 [vboxdrv]
[ 2576.451690]  ? migrate_enable+0x10c/0x340
[ 2576.451694]  ? preempt_count_add+0x49/0xa0
[ 2576.451696]  ? migrate_enable+0x10c/0x340
[ 2576.451699]  ? __kmalloc+0x54/0x2d0
[ 2576.451702]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.451723]  ? preempt_count_add+0x49/0xa0
[ 2576.451726]  ? migrate_enable+0x10c/0x340
[ 2576.451728]  ? migrate_disable+0x38/0xc0
[ 2576.451731]  ? supdrvGipInitOnCpu+0x20/0x20 [vboxdrv]
[ 2576.451750]  ? rt_spin_unlock+0x28/0x40
[ 2576.451753]  ? VBoxHost_RTMpNotificationRegister+0xc3/0x190 [vboxdrv]
[ 2576.451773]  supdrvGipCreate+0x4fd/0xab0 [vboxdrv]
[ 2576.451792]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.451814]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.451833]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.451852]  ? 0xffffffffc0f18000
[ 2576.451854]  do_one_initcall+0x56/0x2a4
[ 2576.451858]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.451861]  ? do_init_module+0x22/0x22e
[ 2576.451866]  do_init_module+0x5b/0x22e
[ 2576.451869]  load_module+0x22a3/0x2a00
[ 2576.451874]  ? vfs_read+0x11c/0x130
[ 2576.451879]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.451882]  __do_sys_finit_module+0xce/0xe0
[ 2576.451887]  do_syscall_64+0x71/0x250
[ 2576.451891]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.451894] RIP: 0033:0x7f442e5acf99
[ 2576.451896] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.451900] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.451901] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.451903] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.451904] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.451906] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.451907] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.451918] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.451920] caller is VBoxHost_RTMpOnAll+0x86/0x1b0 [vboxdrv]
[ 2576.451943] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.451945] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.451946] Call Trace:
[ 2576.451948]  dump_stack+0x66/0x8b
[ 2576.451952]  debug_smp_processor_id+0xbc/0xc0
[ 2576.451955]  VBoxHost_RTMpOnAll+0x86/0x1b0 [vboxdrv]
[ 2576.451977]  ? supdrvGipMpEventOnlineOrInitOnCpu+0x300/0x300 [vboxdrv]
[ 2576.451998]  ? preempt_count_add+0x49/0xa0
[ 2576.452000]  ? migrate_enable+0x10c/0x340
[ 2576.452003]  ? migrate_disable+0x38/0xc0
[ 2576.452006]  ? supdrvGipInitOnCpu+0x20/0x20 [vboxdrv]
[ 2576.452023]  ? rt_spin_unlock+0x28/0x40
[ 2576.452026]  ? VBoxHost_RTMpNotificationRegister+0xc3/0x190 [vboxdrv]
[ 2576.452047]  supdrvGipCreate+0x4fd/0xab0 [vboxdrv]
[ 2576.452066]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.452087]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.452106]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.452125]  ? 0xffffffffc0f18000
[ 2576.452126]  do_one_initcall+0x56/0x2a4
[ 2576.452130]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.452134]  ? do_init_module+0x22/0x22e
[ 2576.452138]  do_init_module+0x5b/0x22e
[ 2576.452141]  load_module+0x22a3/0x2a00
[ 2576.452146]  ? vfs_read+0x11c/0x130
[ 2576.452151]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.452154]  __do_sys_finit_module+0xce/0xe0
[ 2576.452159]  do_syscall_64+0x71/0x250
[ 2576.452162]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.452166] RIP: 0033:0x7f442e5acf99
[ 2576.452168] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.452171] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.452173] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.452174] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.452176] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.452177] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.452178] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.452189] BUG: scheduling while atomic: klogd/982/0x00010001
[ 2576.452193] Modules linked in: vboxdrv(O+) dm_crypt ipv6 cmac bnep
vfat fat fuse uvcvideo videobuf2_vmalloc videobuf2_memops btusb
videobuf2_v4l2 videobuf2_common btrtl btbcm videodev btintel mc
rtsx_usb_ms bluetooth rtsx_usb_sdmmc memstick mmc_core ecdh_generic
ecc rtsx_usb snd_hda_codec_hdmi snd_hda_codec_realtek
snd_hda_codec_generic hid_multitouch hid_generic joydev intel_rapl_msr
i2c_dev dell_smm_hwmon snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
snd_soc_sst_dsp snd_soc_sst_ipc intel_xhci_usb_role_switch
snd_soc_acpi_intel_match roles snd_soc_acpi i2c_designware_platform
dell_wmi snd_soc_core i2c_designware_core sparse_keymap wmi_bmof
mxm_wmi mei_hdcp snd_compress snd_pcm_dmaengine ac97_bus snd_hda_intel
coretemp intel_rapl_common snd_intel_nhlt dell_laptop snd_hda_codec
ledtrig_audio dell_smbios x86_pkg_temp_thermal snd_hda_core
intel_powerclamp dell_wmi_descriptor dcdbas kvm_intel kvm snd_hwdep
ath10k_pci ath10k_core irqbypass snd_pcm_oss ath i915 crct10dif_pclmul
crc32_pclmul
[ 2576.452252]  snd_mixer_oss ghash_clmulni_intel mac80211 aesni_intel
snd_pcm cfg80211 evdev hwmon crypto_simd cec psmouse rc_core
snd_seq_dummy serio_raw snd_seq_oss rapl intel_cstate drm_kms_helper
i2c_hid tpm_crb tpm_tis hid thermal snd_seq_midi snd_seq_midi_event
snd_rawmidi drm snd_seq xhci_pci intel_gtt dell_rbtn battery fan
agpgart snd_seq_device rfkill i2c_algo_bit tpm_tis_core xhci_hcd
snd_timer i2c_core tpm snd wmi soundcore intel_lpss_pci video
intel_lpss acpi_pad ac mei_me idma64 button virt_dma
pinctrl_sunrisepoint mei pinctrl_intel intel_pch_thermal loop [last
unloaded: vboxdrv]
[ 2576.452294] Preemption disabled at:
[ 2576.452294] [<ffffffffb9c0295b>] smp_call_function_interrupt+0xb/0x180
[ 2576.452301] CPU: 3 PID: 982 Comm: klogd Tainted: G        W  O
5.4.66-rt38 #2
[ 2576.452304] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.452305] Call Trace:
[ 2576.452308]  <IRQ>
[ 2576.452310]  dump_stack+0x66/0x8b
[ 2576.452314]  ? smp_call_function_interrupt+0xb/0x180
[ 2576.452317]  __schedule_bug+0x73/0xc0
[ 2576.452322]  __schedule+0x650/0x820
[ 2576.452325]  ? _raw_spin_lock+0x13/0x40
[ 2576.452328]  schedule+0x43/0xd0
[ 2576.452331]  rt_spin_lock_slowlock_locked+0x10d/0x2e0
[ 2576.452334] BUG: using smp_processor_id() in preemptible [00000000]
code: modprobe/11395
[ 2576.452337] caller is supdrvGipMpEventOnlineOrInitOnCpu+0x5a/0x300 [vboxdrv]
[ 2576.452336]  rt_spin_lock_slowlock+0x50/0x80
[ 2576.452362]  VBoxHost_RTSpinlockAcquire+0x25/0x30 [vboxdrv]
[ 2576.452387]  supdrvGipMpEventOnlineOrInitOnCpu+0x6c/0x300 [vboxdrv]
[ 2576.452409]  rtmpLinuxAllWrapper+0x47/0x60 [vboxdrv]
[ 2576.452431]  flush_smp_call_function_queue+0x4b/0x100
[ 2576.452435]  smp_call_function_interrupt+0x4b/0x180
[ 2576.452438]  call_function_interrupt+0xf/0x20
[ 2576.452442]  </IRQ>
[ 2576.452443] RIP: 0033:0x7fa80a8cbe70
[ 2576.452446] Code: 73 01 c3 48 8b 0d 28 c0 2c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 0f 1f 44 00 00 83 3d 19 19 2d 00 00 75 10 b8 01 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 5e dd 01 00 48 89
04 24
[ 2576.452450] RSP: 002b:00007ffd8819d0e8 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff03
[ 2576.452451] RAX: 0000000000000062 RBX: 0000000000000061 RCX: 00007fa80a8cbe70
[ 2576.452453] RDX: 0000000000000062 RSI: 00007ffd8819d550 RDI: 0000000000000001
[ 2576.452454] RBP: 00007ffd8819d550 R08: 0000000000000000 R09: 0000000000000046
[ 2576.452455] R10: 0000000000000046 R11: 0000000000000246 R12: 00007fa80ad6b698
[ 2576.452456] R13: 0000000000000062 R14: 0000000000000000 R15: 0000000000405465
[ 2576.452460] CPU: 0 PID: 11395 Comm: modprobe Tainted: G        W  O
     5.4.66-rt38 #2
[ 2576.452464] Hardware name: Dell Inc. Inspiron 5557/0WT51R, BIOS
1.1.7 02/23/2016
[ 2576.452465] Call Trace:
[ 2576.452467]  dump_stack+0x66/0x8b
[ 2576.452471]  debug_smp_processor_id+0xbc/0xc0
[ 2576.452475]  supdrvGipMpEventOnlineOrInitOnCpu+0x5a/0x300 [vboxdrv]
[ 2576.452495]  VBoxHost_RTMpOnAll+0xf1/0x1b0 [vboxdrv]
[ 2576.452517]  ? supdrvGipMpEventOnlineOrInitOnCpu+0x300/0x300 [vboxdrv]
[ 2576.452537]  ? preempt_count_add+0x49/0xa0
[ 2576.452540]  ? migrate_enable+0x10c/0x340
[ 2576.452542]  ? migrate_disable+0x38/0xc0
[ 2576.452545]  ? supdrvGipInitOnCpu+0x20/0x20 [vboxdrv]
[ 2576.452562]  ? rt_spin_unlock+0x28/0x40
[ 2576.452565]  ? VBoxHost_RTMpNotificationRegister+0xc3/0x190 [vboxdrv]
[ 2576.452586]  supdrvGipCreate+0x4fd/0xab0 [vboxdrv]
[ 2576.452603]  ? rtR0MemAllocEx+0x177/0x250 [vboxdrv]
[ 2576.452625]  supdrvInitDevExt+0x181/0x350 [vboxdrv]
[ 2576.452644]  VBoxDrvLinuxInit+0x97/0x1000 [vboxdrv]
[ 2576.452662]  ? 0xffffffffc0f18000
[ 2576.452664]  do_one_initcall+0x56/0x2a4
[ 2576.452668]  ? kmem_cache_alloc_trace+0x34/0x280
[ 2576.452672]  ? do_init_module+0x22/0x22e
[ 2576.452676]  do_init_module+0x5b/0x22e
[ 2576.452680]  load_module+0x22a3/0x2a00
[ 2576.452685]  ? vfs_read+0x11c/0x130
[ 2576.452690]  ? __do_sys_finit_module+0xce/0xe0
[ 2576.452693]  __do_sys_finit_module+0xce/0xe0
[ 2576.452698]  do_syscall_64+0x71/0x250
[ 2576.452701]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2576.452705] RIP: 0033:0x7f442e5acf99
[ 2576.452707] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cf 1e 2c 00 f7 d8 64 89
01 48
[ 2576.452711] RSP: 002b:00007ffc5983c658 EFLAGS: 00000202 ORIG_RAX:
0000000000000139
[ 2576.452713] RAX: ffffffffffffffda RBX: 0000000000df61d0 RCX: 00007f442e5acf99
[ 2576.452715] RDX: 0000000000000000 RSI: 0000000000418e53 RDI: 0000000000000003
[ 2576.452716] RBP: 0000000000418e53 R08: 0000000000000000 R09: 0000000000000000
[ 2576.452717] R10: 0000000000000003 R11: 0000000000000202 R12: 0000000000000000
[ 2576.452719] R13: 0000000000df5ad0 R14: 0000000000040000 R15: 0000000000df61d0
[ 2576.452901] vboxdrv: TSC mode is Invariant, tentative frequency 2591930220 Hz
[ 2576.452903] vboxdrv: Successfully loaded version 6.1.14 (interface
0x002e0000)
[ 2576.667815] VBoxNetFlt: Successfully started.
[ 2576.672859] VBoxNetAdp: Successfully started.
