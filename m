Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B666C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Apr 2022 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiDLSwZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiDLSwX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Apr 2022 14:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A97045D5CA
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649789400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ae8HX7nTwvX0HpsjyzrmfyzIVhMZxfMCd7W2JmnWCmc=;
        b=DUPBP39X9SdETT3m8EC/5xLhBHTlzDhzWhmTxDNx891d7F5TO6MQ4r6MJCtDw+NsXdZIko
        qjtLn6WlBOwSjbBv3uaNGvznhfyFnPHS+81ziyeg0RztJbXLZdAzMWrDjlVygL16lpMdD6
        OMKUZy+L5TzadrL3ae/NjSZh2lOrqEY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-5qgRjoYzO8-7RFm0SxqnNA-1; Tue, 12 Apr 2022 14:49:59 -0400
X-MC-Unique: 5qgRjoYzO8-7RFm0SxqnNA-1
Received: by mail-qv1-f70.google.com with SMTP id kk19-20020a056214509300b004460dad5312so1347927qvb.23
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 11:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ae8HX7nTwvX0HpsjyzrmfyzIVhMZxfMCd7W2JmnWCmc=;
        b=foE7ONWzGZMAgNypsSoN+aXM8zi5NHtVU7JkD9PT6B9sTWPL7Gp8Qx4GQgpeWLPAAu
         cS0sR+Dh/pXqhnWoK1ossLIgWEgzxSbbGV5SvZ641quGA8w/ObqZd1jBg3FSsZGocOx4
         YmB/EZ5LpuhXIbmwWRQ1d1gkxfNvZ2FZ3Geu3V8gb1R9KlaiihfhNfrbZ9La/I3nFsRB
         jzb+vx+vjmiwyhebXq9vvaZ1x99rL1n5y9p2uabyieQAjb/Lv9BA+px+RV65dIHp4HXD
         fg2bzaBt2Hsph6WWLgcvvfgQ9sf45XJOWMtVb0Lub606bUbsrO2HAeTs4/dkx05+BPex
         Pgyw==
X-Gm-Message-State: AOAM5320/QqCtCGtvTPmU0okKdo44liJaPOej0LucBdZeoI/V76qsgju
        5nM5SFCM4AAOHbbCRUpY2zQVYvr4qzW18yDXgQkPAXMZ1O9K3jMKyRc1aAPIBqrT9UBzJZEj1oF
        EgqTgBgaQwCq9nAebeXlnIp89rCU=
X-Received: by 2002:a05:622a:4006:b0:2eb:dd6f:4f91 with SMTP id cf6-20020a05622a400600b002ebdd6f4f91mr4470493qtb.272.1649789398559;
        Tue, 12 Apr 2022 11:49:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybMoXO7JKkBRZM1lLBxL6UQ/pn/8t4PBFsKPk4VEgkoVVNFxoXifH0OwpVxnE859vbFxD8Ag==
X-Received: by 2002:a05:622a:4006:b0:2eb:dd6f:4f91 with SMTP id cf6-20020a05622a400600b002ebdd6f4f91mr4470482qtb.272.1649789398294;
        Tue, 12 Apr 2022 11:49:58 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id d3-20020a37c403000000b0069c15fcb1bfsm4538920qki.113.2022.04.12.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:49:57 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:49:56 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Bart Wensley <bwensley@redhat.com>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2] rt-tests: resync has_smi_counter with turbostat
 code
In-Reply-To: <CAGCuPdNWM2EBdjuGWMkpskMz5dq5tqUK+YrVLfAOtccTDK6_pQ@mail.gmail.com>
Message-ID: <a4496ccf-1fb0-3cf2-1080-564b85182d9@redhat.com>
References: <CAGCuPdNWM2EBdjuGWMkpskMz5dq5tqUK+YrVLfAOtccTDK6_pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 11 Apr 2022, Bart Wensley wrote:

