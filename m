From: Wargreen <wargreen@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Fri, 10 Mar 2017 18:51:27 +0100
Message-ID: <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dg88ILsUg0AtckHadwKFnmvrPlPtAXXsv"
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:46725 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755028AbdCJRv4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 12:51:56 -0500
In-Reply-To: <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dg88ILsUg0AtckHadwKFnmvrPlPtAXXsv
Content-Type: multipart/mixed; boundary="PKONcBJ60ewRepvaW0c7WK9ljcqkS5lwN";
 protected-headers="v1"
From: Wargreen <wargreen@lebib.org>
To: Julia Cartwright <julia@ni.com>
Cc: Daniel Vidal <danielvidalchornet@gmail.com>,
 Pankaj Gupta <pagupta@redhat.com>, linux-rt-users@vger.kernel.org
Message-ID: <fb9e1287-7042-9b46-1730-1e622eac99cc@lebib.org>
Subject: Re: Radeon driver hang with 4.9.0-rt
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
 <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
 <c5ac6b81-6b61-2923-afc7-c594a5ab34bb@lebib.org>
 <20170306173353.GJ29100@jcartwri.amer.corp.natinst.com>
 <26d68eb9-746d-26ae-cbfe-28a8b4e5a3e6@lebib.org>
 <20170306190707.GL29100@jcartwri.amer.corp.natinst.com>
 <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>
In-Reply-To: <e1193ceb-af77-b561-5b84-c08915e7859e@lebib.org>

--PKONcBJ60ewRepvaW0c7WK9ljcqkS5lwN
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Do you think i should send an issue to DRM/Radeon ?

Thanks for your help !


On 07/03/2017 19:41, Wargreen wrote:
> Sorry, i'm more a user than a debugger...
>
> So, the /proc/[PID]/stack output, with a gnome_shell:
> [<ffffffffc0b37e9f>] radeon_fence_default_wait+0xbf/0x170 [radeon]
> [<ffffffffae34227d>] fence_wait_timeout+0x9d/0x350
> [<ffffffffc0a2dba5>] ttm_bo_vm_fault+0x455/0x530 [ttm]
> [<ffffffffc0b39e27>] radeon_ttm_fault+0x47/0x70 [radeon]
> [<ffffffffae00f9d1>] __do_fault+0x81/0x170
> [<ffffffffae01377b>] handle_mm_fault+0x57b/0x1450
> [<ffffffffade70459>] __do_page_fault+0x289/0x5d0
> [<ffffffffade707c2>] do_page_fault+0x22/0x30
> [<ffffffffae4fccf8>] page_fault+0x28/0x30
> [<ffffffffffffffff>] 0xffffffffffffffff
>
> And the corresponding locks :
> Mar  7 19:15:49 LaChoze kernel: [  239.624948] NOHZ:
> local_softirq_pending 80
> Mar  7 19:15:57 LaChoze kernel: [  247.718336] sysrq: SysRq : Show Lock=
s
> Held
> Mar  7 19:15:57 LaChoze kernel: [  247.718342]
> Mar  7 19:15:57 LaChoze kernel: [  247.718342] Showing all locks held i=
n
> the system:
> Mar  7 19:15:57 LaChoze kernel: [  247.718371] 5 locks held by
> irq/1-i8042/126:
> Mar  7 19:15:57 LaChoze kernel: [  247.718372]  #0:=20
> (&serio->lock){+.+...}, at: [<ffffffffae34dab8>] serio_interrupt+0x28/0=
x80
> Mar  7 19:15:57 LaChoze kernel: [  247.718378]  #1:=20
> (&dev->event_lock){+.+...}, at: [<ffffffffae353cba>] input_event+0x3a/0=
x60
> Mar  7 19:15:57 LaChoze kernel: [  247.718382]  #2:=20
> (rcu_read_lock){......}, at: [<ffffffffae352ee5>]
> input_pass_values.part.5+0x5/0x270
> Mar  7 19:15:57 LaChoze kernel: [  247.718385]  #3:=20
> (rcu_read_lock){......}, at: [<ffffffffae2c1eb5>] __handle_sysrq+0x5/0x=
220
> Mar  7 19:15:57 LaChoze kernel: [  247.718389]  #4:=20
> (tasklist_lock){+.+...}, at: [<ffffffffadeeae1d>]
> debug_show_all_locks+0x3d/0x1a0
> Mar  7 19:15:57 LaChoze kernel: [  247.718412] 1 lock held by in:imklog=
/895:
> Mar  7 19:15:57 LaChoze kernel: [  247.718412]  #0:=20
> (&f->f_pos_lock){+.+.+.}, at: [<ffffffffae08883a>] __fdget_pos+0x4a/0x5=
0
> Mar  7 19:15:57 LaChoze kernel: [  247.718435] 2 locks held by Xorg/221=
5:
> Mar  7 19:15:57 LaChoze kernel: [  247.718435]  #0:=20
> (&rdev->exclusive_lock){++++.+}, at: [<ffffffffadef3710>]
> rt_down_read+0x10/0x20
> Mar  7 19:15:57 LaChoze kernel: [  247.718439]  #1:=20
> (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffadef3710>]
> rt_down_read+0x10/0x20
> Mar  7 19:15:57 LaChoze kernel: [  247.718452] 2 locks held by
> gnome-shell/2412:
> Mar  7 19:15:57 LaChoze kernel: [  247.718453]  #0:=20
> (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffadef3710>]
> rt_down_read+0x10/0x20
> Mar  7 19:15:57 LaChoze kernel: [  247.718456]  #1:=20
> (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffc0a2d7b0>]
> ttm_bo_vm_fault+0x60/0x530 [ttm]
> Mar  7 19:15:57 LaChoze kernel: [  247.718487]
> Mar  7 19:15:57 LaChoze kernel: [  247.718487]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> If needeed, all theres logs are here :
> http://kalaj.darktech.org/~wargreen/logs/radeon/
> I'm here for the next step.
>
>
>
> On 06/03/2017 20:07, Julia Cartwright wrote:
>> On Mon, Mar 06, 2017 at 06:59:26PM +0100, Wargreen wrote:
>>> Here a new try, with a process name more explicit, but without X cras=
h
>>> this time.
>>> So it's the graphic's ressources demanding process.
>>>
>>> [  497.053562] 2 locks held by Xorg/2154:
>>> [  497.053563]  #0: (&rdev->exclusive_lock){++++.+}, at: [<ffffffffa9=
0f3710>] rt_down_read+0x10/0x20
>>> [  497.053571]  #1: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa90f=
3710>] rt_down_read+0x10/0x20
>>> [  497.053589] 2 locks held by gnome-shell/2344:
>>> [  497.053590]  #0: (&rdev->pm.mclk_lock){++++++}, at: [<ffffffffa90f=
3710>] rt_down_read+0x10/0x20
>>> [  497.053597]  #1: (reservation_ww_class_mutex){+.+.+.}, at: [<fffff=
fffc0af47b0>] ttm_bo_vm_fault+0x60/0x530 [ttm]
>> Unfortunately, this doesn't get us any more data than we already had.
>> For some reason, a thread (G.Main in the prior trace, gnome-shell here=
)
>> in this state fails to make progress.
>>
>> We need to better understand what this thread is doing.  Is it
>> Runnable/spinning?  Is it itself waiting on a lock?  Dumping the stack=

