Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C0C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Apr 2022 19:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiDHTnZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiDHTnU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Apr 2022 15:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FBA830F5D
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Apr 2022 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649446875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+r2OavhXw91FZD52g2EFeGVG67jeLfZPsrzv/VcOHQ=;
        b=LVQovisSNQQCJCRUsUXpNyCp9qX95QVoXNmNjDdliqPBo5vBFlDFIJSbQA3tXrWIkbKX8j
        V7W+h5ecW4p1PDv8ODpjdpknBbvniOzSV0Vopf3O/EipqwktJVxNi9tVm3vQKqKNnahGnP
        LkLT6BbnlwtY2Vs/q0eVrNZ/9HSEjdQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-qZWah2ALOGW-EOuEZ4aq4A-1; Fri, 08 Apr 2022 15:41:12 -0400
X-MC-Unique: qZWah2ALOGW-EOuEZ4aq4A-1
Received: by mail-qt1-f199.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso8462375qtj.6
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Apr 2022 12:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=g+r2OavhXw91FZD52g2EFeGVG67jeLfZPsrzv/VcOHQ=;
        b=icpMTkLmrdfZ2XM4K/H7qy6oP6EjMw0415o+GDZN9XVbi+g3liNPr5+sm0pCHraEmV
         KWtJWTMjiinJtmLDnyCJ2hANc25behpI5NHxa2IEimcErJfOOwZMDGo+LF0lfadnUqSr
         PIvenf3XJk9m5Sj00Fqnah7vQffegNeHp6gb9z4f5mmrs6EfF14amUBarqOL9qMhPrrO
         0pmvPPPpS7ZZEt9rK/Pk+L0Iv2zolp1MvM31wMANVDDxUwX0Fz7lX1GVfHHsvD/0RJq2
         9kWHtezkuK2Xi/NaipI5GcnKkf778g67i8h5x/jPGKdsQOC3hsqmA7++rFzb3MgpH0n6
         pgDg==
X-Gm-Message-State: AOAM532S7m7pWvEWaH+YHaAZ7NooYV8eaXJJ83Jk0XgoNPhvsHXaHQop
        Bb2joM6XwLqBgCbZOgrNoK9tJjfbGOn0jqGE8zbYtmRa6Y4U85bgM8ocjmJWySxpd2vcXUa01zD
        SbIbfzrtH/fPhMbFufKvHUokyZ2g=
X-Received: by 2002:ac8:1191:0:b0:2ed:bb6:ab07 with SMTP id d17-20020ac81191000000b002ed0bb6ab07mr2913109qtj.418.1649446871803;
        Fri, 08 Apr 2022 12:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQnzseGjOpnL2/HOa724jZpaZIAJooPbOrERYPGSyEBZ46L9T97MpbRoastmtZz7d6/wf4+w==
X-Received: by 2002:ac8:1191:0:b0:2ed:bb6:ab07 with SMTP id d17-20020ac81191000000b002ed0bb6ab07mr2913100qtj.418.1649446871554;
        Fri, 08 Apr 2022 12:41:11 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a10b000b0067d82ac1de4sm13715314qkk.114.2022.04.08.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 12:41:11 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:41:10 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Bart Wensley <bwensley@redhat.com>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Subject: Re: [PATCH] rt-tests: Update has_smi_counter
In-Reply-To: <CAGCuPdMz-f=PDETQq5EGrsjdLv1+V+BOx=JVk+oOKkh=RA6C8A@mail.gmail.com>
Message-ID: <b66022d6-67db-a8b3-b23b-391e6ce1f81@redhat.com>
References: <20220407182256.19947-1-jkacur@redhat.com> <CAGCuPdMz-f=PDETQq5EGrsjdLv1+V+BOx=JVk+oOKkh=RA6C8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 7 Apr 2022, Bart Wensley wrote:

