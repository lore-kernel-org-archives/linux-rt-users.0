Return-Path: <SRS0=J2Xz=SG=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B8C4360F
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2736B20882
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Apr 2019 15:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfDDPUA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:20:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45540 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfDDPUA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Apr 2019 11:20:00 -0400
Received: from [5.158.153.52] (helo=linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt.kanzenbach@linutronix.de>)
        id 1hC49m-0004iT-EL; Thu, 04 Apr 2019 17:19:58 +0200
Date:   Thu, 4 Apr 2019 17:19:58 +0200
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4/4] rt-tests: deadline_test: add missing frees
Message-ID: <20190404151958.xdo66ytsvpklaqa2@linutronix.de>
References: <20190404134814.13376-1-kurt@linutronix.de>
 <20190404134814.13376-5-kurt@linutronix.de>
 <alpine.LFD.2.21.1904041712560.11547@planxty>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4o6flwrrac5wjdsc"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1904041712560.11547@planxty>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--4o6flwrrac5wjdsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 04, 2019 at 05:13:51PM +0200, John Kacur wrote:
>
>
> On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:
>
> > The threads and thread data structures are allocated using calloc(). But never
> > free'd. So, free them.
> >
> > While here, remove the if statement for setcpu_buf. Free() is NULL safe.
> >
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> >  src/sched_deadline/deadline_test.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> > index 4826557d0624..69e6fd18b73b 100644
> > --- a/src/sched_deadline/deadline_test.c
> > +++ b/src/sched_deadline/deadline_test.c
> > @@ -2092,8 +2092,9 @@ int main (int argc, char **argv)
> >  		printf("\n");
> >  	}
> >
> > -	if (!setcpu_buf)
> > -		free(setcpu_buf);
> > +	free(thread);
> > +	free(sched_data);
> > +	free(setcpu_buf);
> >
> >  	return 0;
> >  }
> > --
> > 2.11.0
>
> Does this remove your own if statement that I didn't even apply yet?
> :)

No. That's a different binary. My patch was made against cyclicdeadline.

Thanks,
Kurt

--4o6flwrrac5wjdsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAlymIJ0ACgkQeSpbgcuY
8KZmeA/8D4lpc7siNhcoaRBrAVBaBEf3KS+f1gypI9z4ltC2nCuxebLUndEETlcc
JUQHcAkTQzQ6/Wkm3hD91YyfReCXDQ/P0oq0Zuscdqm9yKi/DsKqwbT1Cs6G5/2G
+vPIsMO0oVN1xNHFb62nbnBbB+7DvkXrot4QH0eHDWwo6Be4ByHxLOHKSL9RKdvm
EbyZ1SFmu0FDrpMCnm+FDbEsSbqbSp+4Db7uhuV0+PwsnGZz3woX7x6tzo9zHTHc
eLSEskbz57eKmhfLUqspuSg+/4l/oTtjkRdm3oVkFrOR2BHedNchsA1Yl1M5T2CM
v2vzE75z1MJX7NSjHxjsvCLK6Yjqg4LHLurrLoP6WU9Y9nWN5wLDG0+zukfkszOW
W2lo/SgcpclNvtLgJqVvQt6fUqS+zfxdxyQ5TYAPkiAU9856lnZRdzzC5e1dYtEO
yl9zvRZ7OnoXYkTRPu1cufMJOWmSejnnDql5IhAan0NqSC5VeynhZhk2+2uLPTNb
OalfkjLvz4HVPJd7XpUuh4r+gP3VuLXrqtcLNUZ/ZahjL+KQPlS9IYx4WWnG7zqY
4REubXp+w0vBGXciwU+Y3PEfLhk2SugbktLlbVaU5uIxHy014HRjSyVAyvnMpK4v
W+igHgN608pFAES+OJrqaRd8FLEtkcAEBR4BSaLKUYnigH1uY/0=
=ZJrb
-----END PGP SIGNATURE-----

--4o6flwrrac5wjdsc--
