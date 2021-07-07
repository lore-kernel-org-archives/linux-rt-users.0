Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC9C07E95
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B29861CC2
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 08:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhGGIvi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhGGIvh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Jul 2021 04:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625647736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cwuL0ZkglE9+i+mNovBXpEWYLFTVhw5jAdz7hobtpnQ=;
        b=MFUpZMs3yQoPLbLS0/K6alCpRoLFJqFK3KoJGfUIELQhoDrYYPJ+FqV3HF1xv1PUkDdN+5
        wf67GEUFiWfXQOc5ALSsFpgO4Q0dsbWjnl+Fhvq5h17KAHRKyxjCd+DX1MjhxQCNLByhZZ
        7NCOcnDbdopJCEay24Ni4gvgeBmbWJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-hpX0uvChPNOjVHtk5TdQ3A-1; Wed, 07 Jul 2021 04:48:55 -0400
X-MC-Unique: hpX0uvChPNOjVHtk5TdQ3A-1
Received: by mail-wr1-f72.google.com with SMTP id j2-20020a0560001242b029012c82df4dbbso506523wrx.23
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Jul 2021 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cwuL0ZkglE9+i+mNovBXpEWYLFTVhw5jAdz7hobtpnQ=;
        b=iSwD3McqE+Oy1uk5uWTnqaw5VLp+zJ7jK4dfjrpn65aH2jaoT18bvF1XBtyZmJ19PN
         apyzg345FB/0dOjjwGYlk+9S1FhG+R7HwOFf6a6cmQa0Dyd4IXne5Z6RRHw8tke4srDb
         rrEHRqBGTlbusP8pe40/S34UghoecE0hCPwIWB9gTe9ipVSwAU6d/4hKqc0b2R+Q/1PK
         loXSEG2Ixm+wGrcPZUM/ygLwmeSuGoM4dW+F4QvGLDIoVNk12YWKMbVv3Htqc2VzypJS
         WzDXy7TpIsmCxkhzS9XOCSr7MEX9nuL4mIoBVGtsMacX9Nz+5KKa6ceeTkugSlkE9igw
         +fSA==
X-Gm-Message-State: AOAM532StqXl/B7tiBIs0aCmqymXhPV5Dk8EGLHkNbRQQzA+ua0lC90U
        fn9Z3gs57OhJlyzXdU6QaB9ifJReFFG4PDiYF4MMTLcqGdN7v2YHV57P9sE4wjLUtoNe7CDCwK2
        mJJLrowxWWn6ta6PiNee/VQ5DyZ0M20XVg/yUP2R7Ta2pndQMvMgYh/c3wivWRxjEtFgyI8ldWb
        9SDBA=
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr26246385wrf.32.1625647734316;
        Wed, 07 Jul 2021 01:48:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb7pL9tqB5KebXltY0TSWiaBCoD0exj/vwgjP0spoxgAZSnnmrqaPrI0NgPVCp/P1bpJ0JzA==
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr26246364wrf.32.1625647734112;
        Wed, 07 Jul 2021 01:48:54 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id k1sm5533390wme.34.2021.07.07.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 01:48:53 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 1/2] oslat: Remove redundant include
Date:   Wed,  7 Jul 2021 10:48:48 +0200
Message-Id: <20210707084849.304329-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

inttypes.h is already included above.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 6108fed..1cba6fc 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -29,7 +29,6 @@
 #include <numa.h>
 #include <math.h>
 #include <limits.h>
-#include <inttypes.h>
 
 #include <sys/prctl.h>
 #include <sys/stat.h>
-- 
2.31.1

