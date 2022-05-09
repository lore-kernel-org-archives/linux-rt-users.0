Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C6C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 May 2022 19:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiEIT2a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 May 2022 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiEIT23 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 May 2022 15:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332D79BAFB
        for <linux-rt-users@vger.kernel.org>; Mon,  9 May 2022 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652124274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sBJkYCZF/D4dshRAJ52F40rLP0TnSmy8sw3RhuUczo=;
        b=A3i54QTivLcXy6b7slOnImRt5N7ld5gMj9sXArgW6qml9LF9XNEyx22VFeab4spuFRfkP9
        4Pp6IYXO3cxYaYRupYTgf4EmgKoX/ELVG5V7D9SN4JFWzmG4bZvhtJGRdE53SRTbk3YQne
        NfeBIWOls/vHq/rwvrSJzfv/UevBSUI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-i9WmWiH_Pfu83zYWmcAGug-1; Mon, 09 May 2022 15:24:33 -0400
X-MC-Unique: i9WmWiH_Pfu83zYWmcAGug-1
Received: by mail-qt1-f198.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso12916180qtm.8
        for <linux-rt-users@vger.kernel.org>; Mon, 09 May 2022 12:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4sBJkYCZF/D4dshRAJ52F40rLP0TnSmy8sw3RhuUczo=;
        b=5CDVIcAzgbB7QbI+lfj7LF21i+iUPB5lfcjtV6DT9c1v+xUnPXZSEySrSadOhpr6n7
         fWwFRqiXbMfap51DcVYTIsvS/pdDfwzMCDMrTTlgBASOzEm/8MGv3K5+JX+mcjqAdfDe
         DNYkCuUi3MM2CYmmjsG3KmE4/0JEjU3n0O+6HzOuJJxxp5F6vHIIlRui2zjJblNRexjD
         Bn7g4S5g2cBPuXB/6UMkak6HFiiC1nGlpBLQDDl4aDp65R2s747r+D+hqXnBHZ1+dasN
         Kw6uAzZKwKq5CxpPLo2W577EDu/bOOXD9kASNKXiS+zzy+lGl3PXBpFRkHvehlBBOhyA
         +axw==
X-Gm-Message-State: AOAM5300fdlW/Y/R2j2jFyUFeGPvTfI6dra/4U+abYM8Efg7RBejAiMi
        HW425pQQoJ+cVtpj9uRV/xE+22OJQLJurBgAVAf8VEeWrLFeRhyi+M6T1ga/HcJKVqwsE2qsbv4
        OplVUMfE2C4iFS2uZ7iiFuysCVJ4=
X-Received: by 2002:a0c:e409:0:b0:45a:8a6e:c771 with SMTP id o9-20020a0ce409000000b0045a8a6ec771mr15266782qvl.123.1652124272710;
        Mon, 09 May 2022 12:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfPGK0X8cYtNMA1XvnjvkntBR7oWCww/B5IHGxWC1n+7ebE06nFAlp8uOHNFxK+wgQwocehw==
X-Received: by 2002:a0c:e409:0:b0:45a:8a6e:c771 with SMTP id o9-20020a0ce409000000b0045a8a6ec771mr15266756qvl.123.1652124272416;
        Mon, 09 May 2022 12:24:32 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id v1-20020ae9e301000000b0069fc13ce217sm7293435qkf.72.2022.05.09.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 12:24:31 -0700 (PDT)
Date:   Mon, 9 May 2022 15:24:30 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Bart Wensley <bartwensley@gmail.com>
cc:     linux-rt-users@vger.kernel.org, bartwensley <bwensley@redhat.com>
Subject: Re: [PATCH v3] rt-tests: resync has_smi_counter with turbostat
 code
In-Reply-To: <20220413111804.964-1-bwensley@redhat.com>
Message-ID: <da28b6da-1a9b-1257-2462-44bd25337d@redhat.com>
References: <20220413111804.964-1-bwensley@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 13 Apr 2022, Bart Wensley wrote:

> From: bartwensley <bwensley@redhat.com>

Why do you have this above line in your description part?
This comes from the email header, and the fact that you have
"bartwensley" instead "Bart Wensley" means that checkpatch
complains about it.

Leave that out next time, but other than that

