From: jordan <triplesquarednine@gmail.com>
Subject: nvidia bug or RT bug?
Date: Sun, 6 May 2012 21:17:21 -0400
Message-ID: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36488 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab2EGBRV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 May 2012 21:17:21 -0400
Received: by obbtb18 with SMTP id tb18so7543613obb.19
        for <linux-rt-users@vger.kernel.org>; Sun, 06 May 2012 18:17:21 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey everyone.

I've been using linux-rt-3.0 series, which has been very stable using
the nvidia proprietary drivers (pretty much flawlessly, actually). I
had used rt-3.0 with nvidia all the way upto nvidia version 290.35. I
never experienced any problems relating to nvidia, at all... But
external/other reasons, recently I have upgraded to rt-3.2 which also
seems to be working quite well. At the same time, i also upgraded my
nvidia driver to the latest available driver, which is 302.07 (beta).

I know many of the RT devs aren't huge fans of the nvidia blob, but i
would like to know whether this is an nvidia bug or rt bug;

[143335.564097] BUG: scheduling while atomic: irq/19-nvidia/1141/0x00000002
[143335.564099] Modules linked in: snd_usb_audio ipv6 snd_seq_midi
snd_seq_midi_event snd_seq_dummy snd_hrtimer snd_seq joydev wacom(O)
vmnet(O) fuse vsock(O) vmci(O) vmmon(O) bnep bluetooth rfkill
hwmon_vid snd_usb_us122l snd_usbmidi_lib snd_rawmidi snd_seq_device
snd_hda_codec_via snd_hda_codec snd_hwdep snd_pcm forcedeth evdev
snd_page_alloc edac_mce_amd firewire_ohci edac_core firewire_core wmi
k10temp crc_itu_t video asus_atk0110 psmouse serio_raw snd_timer snd
soundcore button i2c_nforce2 processor nvidia(P) i2c_core ext4 crc16
jbd2 mbcache usbhid hid sd_mod pata_amd pata_acpi ahci uhci_hcd
libahci ata_generic ohci_hcd libata ehci_hcd scsi_mod usbcore
usb_common [last unloaded: snd_hda_codec_hdmi]
[143335.564127] Pid: 1141, comm: irq/19-nvidia Tainted: P           O
3.2.16-rt27-1-rt #1
[143335.564128] Call Trace:
[143335.564134]  [<ffffffff81415afa>] __schedule_bug+0x5f/0x63
[143335.564137]  [<ffffffff8141bb92>] __schedule+0x842/0x8b0
[143335.564140]  [<ffffffff8141dde0>] ? _raw_spin_unlock_irqrestore+0x10/0x40
[143335.564141]  [<ffffffff8141de07>] ? _raw_spin_unlock_irqrestore+0x37/0x40
[143335.564144]  [<ffffffff8109a755>] ? task_blocks_on_rt_mutex+0x1a5/0x210
[143335.564146]  [<ffffffff8141c0ae>] schedule+0x2e/0xa0
[143335.564147]  [<ffffffff8141d71c>] rt_spin_lock_slowlock+0x114/0x1f8
[143335.564149]  [<ffffffff8141d996>] rt_spin_lock+0x26/0x30
[143335.564151]  [<ffffffff8105a4a6>] __wake_up+0x36/0x70
[143335.564259]  [<ffffffffa0837783>] nv_post_event+0xe3/0x120 [nvidia]
[143335.564297]  [<ffffffffa080c8ce>] _nv014670rm+0xe8/0x141 [nvidia]
[143335.564367]  [<ffffffffa04d3928>] ? _nv006157rm+0xc0/0xe9 [nvidia]
[143335.564436]  [<ffffffffa04d3be2>] ? _nv013751rm+0xdf/0xf8 [nvidia]
[143335.564504]  [<ffffffffa04d3b62>] ? _nv013751rm+0x5f/0xf8 [nvidia]
[143335.564581]  [<ffffffffa0642bdf>] ? _nv010689rm+0xece/0x10ec [nvidia]
[143335.564657]  [<ffffffffa0642bf8>] ? _nv010689rm+0xee7/0x10ec [nvidia]
[143335.564714]  [<ffffffffa06b378b>] ? _nv013099rm+0x8b8/0xc74 [nvidia]
[143335.564770]  [<ffffffffa06bc932>] ? _nv013078rm+0xf2/0x137 [nvidia]
[143335.564805]  [<ffffffffa08106b3>] ? _nv001098rm+0x143/0x1c2 [nvidia]
[143335.564840]  [<ffffffffa08172d7>] ? rm_isr_bh+0x23/0x66 [nvidia]
[143335.564874]  [<ffffffffa0835532>] ? nv_kern_isr_bh+0x42/0x70 [nvidia]
[143335.564876]  [<ffffffff81068f11>] ? __tasklet_action.isra.9+0x71/0x150
[143335.564878]  [<ffffffff8106909e>] ? tasklet_action+0x5e/0x60
[143335.564880]  [<ffffffff8106826b>] ? __do_softirq_common+0xcb/0x240
[143335.564882]  [<ffffffff81069360>] ? __do_softirq+0x10/0x20
[143335.564883]  [<ffffffff810694ad>] ? local_bh_enable+0x13d/0x160
[143335.564885]  [<ffffffff810c657b>] ? irq_forced_thread_fn+0x4b/0x70
[143335.564887]  [<ffffffff810c6438>] ? irq_thread+0x158/0x200
[143335.564888]  [<ffffffff810c6530>] ? irq_thread_fn+0x50/0x50
[143335.564889]  [<ffffffff810c62e0>] ? irq_finalize_oneshot+0x110/0x110
[143335.564891]  [<ffffffff8108414c>] ? kthread+0x8c/0xa0
[143335.564893]  [<ffffffff81050449>] ? finish_task_switch+0x49/0xf0
[143335.564896]  [<ffffffff81420b34>] ? kernel_thread_helper+0x4/0x10
[143335.564898]  [<ffffffff810840c0>] ? __init_kthread_worker+0x60/0x60
[143335.564899]  [<ffffffff81420b30>] ? gs_change+0x13/0x13
[ninez@ninez ~]$

if this is an nvidia problem (which i assume it is), i would like to
report it to them (and obviously, if it is an rt related bug - i would
like to report it here.

I am using an rt-patch for the nvidia driver. I simply adapted an
existing package for my distro (Archlinux). the patch is available
here, in case it matters;

https://aur.archlinux.org/packages.php?ID=12132

the patch can be viewed by downloading the 'tarball'. I only mention
the patch in case it matters.

any other info you may need, just ask and i will do my best to provide it.

thank you.

jordan
