Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACFC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Apr 2022 15:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiDKPzX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiDKPzV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Apr 2022 11:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83D6331502
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Apr 2022 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649692386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=O9m6y9C6Pfmizntp/dopc6Ki+6b9unw1nEqdAlnl+Ls=;
        b=PE+U88j9F85nks/imQn5w8gGZfKRrVEz7o0e3pOJTrHNz4fJBw4LqLF79Wxp/t5EDUSiUS
        g5lKZh67jt343tCL1iSntmkKs7stmPv6TXw/UGSdDcU4E5JWjND6G+tCF9BUxoioCshmf8
        eI9UMBcKGo6leH+Zbs+4HA+h0QQtOOc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-ehfHCA3QNf-kH2yKQVhvzA-1; Mon, 11 Apr 2022 11:53:05 -0400
X-MC-Unique: ehfHCA3QNf-kH2yKQVhvzA-1
Received: by mail-ej1-f69.google.com with SMTP id hp19-20020a1709073e1300b006e82eaf2677so5729629ejc.1
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Apr 2022 08:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O9m6y9C6Pfmizntp/dopc6Ki+6b9unw1nEqdAlnl+Ls=;
        b=M/b7Cv6N+5oOyovNVEYbUWsLfDUtkaNFc7GgvCqHm9fXMGeLb1MSzgS6jLRycdPHUF
         EcbccOSQMyFFjozZXHyURdqULfJFHMiWLlt8WUT3IGuXWngBCVADwm9LwiS7w/IaEkAq
         8/WNHicD5YzGlbY9QRY2szBwu7gN19iPCrfIOuD8K/y6yVndJNq6GoRYW4sfF0GZ0uBY
         rQpvWndx8x4vTBrhbJNkALhB2ip3s90Cc60LmsHiU9fKLKx0hGR26Ym589+yLFSrZTLw
         qOseaB58+7eN4uk18TRAaZ+OHKL5G++UmZ7oKmEHIdn+cL8gV2OUNGp0eEAvC2IcknwX
         phtA==
X-Gm-Message-State: AOAM532U2XjcdQ8bp2XmBj+VYv1ulXB0tpcEb7szAHA2Np8UutcWweqk
        9GevA3Q/wGqqyr0ObNd+SGQrWaewlA3VP6Bfv05r3oJ7AoUH7EIRzO7hAyYdVoWBoFdJoAhf0wM
        oNHh0UFqwn71AHWQaFmc99JC/VeXTUDgk5lzJD/Tp/Wk=
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id k16-20020a17090632d000b006cee1cf3f2emr29421935ejk.214.1649692384267;
        Mon, 11 Apr 2022 08:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+huLV83lY1+tf3euMJTbQkUKmd8j7EoIS9Xhn/qHteEpVqCOO9PFPs6j7E+6YQcn3u6RYlC1SxFLaBsT2Ngs=
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id
 k16-20020a17090632d000b006cee1cf3f2emr29421919ejk.214.1649692384068; Mon, 11
 Apr 2022 08:53:04 -0700 (PDT)
MIME-Version: 1.0
From:   Bart Wensley <bwensley@redhat.com>
Date:   Mon, 11 Apr 2022 11:52:59 -0400
Message-ID: <CAGCuPdNWM2EBdjuGWMkpskMz5dq5tqUK+YrVLfAOtccTDK6_pQ@mail.gmail.com>
Subject: [PATCH v2] rt-tests: resync has_smi_counter with turbostat code
To:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        John Kacur <jkacur@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Updating has_smi_counter to match most recent turbostat code, in
order to support recent cpu models (e.g. Ice Lake).

Restructured the code to match the turbostat functions so it will
be easier to keep the code in sync in the future.

Signed-off-by: bartwensley <bwensley@redhat.com>
---
 src/cyclictest/cyclictest.c | 104 +++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c9ed9e0..da430dc 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -432,39 +432,81 @@ static int has_smi_counter(void)

        model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);

+       /* Based on intel_model_duplicates */
        switch (model) {
-       case 0x1A:      /* Core i7, Xeon 5500 series - Bloomfield,
Gainstown NHM-EP */
-       case 0x1E:      /* Core i7 and i5 Processor - Clarksfield,
Lynnfield, Jasper Forest */
+       case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
+       case 0x1E:      /* INTEL_FAM6_NEHALEM */
        case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
-       case 0x25:      /* Westmere Client - Clarkdale, Arrandale */
-       case 0x2C:      /* Westmere EP - Gulftown */
-       case 0x2E:      /* Nehalem-EX Xeon - Beckton */
-       case 0x2F:      /* Westmere-EX Xeon - Eagleton */
-       case 0x2A:      /* SNB */
-       case 0x2D:      /* SNB Xeon */
-       case 0x3A:      /* IVB */
-       case 0x3E:      /* IVB Xeon */
-       case 0x3C:      /* HSW */
-       case 0x3F:      /* HSX */
-       case 0x45:      /* HSW */
-       case 0x46:      /* HSW */
-       case 0x3D:      /* BDW */
-       case 0x47:      /* BDW */
-       case 0x4F:      /* BDX */
-       case 0x56:      /* BDX-DE */
-       case 0x4E:      /* SKL */
-       case 0x5E:      /* SKL */
-       case 0x8E:      /* KBL */
-       case 0x9E:      /* KBL */
-       case 0x55:      /* SKX */
-       case 0x37:      /* BYT */
-       case 0x4D:      /* AVN */
-       case 0x4C:      /* AMT */
-       case 0x57:      /* PHI */
-       case 0x5C:      /* BXT */
-       case 0x5F:      /* DNV */
-       case 0x7A:      /* Gemini Lake */
-       case 0x85:      /* Knights Mill */
+       case 0x25:      /* INTEL_FAM6_WESTMERE */
+       case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
+               model = 0x1E;      /* INTEL_FAM6_NEHALEM */
+               break;
+       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
+       case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
+               model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
+               break;
+       case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
+               model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
+               break;
+       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
+       case 0x56:      /* INTEL_FAM6_BROADWELL_D */
+               model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
+               break;
+       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
+       case 0x5E:      /* INTEL_FAM6_SKYLAKE */
+       case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
+       case 0x9E:      /* INTEL_FAM6_KABYLAKE */
+       case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
+       case 0xA5:      /* INTEL_FAM6_COMETLAKE */
+               model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
+               break;
+       case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
+       case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
+       case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
+       case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
+       case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
+       case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
+       case 0x97:      /* INTEL_FAM6_ALDERLAKE */
+       case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
+               model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
+               break;
+       case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
+               model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
+               break;
+       case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
+       case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
+               model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
+               break;
+       }
+
+       /* Based on probe_nhm_msrs */
+       switch (model) {
+       case 0x1E:      /* INTEL_FAM6_NEHALEM */
+       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
+       case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
+       case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
+       case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
+       case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
+       case 0x3C:      /* INTEL_FAM6_HASWELL */
+       case 0x46:      /* INTEL_FAM6_HASWELL_G */
+       case 0x3F:      /* INTEL_FAM6_HASWELL_X */
+       case 0x45:      /* INTEL_FAM6_HASWELL_L */
+       case 0x3D:      /* INTEL_FAM6_BROADWELL */
+       case 0x47:      /* INTEL_FAM6_BROADWELL_G */
+       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
+       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
+       case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
+       case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
+       case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
+       case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
+       case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
+       case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
+       case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
+       case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
+       case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
+       case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
+       case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
+       case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
                break;
        default:
                return 0;
--
2.35.1

