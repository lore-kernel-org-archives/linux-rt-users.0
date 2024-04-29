Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894C7EF18
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402165; cv=none; b=FBit9hI09bf3d6PnlITLFhdy+FZ078pGCfyoQ7NEmRjJu4iX27H5BCthvYqPusIOowJEkAJL6/XxBvtUWYIkfgIRGIjLE8nJfqpu7hSaQdk4r+ndczOF+M4+j/SDuIeQDvn4kynuIDsinxd0ZWYyBnN7kApBs/bVaqOzqp6P8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402165; c=relaxed/simple;
	bh=OwRzYq6hpzi4sO3xCrXCTtPuGdolOtDqwF3zuvrzUvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDJtyLCK7zE14q9Na7bc3IhiDu10CzOdkZURfFQdZcERkBHIw80HseED8w98Mg6LzpRHa/77srq4j21d7InTtIUWOl7s7oIA1Lhb7F+Nbn29/zW8OOSsFHPSV6rqyoU8T9hL65Z6YmEXtwpJDDiLbhO25Kt0CnDU66V/7EvdHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrJZvnIu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrJZvnIu"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b514d3cf4so49884246d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714402162; x=1715006962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hrceh8U7RaFhh62bJ+2ZoopITmuUlwNsDKECcAUApNU=;
        b=LrJZvnIu9nkJpKLEibkXInmeqng4v9FWeQ1R/szpYogngGyHRPPgTqxi7mNDFSpxzl
         aSXzITB0lUSTKHyoUMhQ6b9Z92mx0YgXJ/BVAK3kmaqRtc1Q6wnZ72g3TjN04kscmMH+
         L3HkvdKhSOd8nBlhNYtV+MJi78uqDpNtbIbYxutTGh7xFcFLitkCb9rEsTcJpt1Xoewp
         NTL5OLnZHLAiUSD1DikCWjGvqKwsyUI5JVR6Mii2FHbPcxXRCuadB+JrNr257iXfESbw
         8qm/6z8G5ybM3yuWWIlk3TGmnoTivheJII/SWwV03P65lt+a4i3GNA8rlzQiFvTOtRXc
         U/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402162; x=1715006962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrceh8U7RaFhh62bJ+2ZoopITmuUlwNsDKECcAUApNU=;
        b=YmHxOAjbBKeaWqsiALTQxusah74GATR/hsULkSwOqKMm3gM/wOOpdy83Gs6ew8lf5q
         EHm+EyhWsqQ66TMFfXGClxqB+LatNqQfyDtD7EqZIIplKq80c8+K3LUu8mCt/2vXHuxG
         rZ2jTsISCYwKcfL2S4w5f5RDYZ0dDlI3F6VennGE3YhbJUBZkKRSrufJktf6Y/sWz+DP
         XoK3bMrV9DeXRre3FdlDiECBiAwm/7gb36eY6sITSypP30ssb70gtPCF3yYL9rCSQ9fq
         P5A8QmaXAXQMD2ZXaY0khi8YV/Nu059m7sKG7lC1HXrHOc2jQhDwGScnYPBmdHAOxE3j
         9xcQ==
X-Gm-Message-State: AOJu0Yzu4tl+XjDIez38sZK0se34rdDf8MBUtkKcegCA0b+gf4JQXW8C
	fHWKHkQ4T0DiUO3l22rWDaWPr6LGep8+s46ejLF/Bc/cPl1KaQMWTDk5EQ==
X-Google-Smtp-Source: AGHT+IGNNMMUNXBvwb/64HFT2JhmoSRJ64KSUmHJeJmjM10Z1EccJdz6nGzDdpwFvTIEGChfEZXZkg==
X-Received: by 2002:a05:6214:501d:b0:6a0:9f54:6013 with SMTP id jo29-20020a056214501d00b006a09f546013mr12922929qvb.2.1714402161911;
        Mon, 29 Apr 2024 07:49:21 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id x18-20020a0cda12000000b00698f0a22f5csm10485105qvj.130.2024.04.29.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:49:21 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Generate raw histogram data for an existing timerlat report
Date: Mon, 29 Apr 2024 10:48:50 -0400
Message-ID: <20240429144850.58585-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generate raw histogram data for an existing timerlat report.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rteval_histogram_raw.xsl | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/rteval/rteval_histogram_raw.xsl b/rteval/rteval_histogram_raw.xsl
index 038419bf03b7..00b2be34f305 100644
--- a/rteval/rteval_histogram_raw.xsl
+++ b/rteval/rteval_histogram_raw.xsl
@@ -12,15 +12,26 @@
 
     <!-- Extract overall system histogram data -->
     <xsl:apply-templates select="Measurements/Profile/cyclictest/system/histogram/bucket">
-      <xsl:with-param name="label" select="'system'"/> 
+      <xsl:with-param name="label" select="'system'"/>
       <xsl:sort select="Measurements/Profile/cyclictest/core/histogram/bucket/@index" data-type="number"/>
     </xsl:apply-templates>
 
+    <xsl:apply-templates select="Measurements/Profile/timerlat/system/histogram/bucket">
+      <xsl:with-param name="label" select="'system'"/>
+      <xsl:sort select="Measurements/Profile/timerlat/core/histogram/bucket/@index" data-type="number"/>
+    </xsl:apply-templates>
+
     <!-- Extract per cpu core histogram data -->
     <xsl:apply-templates select="Measurements/Profile/cyclictest/core/histogram/bucket">
       <xsl:sort select="Measurements/Profile/cyclictest/core/@id" data-type="number"/>
       <xsl:sort select="Measurements/Profile/cyclictest/core/histogram/bucket/@index" data-type="number"/>
     </xsl:apply-templates>
+
+    <xsl:apply-templates select="Measurements/Profile/timerlat/core/histogram/bucket">
+      <xsl:sort select="Measurements/Profile/timerlat/core/@id" data-type="number"/>
+      <xsl:sort select="Measurements/Profile/timerlat/core/histogram/bucket/@index" data-type="number"/>
+    </xsl:apply-templates>
+
   </xsl:template>
   <!--                              -->
   <!-- End of main report framework -->
@@ -43,4 +54,20 @@
     <xsl:text>&#10;</xsl:text>
   </xsl:template>
 
+  <xsl:template match="/rteval/Measurements/Profile/timerlat/*/histogram/bucket">
+    <xsl:param name="label"/>
+    <xsl:choose>
+      <!-- If we don't have a id tag in what should be a 'core' tag, use the given label -->
+      <xsl:when test="../../@id"><xsl:value-of select="../../@id"/></xsl:when>
+      <xsl:otherwise><xsl:value-of select="$label"/></xsl:otherwise>
+    </xsl:choose>
+    <xsl:text>&#09;</xsl:text>
+
+    <xsl:value-of select="@index"/>
+    <xsl:text>&#09;</xsl:text>
+
+    <xsl:value-of select="@value"/>
+    <xsl:text>&#10;</xsl:text>
+  </xsl:template>
+
 </xsl:stylesheet>
-- 
2.44.0