>> from it in this state might be revealing.  The contents of
>> /proc/<pid>/stack might be of interest.
>>
>>    Julia
>
>



--PKONcBJ60ewRepvaW0c7WK9ljcqkS5lwN--

--dg88ILsUg0AtckHadwKFnmvrPlPtAXXsv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCAAxFiEEhe8tJb5+nGkdrJsqDnSv7tOnn7gFAljC56QTHHdhcmdyZWVu
QGxlYmliLm9yZwAKCRAOdK/u06efuJ27D/4tnq2V92lQgpdK5pFj6ByhLtuoZXXA
P08EpNl/MOL9rQTR+HQM5k8fCayTt5BXfAPrFMcwYn4W75j4EygJ+L/Ej2TMORbn
Xkh+ZQLymGWYLa/wijECG+HUB2J/vWoY/1I/3lxb8o+0mpTB5rR58qb2/jfgvPaC
+NyRW0Rgaq3a20b5HSQ84jUdS+x1ISEb6Cod1m+r1ppKuHXMyVnoEoKjEmRpP6zQ
CUJp1HCcttYY2fl8Qf/yke3NyinrtwXd0IbxnAKEh7P8WTpSqAmejEljvWJHGrHY
C5Ot5wVM6IuiwltVvlMBnUX+0YJUzRZB4RKdbJMGCl483TRxpuFMfZW6JGXr+IIE
29BYm3smy2TQgjIF+K4TlQUhUhQmeh+OFkpreV1diRJo09Udz+uO0QCKofEznOoG
75aU8LMulAK1ctIZeJcWEsFs3Df1wYRJtApeEde1E6JcLNvY3z+bQLLl5N6OxkkD
9UWQGLuFlMnV49DfL2X7sbRlN9nTE+1CoikGqE5FQLOdhP6MNG3T87ORQ9xrghw1
EeGLw16PXDdgiRSRaOqfefzu70RPLMsGjB4r29uKcwoEnFip01pcLAheIPDGrY0Q
Cl/OjUDj6jSCkp3XmnKdxszy6RqD3cKmylWPfYocSlTSpDnmvXCwtDvmVjwz8SJ7
cqfLtiQ2VjAcXQ==
=/WYg
-----END PGP SIGNATURE-----

--dg88ILsUg0AtckHadwKFnmvrPlPtAXXsv--
