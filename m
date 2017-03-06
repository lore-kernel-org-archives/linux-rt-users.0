From: Wargreen <wargreen@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Mon, 6 Mar 2017 17:14:43 +0100
Message-ID: <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cROgjj6GB9qKSj0sje33M7Rph38lxdlc4"
Cc: Pankaj Gupta <pagupta@redhat.com>, linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>,
        Daniel Vidal <danielvidalchornet@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:37834 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753149AbdCFQPI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Mar 2017 11:15:08 -0500
In-Reply-To: <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cROgjj6GB9qKSj0sje33M7Rph38lxdlc4
Content-Type: multipart/mixed; boundary="ku0cgwaTR6ggB2suxr2ca4jAGmvrh6xEM";
 protected-headers="v1"
From: Wargreen <wargreen@lebib.org>
To: Julia Cartwright <julia@ni.com>,
 Daniel Vidal <danielvidalchornet@gmail.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, linux-rt-users@vger.kernel.org
Message-ID: <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>

--ku0cgwaTR6ggB2suxr2ca4jAGmvrh6xEM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,
As you suggest, i've build the kernel 4.9 rt10 from the debian sources,
with lockdep.

Here the trace when system hang :

Mar  6 17:06:46 LaChoze kernel: [  339.062919] sysrq: SysRq : Show Locks
Held
Mar  6 17:06:46 LaChoze kernel: [  339.062929]
Mar  6 17:06:46 LaChoze kernel: [  339.062929] Showing all locks held in
the system:
Mar  6 17:06:46 LaChoze kernel: [  339.062947] 5 locks held by
irq/1-i8042/126:
Mar  6 17:06:46 LaChoze kernel: [  339.062948]  #0:=20
(&serio->lock){+.+...}, at: [<ffffffff8794dab8>] serio_interrupt+0x28/0x8=
0
Mar  6 17:06:46 LaChoze kernel: [  339.062960]  #1:=20
(&dev->event_lock){+.+...}, at: [<ffffffff87953cba>] input_event+0x3a/0x6=
0
Mar  6 17:06:46 LaChoze kernel: [  339.062967]  #2:=20
(rcu_read_lock){......}, at: [<ffffffff87952ee5>]
input_pass_values.part.5+0x5/0x270
Mar  6 17:06:46 LaChoze kernel: [  339.062975]  #3:=20
(rcu_read_lock){......}, at: [<ffffffff878c1eb5>] __handle_sysrq+0x5/0x22=
0
Mar  6 17:06:46 LaChoze kernel: [  339.062982]  #4:=20
(tasklist_lock){+.+...}, at: [<ffffffff874eae1d>]
debug_show_all_locks+0x3d/0x1a0
Mar  6 17:06:46 LaChoze kernel: [  339.063009] 1 lock held by in:imklog/8=
22:
Mar  6 17:06:46 LaChoze kernel: [  339.063011]  #0:=20
(&f->f_pos_lock){+.+.+.}, at: [<ffffffff8768883a>] __fdget_pos+0x4a/0x50
Mar  6 17:06:46 LaChoze kernel: [  339.063040] 2 locks held by Xorg/2365:=

