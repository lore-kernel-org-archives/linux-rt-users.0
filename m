Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697536894F
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796017; cv=none; b=eCxJFLhNtISKAcwLXMTYA/8EUm1Nj5waeplaQ2kaWZBrYsZ5buquIrv6yFJkeEkWKXjUgL7y58ZOAm5O2sD6LnpfeRlIyvoKjmXA9Q4Pdulel7srwmFRBUSss1yXDaQQLmsMx+TpEWQYvdgUqQozy0AUCbQMEjFUFZILpBZ3M80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796017; c=relaxed/simple;
	bh=Ko00K1nrigUJVxA5DYhHY83XuXmnkI4TwUKLyk0J0+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUlUG1iaV3iHyc7vvB+U/AuF/NZLZZWBp0lhueLlCL+TrYRkjaIwxFh2oRFtW6ezxkcpnIJjzvfZ5QduRO9BIYTK+QX4aWNspm1loW/efsZ0xUgzCu78XgaCIy4Sm6SuufST8VRVUGb695azBFy9XeizilZu6EBpt8O3DxyKfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx5t33Yz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx5t33Yz"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso556516085a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776796000; x=1777400800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3jZLlv6aE/2+QAr600kbXGxxZkyJzbM6AID7HyLnyQ=;
        b=Mx5t33YzGZ99VQbeeHVELxB+ygjQBpr3GGHq11maoCDzFHnsqN8s0DHk76Pz0lctjR
         qugNMDbvjrxn6saqs338nfM/Ict9g4WPm2pMH6S8AVoXaX5ycGQgsrOQi1PLQhO5/ueu
         RDeNVBF6n/gYMzmyIvi9ocnDDT2Rx+KMY+rk4TZst6dA/Hc4bkzRPRmLjl1QGdRPAlkQ
         VbbBh225Lm9cxUuqbXrBIcJx7YU12iQsXEO5q5ayt9azUtqr4JT4ECdStu9/y1j5bUsR
         CfjnaTtga5oaFusElOO32UO8Y/OXwxtsCejktUsnCTPr85kH28Tl2oN7s0vCl6YOnsjI
         wySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796000; x=1777400800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3jZLlv6aE/2+QAr600kbXGxxZkyJzbM6AID7HyLnyQ=;
        b=kDGhHgFy1LkWiQ2F32YhcvtBFW4vX4gTA6J3T8PKWu8n+e/a06s28+s3uI187vDAXd
         X42DMP9tZh400lddJF+dkZBlPN7yjHb/kFMRjbFCjqkDxZqOzqPzbsZKLeh5KX4jGYlv
         +hkZjkI/64mjh7roCYiWtf6iwfY+K1c4XbQk52xUwAzIBAYmOVoXkssJq9VlVkexqUxo
         BjQAY1HY2IvthLnPg1IuDk4eFxUFvs5Bau7jjhV6z51CAsA1zab3TjTkip/OcyHMBmk4
         lDV+yWrYiZwFzESNAPwPGByDKejcvsuejmSoH3ImaYTxNbt8tdeefcE+pTKqPxJnEXzF
         oX8Q==
X-Gm-Message-State: AOJu0YwwIGC7DPGrTslWGA5oYBXFGH7Xl2WRLBcltFM87rV1SOHhTOJn
	X7MYQBfDNxeTy/heHfegiCb6wBVnesCUwj3DIZrXmgv1V0jLpc7uvS+POjo76g==
X-Gm-Gg: AeBDietFQZ8rf06Kw3pkalQFNGArzxFgXrP6FB1hXXvVdMxWqzlYvrjYc/26Q3tT9Gs
	gQDTbmfV/Raq9RI9pqctYPj51olFmB8dzIWgksuZDV1/hFrA2jU3ZhvcAFMB2IZPeXWyLcp/oB4
	/5Ct7AW9P7PRSV5z+eoSyZLUxXwcwX/dmm9JOdmmTU5PmVrI3uodPO8qlk/JTncgzjb3K1N0NEc
	WkJWC5SDWcWSH82prL88EifZ5ItxtuC1Ue9SrJDvumQGlj3dSAq8TIHUai2dU3DpiSnHF9YcbYU
	/K45GwGQif87adIp91BnOuz4xo99Lz/WfDxoRacez/hJii4Tjhj4qR6geimxLxHsxo7neOV+bTb
	MoKaWUEk+iJaHJJ34s9vrqrpRy7Eey06vPTh0wVXvVXa08ukSn2Ujp+zt4Kn8a4ED3YbMPXNP8Q
	4+bH+Kx7bkID3dRBN7R6ClIXtP3sJ36Qhmc5YOcb9JH/QPzeRpl9oTJJDAacmYiW2/dP+EgwC8y
	zZec8aWfWpn7UafarzILgXoPOh3WgBQj0zc4kXihuMdGnsB5+hTXJPymDaMDPIzOiTJW27jC5kB
	GVDoq1RbBDx4w1akgv4=
X-Received: by 2002:a05:620a:2892:b0:8ee:21b3:2eb4 with SMTP id af79cd13be357-8ee21b330e5mr710032085a.33.1776796000034;
        Tue, 21 Apr 2026 11:26:40 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/7] rteval: Display core sharing warnings in text report
Date: Tue, 21 Apr 2026 14:26:16 -0400
Message-ID: <20260421182618.261347-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421182618.261347-1-jkacur@redhat.com>
References: <20260421182618.261347-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add XSLT template to display CoreSharingWarnings in the text report
generated with the -Z option. The warnings appear after the "Tuned state"
section and before "System load" in the report output.

The template conditionally displays the "Core Sharing Warnings:" section
only when warnings are present in the XML, keeping the report clean when
there are no core sharing issues detected.

Example output:
   Core Sharing Warnings:
       Warning: Housekeeping CPU 0 (isol) shares core with measurement CPU 8 (isol)
       Warning: Measurement CPU 1 (isol) shares core with load CPU 9 (isol)

This completes the core sharing validation feature by making the warnings
visible in both the XML report and the human-readable text summary.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/rteval_text.xsl | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 146302744f58..54dc7d2f9a07 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -160,7 +160,18 @@
         </xsl:otherwise>
     </xsl:choose>
     <xsl:text>&#10;&#10;</xsl:text>
-   
+
+    <!-- Display core sharing warnings if present -->
+    <xsl:if test="SystemInfo/CPUtopology/CoreSharingWarnings/warning">
+      <xsl:text>   Core Sharing Warnings:&#10;</xsl:text>
+      <xsl:for-each select="SystemInfo/CPUtopology/CoreSharingWarnings/warning">
+        <xsl:text>       </xsl:text>
+        <xsl:value-of select="."/>
+        <xsl:text>&#10;</xsl:text>
+      </xsl:for-each>
+      <xsl:text>&#10;</xsl:text>
+    </xsl:if>
+
     <xsl:text>   System load:&#10;</xsl:text>
     <xsl:text>       Load average: </xsl:text>
     <xsl:value-of select="loads/@load_average"/>
-- 
2.53.0

