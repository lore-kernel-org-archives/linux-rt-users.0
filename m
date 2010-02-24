From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33-rc8-rt1
Date: Wed, 24 Feb 2010 10:10:22 +0530
Message-ID: <921ca19c1002232040x5de81254s59aec967dc7037ba@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0910061210400.2646@localhost.localdomain>
	 <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain>
	 <alpine.LFD.2.00.0911061743210.12138@localhost.localdomain>
	 <alpine.LFD.2.00.0911101326280.2725@localhost.localdomain>
	 <alpine.LFD.2.00.1001212102220.2906@localhost.localdomain>
	 <alpine.LFD.2.00.1002181748460.2811@localhost.localdomain>
	 <alpine.LFD.2.00.1002212322450.2811@localhost.localdomain>
	 <520f0cf11002220311l2a0caa83lf3ae2817b78501b6@mail.gmail.com>
	 <49b7c2351002231708r279049f9hcc9cc6ff205a47fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Mark Knecht <markknecht@gmail.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49b7c2351002231708r279049f9hcc9cc6ff205a47fb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This Happens when there is an external device(storage) plugged in.

On Wed, Feb 24, 2010 at 6:38 AM, GeunSik Lim <leemgs1@gmail.com> wrote:
> Dear Thomas,
>
> This is a report =A0about booting test with linux-2.6.33.rc8-rt1 by T=
homas.
> I also can't boot linux-2.6.33.rc8-rt1 version on my desktop pc like
> John Kacur. But, This Error message is different in my case.
> So, I returned linux version from this version to linux-2.6.31-rt14 v=
ersion now.
> - version info : Linux-2.6.33.rc8-rt1
> - H/W Spec : intel Core2Quad Q9400 , SATA HDD320G
>
> I uploaded screenshot about booting error on my Q9400 based desktop p=
c.
> http://picasaweb.google.com/leemgs/LinuxRelatedScreenshot#54414365363=
31947314
>
> And, I attached my config file to compile linux-2.6.33.rc8-rt1.
>
> Regards,
> Geunsik Lim.
>
>
>
> On Mon, Feb 22, 2010 at 8:11 PM, John Kacur <jkacur@redhat.com> wrote=
:
>>
>> On Mon, Feb 22, 2010 at 12:24 AM, Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> > We are pleased to announce the next update to our new preempt-rt
>> > series.
>> >
>> > =A0 =A0- Forward to 2.6.33-rc8
>> >
>> > Finally I managed to get that beast tamed.
>> >
>> > Some folks were already joking, that my dog ate the 33-rt patch. T=
he
>> > truth is that my reject fixup skills were one line off in the mm/*
>> > code which resulted in -rt eating my files :)
>> >
>> > When I fixed the wreckage of my own stupidty I found out that -rt
>> > triggered a nasty and hard to reproduce mainline scheduler bug, wh=
ich
>> > refused to reproduce with kernel tracing enabled. Thanks to Peter
>> > Zijlstra for helping me to decode the initial mainline problem and=
 the
>> > ones which resulted from fixing the mainline bug!
>> >
>> > It's all fixed now and I'm pretty happy about the state of this
>> > release with the following exceptions:
>> >
>> > =A01) it is only runtime tested on x86_64 (compiles on x86_32, arm=
,
>> > =A0 =A0powerpc_32/64).
>> >
>> > =A0 =A0I'm going to throw it at my testing infrastructure tomorrow=
, but I
>> > =A0 =A0wanted to release this before .33-final and of course you f=
olks
>> > =A0 =A0are heartely invited to help out with fixing the fallout :)
>> >
>> > =A02) I broke the histogram tracer stuff simply because I got lost=
 in
>> > =A0 =A0the divergence of -rt and mainline kernel/trace/* changes
>> >
>> > =A0 =A0I apologize to Carsten, but I'm sure he will fix that in no=
 time
>> > =A0 =A0as usual
>> >
>> > The current state of the patch on x86_64 is: rock stable!
>> >
>> > =A0 =A0[rt-tests]# chrt -f 1 ./cyclictest -t -a -n -d0 -p80 -i125
>> > =A0 =A0policy: fifo: loadavg: 509.19 490.53 486.66 364/1055 31899
>> >
>> > =A0 =A0T: 0 (27682) P:80 I:125 C:1170997397 Min: 2 Act: 3 Avg: 3 M=
ax: 34
>> > =A0 =A0T: 1 (27683) P:79 I:125 C:1170997397 Min: 2 Act: 3 Avg: 3 M=
ax: 34
>> >
>> > =A0 =A0That's an uptime of ~1.6 days with a load of hackbench, rec=
ursive
>> > =A0 =A0grep and extensive networking traffic going on.
>> >
>> > The merge of the spinlock namespace cleanup and the initial
>> > annotations took a big chunk away from the -rt patch size:
>> >
>> > =A0 =A0 =A0 =A0patch-2.6.31.12-rt21.patch =A0 =A0 1680354
>> > =A0 =A0 =A0 =A0patch-2.6.33-rc8.patch =A0 =A0 =A0 =A0 1179390
>> > =A0 =A0 =A0 =A0patch-2.6.33-rc8+git.patch =A0 =A0 1067064
>> >
>> > We are zooming in, but there is still a way to go!
>> >
>>
>> Woohoo! More -rt fun.
>>
>> Unfortunately, I can't log in on my T500 with this kernel though.
>> The following shows-up on my serial console.
>> ------------[ cut here ]------------
>> WARNING: at /home/jkacur/rt.linux.git/net/mac80211/rx.c:2467 ieee802=
11_rx+0x4c/0
>> x721 [mac80211]()
>> Hardware name: 2241B48
>> Modules linked in: bridge stp bnep sco btusb l2cap crc16 bluetooth s=
unrpc ipt_RE
>> JECT nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_=
REJECT xt_tc
>> pudp nf_conntrack_ipv6 xt_state ip6table_filter ip6_tables x_tables =
ipv6 cpufreq
>> _ondemand acpi_cpufreq ext3 jbd mbcache dm_mirror dm_region_hash dm_=
log dm_multi
>> path scsi_dh dm_mod kvm_intel kvm uinput arc4 ecb snd_hda_codec_cone=
xant iwlagn
>> snd_hda_intel iwlcore snd_hda_codec snd_hwdep snd_seq_dummy mac80211=
 snd_seq_oss
>> =A0snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_o=
ss thinkpad_ac
>> pi snd_pcm firewire_ohci firewire_core hwmon video ppdev tpm_tis cfg=
80211 sr_mod
>> =A0battery wmi ricoh_mmc parport_pc sg tpm cdrom tpm_bios button ac =
ata_generic e1
>> 000e iTCO_wdt snd_timer sdhci_pci pata_acpi sdhci i2c_i801 i2c_core =
parport mmc_
>> core iTCO_vendor_support snd joydev snd_page_alloc pcspkr intel_agp =
soundcore cr
>> c_itu_t rfkill output ahci libata sd_mod scsi_mod crc_t10dif xfs exp=
ortfs uhci_h
>> cd ohci_hcd ehci_hcd [last unloaded: microcode]
>> Pid: 10, comm: sirq-tasklet/0 Not tainted 2.6.33-rc8-rt1-debug #1
>> Call Trace:
>> =A0[<ffffffffa033524f>] ? ieee80211_rx+0x4c/0x721 [mac80211]
>> =A0[<ffffffff81041f25>] warn_slowpath_common+0x77/0xa4
>> =A0[<ffffffff81041f61>] warn_slowpath_null+0xf/0x11
>> =A0[<ffffffffa033524f>] ieee80211_rx+0x4c/0x721 [mac80211]
>> =A0[<ffffffffa039f380>] ? iwl_led_pattern+0x17a/0x189 [iwlcore]
>> =A0[<ffffffff810c0fd1>] ? free_compound_page+0x16/0x18
>> =A0[<ffffffffa039f3f5>] ? iwl_leds_background+0x66/0x219 [iwlcore]
>> =A0[<ffffffffa0393524>] iwl_rx_reply_rx+0xc29/0xc5a [iwlcore]
>> =A0[<ffffffff8106ee74>] ? trace_hardirqs_on+0xd/0xf
>> =A0[<ffffffff8135cf7e>] ? _raw_spin_unlock_irqrestore+0x4c/0x68
>> =A0[<ffffffff811b4e32>] ? unmap_single+0x27/0x4f
>> =A0[<ffffffffa03cec81>] iwl_rx_handle+0x2a0/0x48d [iwlagn]
>> =A0[<ffffffff8135cf7e>] ? _raw_spin_unlock_irqrestore+0x4c/0x68
>> =A0[<ffffffffa03cfbb3>] iwl_irq_tasklet+0x5a3/0x73f [iwlagn]
>> =A0[<ffffffff81047b5a>] __tasklet_action+0x8f/0xfd
>> =A0[<ffffffff81047cc9>] tasklet_action+0x7c/0x85
>> =A0[<ffffffff81048209>] run_ksoftirqd+0x18e/0x2d5
>> =A0[<ffffffff8104807b>] ? run_ksoftirqd+0x0/0x2d5
>> =A0[<ffffffff8105d794>] kthread+0x8c/0x94
>> =A0[<ffffffff8135cfca>] ? _raw_spin_unlock+0x30/0x4b
>> =A0[<ffffffff81003a54>] kernel_thread_helper+0x4/0x10
>> =A0[<ffffffff8135d340>] ? restore_args+0x0/0x30
>> =A0[<ffffffff8105d708>] ? kthread+0x0/0x94
>> =A0[<ffffffff81003a50>] ? kernel_thread_helper+0x0/0x10
>> ---[ end trace 01358557eee38037 ]---
>>
>> Thanks
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards,
> GeunSik Lim ( Samsung Electronics )
> Blog : http://blog.naver.com/invain/
> e-Mail: geunsik.lim@samsung.com
> =A0 =A0 =A0 =A0 =A0 leemgs@gmail.com , leemgs1@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