> Thanks John for doing this.
> 
> It really is too bad we can't check for SMI counter support at runtime
> instead of having to hardcode the families like this. And I guess
> there is no way to access the constants defined in
> linux/arch/x86/include/asm/intel-family.h? I don't see any devel
> package for that.
> 
> My main comment is that the turbostat.c checks also rely on
> intel_model_duplicates which collapses some of the families before
> probe_nhm_msrs is called. Looking at intel_model_duplicates, I think
> we're still missing some families:
> 
> #define INTEL_FAM6_COMETLAKE 0xA5 /* Sky Lake             */
> #define INTEL_FAM6_COMETLAKE_L 0xA6 /* Sky Lake             */
> #define INTEL_FAM6_ICELAKE_L 0x7E /* Sunny Cove */
> #define INTEL_FAM6_ICELAKE_NNPI 0x9D /* Sunny Cove */
> #define INTEL_FAM6_TIGERLAKE_L 0x8C /* Willow Cove */
> #define INTEL_FAM6_TIGERLAKE 0x8D /* Willow Cove */
> #define INTEL_FAM6_ROCKETLAKE 0xA7 /* Cypress Cove */
> #define INTEL_FAM6_LAKEFIELD 0x8A /* Sunny Cove / Tremont */
> #define INTEL_FAM6_ALDERLAKE 0x97 /* Golden Cove / Gracemont */
> #define INTEL_FAM6_ALDERLAKE_L 0x9A /* Golden Cove / Gracemont */
> #define INTEL_FAM6_ATOM_TREMONT_L 0x9C /* Jasper Lake */
> #define INTEL_FAM6_ICELAKE_D 0x6C /* Sunny Cove */
> #define INTEL_FAM6_SAPPHIRERAPIDS_X 0x8F /* Golden Cove */
> 
> To make this easier to maintain in the future it might be nice to do
> the check in two parts - the first to eliminate the duplicates in the
> same way intel_model_duplicates does it and then the second part to
> check the reduced set (basically the existing switch statement. Maybe
> that's too much?

Seems like a good idea to me. I do take patches if you want to take a stab 
at it before I have time to get around to it.

> 
> Also, might be nice to update all the comments to include the
> constants from intel-family.h (I noticed you didn't update the first
> group in the switch statement).
> 
> Bart
> 
> On Thu, Apr 7, 2022 at 2:23 PM John Kacur <jkacur@redhat.com> wrote:
> >
> > Update has_smi_counter() to include
> >
> > case 0x66:      /* INTEL_FAM6_CANNONLAKE_L, Palm Cove */
> > case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> > case 0x96:      /* INTEL_FAM6_ATOM_TREMONT Elkhart Lake */
> > case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D, Jacobsville */
> >
> > This function is based on probe_nhm_msrs() in file turbostat.c in the
> > linux kernel.
> >
> > This update also reorders the model numbers to more closely match the
> > order in probe_nhm_msrs, and adds comments to match symbolic names for
> > the model numbers.
> >
> > Reported-by: Bart Wensley <bwensley@redhat.com>
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.c | 50 ++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 23 deletions(-)
> >
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index c9ed9e08f6e1..a4979ad81f21 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -440,31 +440,35 @@ static int has_smi_counter(void)
> >         case 0x2C:      /* Westmere EP - Gulftown */
> >         case 0x2E:      /* Nehalem-EX Xeon - Beckton */
> >         case 0x2F:      /* Westmere-EX Xeon - Eagleton */
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
> > +       case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE, SNB */
> > +       case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X, SNB Xeon */
> > +       case 0x3A:      /* INTEL_FAM6_IVYBRIDGE, IVB */
> > +       case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X, IVB Xeon */
> > +       case 0x3C:      /* INTEL_FAM6_HASWELL, HSW */
> > +       case 0x46:      /* INTEL_FAM6_HASWELL_G, HSW */
> > +       case 0x3F:      /* INTEL_FAM6_HASWELL_X, HSX */
> > +       case 0x45:      /* INTEL_FAM6_HASWELL_L, HSW */
> > +       case 0x3D:      /* INTEL_FAM6_BROADWELL, BDW */
> > +       case 0x47:      /* INTEL_FAM6_BROADWELL_G, BDW */
> > +       case 0x4F:      /* INTEL_FAM6_BROADWELL_X, BDX */
> > +       case 0x56:      /* INTEL_FAM6_BROADWELL_D, BDX-DE */
> > +       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L SKL */
> > +       case 0x66:      /* INTEL_FAM6_CANNONLAKE_L, Palm Cove */
> > +       case 0x55:      /* INTEL_FAM6_SKYLAKE_X, SKX */
> > +       case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> > +       case 0x5E:      /* INTEL_FAM6_SKYLAKE, SKL */
> >         case 0x8E:      /* KBL */
> >         case 0x9E:      /* KBL */
> > -       case 0x55:      /* SKX */
> > -       case 0x37:      /* BYT */
> > -       case 0x4D:      /* AVN */
> > -       case 0x4C:      /* AMT */
> > -       case 0x57:      /* PHI */
> > -       case 0x5C:      /* BXT */
> > -       case 0x5F:      /* DNV */
> > -       case 0x7A:      /* Gemini Lake */
> > -       case 0x85:      /* Knights Mill */
> > +       case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT, BYT */
> > +       case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D, AVN */
> > +       case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT, AMT */
> > +       case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL, PHI */
> > +       case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT, BXT, Apollo Lake */
> > +       case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS, Gemini Lake */
> > +       case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D, DNV, Denverton */
> > +       case 0x96:      /* INTEL_FAM6_ATOM_TREMONT Elkhart Lake */
> > +       case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D, Jacobsville */
> > +       case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM, Knights Mill */
> >                 break;
> >         default:
> >                 return 0;
> > --
> > 2.35.1
> >
> 
> 

