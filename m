From: Morten Mossige <morten.mossige@gmail.com>
Subject: Alarm / timer callback from the kernel
Date: Wed, 10 Oct 2007 17:45:23 +0000 (UTC)
Message-ID: <loom.20071010T171710-319@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50447 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbXJJSQs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2007 14:16:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IffsB-0007Wx-Ln
	for linux-rt-users@vger.kernel.org; Wed, 10 Oct 2007 18:01:31 +0000
Received: from 217.68.101.68 ([217.68.101.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Oct 2007 18:01:31 +0000
Received: from morten.mossige by 217.68.101.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Oct 2007 18:01:31 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I=E2=80=99m porting several huge libraries from other real-time os'es (=
VxWorks, WINCE,=20
DSP/BIOS etc.) to Linux. The job includes porting of a glue-layer betwe=
en=20
Linux and the libraries. This glue-layer is the implementation of:
* clock_ms ()
* int_lock()
* int_unlock()
* mutex_create()
* mutex_give()
* task_create()
etc.
etc.

Each function has a different implementation on each real-time os.

As an ex. the implementation of mutex_create() for vxworks is like this=
:
SEM_ID id =3D semMCreate(SEM_Q_PRIORITY | SEM_INVERSION_SAFE | SEM_DELE=
TE_SAFE);
=09
while on Linux it is like this:

sem_t *semH =3D (sem_t*)malloc( sizeof(sem_t) );
sem_init(semH, 0,init);=20
return (void*)semH;

By using this approach, the libraries can be written independent of OS.

But the functions (which I need) that causes problem for me is the foll=
owing=20
functions:

timer_init( callbackFunc )
and
timer_set( CLOCK_MS timeMs )

The first function (timer_init) is called at startup of my application,=
 and=20
installs a callbackfuction for all timerevents. The second function is =
to arm=20
the timer. When the timer goes off, the callbackfuntion should be calle=
d=20
preferably on a high priority. Some of the other os'es implements this =
as a=20
one-shot-timerinterrupt, so the priority should be quite high.

My first approach to port this to Linux was to use signals and setitime=
r().=20
This worked, but the problem with this solution was that the priority o=
f the=20
callback was the same as the priority of the thread that set up the tim=
er.

My next approach was to use a special high priority timer thread. Whene=
ver a=20
lo-pri thread needs to arm the timer, it signals the high-pri thread to=
 set up=20
the alarm. I have not tested this yet so I don't know how well it will =
work.

But does other have other solutions/suggestions how to solve this?

br. Morten
