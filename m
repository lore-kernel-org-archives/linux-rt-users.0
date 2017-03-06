From: Julia Cartwright <julia@ni.com>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Mon, 6 Mar 2017 11:33:53 -0600
Message-ID: <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        <linux-rt-users@vger.kernel.org>
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:42568 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932702AbdCFTmo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Mar 2017 14:42:44 -0500
Content-Disposition: inline
In-Reply-To: <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 06, 2017 at 05:14:43PM +0100, Wargreen wrote:
> Hi,
> As you suggest, i've build the kernel 4.9 rt10 from the debian sources,
> with lockdep.
>
> Here the trace when system hang :
>
> [  339.062919] sysrq: SysRq : Show Locks Held
> [  339.062929]
> [  339.062929] Showing all locks held in the system:
> [  339.062947] 5 locks held by irq/1-i8042/126:
> [  339.062948]  #0: (&serio->lock){+.+...}, at: [<ffffffff8794dab8>] serio_interrupt+0x28/0x80
> [  339.062960]  #1: (&dev->event_lock){+.+...}, at: [<ffffffff87953cba>] input_event+0x3a/0x60
> [  339.062967]  #2: (rcu_read_lock){......}, at: [<ffffffff87952ee5>] input_pass_values.part.5+0x5/0x270
> [  339.062975]  #3: (rcu_read_lock){......}, at: [<ffffffff878c1eb5>] __handle_sysrq+0x5/0x220
> [  339.062982]  #4: (tasklist_lock){+.+...}, at: [<ffffffff874eae1d>] debug_show_all_locks+0x3d/0x1a0
> [  339.063009] 1 lock held by in:imklog/822:
> [  339.063011]  #0: (&f->f_pos_lock){+.+.+.}, at: [<ffffffff8768883a>] __fdget_pos+0x4a/0x50

The above two threads are irrelevant.

> [  339.063040] 2 locks held by Xorg/2365:
> [  339.063041]  #0: (&rdev->exclusive_lock){++++.+}, at: [<ffffffff874f3710>] rt_down_read+0x10/0x20
> [  339.063049]  #1: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>] rt_down_read+0x10/0x20
> [  339.063100] 2 locks held by G.Main/3575:
> [  339.063101]  #0: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>] rt_down_read+0x10/0x20
> [  339.063108]  #1: (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc087b7b0>] ttm_bo_vm_fault+0x60/0x530 [ttm]

These two are suspicious, though.  Note that what it claimed is that
&rdev->pm.mclk_lock is acquired by both threads.  However:

> [  339.063124]
> [  339.063125] =============================================
> [  339.063125]
> [  363.523950] INFO: task Xorg:2365 blocked for more than 120 seconds.
> [  363.523959]       Not tainted 4.9.13-rt10 #1
> [  363.523961] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.523964] Xorg            D    0 2365   2363 0x00000004
> [  363.523970]  0000000000000000 ffff96333582b458 ffff9633027bd580 ffff96333582b440
> [  363.523975]  ffff96332f2b1c80 ffffba8646bffa50 ffffffff87af622f 00ffba8646bffb08
> [  363.523980]  ffff9633027bdbc0 ffff96333582b458 ffff96332841b800 ffff9633027bd580
> [  363.523984] Call Trace:
> [  363.523984] Call Trace:
> [  363.523992]  [<ffffffff87af622f>] ?  __schedule+0x32f/0x800
> [  363.523996]  [<ffffffff87af674c>] schedule+0x4c/0xe0
> [  363.523998]  [<ffffffff87af8146>] __rt_mutex_slowlock+0x56/0x1c0
> [  363.524001]  [<ffffffff87af8834>] rt_mutex_slowlock+0x114/0x360
> [  363.524005]  [<ffffffff87665615>] ?  get_empty_filp+0x175/0x250
> [  363.524007]  [<ffffffff87af8a9a>] rt_mutex_lock+0x1a/0x20
> [  363.524011]  [<ffffffff874f36e3>] __rt_down_read+0x53/0x70
> [  363.524014]  [<ffffffff874f3710>] ?  rt_down_read+0x10/0x20
> [  363.524016]  [<ffffffff874f3710>] rt_down_read+0x10/0x20
> [  363.524043]  [<ffffffffc0ae7d97>] radeon_bo_create+0x157/0x360 [radeon]
> [  363.524064]  [<ffffffffc0afb21d>] radeon_gem_object_create+0xbd/0x1a0 [radeon]
> [  363.524084]  [<ffffffffc0afb6ae>] radeon_gem_create_ioctl+0x6e/0x100 [radeon]
> [  363.524101]  [<ffffffffc081ef6a>] drm_ioctl+0x37a/0x4d0 [drm]
> [  363.524119]  [<ffffffffc0afb640>] ?  radeon_gem_pwrite_ioctl+0x30/0x30 [radeon]
> [  363.524122]  [<ffffffff877de437>] ?  debug_smp_processor_id+0x17/0x20
> [  363.524125]  [<ffffffff8748d8f6>] ?  unpin_current_cpu+0x16/0x70
> [  363.524128]  [<ffffffff874bce47>] ?  migrate_enable+0x87/0x150
> [  363.524131]  [<ffffffff87afb18f>] ?  rt_spin_unlock+0x2f/0x40
> [  363.524145]  [<ffffffffc0ac804f>] radeon_drm_ioctl+0x4f/0x90 [radeon]
> [  363.524148]  [<ffffffff87679fd3>] do_vfs_ioctl+0xa3/0x6f0
> [  363.524152]  [<ffffffff8768789c>] ?  __fget+0x11c/0x210
> [  363.524154]  [<ffffffff87687785>] ?  __fget+0x5/0x210
> [  363.524157]  [<ffffffff8767a699>] SyS_ioctl+0x79/0x90
> [  363.524159]  [<ffffffff87afb845>] system_call_fast_compare_end+0xc/0xaf

It appears that Xorg hasn't actually acquired the rwsem's underlying
rt_mutex, but is in the process of acquiring it, but is suspended
waiting on G.Main/3575 to release it.

> [  363.524263] 2 locks held by G.Main/3575:
> [  363.524264]  #0: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffff874f3710>] rt_down_read+0x10/0x20
> [  363.524270]  #1: (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc087b7b0>] ttm_bo_vm_fault+0x60/0x530 [ttm]

So, the question is: what is this G.Main/3575 thread, and what is it
doing?  Do you find it spinning?

Could be something fishy with w/w mutexes as well.

   Julia

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli9nX4ACgkQjNrC4UVN
dG+4GwgAkp+T8K5pJgfCEWvxTBAsv1YxARegQn96WofVS9QdIOOT9PhqP9yTDHLC
w/2jBzbm8ZGxuk9lHLjshfwVCxbxD/VQdImI/ktRnrCZRYvtiy4VPDgR/hiu4EhY
xjNM8qAQVyul6qFLtTavSuuViSO6zSd1F7hUM8jjZsZC+m5B5sJmDccx45OpmnSy
fTsvewtJu22un3x1dioSjYysgrEa1otkchLYL2fQNipZ5hoQzn++EZdg3i6ZEcpU
ocBoKhwk5YOHzYtgaSp0lywwbaVazWayWmYfWZ9itWyK4as5iaTM8eQZ5frOJB30
/lmJ883iiTgGvO3LFGXPFOfUZyeIsg==
=5/Rh
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--
