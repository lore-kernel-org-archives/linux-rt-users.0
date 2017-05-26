From: Clark Williams <williams@redhat.com>
Subject: cyclictest usage
Date: Fri, 26 May 2017 11:25:02 -0500
Message-ID: <20170526112502.4f6a49ac@tagon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ABLNa5VFeN029LeGulWHdn/"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbdEZQZG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 May 2017 12:25:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFE3D80074
        for <linux-rt-users@vger.kernel.org>; Fri, 26 May 2017 16:25:05 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/ABLNa5VFeN029LeGulWHdn/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I was gently reminded at the Linux Foundation RT board meeting that I had b=
een tasked with sending out an email, soliciting people's use-cases for run=
ning cyclictest on RT kernels and to announce that we're looking at doing a=
 rewrite to cyclictest 2.0. Herein is that email (better late than never).=
=20

What we're looking for is how people are using cyclictest. For example, at =
Red Hat we use the 'rteval' tool, which puts a large SCHED_OTHER load on th=
e system and then runs cyclictest with a measurement thread on each core. T=
he intent is to put a large load on the scheduler and prove that the RT pat=
chset provides deterministic performance under load.=20

What other types of testing/measurement are people doing with cyclictest?

John Kacur and I are wanting to clean up tracing and make sure that the mos=
t commonly used options are on by default. In addition we want to refactor =
some of the runtime logic. Are there other areas that need to be cleaned up=
? Features that need to be added/deleted?

Thanks,

Clark

--=20
The United States Coast Guard
Ruining Natural Selection since 1790

--Sig_/ABLNa5VFeN029LeGulWHdn/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZKFbeAAoJEBO1XdB8U7hRACQP/2gKWm++njx02fL8p7FzPoR5
WBOmT66iOGWt+Pqh7YTmj4wJJqgAQZDnyU9bPDsPoIHRtdcjPPx47QUW7q5Ehkro
I8ip25NxjHCqiu0amY+uIWrMDDOfqm6LT7TG5e+z0HcFMwyRPI/Aa94K8Fz3aInP
dudH7QozguGJuY3C13ac+KUr5OPgVpfexIcb4hVhUQsTJx1A7kpfQi/gfalv6BFd
PdlTGy4jMFoo3zQMe8lYjZcVAAhdZz6n46Kxp+dWMBHSDfUkS7oX/uR62ypRXZqi
2mHPKyYfmZGYRVsQIwDN5sBWUGJbtAwrETylKv4diBFq2T2IGqXwrLydt/JbbOzs
iAMLHEYLdTkV7dqyRHnG4BzM5C+AMhQ42PpBjjfVI1gseKmD4diuZKpXgEqnHdAH
WRA4oHrtXBGvBmhbUf8KFa8v+4OXeXSfCZUMGsGE/0RKXh2WoKW8eLM+sXzlPKDA
5fVRegIPQe9rlWaFKvMpVClMikCOKIiA4jO0RTwZWrZXk67EuegFBdWQANiSy+XL
Ut0Ph22UHQ/OBBmgvIQHlFeG6m7CNBykV4Z9jhpPx3VBoObtL0lcvrhZPiK+8hEm
CNSHZj+u8z5a1g9dwTxovof96c8RhwPSKWgVby9zcQd+EgFtiA2YwEIwX1d9ZPYE
tU9doYlKFgibbNJO+reR
=hBFK
-----END PGP SIGNATURE-----

--Sig_/ABLNa5VFeN029LeGulWHdn/--
