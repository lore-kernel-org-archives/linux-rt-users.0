From: Clark Williams <williams@redhat.com>
Subject: Re: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Wed, 30 Mar 2016 08:52:18 -0500
Message-ID: <20160330085218.32f13bd2@sluggy.hsv.redhat.com>
References: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
	<alpine.DEB.2.11.1603140948560.3657@nanos>
	<20160330102251.GB21849@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/+P7MMLeh0G_e6yEldCjIdwt"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330102251.GB21849@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/+P7MMLeh0G_e6yEldCjIdwt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Mar 2016 12:22:51 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Thomas Gleixner | 2016-03-14 09:49:52 [+0100]:
>=20
> >On Sun, 13 Mar 2016, Clark Williams wrote:
> > =20
> >> I'm hitting the WARN_ON(wakes > 2) in $SUBJECT when resuming from susp=
end on my laptop (quad-core i7 with HT on). Looks like the warning gets hit=
 36 times on resume. E.g.:
> >> This trace (and a similar one with device_resume) happens on all cpus =
so the
> >> trace info is kinda jumbled up. I'll try it with WARN_ON_ONCE instead
> >> tomorrow. =20
> >
> >If resume is the only case, then we can filter that out and not worry ab=
out it
> >at all :) =20
>=20
> I see here 3 to 7 loops on each warning in the resume case and I see
> approx 7 warnings. It wakes always a kworker/u*/* task.
> system_state is always set to SYSTEM_RUNNING so I am not sure what can
> be used for filtering.
> Any suggestions?
>=20
> >Thanks,
> >
> >	tglx =20
>=20
> Sebastian

I added this debugging patch (mainly to get a better idea of who was waking=
 and how much they were waking):

diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 8459561f0379..dff527305369 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -42,7 +42,11 @@ void swake_up_all_locked(struct swait_queue_head *q)
                list_del_init(&curr->task_list);
                wakes++;
        }
-       WARN_ON(wakes > 2);
+       if (wakes > 2) {
+               printk("swake_up_all_locked: %d wakes done on cpu %d: %s (p=
id: %d)\n",
+                      wakes, raw_smp_processor_id(), current->comm, curren=
t->pid);
+               WARN_ON_ONCE(wakes > 2);
+       }
 }
 EXPORT_SYMBOL(swake_up_all_locked);


I'm seeing output like this with between 3 and 9 wakeups per kworker:

swake_up_all_locked: 3 wakes done on cpu 6: kworker/u16:37 (pid: 15725)
------------[ cut here ]------------
WARNING: CPU: 6 PID: 15725 at /home/williams/src/linux-rt/kernel/rt-linux.g=
it/kernel/sched/swait.c:48 swake_up_all_locked+0xa5/0xb0()
swake_up_all_locked: more than two wakeups on queue
Modules linked in: tun hid_logitech_hidpp hid_logitech_dj ccm rfcomm bnep b=
tusb btrtl btbcm btintel bluetooth fuse rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs fscache nf_con
 videobuf2_v4l2 videobuf2_core videobuf2_memops kvm snd_seq_device thinkpad=
_acpi snd_pcm v4l2_common iTCO_wdt videodev snd_timer cfg80211 iTCO_vendor_=
support snd mei_me
CPU: 6 PID: 15725 Comm: kworker/u16:37 Not tainted 4.4.6-rt12+ #20
Hardware name: LENOVO 24293E8/24293E8, BIOS G4ET94WW (2.54 ) 05/23/2013
Workqueue: events_unbound async_run_entry_fn
 0000000000000086 000000006760687a ffff8802be2cbc90 ffffffff813c1720
 ffff8802be2cbcd8 0000000000000009 ffff8802be2cbcc8 ffffffff810a7572
 ffff880400b531c0 0000000000000003 ffff880400b531a8 ffff880400b531c0
Call Trace:
 [<ffffffff813c1720>] dump_stack+0x65/0x85
 [<ffffffff810a7572>] warn_slowpath_common+0x82/0xd0
 [<ffffffff810a761c>] warn_slowpath_fmt+0x5c/0x80
 [<ffffffff810ec765>] swake_up_all_locked+0xa5/0xb0
 [<ffffffff810ecd70>] complete_all+0x30/0x50
 [<ffffffff815066e8>] device_resume_noirq+0x48/0x190
 [<ffffffff8150684d>] async_resume_noirq+0x1d/0x50
 [<ffffffff810ca188>] async_run_entry_fn+0x48/0x130
 [<ffffffff810c14a9>] process_one_work+0x139/0x480
 [<ffffffff810c1847>] worker_thread+0x57/0x490
 [<ffffffff810c17f0>] ? process_one_work+0x480/0x480
 [<ffffffff810c779d>] kthread+0xed/0x110
 [<ffffffff810c76b0>] ? kthread_worker_fn+0x150/0x150
 [<ffffffff817b118f>] ret_from_fork+0x3f/0x70
 [<ffffffff810c76b0>] ? kthread_worker_fn+0x150/0x150
---[ end trace 0000000000000002 ]---
swake_up_all_locked: 3 wakes done on cpu 7: kworker/u16:73 (pid: 15772)
swake_up_all_locked: 6 wakes done on cpu 3: kworker/u16:13 (pid: 15671)
swake_up_all_locked: 4 wakes done on cpu 6: kworker/u16:38 (pid: 15727)
swake_up_all_locked: 9 wakes done on cpu 7: kworker/u16:74 (pid: 15773)
ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
swake_up_all_locked: 3 wakes done on cpu 0: kworker/u16:30 (pid: 15712)
swake_up_all_locked: 3 wakes done on cpu 2: kworker/u16:0 (pid: 13668)
swake_up_all_locked: 4 wakes done on cpu 6: kworker/u16:31 (pid: 15715)
swake_up_all_locked: 5 wakes done on cpu 4: kworker/u16:63 (pid: 15762)
swake_up_all_locked: 4 wakes done on cpu 5: kworker/u16:112 (pid: 15811)
swake_up_all_locked: 5 wakes done on cpu 0: kworker/u16:45 (pid: 15734)
sdhci-pci 0000:02:00.0: MMC controller base frequency changed to 50Mhz.
swake_up_all_locked: 7 wakes done on cpu 4: kworker/u16:64 (pid: 15763)
swake_up_all_locked: 5 wakes done on cpu 0: kworker/u16:53 (pid: 15747)
swake_up_all_locked: 3 wakes done on cpu 4: kworker/u16:88 (pid: 15787)
swake_up_all_locked: 5 wakes done on cpu 4: kworker/u16:99 (pid: 15798)
swake_up_all_locked: 4 wakes done on cpu 4: kworker/u16:100 (pid: 15799)
PM: noirq resume of devices complete after 12.801 msecs
PM: early resume of devices complete after 1.340 msecs
e1000e 0000:00:19.0: System wakeup disabled by ACPI
swake_up_all_locked: 5 wakes done on cpu 3: kworker/u16:101 (pid: 15800)
swake_up_all_locked: 5 wakes done on cpu 1: kworker/u16:90 (pid: 15789)
sd 0:0:0:0: [sda] Starting disk
rtc_cmos 00:02: System wakeup disabled by ACPI
tpm_tis 00:05: TPM is disabled/deactivated (0x6)
swake_up_all_locked: 3 wakes done on cpu 7: kworker/u16:92 (pid: 15791)
swake_up_all_locked: 3 wakes done on cpu 1: kworker/u16:119 (pid: 15821)
swake_up_all_locked: 4 wakes done on cpu 6: kworker/u16:68 (pid: 15767)
swake_up_all_locked: 4 wakes done on cpu 0: kworker/u16:91 (pid: 15790)
swake_up_all_locked: 3 wakes done on cpu 2: kworker/u16:52 (pid: 15746)
swake_up_all_locked: 5 wakes done on cpu 1: kworker/u16:35 (pid: 15722)
swake_up_all_locked: 9 wakes done on cpu 0: kworker/u16:64 (pid: 15763)
swake_up_all_locked: 7 wakes done on cpu 1: kworker/u16:118 (pid: 15819)
swake_up_all_locked: 4 wakes done on cpu 6: kworker/u16:6 (pid: 30341)
usb 1-1.6: reset high-speed USB device number 3 using ehci-pci
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata5: SATA link down (SStatus 0 SControl 300)
ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
ata1.00: configured for UDMA/133
ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
ata2.00: configured for UDMA/133
usb 2-1.5: reset low-speed USB device number 3 using ehci-pci
firewire_core 0000:02:00.3: rediscovered device fw0
swake_up_all_locked: 3 wakes done on cpu 6: kworker/u16:69 (pid: 15768)
usb 1-1.4: reset full-speed USB device number 4 using ehci-pci
swake_up_all_locked: 5 wakes done on cpu 3: kworker/u16:34 (pid: 15721)
swake_up_all_locked: 4 wakes done on cpu 1: kworker/u16:45 (pid: 15734)
PM: resume of devices complete after 953.926 msecs
PM: Finishing wakeup.
Restarting tasks ...=20


--Sig_/+P7MMLeh0G_e6yEldCjIdwt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJW+9oSAAoJEOI5asVwYXLruvQP/iwx1gjyd76lbdN/GGL8IFNk
FkWbGSALgg2m8z8V7uwiMvB41T11WQpBLRrJeVG/pAjHJjdEJ4vJI4KHjhgJtPfE
gqHaZk/4gvzbDYg100LDex38iJgIS1xL0aQgcqnsDe8L0GwG61n36SDQX3I7ExfO
W2F9rF7irammF38Ri5CGYOdD6IekFFLQ9lcq3b9cgyaAWk7q5R8QKSLs9tGc6p6S
g1eEYwoT0engnnyUHwd9jIl6CAWP8/Tvnv9tSLUaEFTPF9bGRzljQDIvT5C+wuIz
esYmCktrKwbIaoQEK5E+5XJE+UtxQmAtxoCHLx1GrLAO7OtejgNubS0UjUvOq00v
fPq9ff2Jzncl7qIKhyntUOoAXJMIE7dx8OAflcJq0Jlg83Td5NNg7Yv9TJEd0JZs
kRtpASX/6b2mjWU6xe4vQSSeoYH04RFro7QoX1wOTzDirs3aF4b6uXRoXyv6oxlV
0AbE7e5YDT7eFdgMFa/EPESLDkUW+Z/R3jRWJpDL2Gp9vLglS2XYskpBFfDnwFmB
kX6iMu3BXZStDojqCd8e257SurYJdk6VvwUvJAWJ+YvKhgqc+kw6kvjEWkgrMZG3
xWaty3rAlnYEoEcfo+YyKXoKWFoSWE/LCgWe4rHNnWRQw+dg8rU56FjmkuVkHpkS
3XSLLe3zLGgetc7Uxwu4
=AgHy
-----END PGP SIGNATURE-----

--Sig_/+P7MMLeh0G_e6yEldCjIdwt--
