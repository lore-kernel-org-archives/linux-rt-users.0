Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A77C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Apr 2022 15:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbiDKPol (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348140AbiDKPoj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Apr 2022 11:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48C413A72E
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Apr 2022 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649691744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=c0SgzPryCZojDzJRLd6F/Ur4NY8y2weg3fmZUbIUSQY=;
        b=JEbPrWOz0oMF2m7dzxRdSDLx2nAHbT6fxhsi+hibEqAj8Nlglnyu1mAheE6nvryR7PjytA
        LEOw8kaKnXu9eO5L1AiwGP10yxjo3aUz8KP79XIUYtrZwfb0HW6DW99vuq8zEgxf6USDfj
        Z6KldsW6FSa2gFdtvR+W2+gk1SgD4XY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-zCSe3AkbPmKOU6Fmh9oYvg-1; Mon, 11 Apr 2022 11:42:16 -0400
X-MC-Unique: zCSe3AkbPmKOU6Fmh9oYvg-1
Received: by mail-ed1-f71.google.com with SMTP id ee36-20020a056402292400b0041d836b664cso1287875edb.6
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Apr 2022 08:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c0SgzPryCZojDzJRLd6F/Ur4NY8y2weg3fmZUbIUSQY=;
        b=7x9WpMnx0ZdQjiw/S7b62juOqMI490gWiTjOQp+QQaAvT0uRZNfDIN5U5/Hi8UV1q4
         ZPNWAASrDCh6q/uHhBHP/dOA16dgDJIBDrQddk6CGQXXQJwasNsS30Hv5I9cawKPnCH9
         WZfdQr9kiUSsUvd/2pC6IYqNo7zEMflk2LfmiELtzI126wXEtLiSUhmda0kV7ZC5kEVM
         QNFPjDJchHe2gBgyBnAbcVsH4dQRxeDt9EaAvVg60gGNxR/GqKCRh9uexyrhr3t2fPbP
         McVnDu0HJs8vseEZyXi5iL/mukCaMDPQUuvKHp4S+dgMduty+XY9u3/3u5IHj5ZvCNLv
         iaPQ==
X-Gm-Message-State: AOAM530BRoDdtjlGizmOxLFLCqJbRQM/hZXt2mnwLuIKKRG796y5HYJ4
        N39ZUS7ZI6UyOnqJMhKonwwKSJjPM5q9yAfS9BIdv69SIyq9JkU17RB9XH8Cg4MHLRHx6XLppk2
        Lym4M0KdCPhuAFSAsIgIewe3oGJiCDbSZSs3DikPUVPU=
X-Received: by 2002:a05:6402:b1c:b0:41d:798c:78e3 with SMTP id bm28-20020a0564020b1c00b0041d798c78e3mr6866844edb.188.1649691734603;
        Mon, 11 Apr 2022 08:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTqwZmOMP/t2Z5vMPsEczo9xphV2yzarqh5Nuuw/q6I2eByEZXJ7ffALgFQ+gI2koqp7aw+2NYRd2S6mZKVA0=
X-Received: by 2002:a05:6402:b1c:b0:41d:798c:78e3 with SMTP id
 bm28-20020a0564020b1c00b0041d798c78e3mr6866831edb.188.1649691734379; Mon, 11
 Apr 2022 08:42:14 -0700 (PDT)
MIME-Version: 1.0
From:   Bart Wensley <bwensley@redhat.com>
Date:   Mon, 11 Apr 2022 11:42:09 -0400
Message-ID: <CAGCuPdP4jRsupmgWaUF+mRL6R-J3effciUGDw6cybf30-akqAw@mail.gmail.com>
Subject: [PATCH] rt-tests: resync has_smi_counter with turbostat code
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
 src/cyclictest/cyclictest.c | 96 +++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c9ed9e0..8673c89 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -432,39 +432,73 @@ static int has_smi_counter(void)

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
+       case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
+       case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
+               model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
+       case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
+               model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
+       case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
+       case 0x56:      /* INTEL_FAM6_BROADWELL_D */
+               model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
+       case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
+       case 0x5E:      /* INTEL_FAM6_SKYLAKE */
+       case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
+       case 0x9E:      /* INTEL_FAM6_KABYLAKE */
+       case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
+       case 0xA5:      /* INTEL_FAM6_COMETLAKE */
+               model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
+       case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
+       case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
+       case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
+       case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
+       case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
+       case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
+       case 0x97:      /* INTEL_FAM6_ALDERLAKE */
+       case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
+               model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
+       case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
+               model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
+       case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
+       case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
+               model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
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

