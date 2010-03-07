From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/2] do-not-allow-prio-less-than-one-in-cyclictest.patch
Date: Sun, 7 Mar 2010 23:37:29 +0100
Message-ID: <520f0cf11003071437p13cda9f9n1dba8d01ad33aedd@mail.gmail.com>
References: <20100307203955.895980022@osadl.org>
	 <20100307204241.033320249@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:64188 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab0CGWhb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 17:37:31 -0500
Received: by ewy20 with SMTP id 20so1293912ewy.1
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 14:37:30 -0800 (PST)
In-Reply-To: <20100307204241.033320249@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Mar 7, 2010 at 9:39 PM, Carsten Emde <C.Emde@osadl.org> wrote:
> If not in SMP testing mode, the priority may go below 1, if the speci=
fied
> priority is lower than the number of threads, e.g.
> # cyclictest -p2 -t3
> T: 0 (21970) P: 2 [..]
> T: 1 (21971) P: 1 [..]
> T: 2 (21972) P: 0 [..]
>
> Do not allow priority to go below 1.
>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
> Index: rt-tests/src/cyclictest/cyclictest.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- rt-tests.orig/src/cyclictest/cyclictest.c
> +++ rt-tests/src/cyclictest/cyclictest.c
> @@ -1304,7 +1304,7 @@ int main(int argc, char **argv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0par->prio =3D priority;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!sameprio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (priority > 1 && !sameprio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priority--;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =A0 =A0 =A0(priority && policy <=3D=
 1) par->policy =3D SCHED_FIFO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (priority && policy =3D=3D 2)=
 par->policy =3D SCHED_RR;
>
> --

I'm not sure about this, why not allow a priority below 1? The code
below properly sets the third thead to SCHED_OTHER.
I could imagine wanting to test that too. If you don't want to go
below 1 then just set a higher prio, p3 in the scenario you
showed.

Thanks.
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
