From: Tim Blechmann <tim@klingt.org>
Subject: rt-related bug?
Date: Sun, 6 Jan 2008 13:40:48 +0000 (UTC)
Message-ID: <flqlp0$p1l$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40636 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbYAFNuG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 Jan 2008 08:50:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JBVt4-0006f7-5H
	for linux-rt-users@vger.kernel.org; Sun, 06 Jan 2008 13:50:02 +0000
Received: from 85.127.250.217 ([85.127.250.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 06 Jan 2008 13:50:02 +0000
Received: from tim by 85.127.250.217 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Sun, 06 Jan 2008 13:50:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

not sure, whether this is an rt-related problem but on 2.6.23.12-rt14, i had
the following message ... not sure, whether this is any help ...
i have been running this kernel for quite some time without any problem, so i guess
it is not easy to reproduce:

kernel BUG at mm/slab.c:649!
invalid opcode: 0000 [#1]
PREEMPT SMP 
Modules linked in: nfs lockd nfs_acl sunrpc snd_hdsp binfmt_misc ppdev parport_pc lp parport ipv6 cpufreq_powersave cpufreq_stats cpufreq_userspace cpufreq_conservative cpufreq_ondemand ext2 fuse dm_snapshot dm_mirror dm_mod acpi_cpufreq freq_table snd_hwdep joydev irtty_sir sir_dev snd_hda_intel pcmcia snd_pcm_oss snd_pcm arc4 snd_mixer_oss ecb blkcipher snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq tsdev snd_timer yenta_socket rsrc_nonstatic iwl3945 snd_seq_device pcmcia_core battery ac psmouse firmware_class usbhid irda snd video i2c_i801 crc_ccitt serio_raw hid output mac80211 button iTCO_wdt i2c_core soundcore cfg80211 snd_page_alloc rtc intel_agp thinkpad_acpi pcspkr nvram evdev ext3 jbd mbcache sg sr_mod cdrom piix generic ide_core sd_mod ata_piix ehc
 i_hcd uhci_hcd usbcore ata_generic ahci libata scsi_mod e1000 thermal processor fan
CPU:    0
EIP:    0060:[<c0174d1c>]    Not tainted VLI
EFLAGS: 00010246   (2.6.23.12-rt14-686 #1)
EIP is at kmem_cache_free+0x92/0x9b
eax: 40000000   ebx: dfffc540   ecx: 00000000   edx: c130b040
esi: d8582c48   edi: d8582bfc   ebp: 00000246   esp: df90df80
ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068  preempt:00000001
Process softirq-rcu/0 (pid: 13, ti=df90d000 task=df926650 task.ti=df90d000)
Stack: 00000000 d8582ce8 d8582c48 c03b1260 c0157119 c03b4200 fffffeff 00000000 
       00000100 c012b93e 00000000 00000001 df90dfc4 c03b4200 c03b1018 c2022fec 
       c2022fe0 00000032 c2022fe0 c012b816 00000000 00000000 c01387c3 c013877b 
Call Trace:
 [<c0157119>] rcu_process_callbacks_rt+0x47/0x6e
 [<c012b93e>] ksoftirqd+0x128/0x251
 [<c012b816>] ksoftirqd+0x0/0x251
 [<c01387c3>] kthread+0x48/0x58
 [<c013877b>] kthread+0x0/0x58
 [<c0104e07>] kernel_thread_helper+0x7/0x10
 =======================
Code: fa 89 f0 e8 0c fe ff ff 8b 04 24 03 1c 85 80 94 37 c0 89 d8 e8 06 bc 15 00 83 c4 04 5b 5e 5f c3 8b 52 0c 8b 0a eb 9e 0f 0b eb fe <0f> 0b eb fe 8b 52 0c eb 9f 56 53 89 c6 8b 58 08 8b 50 0c 89 d8 
EIP: [<c0174d1c>] kmem_cache_free+0x92/0x9b SS:ESP 0068:df90df80


cheers, tim

-- 
tim@klingt.org
http://tim.klingt.org

There's no such entity as "most people". These are generalities. All
generalities are meaningless. You've got to pin it down to a specific
person doing a specific thing at a specific time and space.
  William S. Burroughs
