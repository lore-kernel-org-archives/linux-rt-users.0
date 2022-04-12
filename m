Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2439FC433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Apr 2022 19:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiDLT4p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiDLTzc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Apr 2022 15:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4C6C70058
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649792921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6C0bV0LZ+z7dCeMp95Z4bl7XDSs1aNaHVEIPnxdwSo0=;
        b=PPVC2bAEmCfYgenlH2lyKdtWXVc/G1wq0cgIOE/arcewXsJzMBO3sfxkCPQ0YjhGNjG5YV
        XcXCkjMZCbgXZvKYde4cznImNaTVWlotAJY3mbD1wmf+RM1tkJ04Eun1+nzG2mX13Afgsa
        oHOuQ3wyWUouweBfFWG1cY2elxd4wCQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-tGhBFO2kM2S9EbSXDnuL5Q-1; Tue, 12 Apr 2022 15:48:40 -0400
X-MC-Unique: tGhBFO2kM2S9EbSXDnuL5Q-1
Received: by mail-ej1-f72.google.com with SMTP id dp12-20020a170906c14c00b006e7e8234ae2so3440074ejc.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 12:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6C0bV0LZ+z7dCeMp95Z4bl7XDSs1aNaHVEIPnxdwSo0=;
        b=DFY+ESgggDSahBXsU3CjhAen7kbO++KKZ+KeUE9z/cEtp80/0bXtP2Mex0lDUIV7zj
         tEj7df0weilIoqtkltequ8ZgceAVsgQVZZDsmzLqEZchy6qfzbiG5rke7XE5tYtWDUu3
         sI39fZ1xXMEJkE5OtLvn4VgmK8aGPo2vOUfGHPLlnN0v6og9oCMmZVVDBPgltpjQ2DFr
         jujkIPn6dP+IEhzKSaHCgb+35hA5xen615Nkh3KyiPhcxN/zqgdDwlxBTyFFS2HbPqXz
         rduJRzOKPRxLrfSH6kVicit34O6xxtBae82VX4xj1rUbTHCVvpXEhUzLckfo9OkHt8//
         YfCQ==
X-Gm-Message-State: AOAM531QPyC3OYtIjA+5T3hV+LhJWErsh8QP23ikxqIVD7K8i77xF49l
        nF7OT+ruPSOL8WM4f4zyo6FGvNKeFyhilRQeK1Eb2Vnk1pUKh/QOddQDjpmrJnxSi29kRv/Az/o
        48N1Ly3yffs2NVCkumxSS2t+Jo0wMJ5utU27/X9ULiqo=
X-Received: by 2002:a17:906:714:b0:6e8:7f57:2d4e with SMTP id y20-20020a170906071400b006e87f572d4emr13071599ejb.575.1649792919031;
        Tue, 12 Apr 2022 12:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV07Tabe2X5m8i618H54z5MuEBqspoJshsxo3rtFwSatGDzkAlHdpNSm4OnycE39Ndyel9pHATMVTZhIN6Dsk=
X-Received: by 2002:a17:906:714:b0:6e8:7f57:2d4e with SMTP id
 y20-20020a170906071400b006e87f572d4emr13071593ejb.575.1649792918832; Tue, 12
 Apr 2022 12:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAGCuPdNWM2EBdjuGWMkpskMz5dq5tqUK+YrVLfAOtccTDK6_pQ@mail.gmail.com>
 <a4496ccf-1fb0-3cf2-1080-564b85182d9@redhat.com>
In-Reply-To: <a4496ccf-1fb0-3cf2-1080-564b85182d9@redhat.com>
From:   Bart Wensley <bwensley@redhat.com>
Date:   Tue, 12 Apr 2022 15:48:35 -0400
Message-ID: <CAGCuPdN8P5Y=JgJoVhkpb6Pi-6=Gc-mn7j8sBj6h35Q=syG-9g@mail.gmail.com>
Subject: Re: [PATCH v2] rt-tests: resync has_smi_counter with turbostat code
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John,

Sorry for the trouble - this was my first time submitting a patch to a
mailing list.

I (stupidly) thought I could just generate the patch with "git
format-patch" and then cut/paste it into a text format email.
Unfortunately, gmail decided to insert line breaks and convert the
tabs to spaces, which explains why it won't apply for you.

And yes - the patch was generated against main - not on top of your
original patch.

I will figure out how to submit this with "git send-email" and upload
v3 of the patch for you to review.

Thanks,
Bart