Mar  6 17:06:46 LaChoze kernel: [  339.063041]  #0:=20
(&rdev->exclusive_lock){++++.+}, at: [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:06:46 LaChoze kernel: [  339.063049]  #1:=20
(&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:06:46 LaChoze kernel: [  339.063100] 2 locks held by G.Main/357=
5:
Mar  6 17:06:46 LaChoze kernel: [  339.063101]  #0:=20
(&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:06:46 LaChoze kernel: [  339.063108]  #1:=20
(reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc087b7b0>]
ttm_bo_vm_fault+0x60/0x530 [ttm]
Mar  6 17:06:46 LaChoze kernel: [  339.063124]
Mar  6 17:06:46 LaChoze kernel: [  339.063125]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mar  6 17:06:46 LaChoze kernel: [  339.063125]
Mar  6 17:07:11 LaChoze kernel: [  363.523950] INFO: task Xorg:2365
blocked for more than 120 seconds.
Mar  6 17:07:11 LaChoze kernel: [  363.523959]       Not tainted
4.9.13-rt10 #1
Mar  6 17:07:11 LaChoze kernel: [  363.523961] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  6 17:07:11 LaChoze kernel: [  363.523964] Xorg            D    0=20
2365   2363 0x00000004
Mar  6 17:07:11 LaChoze kernel: [  363.523970]  0000000000000000
ffff96333582b458 ffff9633027bd580 ffff96333582b440
Mar  6 17:07:11 LaChoze kernel: [  363.523975]  ffff96332f2b1c80
ffffba8646bffa50 ffffffff87af622f 00ffba8646bffb08
Mar  6 17:07:11 LaChoze kernel: [  363.523980]  ffff9633027bdbc0
ffff96333582b458 ffff96332841b800 ffff9633027bd580
Mar  6 17:07:11 LaChoze kernel: [  363.523984] Call Trace:
Mar  6 17:07:11 LaChoze kernel: [  363.523984] Call Trace:
Mar  6 17:07:11 LaChoze kernel: [  363.523992]  [<ffffffff87af622f>] ?
__schedule+0x32f/0x800
Mar  6 17:07:11 LaChoze kernel: [  363.523996]  [<ffffffff87af674c>]
schedule+0x4c/0xe0
Mar  6 17:07:11 LaChoze kernel: [  363.523998]  [<ffffffff87af8146>]
__rt_mutex_slowlock+0x56/0x1c0
Mar  6 17:07:11 LaChoze kernel: [  363.524001]  [<ffffffff87af8834>]
rt_mutex_slowlock+0x114/0x360
Mar  6 17:07:11 LaChoze kernel: [  363.524005]  [<ffffffff87665615>] ?
get_empty_filp+0x175/0x250
Mar  6 17:07:11 LaChoze kernel: [  363.524007]  [<ffffffff87af8a9a>]
rt_mutex_lock+0x1a/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524011]  [<ffffffff874f36e3>]
__rt_down_read+0x53/0x70
Mar  6 17:07:11 LaChoze kernel: [  363.524014]  [<ffffffff874f3710>] ?
rt_down_read+0x10/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524016]  [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524043]  [<ffffffffc0ae7d97>]
radeon_bo_create+0x157/0x360 [radeon]
Mar  6 17:07:11 LaChoze kernel: [  363.524064]  [<ffffffffc0afb21d>]
radeon_gem_object_create+0xbd/0x1a0 [radeon]
Mar  6 17:07:11 LaChoze kernel: [  363.524084]  [<ffffffffc0afb6ae>]
radeon_gem_create_ioctl+0x6e/0x100 [radeon]
Mar  6 17:07:11 LaChoze kernel: [  363.524101]  [<ffffffffc081ef6a>]
drm_ioctl+0x37a/0x4d0 [drm]
Mar  6 17:07:11 LaChoze kernel: [  363.524119]  [<ffffffffc0afb640>] ?
radeon_gem_pwrite_ioctl+0x30/0x30 [radeon]
Mar  6 17:07:11 LaChoze kernel: [  363.524122]  [<ffffffff877de437>] ?
debug_smp_processor_id+0x17/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524125]  [<ffffffff8748d8f6>] ?
unpin_current_cpu+0x16/0x70
Mar  6 17:07:11 LaChoze kernel: [  363.524128]  [<ffffffff874bce47>] ?
migrate_enable+0x87/0x150
Mar  6 17:07:11 LaChoze kernel: [  363.524131]  [<ffffffff87afb18f>] ?
rt_spin_unlock+0x2f/0x40
Mar  6 17:07:11 LaChoze kernel: [  363.524145]  [<ffffffffc0ac804f>]
radeon_drm_ioctl+0x4f/0x90 [radeon]
Mar  6 17:07:11 LaChoze kernel: [  363.524148]  [<ffffffff87679fd3>]
do_vfs_ioctl+0xa3/0x6f0
Mar  6 17:07:11 LaChoze kernel: [  363.524152]  [<ffffffff8768789c>] ?
__fget+0x11c/0x210
Mar  6 17:07:11 LaChoze kernel: [  363.524154]  [<ffffffff87687785>] ?
__fget+0x5/0x210
Mar  6 17:07:11 LaChoze kernel: [  363.524157]  [<ffffffff8767a699>]
SyS_ioctl+0x79/0x90
Mar  6 17:07:11 LaChoze kernel: [  363.524159]  [<ffffffff87afb845>]
system_call_fast_compare_end+0xc/0xaf
Mar  6 17:07:11 LaChoze kernel: [  363.524162]
Mar  6 17:07:11 LaChoze kernel: [  363.524162] Showing all locks held in
the system:
Mar  6 17:07:11 LaChoze kernel: [  363.524170] 2 locks held by
khungtaskd/90:
Mar  6 17:07:11 LaChoze kernel: [  363.524171]  #0:=20
(rcu_read_lock){......}, at: [<ffffffff8756ef6e>] watchdog+0xae/0x640
Mar  6 17:07:11 LaChoze kernel: [  363.524180]  #1:=20
(tasklist_lock){+.+...}, at: [<ffffffff874eae1d>]
debug_show_all_locks+0x3d/0x1a0
Mar  6 17:07:11 LaChoze kernel: [  363.524193] 1 lock held by in:imklog/8=
22:
Mar  6 17:07:11 LaChoze kernel: [  363.524194]  #0:=20
(&f->f_pos_lock){+.+.+.}, at: [<ffffffff8768883a>] __fdget_pos+0x4a/0x50
Mar  6 17:07:11 LaChoze kernel: [  363.524208] 2 locks held by Xorg/2365:=

