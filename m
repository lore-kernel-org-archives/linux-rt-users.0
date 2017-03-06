From: Wargreen <wargreen@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Mon, 6 Mar 2017 18:59:26 +0100
Message-ID: <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uNekpKvaNutpTpndasAeUe6bMVoR7wCpU"
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:38334 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932192AbdCFSgs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Mar 2017 13:36:48 -0500
In-Reply-To: <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uNekpKvaNutpTpndasAeUe6bMVoR7wCpU
Content-Type: multipart/mixed; boundary="hPICmH9vH7aHqxHrd8SsSQ6JjUcKQRb6P";
 protected-headers="v1"
From: Wargreen <wargreen@lebib.org>
To: Julia Cartwright <julia@ni.com>
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
 Pankaj Gupta <pagupta@redhat.com>, linux-rt-users@vger.kernel.org
Message-ID: <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>

--hPICmH9vH7aHqxHrd8SsSQ6JjUcKQRb6P
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Here a new try, with a process name more explicit, but without X crash
this time.
So it's the graphic's ressources demanding process.

Mar  6 18:44:47 LaChoze kernel: [  497.053439] sysrq: SysRq : Show Locks
Held
Mar  6 18:44:47 LaChoze kernel: [  497.053450]
Mar  6 18:44:47 LaChoze kernel: [  497.053450] Showing all locks held in
the system:
Mar  6 18:44:47 LaChoze kernel: [  497.053468] 5 locks held by
irq/1-i8042/126:
Mar  6 18:44:47 LaChoze kernel: [  497.053470]  #0:=20
(&serio->lock){+.+...}, at: [<ffffffffa954dab8>] serio_interrupt+0x28/0x8=
0
Mar  6 18:44:47 LaChoze kernel: [  497.053481]  #1:=20
(&dev->event_lock){+.+...}, at: [<ffffffffa9553cba>] input_event+0x3a/0x6=
0
Mar  6 18:44:47 LaChoze kernel: [  497.053489]  #2:=20
(rcu_read_lock){......}, at: [<ffffffffa9552ee5>]
input_pass_values.part.5+0x5/0x270
Mar  6 18:44:47 LaChoze kernel: [  497.053496]  #3:=20
(rcu_read_lock){......}, at: [<ffffffffa94c1eb5>] __handle_sysrq+0x5/0x22=
0
Mar  6 18:44:47 LaChoze kernel: [  497.053504]  #4:=20
(tasklist_lock){+.+...}, at: [<ffffffffa90eae1d>]
debug_show_all_locks+0x3d/0x1a0
Mar  6 18:44:47 LaChoze kernel: [  497.053532] 1 lock held by in:imklog/8=
55:
Mar  6 18:44:47 LaChoze kernel: [  497.053533]  #0:=20
(&f->f_pos_lock){+.+.+.}, at: [<ffffffffa928883a>] __fdget_pos+0x4a/0x50
Mar  6 18:44:47 LaChoze kernel: [  497.053562] 2 locks held by Xorg/2154:=

Mar  6 18:44:47 LaChoze kernel: [  497.053563]  #0:=20
(&rdev->exclusive_lock){++++.+}, at: [<ffffffffa90f3710>]
rt_down_read+0x10/0x20
Mar  6 18:44:47 LaChoze kernel: [  497.053571]  #1:=20
(&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa90f3710>]
rt_down_read+0x10/0x20
Mar  6 18:44:47 LaChoze kernel: [  497.053589] 2 locks held by
gnome-shell/2344:
Mar  6 18:44:47 LaChoze kernel: [  497.053590]  #0:=20
(&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa90f3710>]
rt_down_read+0x10/0x20
Mar  6 18:44:47 LaChoze kernel: [  497.053597]  #1:=20
(reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc0af47b0>]
ttm_bo_vm_fault+0x60/0x530 [ttm]
Mar  6 18:44:47 LaChoze kernel: [  497.053637]
Mar  6 18:44:47 LaChoze kernel: [  497.053638]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



