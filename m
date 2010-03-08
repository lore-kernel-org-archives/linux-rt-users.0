From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/1] fix-policy-display-for-cyclictest.patch
Date: Mon, 8 Mar 2010 13:46:59 +0100
Message-ID: <520f0cf11003080446y505e3fbdj3c769cfd4c29c175@mail.gmail.com>
References: <20100308083749.529203420@osadl.org>
	 <20100308083945.956980588@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:54960 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0CHMrB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 07:47:01 -0500
Received: by ewy8 with SMTP id 8so28552ewy.28
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Mar 2010 04:46:59 -0800 (PST)
In-Reply-To: <20100308083945.956980588@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 8, 2010 at 9:37 AM, Carsten Emde <C.Emde@osadl.org> wrote:
> If the policy is forced to SCHED_OTHER, since the priority no longer
> fits into the SCHED_FIFO or SCHED_RR range, the policy display of
> cyclictest is somewhat incorrect.
>
> Display all policies.
>
> Also make the variable policystr static; the condition
> "if (!policystr)" is useless, otherwise.
>
> In addition, place the priority logic before decrementing the priorit=
y;
> a priority of 1 is incorrectly made SCHED_OTHER, otherwise.
>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
> Index: rt-tests/src/cyclictest/cyclictest.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rt-tests.orig/src/cyclictest/cyclictest.c
> +++ rt-tests/src/cyclictest/cyclictest.c
> @@ -156,6 +156,7 @@ static int histogram =3D 0;
> =A0static int duration =3D 0;
> =A0static int use_nsecs =3D 0;
> =A0static int refresh_on_max;
> +static int force_sched_other;
>
> =A0static pthread_cond_t refresh_on_max_cond =3D PTHREAD_COND_INITIAL=
IZER;
> =A0static pthread_mutex_t refresh_on_max_lock =3D PTHREAD_MUTEX_INITI=
ALIZER;
> @@ -1295,11 +1296,14 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->prio =3D priority;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priority && (policy =3D=3D SCHED=
_FIFO || policy =3D=3D SCHED_RR))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par->policy =3D policy;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par->policy =3D SCHED_O=
THER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 force_sched_other =3D 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priority && !histogram && !smp && =
!numa)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priority--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (priority && policy =3D=3D SCHED_=
=46IFO) par->policy =3D SCHED_FIFO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (priority && policy =3D=3D S=
CHED_RR) par->policy =3D SCHED_RR;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0par->policy =3D SCHED_OTHER;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->clock =3D clocksources[clocksel];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->mode =3D mode;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->timermode =3D timermode;
> @@ -1330,18 +1334,27 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0while (!shutdown) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char lavg[256];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int fd, len, allstopped =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *policystr =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char *policystr =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char *slash =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char *policystr2;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!policystr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0policystr =3D policyna=
me(policy);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!slash) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (force_sched_other) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slash =3D=
 "/";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policys=
tr2 =3D policyname(SCHED_OTHER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slash =3D=
 policystr2 =3D "";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!verbose && !quiet) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fd =3D open("/proc/loa=
davg", O_RDONLY, 0666);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len =3D read(fd, &lavg=
, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(fd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lavg[len-1] =3D 0x0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("policy: %s: loa=
davg: %s =A0 =A0 =A0 =A0 =A0\n\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0policyst=
r, lavg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("policy: %s%s%s:=
 loadavg: %s =A0 =A0 =A0 =A0 =A0\n\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0policyst=
r, slash, policystr2, lavg);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < num_threads; i++) {
>
> --

Thanks! I like the fifo / other display - that's more correct.
Acked-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
