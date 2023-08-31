Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8711FC83F37
	for <linux-rt-users@archiver.kernel.org>; Thu, 31 Aug 2023 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347347AbjHaU2S (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbjHaU2P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Aug 2023 16:28:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97310D1
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Aug 2023 13:28:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4108a8f0de7so6962541cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Aug 2023 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693513686; x=1694118486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Bce4gBSUS/HEj8R8SA5eySaeSaHl1B/2bU2j9713QSg=;
        b=JSozqzY/gcz+n3/oZcUfTP6SHK3cepJKirSnZV7tKJ9BzflTccRLYDreT29QkyLJsn
         oasoxd3n0Iox25EPRlvqgwLmJScKeG3dF7jRgnZNHzv1f2aPDT3/HRBOsq1YzcBqVrEQ
         WlHg8okLuwxFwL1l/ciZ5RUd3sTWv0V9nxnrsmMDV4A1d3LtkZeYwy/y0CaRPLkKnlY8
         yDGrlbYgT9OYad1tP+yuwmNsBE4wGhpj4IzFg6j+TeAdVzVr3Mt4BtiyOLE/QRqNsaUs
         46Urhbvd6USQXRuR0w5TCKSL2CmeNKbxduj2egbT93+xqf6XVJhOEnJfDNr1LBcBc7D5
         RJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693513686; x=1694118486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bce4gBSUS/HEj8R8SA5eySaeSaHl1B/2bU2j9713QSg=;
        b=hEEsShDQAGh5e771xITnFG/WI8gcuvt0Z5rpxlCCxFGimr+ZirWFqL5SAxcNIsTcug
         VYZjb2LVRuSzUz8ReDgpaWEt4JBDUMBNdCnLoOUASTSk6X6+NaRuyan7qf7R/zusxLdI
         r3ch72NulEclrPTQPB89DDkXcKLFcfTCN07i+s+LvOCeCqiFUEt2H9qbESpzWs2/w4h7
         mZ+SFE7D3L/tK80FiOUOPVEq5sZRAPsQLojTYyW74Ntafxkj80czcfZ+1JH0uCKbcDN0
         BReY9I5Dwf85QYpkrTooZ/qQnvh7Sd1zFapUXduD9xvIUvzxvhSC9J1v5gD86GzmPJSf
         63kg==
X-Gm-Message-State: AOJu0YzKxuKT7uV4o/7SOL8LRR7kCW3ilc7zDQ+Yr0Qp5YZ0bjlI8OB3
        uhkTof/QOy8jeRboBArxa4djBaHTFX4=
X-Google-Smtp-Source: AGHT+IGJWQbqOKF92ceJQaizkPZaUPOQE21tUvgIcd+vwQ3wlJoc2mDhhHKeQitJtcVBrYl4We7VUg==
X-Received: by 2002:ac8:5804:0:b0:410:31c4:f460 with SMTP id g4-20020ac85804000000b0041031c4f460mr576761qtg.1.1693513686402;
        Thu, 31 Aug 2023 13:28:06 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.227])
        by smtp.gmail.com with ESMTPSA id x22-20020ac86b56000000b004108d49f391sm887748qts.48.2023.08.31.13.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 13:28:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: return empty string in compress_cpulist for an  empty list
Date:   Thu, 31 Aug 2023 16:27:41 -0400
Message-Id: <20230831202741.200657-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If an empty list is passed to the function compress_cpulist in
systopology.py, return an empty string, or else an IndexError will be
triggered.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/systopology.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index aca2dfd03e95..62ad3558e2e5 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -147,6 +147,8 @@ class CpuList:
     @staticmethod
     def compress_cpulist(cpulist):
         """ return a string representation of cpulist """
+        if not cpulist:
+            return ""
         if isinstance(cpulist[0], int):
             return ",".join(str(e) for e in cpulist)
         return ",".join(cpulist)
-- 
2.40.1

