Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B33C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Apr 2022 18:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiDGSZW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiDGSZV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Apr 2022 14:25:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3B11B
        for <linux-rt-users@vger.kernel.org>; Thu,  7 Apr 2022 11:23:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t7so8730961qta.10
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Apr 2022 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOXNSvSnGVuY6DDNk6cy0IxMz81cIzSK7RneGT1gKyQ=;
        b=glNPyT8SxqNNLSrw9j91I/ViqPKs5q7+kvQik2hQfX5hQWDMZYXlG6meYeRrfIEmzk
         ptbWprsr8jPhaxfytsMi3nq3g4ij4VEcBIgeUqXooABMNGt+zQ2fs/Dox/dtr6wACNAw
         7jj72VxqVoXXveYz76VAP9t9x7S1LJ8ld7LYUIWQvtyojU0OGXeqwOyBhQ9t45hlseen
         +CQPrKzK0Fvgh0G7nDAHeS4+zv7qfezM/ADbTixtpR8TXhbQYRP0yPYdRdt0RTOPV7Rh
         y+SWyqj71HjwzHraK95d4b0SNy4Ky2m9imIQcMVzCWUfm9hJZFBC/iLyQpUv2pYS0aK5
         m7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lOXNSvSnGVuY6DDNk6cy0IxMz81cIzSK7RneGT1gKyQ=;
        b=uBx4EAYbuqxN61VbCugolT0R+hEWfBbNkVHP6Xn32h7z4RPOfQI8iMSL8+hSMmG8YZ
         30MADnrsdcl3YPxsKnbdHCAVUSfNsSlt4PGixG3o2y3V1ZG+ZKbQCpPbMQoIXf74TnXS
         MEzKtrHffqn9aUkzn9kbKxrHKn8UPejU56dD4yg+kHFUgJDH5FzdzUZo7t7Ql/F7XdVX
         uCePlJZmo1KTkxd21rOAqpVRqxD44XFHryEVCXwTTKbeaWmlADcIsmp7rK6UcAm6ffT/
         cTkE5efQw5rRU2rnkPVi6fX/hbOgzFZyMybGtvqWrrSG4XXAueh86iw6QNWqfToyciTF
         FgDg==
X-Gm-Message-State: AOAM530KKGLZpQJWAaWA+y6YEYwExQGPyPQRuJ3SgVtXkhaVmRTVEwEu
        jaEqrE+Rg6HrxnH37z5eDki2VU2KPko=
X-Google-Smtp-Source: ABdhPJyUBoK1/lEGG7vm7g/W9jSj96gwtwL8/fRuT7SnoSuNBaYxwLHpJDdStr9+B+/SWkCjjlavJA==
X-Received: by 2002:ac8:7e8e:0:b0:2eb:8e71:8dcc with SMTP id w14-20020ac87e8e000000b002eb8e718dccmr12780861qtj.67.1649355799335;
        Thu, 07 Apr 2022 11:23:19 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002e234014a1fsm17043388qta.81.2022.04.07.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:23:19 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveria <bristot@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Bart Wensley <bwensley@redhat.com>
Subject: [PATCH] rt-tests: Update has_smi_counter
Date:   Thu,  7 Apr 2022 14:22:56 -0400
Message-Id: <20220407182256.19947-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Update has_smi_counter() to include

case 0x66:	/* INTEL_FAM6_CANNONLAKE_L, Palm Cove */
case 0x6A:	/* INTEL_FAM6_ICELAKE_X */
case 0x96:	/* INTEL_FAM6_ATOM_TREMONT Elkhart Lake */
case 0x86:	/* INTEL_FAM6_ATOM_TREMONT_D, Jacobsville */

This function is based on probe_nhm_msrs() in file turbostat.c in the
linux kernel.

This update also reorders the model numbers to more closely match the
order in probe_nhm_msrs, and adds comments to match symbolic names for
the model numbers.

Reported-by: Bart Wensley <bwensley@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 50 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c9ed9e08f6e1..a4979ad81f21 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -440,31 +440,35 @@ static int has_smi_counter(void)
 	case 0x2C:      /* Westmere EP - Gulftown */
 	case 0x2E:      /* Nehalem-EX Xeon - Beckton */
 	case 0x2F:      /* Westmere-EX Xeon - Eagleton */
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
+	case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE, SNB */
+	case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X, SNB Xeon */
+	case 0x3A:      /* INTEL_FAM6_IVYBRIDGE, IVB */
+	case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X, IVB Xeon */
+	case 0x3C:      /* INTEL_FAM6_HASWELL, HSW */
+	case 0x46:      /* INTEL_FAM6_HASWELL_G, HSW */
+	case 0x3F:      /* INTEL_FAM6_HASWELL_X, HSX */
+	case 0x45:      /* INTEL_FAM6_HASWELL_L, HSW */
+	case 0x3D:      /* INTEL_FAM6_BROADWELL, BDW */
+	case 0x47:      /* INTEL_FAM6_BROADWELL_G, BDW */
+	case 0x4F:      /* INTEL_FAM6_BROADWELL_X, BDX */
+	case 0x56:      /* INTEL_FAM6_BROADWELL_D, BDX-DE */
+	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L SKL */
+	case 0x66:	/* INTEL_FAM6_CANNONLAKE_L, Palm Cove */
+	case 0x55:      /* INTEL_FAM6_SKYLAKE_X, SKX */
+	case 0x6A:	/* INTEL_FAM6_ICELAKE_X */
+	case 0x5E:      /* INTEL_FAM6_SKYLAKE, SKL */
 	case 0x8E:      /* KBL */
 	case 0x9E:      /* KBL */
-	case 0x55:      /* SKX */
-	case 0x37:      /* BYT */
-	case 0x4D:      /* AVN */
-	case 0x4C:      /* AMT */
-	case 0x57:      /* PHI */
-	case 0x5C:      /* BXT */
-	case 0x5F:	/* DNV */
-	case 0x7A:	/* Gemini Lake */
-	case 0x85:	/* Knights Mill */
+	case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT, BYT */
+	case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D, AVN */
+	case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT, AMT */
+	case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL, PHI */
+	case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT, BXT, Apollo Lake */
+	case 0x7A:	/* INTEL_FAM6_ATOM_GOLDMONT_PLUS, Gemini Lake */
+	case 0x5F:	/* INTEL_FAM6_ATOM_GOLDMONT_D, DNV, Denverton */
+	case 0x96:	/* INTEL_FAM6_ATOM_TREMONT Elkhart Lake */
+	case 0x86:	/* INTEL_FAM6_ATOM_TREMONT_D, Jacobsville */
+	case 0x85:	/* INTEL_FAM6_XEON_PHI_KNM, Knights Mill */
 		break;
 	default:
 		return 0;
-- 
2.35.1

