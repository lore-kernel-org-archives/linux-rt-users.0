From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH 1/4] pip_stress: drop unused variable
Date: Thu, 17 Mar 2016 09:22:56 -0400
Message-ID: <20160317092256.1f19d9d6@redhat.com>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
	<1456346981-24032-2-git-send-email-lcapitulino@redhat.com>
	<alpine.LFD.2.20.1603162257350.16977@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932614AbcCQNXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 09:23:00 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2B9D164D1E
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 13:23:00 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.20.1603162257350.16977@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 16 Mar 2016 23:00:37 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

>=20
>=20
> On Wed, 24 Feb 2016, Luiz Capitulino wrote:
>=20
> > src/pi_tests/pip_stress.c: In function =E2=80=98main=E2=80=99:
> > src/pi_tests/pip_stress.c:94:6: warning: unused variable =E2=80=98c=
=E2=80=99 [-Wunused-variable]
> >=20
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> > ---
> >  src/pi_tests/pip_stress.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> > index 66b3dc1..812a703 100644
> > --- a/src/pi_tests/pip_stress.c
> > +++ b/src/pi_tests/pip_stress.c
> > @@ -91,7 +91,6 @@ int main(void)
> >  	cpu_set_t set, *setp =3D &set;
> >  	int res;
> >  	int *minimum_priority =3D (int*)&prio_min;
> > -	int c;
> > =20
> >  	*minimum_priority =3D sched_get_priority_min(policy);
> > =20
> > --=20
> > 2.1.0
>=20
> Where are you getting your repo from?
> According to my logs this was already fixed on June 30, 2015
>=20
> The current repo is at
> git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Oh, I'm using:

git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

I'll the series.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
