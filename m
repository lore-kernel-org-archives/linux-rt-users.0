Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF160C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Apr 2022 18:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiDGS6R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347159AbiDGS6N (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Apr 2022 14:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 518E8DBD1A
        for <linux-rt-users@vger.kernel.org>; Thu,  7 Apr 2022 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649357768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwYJ1tfYEAIxUiQ6jWtttv5DsBenUn9oy5Vn+k9D8c0=;
        b=NiRO3KPUG+jZuddqsCw32M++UO0awmxpayfAztvpjXlkfwAu4gYAVjZg6KyNOKZD85fKDa
        8pjoXmccBnWeDhJpyukvzTYOZu9VhJCj09zW1s0aebi9BDhbr3u7lZTgTzXAt/WU070CI2
        xRey8TEJ0aZmZntgp1/+6rc16Kt1TGs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-goTQtmkeOzGXEycomSSRjw-1; Thu, 07 Apr 2022 14:56:07 -0400
X-MC-Unique: goTQtmkeOzGXEycomSSRjw-1
Received: by mail-ej1-f70.google.com with SMTP id sc14-20020a1709078a0e00b006e773507c0cso3579871ejc.10
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Apr 2022 11:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwYJ1tfYEAIxUiQ6jWtttv5DsBenUn9oy5Vn+k9D8c0=;
        b=ApgVnL9v5CY7OIIu2DYAZ4XRsIK+XuXvQHoAtWBQfoUhV30NyeQ0X8NeeF090aGS3r
         pWbgxSE/eQo346FhFPcYE9VcC2ypRgrzAJ028zWGtpmREhD4fKagFbPkmVHqWF+lg6Ct
         LLc0wu44TFnDRsbtpRvH8VhvubmuW3pIOCDvIz1rc8lRPRkxV4qvhUXTOJ6h1ubZawHs
         Tkah+mNUV4bucw8S2fhdxPYl58ZDxU8tDs+PrO/gl1HX7wIGGXJEqZmnSn4GEobWEiYz
         mBCUBlJBuDMNauaC6uFpW6i7HTyXGiasMLOGDTX40v6ERPMpFdO+V1MBRo6RNIE9rSQf
         IvdQ==
X-Gm-Message-State: AOAM5300VlhZwZkP1Yi4GjwUyWjRmSug741kl+s0tWmf/2iluSOUfX3D
        HJf+jCSh1GeWMBYCR2nmeCxMXoXAy97jimusrKNOzohS81whudpgf3PNT9C6MoIWNe3sUHRDGRL
        l7IVYfiHwkTKlT76M3i43/5FFOaof86eT9xdX+8AR7r4=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id c17-20020a05640227d100b004191b024a04mr15661370ede.218.1649357765861;
        Thu, 07 Apr 2022 11:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbfXdRHFrFS4EcN7BYQ5HnA6ZgtukF7abN/5NIbWjfdJ6PnolFz2sPCmBN7yFY7v9lQJMty5IFJ8QNk1fsyJY=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr15661356ede.218.1649357765675; Thu, 07
 Apr 2022 11:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220407182256.19947-1-jkacur@redhat.com>
In-Reply-To: <20220407182256.19947-1-jkacur@redhat.com>
From:   Bart Wensley <bwensley@redhat.com>
Date:   Thu, 7 Apr 2022 14:55:55 -0400
Message-ID: <CAGCuPdMz-f=PDETQq5EGrsjdLv1+V+BOx=JVk+oOKkh=RA6C8A@mail.gmail.com>
Subject: Re: [PATCH] rt-tests: Update has_smi_counter
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveria <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks John for doing this.

It really is too bad we can't check for SMI counter support at runtime
instead of having to hardcode the families like this. And I guess
there is no way to access the constants defined in
linux/arch/x86/include/asm/intel-family.h? I don't see any devel
package for that.

My main comment is that the turbostat.c checks also rely on
intel_model_duplicates which collapses some of the families before
probe_nhm_msrs is called. Looking at intel_model_duplicates, I think
we're still missing some families:

#define INTEL_FAM6_COMETLAKE 0xA5 /* Sky Lake             */
#define INTEL_FAM6_COMETLAKE_L 0xA6 /* Sky Lake             */
#define INTEL_FAM6_ICELAKE_L 0x7E /* Sunny Cove */
#define INTEL_FAM6_ICELAKE_NNPI 0x9D /* Sunny Cove */
#define INTEL_FAM6_TIGERLAKE_L 0x8C /* Willow Cove */
#define INTEL_FAM6_TIGERLAKE 0x8D /* Willow Cove */
#define INTEL_FAM6_ROCKETLAKE 0xA7 /* Cypress Cove */
#define INTEL_FAM6_LAKEFIELD 0x8A /* Sunny Cove / Tremont */
#define INTEL_FAM6_ALDERLAKE 0x97 /* Golden Cove / Gracemont */
#define INTEL_FAM6_ALDERLAKE_L 0x9A /* Golden Cove / Gracemont */
#define INTEL_FAM6_ATOM_TREMONT_L 0x9C /* Jasper Lake */
#define INTEL_FAM6_ICELAKE_D 0x6C /* Sunny Cove */
#define INTEL_FAM6_SAPPHIRERAPIDS_X 0x8F /* Golden Cove */

To make this easier to maintain in the future it might be nice to do
the check in two parts - the first to eliminate the duplicates in the
same way intel_model_duplicates does it and then the second part to
check the reduced set (basically the existing switch statement. Maybe
that's too much?

Also, might be nice to update all the comments to include the
constants from intel-family.h (I noticed you didn't update the first
group in the switch statement).

Bart

On Thu, Apr 7, 2022 at 2:23 PM John Kacur <jkacur@redhat.com> wrote:
>
> Update has_smi_counter() to include
>
> case 0x66:      /* INTEL_FAM6_CANNONLAKE_L, Palm Cove */
> case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> case 0x96:      /* INTEL_FAM6_ATOM_TREMONT Elkhart Lake */
> case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D, Jacobsville */
>
> This function is based on probe_nhm_msrs() in file turbostat.c in the
> linux kernel.
>
> This update also reorders the model numbers to more closely match the
> order in probe_nhm_msrs, and adds comments to match symbolic names for
> the model numbers.
>
> Reported-by: Bart Wensley <bwensley@redhat.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 50 ++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c9ed9e08f6e1..a4979ad81f21 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -440,31 +440,35 @@ static int has_smi_counter(void)
>         case 0x2C:      /* Westmere EP - Gulftown */
>         case 0x2E:      /* Nehalem-EX Xeon - Beckton */
>         case 0x2F:      /* Westmere-EX Xeon - Eagleton */
> -       case 0x2A:      /* SNB */
> -       case 0x2D:      /* SNB Xeon */
> -       case 0x3A:      /* IVB */
> -       case 0x3E:      /* IVB Xeon */
> -       case 0x3C:      /* HSW */
> -       case 0x3F:      /* HSX */
> -       case 0x45:      /* HSW */
> -       case 0x46:      /* HSW */
> -       case 0x3D:      /* BDW */
> -       case 0x47:      /* BDW */
> -       case 0x4F:      /* BDX */
> -       case 0x56:      /* BDX-DE */
> -       case 0x4E:      /* SKL */
> -       case 0x5E:      /* SKL */
> +       case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE, SNB */
> +       case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X, SNB Xeon */
> +       case 0x3A:      /* INTEL_FAM6_IVYBRIDGE, IVB */
> +       case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X, IVB Xeon */
> +       case 0x3C:      /* INTEL_FAM6_HASWELL, HSW */
> +       case 0x46:      /* INTEL_FAM6_HASWELL_G, HSW */
> +       case 0x3F:      /* INTEL_FAM6_HASWELL_X, HSX */
> +       case 0x45:      /* INTEL_FAM6_HASWELL_L, HSW */
> +       case 0x3D:      /* INTEL_FAM6_BROADWELL, BDW */
> +       case 0x47:      /* INTEL_FAM6_BROADWELL_G, BDW */
> +       case 0x4F:      /* INTEL_FAM6_BROADWELL_X, BDX */
> +       case 0x56:      /* INTEL_FAM6_BROADWELL_D, BDX-DE */
> +       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L SKL */
> +       case 0x66:      /* INTEL_FAM6_CANNONLAKE_L, Palm Cove */
> +       case 0x55:      /* INTEL_FAM6_SKYLAKE_X, SKX */
> +       case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> +       case 0x5E:      /* INTEL_FAM6_SKYLAKE, SKL */
>         case 0x8E:      /* KBL */
>         case 0x9E:      /* KBL */
> -       case 0x55:      /* SKX */
> -       case 0x37:      /* BYT */
> -       case 0x4D:      /* AVN */
> -       case 0x4C:      /* AMT */
> -       case 0x57:      /* PHI */
> -       case 0x5C:      /* BXT */
> -       case 0x5F:      /* DNV */
> -       case 0x7A:      /* Gemini Lake */
> -       case 0x85:      /* Knights Mill */
> +       case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT, BYT */
> +       case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D, AVN */
> +       case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT, AMT */
> +       case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL, PHI */
> +       case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT, BXT, Apollo Lake */
> +       case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS, Gemini Lake */
> +       case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D, DNV, Denverton */
> +       case 0x96:      /* INTEL_FAM6_ATOM_TREMONT Elkhart Lake */
> +       case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D, Jacobsville */
> +       case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM, Knights Mill */
>                 break;
>         default:
>                 return 0;
> --
> 2.35.1
>

