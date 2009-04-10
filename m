From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: futex warning tracback on 2.6.29.1-rt6
Date: Fri, 10 Apr 2009 08:50:26 -0700
Message-ID: <49DF6AC2.4000801@us.ibm.com>
References: <20090409215520.7daf9835@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:43377 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbZDJPua (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Apr 2009 11:50:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3AFl5Uj024486
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Apr 2009 11:47:05 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n3AFoTGW158306
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Apr 2009 11:50:29 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n3AFoSp4002767
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Apr 2009 11:50:29 -0400
In-Reply-To: <20090409215520.7daf9835@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Thomas,
>=20
> Got the below warning/traceback on 2.6.29.1-rt6.  This is running on =
my
> T60, 64-bit kernel.  Haven't been able to figure out how to trigger i=
t
> yet.=20
>=20
> $ uname -a
> Linux torg 2.6.29.1-rt6 #20 SMP PREEMPT RT Thu Apr 9 15:30:06 CDT 200=
9
> x86_64 x86_64 x86_64 GNU/Linux
>=20
> Clark
>=20
> - ------------[ cut here ]------------
> WARNING: at kernel/futex.c:184 drop_futex_key_refs+0x7e/0x111()

static void drop_futex_key_refs(union futex_key *key)
{
        if (!key->both.ptr) {
                /* If we're here then we tried to put a key we failed t=
o get */
                WARN_ON_ONCE(1);
                return;
        }

OK, looks like we have some key management issues to sort out.  Clark, =
I presume you weren't running
the glibc patch to enable requeue_pi?  From the trace below this appear=
s to have happened during a
normal futex_wait() call.  Looking at futex_wait_setup() I see a rather=
 obvious bug:

        ret =3D get_futex_key(uaddr, fshared, &q->key);
        if (unlikely(ret !=3D 0))
                goto out;

=2E..

out:
        if (ret)
                put_futex_key(fshared, &q->key);

So if we fail to get the key, we goto out... and then put the key.  Oop=
s.  I'll prepare a patch and send
out after some testing.


> Hardware name:       =20
> Modules linked in: tun fuse i915 drm i2c_algo_bit sunrpc ip6t_REJECT =
nf_conntrack_ipv6 ip6table_filter ip6_tables ipv6 cpufreq_ondemand acpi=
_cpufreq freq_table loop dm_multipath scsi_dh uinput snd_hda_codec_anal=
og snd_hda_intel snd_hda_codec snd_hwdep snd_seq_dummy snd_seq_oss snd_=
seq_midi_event snd_seq arc4 ecb snd_seq_device iwl3945 snd_pcm_oss mac8=
0211 btusb snd_mixer_oss snd_pcm snd_timer sr_mod iTCO_wdt snd cdrom li=
b80211 pl2303 iTCO_vendor_support video bluetooth yenta_socket ata_gene=
ric joydev pcspkr usbserial ata_piix soundcore i2c_i801 i2c_core cfg802=
11 rsrc_nonstatic e1000e sg ati_remote thinkpad_acpi rfkill hwmon outpu=
t snd_page_alloc dm_snapshot dm_zero dm_mirror dm_region_hash dm_log dm=
_mod ahci libata sd_mod scsi_mod uhci_hcd ohci_hcd ssb [last unloaded: =
microcode]
> Pid: 12898, comm: sbcl Not tainted 2.6.29.1-rt6 #20
> Call Trace:
>  [<ffffffff81065411>] warn_slowpath+0xe2/0x116
>  [<ffffffff8109e00a>] ? __lock_release+0x10c/0x125
>  [<ffffffff8100ce96>] ? ftrace_call+0x5/0x2b
>  [<ffffffff8152078b>] ? rt_mutex_unlock+0x47/0x67
>  [<ffffffff810a7414>] ? rt_up_read+0x2b/0x2f
>  [<ffffffff81044bbb>] ? get_user_pages_fast+0x1e4/0x235
>  [<ffffffff8100ce96>] ? ftrace_call+0x5/0x2b
>  [<ffffffff810a023d>] drop_futex_key_refs+0x7e/0x111
>  [<ffffffff810a04b9>] futex_wait_setup+0x1e9/0x1fb
>  [<ffffffff8100ce96>] ? ftrace_call+0x5/0x2b
>  [<ffffffff810a08ee>] futex_wait+0x13f/0x2ce
>  [<ffffffff8101573b>] ? sched_clock+0x42/0x48
>  [<ffffffff8109b621>] ? lock_release_holdtime+0x18d/0x192
>  [<ffffffff8109e00a>] ? __lock_release+0x10c/0x125
>  [<ffffffff8100ce96>] ? ftrace_call+0x5/0x2b
>  [<ffffffff81086896>] ? __wake_up_bit+0xd/0x51
>  [<ffffffff811052c1>] ? page_waitqueue+0x9/0x68
>  [<ffffffff811072f2>] ? unlock_page+0x27/0x2b
>  [<ffffffff8109c92e>] ? __lock_acquire+0x659/0x744
>  [<ffffffff81527701>] ? do_page_fault+0x7e2/0x80d
>  [<ffffffff810157cd>] ? native_sched_clock+0x8c/0xba
>  [<ffffffff8101573b>] ? sched_clock+0x42/0x48
>  [<ffffffff8109b621>] ? lock_release_holdtime+0x18d/0x192
>  [<ffffffff8105b130>] ? default_wake_function+0x0/0x16
>  [<ffffffff8100ce96>] ? ftrace_call+0x5/0x2b
>  [<ffffffff810a4937>] do_futex+0xaa/0x1d1
>  [<ffffffff810a4c2b>] sys_futex+0x1cd/0x1dc
>  [<ffffffff8100d1b2>] system_call_fastpath+0x16/0x1b
> - ---[ end trace 384450cb13d7d800 ]---
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.10 (GNU/Linux)
>=20
> iEYEARECAAYFAknetR0ACgkQHyuj/+TTEp2XkACgqc+Ko+v6cmDsbaVOg9tWaNUF
> pO0AnRHVIqZYUo9PrxeKc4ws+BXZMyvN
> =3DmJTq
> -----END PGP SIGNATURE-----
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{=
=2En=C7+=89=B7=A5=8A{=B1=AE=DB=ACz=BB"=9E=D8^n=87r=A1=F6=A6z=CB=1A=81=EB=
h=99=A8=E8=AD=DA&=A2=F8=1E=AEG=AB=9D=E9h=AE=03(=AD=E9=9A=8E=8A=DD=A2j"=9D=
=FA=1A=B6=1Bm=A7=FF=EF=81=EA=E4z=B9=DE=96=8A=E0=FEf=A3=A2=B7h=9A=88=A7~=
=88mml=3D=3D


--=20
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
