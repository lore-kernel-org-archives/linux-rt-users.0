Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E9C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Apr 2022 11:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiDMLVF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 07:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiDMLVE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Apr 2022 07:21:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77E54BE3
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2022 04:18:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z16so1088487qtq.6
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2022 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xgzyx+A7dbIJCsy88HXlzZu54jaQOLkTo67hR9c26uA=;
        b=W6siiCmGUwZOretXTfl0yA2gOHyEm9FJPRwU9EhND7RT4BVuz4mflap6+Ig/hGQ/6y
         WKvh46gDrwFTWtEkupB2vEWZIBFYCJ0+Tc+OOQjuxMxdjrh7zUtUtm9SyLujqmwUe+vb
         rRYRBtBmK8aI52XJMmdxWKHHLGimCUdCZU1G8ilLqDULl90bphTEKqFV+6EA+MTCz2bn
         khnlLOK1R5YXpeGFyNWm/Dc5sRtMtBE5zBMNPUThkSMGTue4UISdftqf/8jvZUwJvFMt
         iuoSG1mf8FNBWv2pIPlPNvjZ32SR9bUg+6/mjKcTL7lqkuBTcrnj1hG/GtLBF/c8cooh
         3rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xgzyx+A7dbIJCsy88HXlzZu54jaQOLkTo67hR9c26uA=;
        b=0T4Gfb/MPmKhCSCFB1pNIf9gWjcSLZUPZ0QLWid2Qg6H60orvXgWE5GWEk/SIjBT/w
         6MUnFkZ1nVyysl9X1dm69jCXFG0DIeYl+Llzv0fMrd6e2am53P3rOIeq561Gp1P4Ahbr
         1R4gQcZYPfgsneYvEii/ezt3wbliNq6ulnEj1qO0tHmfj/h1tHNnRy6dfvB27U/Ef2uJ
         Sy0apJ/dr/ibXFvTFI4miwpz2JF0q9awP37a7ek6u9TwuuhCRutGdIyAfQ1UMQr7ri+g
         RtVVyWL4er0NJmZgoGHASxDej2fSvmFGnZbK1zcWGOYXtt/iJLqrBzyM+KOtjeQxWDcN
         D25g==
X-Gm-Message-State: AOAM533tw6lU6hLcCzwgikt7DPL0XnG3TFYSyZ1V+YCRKiwmKZr731VO
        f20Pxpf7NY6RXBTVaH70I93coqbSr/Y=
X-Google-Smtp-Source: ABdhPJzdV0VOYwcMs66jPG6LqhBGlKNiT5/sCFel4oVsTPi8iZcSM6R+c/qYnfeNO9d58fDMUf2mCA==
X-Received: by 2002:a05:622a:253:b0:2e2:33fb:a583 with SMTP id c19-20020a05622a025300b002e233fba583mr6631504qtx.92.1649848722054;
        Wed, 13 Apr 2022 04:18:42 -0700 (PDT)
Received: from BWENSLEY-W10E.win.redhat.com (cpe74acb9a5208e-cmf0f249433a50.cpe.net.cable.rogers.com. [174.115.19.16])
        by smtp.gmail.com with ESMTPSA id f15-20020a379c0f000000b0069bf3430cc4sm8558343qke.100.2022.04.13.04.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:18:41 -0700 (PDT)
From:   Bart Wensley <bartwensley@gmail.com>
X-Google-Original-From: Bart Wensley <bwensley@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     bartwensley <bwensley@redhat.com>
Subject: [PATCH v3] rt-tests: resync has_smi_counter with turbostat code
Date:   Wed, 13 Apr 2022 07:18:04 -0400
Message-Id: <20220413111804.964-1-bwensley@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: bartwensley <bwensley@redhat.com>

Updating has_smi_counter to match most recent turbostat code, in
order to support recent cpu models (e.g. Ice Lake).

Restructured the code to match the turbostat functions so it will
be easier to keep the code in sync in the future.

Signed-off-by: Bart Wensley <bwensley@redhat.com>
---
 src/cyclictest/cyclictest.c | 104 +++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c9ed9e0..da430dc 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -432,39 +432,81 @@ static int has_smi_counter(void)
 
 	model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
 
+	/* Based on intel_model_duplicates */
 	switch (model) {
-	case 0x1A:      /* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */
-	case 0x1E:      /* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper Forest */
+	case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
+	case 0x1E:      /* INTEL_FAM6_NEHALEM */
 	case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
-	case 0x25:      /* Westmere Client - Clarkdale, Arrandale */
-	case 0x2C:      /* Westmere EP - Gulftown */
-	case 0x2E:      /* Nehalem-EX Xeon - Beckton */
-	case 0x2F:      /* Westmere-EX Xeon - Eagleton */
-	case 0x2A:      /* SNB */
-	case 0x2D:      /* SNB Xeon */
-	case 0x3A:      /* IVB */
-	case 0x3E:      /* IVB Xeon */
-	case 0x3C:      /* HSW */
-	case 0x3F:      /* HSX */
-	case 0x45:      /* HSW */
-	case 0x46:      /* HSW */
-	case 0x3D:      /* BDW */
-	case 0x47:      /* BDW */
-	case 0x4F:      /* BDX */
-	case 0x56:      /* BDX-DE */
-	case 0x4E:      /* SKL */
-	case 0x5E:      /* SKL */
-	case 0x8E:      /* KBL */
-	case 0x9E:      /* KBL */
-	case 0x55:      /* SKX */
-	case 0x37:      /* BYT */
-	case 0x4D:      /* AVN */
-	case 0x4C:      /* AMT */
-	case 0x57:      /* PHI */
-	case 0x5C:      /* BXT */
-	case 0x5F:	/* DNV */
-	case 0x7A:	/* Gemini Lake */
-	case 0x85:	/* Knights Mill */
+	case 0x25:      /* INTEL_FAM6_WESTMERE */
+	case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
+		model = 0x1E;      /* INTEL_FAM6_NEHALEM */
+		break;
+	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
+	case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
+		model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
+		break;
+	case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
+		model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
+		break;
+	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
+	case 0x56:      /* INTEL_FAM6_BROADWELL_D */
+		model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
+		break;
+	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
+	case 0x5E:      /* INTEL_FAM6_SKYLAKE */
+	case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
+	case 0x9E:      /* INTEL_FAM6_KABYLAKE */
+	case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
+	case 0xA5:      /* INTEL_FAM6_COMETLAKE */
+		model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
+		break;
+	case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
+	case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
+	case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
+	case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
+	case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
+	case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
+	case 0x97:      /* INTEL_FAM6_ALDERLAKE */
+	case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
+		model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
+		break;
+	case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
+		model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
+		break;
+	case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
+	case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
+		model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
+		break;
+	}
+
+	/* Based on probe_nhm_msrs */
+	switch (model) {
+	case 0x1E:      /* INTEL_FAM6_NEHALEM */
+	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
+	case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
+	case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
+	case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
+	case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
+	case 0x3C:      /* INTEL_FAM6_HASWELL */
+	case 0x46:      /* INTEL_FAM6_HASWELL_G */
+	case 0x3F:      /* INTEL_FAM6_HASWELL_X */
+	case 0x45:      /* INTEL_FAM6_HASWELL_L */
+	case 0x3D:      /* INTEL_FAM6_BROADWELL */
+	case 0x47:      /* INTEL_FAM6_BROADWELL_G */
+	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
+	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
+	case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
+	case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
+	case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
+	case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
+	case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
+	case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
+	case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
+	case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
+	case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
+	case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
+	case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
+	case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
 		break;
 	default:
 		return 0;
-- 
2.35.1