On 06/03/2017 18:33, Julia Cartwright wrote:
> On Mon, Mar 06, 2017 at 05:14:43PM +0100, Wargreen wrote:
>> Hi,
>> As you suggest, i've build the kernel 4.9 rt10 from the debian sources=
,
>> with lockdep.
>>
>> Here the trace when system hang :
>>
>> [  339.062919] sysrq: SysRq : Show Locks Held
>> [  339.062929]
>> [  339.062929] Showing all locks held in the system:
>> [  339.062947] 5 locks held by irq/1-i8042/126:
>> [  339.062948]  #0: (&serio->lock){+.+...}, at: [<ffffffff8794dab8>] s=
erio_interrupt+0x28/0x80
>> [  339.062960]  #1: (&dev->event_lock){+.+...}, at: [<ffffffff87953cba=
>] input_event+0x3a/0x60
>> [  339.062967]  #2: (rcu_read_lock){......}, at: [<ffffffff87952ee5>] =
input_pass_values.part.5+0x5/0x270
>> [  339.062975]  #3: (rcu_read_lock){......}, at: [<ffffffff878c1eb5>] =
__handle_sysrq+0x5/0x220
>> [  339.062982]  #4: (tasklist_lock){+.+...}, at: [<ffffffff874eae1d>] =
debug_show_all_locks+0x3d/0x1a0
>> [  339.063009] 1 lock held by in:imklog/822:
>> [  339.063011]  #0: (&f->f_pos_lock){+.+.+.}, at: [<ffffffff8768883a>]=
 __fdget_pos+0x4a/0x50
> The above two threads are irrelevant.
>
>> [  339.063040] 2 locks held by Xorg/2365:
>> [  339.063041]  #0: (&rdev->exclusive_lock){++++.+}, at: [<ffffffff874=
f3710>] rt_down_read+0x10/0x20
>> [  339.063049]  #1: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3=
710>] rt_down_read+0x10/0x20
>> [  339.063100] 2 locks held by G.Main/3575:
>> [  339.063101]  #0: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3=
710>] rt_down_read+0x10/0x20
>> [  339.063108]  #1: (reservation_ww_class_mutex){+.+.+.}, at: [<ffffff=
ffc087b7b0>] ttm_bo_vm_fault+0x60/0x530 [ttm]
> These two are suspicious, though.  Note that what it claimed is that
> &rdev->pm.mclk_lock is acquired by both threads.  However:
>
>> [  339.063124]
>> [  339.063125] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> [  339.063125]
>> [  363.523950] INFO: task Xorg:2365 blocked for more than 120 seconds.=