Mar  6 17:07:11 LaChoze kernel: [  363.524209]  #0:=20
(&rdev->exclusive_lock){++++.+}, at: [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524215]  #1:=20
(&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524263] 2 locks held by G.Main/357=
5:
Mar  6 17:07:11 LaChoze kernel: [  363.524264]  #0:=20
(&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>]
rt_down_read+0x10/0x20
Mar  6 17:07:11 LaChoze kernel: [  363.524270]  #1:=20
(reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc087b7b0>]
ttm_bo_vm_fault+0x60/0x530 [ttm]
Mar  6 17:07:11 LaChoze kernel: [  363.524282]
Mar  6 17:07:11 LaChoze kernel: [  363.524283]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mar  6 17:07:11 LaChoze kernel: [  363.524283]


I hope this can help !



On 02/03/2017 22:10, Julia Cartwright wrote:
> On Sun, Feb 26, 2017 at 12:55:01PM +0100, Daniel Vidal wrote:
>> Hi
>>
>> The radeon driver hangs from 3.16 kernel.
>>
>> RT patch for radeon driver only disable ( preempt_disable_rt() ) and
>> reenable ( preempt_enable_rt() ) the whole RT in file radeon_display.c=

>>
>> Obviously this is not enough.
>>
>> I think the radeon developers should make some modification in the
>> driver but I do not know which is the right place to indicate it
>>
>> Here my backtrace.
> Two more debugging ideas:
>
>   1. Boot with lockdep enabled, see if that gives you a meaningful
>      splat.
>
>   2. Use sysrq-trigger 'd' to dump held locks to console when stuck in
>      this state, in order to track down the codepath causing problems.
>
>    Julia




--ku0cgwaTR6ggB2suxr2ca4jAGmvrh6xEM--

--cROgjj6GB9qKSj0sje33M7Rph38lxdlc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCAAxFiEEhe8tJb5+nGkdrJsqDnSv7tOnn7gFAli9ivgTHHdhcmdyZWVu
QGxlYmliLm9yZwAKCRAOdK/u06efuJGpEADLoZHj2CFRFeTQ+VtuAxC+sx3m4oFL
MxwqzcdMKsLQWyScdfWLTOGzC0Wgs1BgJTg+KVs2WuIg9JOahNpYCQJ8MeEReDqn
/fxWYFKaJqgUGtH7ytmM7e5uAA6jboluZ/oBZVmsyE2TuFtQOKxCFgSn9OJKxg2/
5M3RifzUpc9DF+enXhGp3RZ8e6tiQ/9g+n0HGzf7qoDolASNI2zYR3W02Ho0tKKe
ONAkw/Bp+5oBGEwa0Zyk5d4714gaI0kmSf3aCLGmaEyIDtLIXigU8nxJW5L4VMuZ
VzlD1hUKopH9MeaOQMnMRDoqvzBezhpgcSJTKpOCK+sXR9f5Ej1wVdmshCnUYXDp
+Eon9xxBD5fUUwIY0yusM08dqgwJCMmVUia6MxEAaVTb2MRHwSuaJ41RAFhYYJyy
59gzMNQpYOnnzjwMB0GFjxFtZ5htcpoNCUmUxGWREYIjxqebXJoq5c7oR+dCRW/S
SrH/7JDu51omtB5f6gTe/X4cOyLb+oo5kvkx4UO4R9ZXxzhgYEEudgAhx86RkJQq
9kk210+jZ6n+7/7dc4z2JJSmD0ux7944onwtN9osWFgGOYuHcWdCyVW05n9vy0Yk
Q4b1iEpsu0nzwcnyO9L2E39SAT3VCU3V41AlYbayVrwTttEd6jDzOFndVJOXkIzZ
/n38zNsh8zexCg==
=1sE6
-----END PGP SIGNATURE-----

--cROgjj6GB9qKSj0sje33M7Rph38lxdlc4--