On Tue, Apr 12, 2022 at 2:50 PM John Kacur <jkacur@redhat.com> wrote:
>
>
>
> On Mon, 11 Apr 2022, Bart Wensley wrote:
>
> > Updating has_smi_counter to match most recent turbostat code, in
> > order to support recent cpu models (e.g. Ice Lake).
> >
> > Restructured the code to match the turbostat functions so it will
> > be easier to keep the code in sync in the future.
> >
> > Signed-off-by: bartwensley <bwensley@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 104 +++++++++++++++++++++++++-----------
> >  1 file changed, 73 insertions(+), 31 deletions(-)
> >
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index c9ed9e0..da430dc 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -432,39 +432,81 @@ static int has_smi_counter(void)
> >
> >         model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
> >
> > +       /* Based on intel_model_duplicates */
> >         switch (model) {
> > -       case 0x1A:      /* Core i7, Xeon 5500 series - Bloomfield,
> > Gainstown NHM-EP */
> > -       case 0x1E:      /* Core i7 and i5 Processor - Clarksfield,
> > Lynnfield, Jasper Forest */
> > +       case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
> > +       case 0x1E:      /* INTEL_FAM6_NEHALEM */
> >         case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
> > -       case 0x25:      /* Westmere Client - Clarkdale, Arrandale */
> > -       case 0x2C:      /* Westmere EP - Gulftown */
> > -       case 0x2E:      /* Nehalem-EX Xeon - Beckton */
> > -       case 0x2F:      /* Westmere-EX Xeon - Eagleton */
> > -       case 0x2A:      /* SNB */
> > -       case 0x2D:      /* SNB Xeon */
> > -       case 0x3A:      /* IVB */
> > -       case 0x3E:      /* IVB Xeon */
> > -       case 0x3C:      /* HSW */
> > -       case 0x3F:      /* HSX */
> > -       case 0x45:      /* HSW */
> > -       case 0x46:      /* HSW */
> > -       case 0x3D:      /* BDW */
> > -       case 0x47:      /* BDW */
> > -       case 0x4F:      /* BDX */
> > -       case 0x56:      /* BDX-DE */
> > -       case 0x4E:      /* SKL */
> > -       case 0x5E:      /* SKL */
> > -       case 0x8E:      /* KBL */
> > -       case 0x9E:      /* KBL */
> > -       case 0x55:      /* SKX */
> > -       case 0x37:      /* BYT */
> > -       case 0x4D:      /* AVN */
> > -       case 0x4C:      /* AMT */
> > -       case 0x57:      /* PHI */
> > -       case 0x5C:      /* BXT */
> > -       case 0x5F:      /* DNV */
> > -       case 0x7A:      /* Gemini Lake */
> > -       case 0x85:      /* Knights Mill */
> > +       case 0x25:      /* INTEL_FAM6_WESTMERE */
> > +       case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
> > +               model = 0x1E;      /* INTEL_FAM6_NEHALEM */
> > +               break;
> > +       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> > +       case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
> > +               model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
> > +               break;
> > +       case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
> > +               model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
> > +               break;
> > +       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> > +       case 0x56:      /* INTEL_FAM6_BROADWELL_D */
> > +               model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
> > +               break;
> > +       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> > +       case 0x5E:      /* INTEL_FAM6_SKYLAKE */
> > +       case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
> > +       case 0x9E:      /* INTEL_FAM6_KABYLAKE */
> > +       case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
> > +       case 0xA5:      /* INTEL_FAM6_COMETLAKE */
> > +               model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
> > +               break;
> > +       case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
> > +       case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
> > +       case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
> > +       case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
> > +       case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
> > +       case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
> > +       case 0x97:      /* INTEL_FAM6_ALDERLAKE */
> > +       case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
> > +               model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
> > +               break;
> > +       case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
> > +               model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
> > +               break;
> > +       case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
> > +       case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
> > +               model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
> > +               break;
> > +       }
> > +
> > +       /* Based on probe_nhm_msrs */
> > +       switch (model) {
> > +       case 0x1E:      /* INTEL_FAM6_NEHALEM */
> > +       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> > +       case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
> > +       case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
> > +       case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
> > +       case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
> > +       case 0x3C:      /* INTEL_FAM6_HASWELL */
> > +       case 0x46:      /* INTEL_FAM6_HASWELL_G */
> > +       case 0x3F:      /* INTEL_FAM6_HASWELL_X */
> > +       case 0x45:      /* INTEL_FAM6_HASWELL_L */
> > +       case 0x3D:      /* INTEL_FAM6_BROADWELL */
> > +       case 0x47:      /* INTEL_FAM6_BROADWELL_G */
> > +       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> > +       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> > +       case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
> > +       case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
> > +       case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> > +       case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
> > +       case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
> > +       case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
> > +       case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
> > +       case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
> > +       case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
> > +       case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
> > +       case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
> > +       case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
> >                 break;
> >         default:
> >                 return 0;
> > --
> > 2.35.1
>
> Ok, thanks for working on this, but there are a couple of problems here.
>
> I assume that this patch is against main, and doesn't include the patch I
> already posted, it would be good to let me know. (yes I can figure it out,
> but still)
>
> Also this patch does not apply cleanly. Not sure if this is due to style
> problems or something else. You are getting source from some variation of
> git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
> correct?
>
> Could you run checkpatch.pl from the kernel on this?
> When I run checkpatch on it I get 17 errors and 71 warnings
> Even your signed-off-by seems incorrect.
>
> So please fix all the problems and send a version 3, and then I will
> review it.
>
> Thanks
>
> John
>
>