>> [  363.523959]       Not tainted 4.9.13-rt10 #1
>> [  363.523961] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
>> [  363.523964] Xorg            D    0 2365   2363 0x00000004
>> [  363.523970]  0000000000000000 ffff96333582b458 ffff9633027bd580 fff=
f96333582b440
>> [  363.523975]  ffff96332f2b1c80 ffffba8646bffa50 ffffffff87af622f 00f=
fba8646bffb08
>> [  363.523980]  ffff9633027bdbc0 ffff96333582b458 ffff96332841b800 fff=
f9633027bd580
>> [  363.523984] Call Trace:
>> [  363.523984] Call Trace:
>> [  363.523992]  [<ffffffff87af622f>] ?  __schedule+0x32f/0x800
>> [  363.523996]  [<ffffffff87af674c>] schedule+0x4c/0xe0
>> [  363.523998]  [<ffffffff87af8146>] __rt_mutex_slowlock+0x56/0x1c0
>> [  363.524001]  [<ffffffff87af8834>] rt_mutex_slowlock+0x114/0x360
>> [  363.524005]  [<ffffffff87665615>] ?  get_empty_filp+0x175/0x250
>> [  363.524007]  [<ffffffff87af8a9a>] rt_mutex_lock+0x1a/0x20
>> [  363.524011]  [<ffffffff874f36e3>] __rt_down_read+0x53/0x70
>> [  363.524014]  [<ffffffff874f3710>] ?  rt_down_read+0x10/0x20
>> [  363.524016]  [<ffffffff874f3710>] rt_down_read+0x10/0x20
>> [  363.524043]  [<ffffffffc0ae7d97>] radeon_bo_create+0x157/0x360 [rad=
eon]
>> [  363.524064]  [<ffffffffc0afb21d>] radeon_gem_object_create+0xbd/0x1=
a0 [radeon]
>> [  363.524084]  [<ffffffffc0afb6ae>] radeon_gem_create_ioctl+0x6e/0x10=
0 [radeon]
>> [  363.524101]  [<ffffffffc081ef6a>] drm_ioctl+0x37a/0x4d0 [drm]
>> [  363.524119]  [<ffffffffc0afb640>] ?  radeon_gem_pwrite_ioctl+0x30/0=
x30 [radeon]
>> [  363.524122]  [<ffffffff877de437>] ?  debug_smp_processor_id+0x17/0x=
20
>> [  363.524125]  [<ffffffff8748d8f6>] ?  unpin_current_cpu+0x16/0x70
>> [  363.524128]  [<ffffffff874bce47>] ?  migrate_enable+0x87/0x150
>> [  363.524131]  [<ffffffff87afb18f>] ?  rt_spin_unlock+0x2f/0x40
>> [  363.524145]  [<ffffffffc0ac804f>] radeon_drm_ioctl+0x4f/0x90 [radeo=
n]
>> [  363.524148]  [<ffffffff87679fd3>] do_vfs_ioctl+0xa3/0x6f0
>> [  363.524152]  [<ffffffff8768789c>] ?  __fget+0x11c/0x210
>> [  363.524154]  [<ffffffff87687785>] ?  __fget+0x5/0x210
>> [  363.524157]  [<ffffffff8767a699>] SyS_ioctl+0x79/0x90
>> [  363.524159]  [<ffffffff87afb845>] system_call_fast_compare_end+0xc/=
0xaf
> It appears that Xorg hasn't actually acquired the rwsem's underlying
> rt_mutex, but is in the process of acquiring it, but is suspended
> waiting on G.Main/3575 to release it.
>
>> [  363.524263] 2 locks held by G.Main/3575:
>> [  363.524264]  #0: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3=
710>] rt_down_read+0x10/0x20
>> [  363.524270]  #1: (reservation_ww_class_mutex){+.+.+.}, at: [<ffffff=
ffc087b7b0>] ttm_bo_vm_fault+0x60/0x530 [ttm]
> So, the question is: what is this G.Main/3575 thread, and what is it
> doing?  Do you find it spinning?
>
> Could be something fishy with w/w mutexes as well.
>
>    Julia




--hPICmH9vH7aHqxHrd8SsSQ6JjUcKQRb6P--

--uNekpKvaNutpTpndasAeUe6bMVoR7wCpU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCAAxFiEEhe8tJb5+nGkdrJsqDnSv7tOnn7gFAli9o4ITHHdhcmdyZWVu
QGxlYmliLm9yZwAKCRAOdK/u06efuN/VD/wPyLPTT020l9046pOVNkNLLINpFRzd
xrZLifZ3nCJfZtgtffxU48jeXDtbbDFJP+5VnlNl4GM/okgFNTDKgbs0X7cImtUo
d8XBMfX2R336kWRITTo4H8LTG9kZOmL2fQ/JGM2tH+s/TJA0pYy/HkV0PPad4ybV
799uSVegtW45I/D3Z/TTE3HfvPhzBl6jJ0v6J+qAXsjr61r9ivV518fyDIzWikMK
3itIOGIVUm+OU+jfis1XBymd/HQ0gPnSrbPLdyLdehOPJ/x6oWEeH35v1loDJeN+
Cp6uJCL6YLnkI+pKBvHpI/nP5YuBTzBWHJswROWftzYcSrcw6cqZfcxKM/X6FUve
sQDJcln2KPGhcwaSygR2bZPPK+03UThCBXGU3jAZBcPvwNIa3gZ1u+vPYAClcfsh
iiGgHPJ39BUExIXFBOApg3TKLy7ZnnKGq+99rNrZfPDVfy2RLgg1jU4Qw05WmPzt
G4wMRorP0p+D80cR+nwRPo/gexb2ccewRN5u1sDuda+sjGx1/e788bfXiudZq7LS
lv6G/kImq8bJXpti1kHXmf9J1OBGOYmeKQ+ghow3BepMDltm1t2yoU6b3rZ7BWNB
v0DDUdiioNHQwmHjp5WalUFLoXWwMSqYwBr57me0XLarT7q1c8Er4b9y5T4ZoM8S
2+vBAvkkRa9QZg==
=0YEJ
-----END PGP SIGNATURE-----

--uNekpKvaNutpTpndasAeUe6bMVoR7wCpU--
