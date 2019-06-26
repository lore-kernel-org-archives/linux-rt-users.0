Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AD3C48BD6
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 11:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC192080C
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 11:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZLZu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:25:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47032 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZLZu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 07:25:50 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1hg63g-0005uH-1J; Wed, 26 Jun 2019 13:25:48 +0200
Date:   Wed, 26 Jun 2019 13:25:47 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: Use gettid from rt-utils.c everywhere
Message-ID: <20190626112547.rhqgypbepi7mxlth@linutronix.de>
References: <20190626110838.7800-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dqh555zs3s6uiucx"
Content-Disposition: inline
In-Reply-To: <20190626110838.7800-1-jkacur@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--dqh555zs3s6uiucx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jun 26, 2019 at 01:08:38PM +0200, John Kacur wrote:
> gettid is defined in rt-utils, so we should use that everywhere instead
> of defining a separate macro in each test for it.

looks good to me.

Thanks,
Kurt

--dqh555zs3s6uiucx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl0TVjsACgkQeSpbgcuY
8Kb+3w/+MSrvTtMUwrjTK8/kqKzjUpF6LgtVit1HYSasX6OnYeeXsp6BCDw9YHwq
eYMrexmPAJWEJgHYwZ6K00WevxaI49t3kESjEGR4+IhXqNogN7VQK2u5K0LXHPLK
sTpuLHiOPoi4KQnYVonIlJNh2zsT+ysci6gGhumPqxbp57Ma7Nl2PN8MptLHG92P
NQ4etOnns27kohL//LANTFlLdxFYzECTubtW72UijzGEWP1iN+Z0ssn7W+WOgQi9
frCxQEbF33J5Kb6fWRM0RQeDKoEUO1293/1OUu9iSkCICsv0gAhXWb9QxISjkCVe
tNcavtCgpEPR+6+FFb1GuCQIxj5227vYWbipGmnJ+scfacgtk2CfjtMouwCo0043
7Wxv/khrC9+ypYOAj1SzdlKWlsVFHh/7ewCazywHj57fg7Ke1hmVlZfiQ5gwsCBk
KDmp2+dzk2NmXNlS+yx75Rh64Gk1MQJX35O2fxZRCvDbwgIIWLVdeccLFp6s6SUk
2q9JTO8mOcq+9HYcIDVOdWvhXNESHchF4Q23/E5NngAR9UNjErHOBDO7rQbihyKk
XXD0UTY4PEDev/i4QOu6R0WoWN4sBqgtBmSwpCsVaJVRFatc2uWJz+VqFpJ4CeHu
BhyKIftx1mOCLOzPnCguZ890QOyC4n3o8dyeNT+SmdklCnYa0+g=
=dgBn
-----END PGP SIGNATURE-----

--dqh555zs3s6uiucx--
