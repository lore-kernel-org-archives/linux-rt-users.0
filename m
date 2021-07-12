Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39CC07E99
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jul 2021 10:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BD261006
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jul 2021 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGLKUi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGLKUc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jul 2021 06:20:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701AC0613DD
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jul 2021 03:17:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so11116129wmq.3
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jul 2021 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=H/75+yStl5GZXoIRvQWZvPGZn7Ap8V5j+HajXFzOom0=;
        b=FJpJksHLn+x+DFzs6/Ta1dfqNLhIh4vh/OEubs72N6Mg808DrZvMhdc+WBQb/LevaX
         4b6ie1Xdn+bgnHMPsfuShWQq9++zgsXQEnSdjZwx7TDrRsZO3oZBtQzu47dCTTfmxPQJ
         THo6yj703KGzeBaANHvGaD6H4JqKOB6peFjGdWsIuezc6VhAfh7LWD7tOblqtdrBGPme
         F+QKWcVKhwLcBaukN0YSpANrT/9ywbT3a2oEAVs8rYBd8DBTBJ1g7JtcEQDQojRUuO1J
         ylt0NnqwwqkGb/9ll7Vf8ZX4FfKzA6lc7dFZHf147eHWWePPfeZlphh/YuQw/PFNm2oQ
         iJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=H/75+yStl5GZXoIRvQWZvPGZn7Ap8V5j+HajXFzOom0=;
        b=TZLCNGmKfXLLp6Irz9LxsjCveG+O5ZvaKQ8XBPranR9oskf3//OtVhpLrLxyRteE3l
         uxZbvAql6qP1y3e028TREV7JwryPi7zDIb3B7uqgQ0+z3khvYK881qJEPEQ2X221+gk1
         Nt1sh+f013LlhJXUcDT0PQ0P4Y2+7EsGCtmxAqjbu+iqh79fTHbj6JQlE9sIKtnZ5Ug7
         PuyyQkxmiakFLS6aBYvunLufb1ulmddalqF1Li2mJvWTk1oHhHEUQwD2ds15zjyNkjbm
         nM9PD/i7kDDOyPJmgAr1LDD4RsHNNLeCdnx839YGJS1bJjhXsQ64V9SuT715jVIOl/UT
         hX2g==
X-Gm-Message-State: AOAM532OLMmATZf4EsNbypvf9K0372fnP6GHt0LKuxP3KChW3fZXv9rS
        m0OPzpgFfuZeSOoVP2E7Bu8=
X-Google-Smtp-Source: ABdhPJySECm5tx/ClRQZvRsb6Fmi9FWnxgEpO5i3ybRx5G/e1WmQ0nYl7Rc4rSIo6GNCugfqO77DOQ==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr1461733wmk.84.1626085062114;
        Mon, 12 Jul 2021 03:17:42 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id b6sm3060707wmj.34.2021.07.12.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 03:17:41 -0700 (PDT)
Message-ID: <1a630437ca66263d8adf41e11d357514f902cdb4.camel@gmail.com>
Subject: Re: [PATCH 2/2] oslat: Add trace maker prior starting main thread
From:   nicolassaenzj@gmail.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Mon, 12 Jul 2021 12:17:40 +0200
In-Reply-To: <YOiX+lp/PQL136TZ@t490s>
References: <20210709155414.610308-1-nsaenzju@redhat.com>
         <20210709155414.610308-2-nsaenzju@redhat.com> <YOiX+lp/PQL136TZ@t490s>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-THPczI0S/oP1dkUNMp4N"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--=-THPczI0S/oP1dkUNMp4N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Fri, 2021-07-09 at 14:39 -0400, Peter Xu wrote:
> On Fri, Jul 09, 2021 at 05:54:14PM +0200, Nicolas Saenz Julienne wrote:
> > After a long tracing session it's sometimes hard to find the moment
> > oslat started. So leave a message in the trace buffer just before the
> > main thread starts.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > ---
> >  src/oslat/oslat.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> > index d35be57..20bf02b 100644
> > --- a/src/oslat/oslat.c
> > +++ b/src/oslat/oslat.c
> > @@ -400,6 +400,10 @@ static void *thread_main(void *arg)
> >  	while (g.n_threads_running !=3D g.n_threads)
> >  		relax();
> > =20
> > +	if (!g.preheat)
> > +		tracemark(false, "%s: Starting thread on CPU %d.\n",
> > +			  g.app_name, t->core_i);
> > +
> >  	frc(&t->frc_start);
> >  	doit(t);
> >  	frc(&t->frc_stop);
> > --=20
> > 2.31.1
> >=20
>=20
> Not sure how it would help.. but no objection either. :)

For example, I tend to enable all trace points on Isolated CPUs. It's
manageable, since once oslat runs you shouldn't be getting much action. But=
 you
get 10s/100s MBs of noise generated while oslat is being initialized. This
makes finding the beginning of the test very annoying and time consuming.

> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

--=-THPczI0S/oP1dkUNMp4N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmDsFsQACgkQlfZmHno8
x/5xTQf9EQs2X1zsyerQ/Jt9wp5t21CHFoC4i1RorgzgIZrG5Ldwx+GEnAX7i1Yt
sLtwhCUoLdEgCqdoiKT+0GghokzIUfgCtJLij0mkH2Rti8UMexc04FGLiqQJKi26
xmuyCX+Z2VsqD3Fy97+0uioewR150CHoh+wDrBLY8OHzhEKqhuIL6lMvk1iwPkvB
Ecit1pOsTb0RbhQJDsY2W/EM1NWflwhu+5pW6v6zHIVJmTm1ThVscLPET5bmqM+e
JUeM+wxSUImit4WEeJ7UqHiAF6ZTJQcA7PpH4ERujf7hfwtsh0uw1eCE3WJrbNC1
b8Nvefg2WJi8BOB63b3kIV2xTKSMHQ==
=IgUl
-----END PGP SIGNATURE-----

--=-THPczI0S/oP1dkUNMp4N--