> Updating has_smi_counter to match most recent turbostat code, in
> order to support recent cpu models (e.g. Ice Lake).
> 
> Restructured the code to match the turbostat functions so it will
> be easier to keep the code in sync in the future.
> 
> Signed-off-by: bartwensley <bwensley@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 104 +++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 31 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c9ed9e0..da430dc 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -432,39 +432,81 @@ static int has_smi_counter(void)
> 
>         model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
> 
> +       /* Based on intel_model_duplicates */
>         switch (model) {
> -       case 0x1A:      /* Core i7, Xeon 5500 series - Bloomfield,
> Gainstown NHM-EP */
> -       case 0x1E:      /* Core i7 and i5 Processor - Clarksfield,
> Lynnfield, Jasper Forest */
> +       case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
> +       case 0x1E:      /* INTEL_FAM6_NEHALEM */
>         case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
> -       case 0x25:      /* Westmere Client - Clarkdale, Arrandale */
> -       case 0x2C:      /* Westmere EP - Gulftown */
> -       case 0x2E:      /* Nehalem-EX Xeon - Beckton */
> -       case 0x2F:      /* Westmere-EX Xeon - Eagleton */
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
> -       case 0x8E:      /* KBL */
> -       case 0x9E:      /* KBL */
> -       case 0x55:      /* SKX */
> -       case 0x37:      /* BYT */
> -       case 0x4D:      /* AVN */
> -       case 0x4C:      /* AMT */
> -       case 0x57:      /* PHI */
> -       case 0x5C:      /* BXT */
> -       case 0x5F:      /* DNV */
> -       case 0x7A:      /* Gemini Lake */
> -       case 0x85:      /* Knights Mill */
> +       case 0x25:      /* INTEL_FAM6_WESTMERE */
> +       case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
> +               model = 0x1E;      /* INTEL_FAM6_NEHALEM */
> +               break;
> +       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> +       case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
> +               model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
> +               break;
> +       case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
> +               model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
> +               break;
> +       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> +       case 0x56:      /* INTEL_FAM6_BROADWELL_D */
> +               model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
> +               break;
> +       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> +       case 0x5E:      /* INTEL_FAM6_SKYLAKE */
> +       case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
> +       case 0x9E:      /* INTEL_FAM6_KABYLAKE */
> +       case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
> +       case 0xA5:      /* INTEL_FAM6_COMETLAKE */
> +               model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
> +               break;
> +       case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
> +       case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
> +       case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
> +       case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
> +       case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
> +       case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
> +       case 0x97:      /* INTEL_FAM6_ALDERLAKE */
> +       case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
> +               model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
> +               break;
> +       case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
> +               model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
> +               break;
> +       case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
> +       case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
> +               model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
> +               break;
> +       }
> +
> +       /* Based on probe_nhm_msrs */
> +       switch (model) {
> +       case 0x1E:      /* INTEL_FAM6_NEHALEM */
> +       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> +       case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
> +       case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
> +       case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
> +       case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
> +       case 0x3C:      /* INTEL_FAM6_HASWELL */
> +       case 0x46:      /* INTEL_FAM6_HASWELL_G */
> +       case 0x3F:      /* INTEL_FAM6_HASWELL_X */
> +       case 0x45:      /* INTEL_FAM6_HASWELL_L */
> +       case 0x3D:      /* INTEL_FAM6_BROADWELL */
> +       case 0x47:      /* INTEL_FAM6_BROADWELL_G */
> +       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> +       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> +       case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
> +       case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
> +       case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> +       case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
> +       case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
> +       case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
> +       case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
> +       case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
> +       case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
> +       case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
> +       case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
> +       case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
>                 break;
>         default:
>                 return 0;
> --
> 2.35.1

Ok, thanks for working on this, but there are a couple of problems here.

I assume that this patch is against main, and doesn't include the patch I 
already posted, it would be good to let me know. (yes I can figure it out, 
but still)

Also this patch does not apply cleanly. Not sure if this is due to style 
problems or something else. You are getting source from some variation of
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
correct?

Could you run checkpatch.pl from the kernel on this?
When I run checkpatch on it I get 17 errors and 71 warnings
Even your signed-off-by seems incorrect.

So please fix all the problems and send a version 3, and then I will 
review it.

Thanks

John


