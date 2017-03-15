From: Julia Cartwright <julia@ni.com>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Wed, 15 Mar 2017 14:20:49 -0500
Message-ID: <20170315192049.GA32688@jcartwri.amer.corp.natinst.com>
References: <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
 <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        <linux-rt-users@vger.kernel.org>
To: Wargreen <wargreen@lebib.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:33036 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750877AbdCOTVC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Mar 2017 15:21:02 -0400
Content-Disposition: inline
In-Reply-To: <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 06:51:27PM +0100, Wargreen wrote:
> Do you think i should send an issue to DRM/Radeon ?

More eyes certainly wouldn't hurt.

> On 07/03/2017 19:41, Wargreen wrote:
> > Sorry, i'm more a user than a debugger...
> >
> > So, the /proc/[PID]/stack output, with a gnome_shell:
> > [<ffffffffc0b37e9f>] radeon_fence_default_wait+0xbf/0x170 [radeon]
> > [<ffffffffae34227d>] fence_wait_timeout+0x9d/0x350
> > [<ffffffffc0a2dba5>] ttm_bo_vm_fault+0x455/0x530 [ttm]
> > [<ffffffffc0b39e27>] radeon_ttm_fault+0x47/0x70 [radeon]
> > [<ffffffffae00f9d1>] __do_fault+0x81/0x170
> > [<ffffffffae01377b>] handle_mm_fault+0x57b/0x1450
> > [<ffffffffade70459>] __do_page_fault+0x289/0x5d0
> > [<ffffffffade707c2>] do_page_fault+0x22/0x30
> > [<ffffffffae4fccf8>] page_fault+0x28/0x30
> > [<ffffffffffffffff>] 0xffffffffffffffff
> >
> > And the corresponding locks :
> > Mar  7 19:15:49 LaChoze kernel: [  239.624948] NOHZ:
> > local_softirq_pending 80
> > Mar  7 19:15:57 LaChoze kernel: [  247.718336] sysrq: SysRq : Show Locks
> > Held
> > Mar  7 19:15:57 LaChoze kernel: [  247.718342]
> > Mar  7 19:15:57 LaChoze kernel: [  247.718342] Showing all locks held in
> > the system:
> > Mar  7 19:15:57 LaChoze kernel: [  247.718371] 5 locks held by
> > irq/1-i8042/126:
> > Mar  7 19:15:57 LaChoze kernel: [  247.718372]  #0:=20
> > (&serio->lock){+.+...}, at: [<ffffffffae34dab8>] serio_interrupt+0x28/0=
x80
> > Mar  7 19:15:57 LaChoze kernel: [  247.718378]  #1:=20
> > (&dev->event_lock){+.+...}, at: [<ffffffffae353cba>] input_event+0x3a/0=
x60
> > Mar  7 19:15:57 LaChoze kernel: [  247.718382]  #2:=20
> > (rcu_read_lock){......}, at: [<ffffffffae352ee5>]
> > input_pass_values.part.5+0x5/0x270
> > Mar  7 19:15:57 LaChoze kernel: [  247.718385]  #3:=20
> > (rcu_read_lock){......}, at: [<ffffffffae2c1eb5>] __handle_sysrq+0x5/0x=
220
> > Mar  7 19:15:57 LaChoze kernel: [  247.718389]  #4:=20
> > (tasklist_lock){+.+...}, at: [<ffffffffadeeae1d>]
> > debug_show_all_locks+0x3d/0x1a0
> > Mar  7 19:15:57 LaChoze kernel: [  247.718412] 1 lock held by in:imklog=
/895:
> > Mar  7 19:15:57 LaChoze kernel: [  247.718412]  #0:=20
> > (&f->f_pos_lock){+.+.+.}, at: [<ffffffffae08883a>] __fdget_pos+0x4a/0x50
> > Mar  7 19:15:57 LaChoze kernel: [  247.718435] 2 locks held by Xorg/221=
5:
> > Mar  7 19:15:57 LaChoze kernel: [  247.718435]  #0:=20
> > (&rdev->exclusive_lock){++++.+}, at: [<ffffffffadef3710>]
> > rt_down_read+0x10/0x20
> > Mar  7 19:15:57 LaChoze kernel: [  247.718439]  #1:=20
> > (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffadef3710>]
> > rt_down_read+0x10/0x20
> > Mar  7 19:15:57 LaChoze kernel: [  247.718452] 2 locks held by
> > gnome-shell/2412:
> > Mar  7 19:15:57 LaChoze kernel: [  247.718453]  #0:=20
> > (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffadef3710>]
> > rt_down_read+0x10/0x20
> > Mar  7 19:15:57 LaChoze kernel: [  247.718456]  #1:=20
> > (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc0a2d7b0>]
> > ttm_bo_vm_fault+0x60/0x530 [ttm]
> > Mar  7 19:15:57 LaChoze kernel: [  247.718487]
> > Mar  7 19:15:57 LaChoze kernel: [  247.718487]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hmm, there is nothing obviously wrong here, or at least nothing that
sticks out to me.  I see that there are a few fence tracepoints that the
kernel has made available, perhaps you can run an execution in the
working case with those tracepoints enabled (and probably sched/ irq/
events as well), and compare them to a test run where it fails.

Beyond that, you might have to get help from folks more familiar with
this particular driver :(.

   Julia

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAljJlA0ACgkQjNrC4UVN
dG+6fAgAhfBwgjdZGzDOW94x+viTyiWw22Hp0FQAdlkpXIfAPUIIgBXxwiZ9EYte
CHBNXmsa7wNIgcuw4fd/6qfA94gLl61/O20VqGOjqL7fUZrdJupV8pLGhfln/YFg
+bHg4HoV+M1p6CRhBfS99jc8Uj6BajcEVWIstp8dSUeZtEX4vItB/0OkSzI3lHQu
iakpCDjcPzSFNiWnLp2isUn5D/3kkiKuXpUxEDYzb+TorpV1JsqMeJkNtKUq+IzY
1qt2xBXUtpGWc/VhNFVEG9ItMikYle85D6yyn9b0181OOTZ2F8WHtnZ+/h/nhgue
kdMQwEEoPFRsMyEphgcJtGaeGQIhOg==
=8W59
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
