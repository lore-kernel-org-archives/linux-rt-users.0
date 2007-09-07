From: joel silvestre <j.silvestre@wanadoo.fr>
Subject: BUG: unable to handle kernel paging...
Date: Fri, 07 Sep 2007 14:30:21 +0200
Message-ID: <1189168221.5020.6.camel@zordi>
References: <20070607041411.GB1783@linux.vnet.ibm.com>
	 <1181226138.18444.54.camel@localhost.localdomain>
	 <20070607161754.GA11941@linux.vnet.ibm.com>
	 <1181240819.10408.14.camel@localhost.localdomain>
	 <20070607210247.GA9390@linux.vnet.ibm.com>
	 <1181316428.10408.30.camel@localhost.localdomain>
	 <20070608193655.GA18399@linux.vnet.ibm.com>
	 <1181331828.10408.34.camel@localhost.localdomain>
	 <20070608200058.GC18399@linux.vnet.ibm.com> <46E03E40.80801@redhat.com>
	 <20070906180634.GG8030@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp19.orange.fr ([80.12.242.18]:42506 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965065AbXIGMpb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Sep 2007 08:45:31 -0400
Received: from smtp19.orange.fr (mwinf1928 [172.22.129.128])
	by mwinf1920.orange.fr (SMTP Server) with ESMTP id 4D5845C0396D
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Sep 2007 14:31:04 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 79ED61C00099
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Sep 2007 14:30:22 +0200 (CEST)
Received: from [192.168.0.3] (AAnnecy-157-1-8-162.w86-200.abo.wanadoo.fr [86.200.23.162])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 1CDE31C00094
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Sep 2007 14:30:22 +0200 (CEST)
In-Reply-To: <20070906180634.GG8030@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi ,

is this of any use for you?

kernel is 2.6.22.1-rt9


Sep  6 07:35:11 pcazick kernel: BUG: unable to handle kernel paging
request at virtual address 28000000
Sep  6 07:35:11 pcazick kernel:  printing eip:
Sep  6 07:35:11 pcazick kernel: c017a26a
Sep  6 07:35:11 pcazick kernel: *pde =3D 00000000
Sep  6 07:35:11 pcazick kernel: stopped custom tracer.
Sep  6 07:35:11 pcazick kernel: Oops: 0000 [#1]
Sep  6 07:35:11 pcazick kernel: PREEMPT SMP=20
Sep  6 07:35:12 pcazick kernel: Modules linked in: fuse snd_seq_midi
snd_seq_midi_event snd_seq_dummy nfs lockd nfs_acl sunrpc capability
commoncap evdev button ac battery ipv6 dm_snapshot dm_mirror dm_mod
snd_seq i2c_savage4 savagefb fb_ddc i2c_algo_bit snd_ice1724
snd_ice17xx_ak4xxx snd_ac97_codec ac97_bus snd_ak4114 snd_pcm snd_timer
snd_page_alloc i2c_viapro snd_pt2258 snd_i2c snd_ak4xxx_adda
snd_mpu401_uart snd_rawmidi via686a snd_seq_device i2c_isa snd shpchp
parport_pc via_agp soundcore i2c_core rt2500 parport pci_hotplug agpgar=
t
ext3 jbd mbcache raid10 raid456 xor raid1 raid0 multipath linear md_mod
ide_disk ata_generic libata scsi_mod via82cxxx generic ide_core thermal
processor fan vga16fb vgastate
Sep  6 07:35:12 pcazick kernel: CPU:    0
Sep  6 07:35:12 pcazick kernel: EIP:    0060:[<c017a26a>]    Not tainte=
d
VLI
Sep  6 07:35:12 pcazick kernel: EFLAGS: 00010206   (2.6.22.1-rt9 #1)
Sep  6 07:35:12 pcazick kernel: EIP is at __d_lookup+0xd2/0xfa
Sep  6 07:35:12 pcazick kernel: eax: 28000000   ebx: c1720a75   ecx:
e4251084   edx: d8874c10
Sep  6 07:35:12 pcazick kernel: esi: d2e510e8   edi: 28000000   ebp:
ce5e3f04   esp: ce5e3dc4
Sep  6 07:35:12 pcazick kernel: ds: 007b   es: 007b   fs: 00d8  gs: 003=
3
ss: 0068  preempt:00000001
Sep  6 07:35:12 pcazick kernel: Process find (pid: 3451, ti=3Dce5e2000
task=3Dd8874c10 task.ti=3Dce5e2000)
Sep  6 07:35:12 pcazick kernel: Stack: ce5e3e3c c3e5e9dc 00000009
e4251084 c97d8000 e4251084 d2e510e8 c97d8000=20
Sep  6 07:35:12 pcazick kernel:        ce5e3f04 c01714b8 ce5e3e48
ce5e3e3c ce5e3f04 dfadbf20 e4251084 d2e510e8=20
Sep  6 07:35:12 pcazick kernel:        c97d8000 ce5e3f04 c01731c1
c97d8009 00000000 00000000 dfadbf20 c017dba5=20
Sep  6 07:35:12 pcazick kernel: Call Trace:
Sep  6 07:35:12 pcazick kernel:  [<c01714b8>] do_lookup+0x24/0x143
Sep  6 07:35:12 pcazick kernel:  [<c01731c1>] __link_path_walk
+0x7d4/0xc12
Sep  6 07:35:12 pcazick kernel:  [<c017dba5>] mntput_no_expire+0x11/0x6=
e
Sep  6 07:35:12 pcazick kernel:  [<c01736a8>] link_path_walk+0xa9/0xb3
Sep  6 07:35:12 pcazick kernel:  [<c0173643>] link_path_walk+0x44/0xb3
Sep  6 07:35:12 pcazick kernel:  [<c017393a>] do_path_lookup+0x162/0x17=
d
Sep  6 07:35:12 pcazick kernel:  [<c017275e>] getname+0x59/0x8f
Sep  6 07:35:12 pcazick kernel:  [<c0174106>] __user_walk_fd+0x2f/0x45
Sep  6 07:35:12 pcazick kernel:  [<c016df47>] vfs_lstat_fd+0x16/0x3d
Sep  6 07:35:12 pcazick kernel:  [<c016dfb3>] sys_lstat64+0xf/0x23
Sep  6 07:35:12 pcazick kernel:  [<c0103e1a>] syscall_call+0x7/0xb
Sep  6 07:35:12 pcazick kernel:  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Sep  6 07:35:12 pcazick kernel: Code: 6f 77 05 00 85 c0 75 16 31 f6 f6
43 04 10 75 05 90 ff 03 89 de 89 e8 e8 4d 11 13 00 eb 26 89 e8 e8 44 11
13 00 8b 3f 85 ff 74 17 <8b> 07 0f 18 00 90 8d 5f d4 8b 4c 24 0c 39 4b
38 75 e8 e9 71 ff=20
Sep  6 07:35:12 pcazick kernel: EIP: [<c017a26a>] __d_lookup+0xd2/0xfa
SS:ESP 0068:ce5e3dc4


Sep  7 14:15:35 pcazick kernel: BUG: unable to handle kernel paging
request at virtual address ff7eff00
Sep  7 14:15:35 pcazick kernel:  printing eip:
Sep  7 14:15:35 pcazick kernel: c017a26a
Sep  7 14:15:35 pcazick kernel: *pde =3D 00000000
Sep  7 14:15:35 pcazick kernel: Oops: 0000 [#2]
Sep  7 14:15:35 pcazick kernel: PREEMPT SMP=20
Sep  7 14:15:35 pcazick kernel: Modules linked in: fuse snd_seq_midi
snd_seq_midi_event snd_seq_dummy nfs lockd nfs_acl sunrpc capability
commoncap evdev button ac battery ipv6 dm_snapshot dm_mirror dm_mod
snd_seq i2c_savage4 savagefb fb_ddc i2c_algo_bit snd_ice1724
snd_ice17xx_ak4xxx snd_ac97_codec ac97_bus snd_ak4114 snd_pcm snd_timer
snd_page_alloc i2c_viapro snd_pt2258 snd_i2c snd_ak4xxx_adda
snd_mpu401_uart snd_rawmidi via686a snd_seq_device i2c_isa snd shpchp
parport_pc via_agp soundcore i2c_core rt2500 parport pci_hotplug agpgar=
t
ext3 jbd mbcache raid10 raid456 xor raid1 raid0 multipath linear md_mod
ide_disk ata_generic libata scsi_mod via82cxxx generic ide_core thermal
processor fan vga16fb vgastate
Sep  7 14:15:35 pcazick kernel: CPU:    0
Sep  7 14:15:35 pcazick kernel: EIP:    0060:[<c017a26a>]    Not tainte=
d
VLI
Sep  7 14:15:35 pcazick kernel: EFLAGS: 00010286   (2.6.22.1-rt9 #1)
Sep  7 14:15:35 pcazick kernel: EIP is at __d_lookup+0xd2/0xfa
Sep  7 14:15:35 pcazick kernel: eax: ff7eff00   ebx: c3700e5c   ecx:
b8a04b79   edx: d1b3e740
Sep  7 14:15:35 pcazick kernel: esi: df48a388   edi: ff7eff00   ebp:
d4ddbf04   esp: d4ddbdc4
Sep  7 14:15:35 pcazick kernel: ds: 007b   es: 007b   fs: 00d8  gs: 003=
3
ss: 0068  preempt:00000001
Sep  7 14:15:35 pcazick kernel: Process find (pid: 4155, ti=3Dd4dda000
task=3Dd1b3e740 task.ti=3Dd4dda000)
Sep  7 14:15:35 pcazick kernel: Stack: d4ddbe3c dee70edc 00000006
b8a04b79 d4d21000 b8a04b79 df48a388 d4d21000=20
Sep  7 14:15:35 pcazick kernel:        d4ddbf04 c01714b8 d4ddbe48
d4ddbe3c d4ddbf04 dfadbf20 b8a04b79 df48a388=20
Sep  7 14:15:35 pcazick kernel:        d4d21000 d4ddbf04 c01731c1
d4d21006 00000000 d4ddbe94 c032c960 00010000=20
Sep  7 14:15:35 pcazick kernel: Call Trace:
Sep  7 14:15:35 pcazick kernel:  [<c01714b8>] do_lookup+0x24/0x143
Sep  7 14:15:35 pcazick kernel:  [<c01731c1>] __link_path_walk
+0x7d4/0xc12
Sep  7 14:15:35 pcazick kernel:  [<c01070f3>] timer_interrupt+0x2e/0x34
Sep  7 14:15:35 pcazick kernel:  [<c0173643>] link_path_walk+0x44/0xb3
Sep  7 14:15:35 pcazick kernel:  [<c017393a>] do_path_lookup+0x162/0x17=
d
Sep  7 14:15:35 pcazick kernel:  [<c017275e>] getname+0x59/0x8f
Sep  7 14:15:35 pcazick kernel:  [<c0174106>] __user_walk_fd+0x2f/0x45
Sep  7 14:15:35 pcazick kernel:  [<c016df47>] vfs_lstat_fd+0x16/0x3d
Sep  7 14:15:35 pcazick kernel:  [<c016dfb3>] sys_lstat64+0xf/0x23
Sep  7 14:15:35 pcazick kernel:  [<c0103e1a>] syscall_call+0x7/0xb
Sep  7 14:15:35 pcazick kernel:  [<c02a0000>] __ipv6_addr_type+0xc/0xb8
Sep  7 14:15:35 pcazick kernel:  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Sep  7 14:15:35 pcazick kernel: Code: 6f 77 05 00 85 c0 75 16 31 f6 f6
43 04 10 75 05 90 ff 03 89 de 89 e8 e8 4d 11 13 00 eb 26 89 e8 e8 44 11
13 00 8b 3f 85 ff 74 17 <8b> 07 0f 18 00 90 8d 5f d4 8b 4c 24 0c 39 4b
38 75 e8 e9 71 ff=20
Sep  7 14:15:35 pcazick kernel: EIP: [<c017a26a>] __d_lookup+0xd2/0xfa
SS:ESP 0068:d4ddbdc4
=20











Le jeudi 06 septembre 2007 =E0 11:06 -0700, Paul E. McKenney a =E9crit =
:
> On Thu, Sep 06, 2007 at 12:52:00PM -0500, Clark Williams wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >=20
> > Paul E. McKenney wrote:
> > > On Fri, Jun 08, 2007 at 03:43:48PM -0400, Steven Rostedt wrote:
> > >> On Fri, 2007-06-08 at 12:36 -0700, Paul E. McKenney wrote:
> > >>> On Fri, Jun 08, 2007 at 11:27:08AM -0400, Steven Rostedt wrote:
> > >>>> The first time I compiled it, I forgot the ';' and got a warni=
ng there.
> > >>>> But the warning also included "declaring structure softirq_act=
ion in
> > >>>> prototype", so I fixed both the ';' and added the struct. I ca=
n try
> > >>>> compile without it. But I also know that adding #include <inte=
rrupt.h>
> > >>>> in rcupreempt.h caused issues too.
> > >>> If I leave out both the "struct softirq_action" and the
> > >>> rcu_process_callbacks() declaration,, it compiles for me.
> > >>>
> > >>> So I guess the rcu_process_callbacks() should be declared stati=
c...
> > >> OK, I can update the patch to reflect that. Remember, I didn't l=
earn
> > >> anything from doing this patch, so I have no idea why
> > >> rcu_procell_callbacks was global. I was just keeping to the norm=
=2E :-)
> > >=20
> > > Hey, -I- learned something from your doing the patch -- namely th=
at
> > > rcu_process_callbacks() was needlessly non-static.  ;-)
> > >=20
> > >> Actually, I'll make a separate patch for this change. This is a
> > >> different issue.
> > >=20
> > > Sounds good!
> > >=20
> >=20
> > Paul,
> >=20
> > I had a test run of a kernel using Steven's patch (RCU using taskle=
ts) going over the
> > weekend. It looks like it made it through running racer for 24hrs w=
ithout a panic,
> > but I'm not entirely convinced (since my reservation of the test sy=
stem expired on
> > Saturday and I didn't look at it until Wednesday; bad Clark, no dou=
ghnut).
> >=20
> > I've got another test running now and I'll be able to poke around o=
n the system
> > tomorrow morning to see if in fact there were no RCU related Oops'e=
n. I'll let you
> > know what we find.
>=20
> Thank you for the info, Clark!
>=20
> Of course, this all begs the question of why the heck switching from
> tasklets to softirqs should make any difference at all...
>=20
> 							Thanx, Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