Signed-off-by: John Kacur <jkacur@redhat.com>

> 
> Updating has_smi_counter to match most recent turbostat code, in
> order to support recent cpu models (e.g. Ice Lake).
> 
> Restructured the code to match the turbostat functions so it will
> be easier to keep the code in sync in the future.
> 
> Signed-off-by: Bart Wensley <bwensley@redhat.com>
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
>  	model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
>  
> +	/* Based on intel_model_duplicates */
>  	switch (model) {
> -	case 0x1A:      /* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */
> -	case 0x1E:      /* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper Forest */
> +	case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
> +	case 0x1E:      /* INTEL_FAM6_NEHALEM */
>  	case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
> -	case 0x25:      /* Westmere Client - Clarkdale, Arrandale */
> -	case 0x2C:      /* Westmere EP - Gulftown */
> -	case 0x2E:      /* Nehalem-EX Xeon - Beckton */
> -	case 0x2F:      /* Westmere-EX Xeon - Eagleton */
> -	case 0x2A:      /* SNB */
> -	case 0x2D:      /* SNB Xeon */
> -	case 0x3A:      /* IVB */
> -	case 0x3E:      /* IVB Xeon */
> -	case 0x3C:      /* HSW */
> -	case 0x3F:      /* HSX */
> -	case 0x45:      /* HSW */
> -	case 0x46:      /* HSW */
> -	case 0x3D:      /* BDW */
> -	case 0x47:      /* BDW */
> -	case 0x4F:      /* BDX */
> -	case 0x56:      /* BDX-DE */
> -	case 0x4E:      /* SKL */
> -	case 0x5E:      /* SKL */
> -	case 0x8E:      /* KBL */
> -	case 0x9E:      /* KBL */
> -	case 0x55:      /* SKX */
> -	case 0x37:      /* BYT */
> -	case 0x4D:      /* AVN */
> -	case 0x4C:      /* AMT */
> -	case 0x57:      /* PHI */
> -	case 0x5C:      /* BXT */
> -	case 0x5F:	/* DNV */
> -	case 0x7A:	/* Gemini Lake */
> -	case 0x85:	/* Knights Mill */
> +	case 0x25:      /* INTEL_FAM6_WESTMERE */
> +	case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
> +		model = 0x1E;      /* INTEL_FAM6_NEHALEM */
> +		break;
> +	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> +	case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
> +		model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
> +		break;
> +	case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
> +		model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
> +		break;
> +	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> +	case 0x56:      /* INTEL_FAM6_BROADWELL_D */
> +		model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
> +		break;
> +	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> +	case 0x5E:      /* INTEL_FAM6_SKYLAKE */
> +	case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
> +	case 0x9E:      /* INTEL_FAM6_KABYLAKE */
> +	case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
> +	case 0xA5:      /* INTEL_FAM6_COMETLAKE */
> +		model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
> +		break;
> +	case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
> +	case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
> +	case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
> +	case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
> +	case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
> +	case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
> +	case 0x97:      /* INTEL_FAM6_ALDERLAKE */
> +	case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
> +		model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
> +		break;
> +	case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
> +		model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
> +		break;
> +	case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
> +	case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
> +		model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
> +		break;
> +	}
> +
> +	/* Based on probe_nhm_msrs */
> +	switch (model) {
> +	case 0x1E:      /* INTEL_FAM6_NEHALEM */
> +	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> +	case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
> +	case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
> +	case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
> +	case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
> +	case 0x3C:      /* INTEL_FAM6_HASWELL */
> +	case 0x46:      /* INTEL_FAM6_HASWELL_G */
> +	case 0x3F:      /* INTEL_FAM6_HASWELL_X */
> +	case 0x45:      /* INTEL_FAM6_HASWELL_L */
> +	case 0x3D:      /* INTEL_FAM6_BROADWELL */
> +	case 0x47:      /* INTEL_FAM6_BROADWELL_G */
> +	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> +	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> +	case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
> +	case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
> +	case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> +	case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
> +	case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
> +	case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
> +	case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
> +	case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
> +	case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
> +	case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
> +	case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
> +	case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
>  		break;
>  	default:
>  		return 0;
> -- 
> 2.35.1
> 
> 

