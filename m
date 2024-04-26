Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17F748F
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Apr 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157457; cv=none; b=rWUYThJUa8DYbZeXlIeEF6BWRQ7FwJUw5Gop7m+6PTDn282P5IXJHQ9AijPb0y+Yufs3S6Kl8l1aUuiFSI855YF0b9bCp9RXLpmhsW0ta4iZcpJpZwu+8mCFJbOQzbyskrU6sF7yk2pe6Pfdwzpj54/PWIvvWKMxQWs/IjhhGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157457; c=relaxed/simple;
	bh=OJ6AETWdR3/NDmX/Ve1rWXvK2MXz5EiReav5lQCPriU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqMOUaYuB3lM3pT7O1cCVy5NrRkoS6v8+1jyu717Z2jFnobg3BFI7aEYrK43ADM8WPSyOHmk5f4RcmsaftQkwlHGfGLNsnc1g00rHVcXZbKcU0x5BAkQNOvtiX+QzL0ZzF/7fJlmPXZq7NIcEWi7US0bYf7S2nd4dMkvkcAKsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEZJoRKk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEZJoRKk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78edc3e7cd9so165798885a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Apr 2024 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714157454; x=1714762254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yJvwxFcTYLVvrhwsYHxsoqzSVJd3Wrpy950jhWuu9FE=;
        b=LEZJoRKkl8AvD+hjFajD9ggKpyRjPl5i0v1fLEprOzAcmzeXBee+NjM2hLmkig99A4
         /KeDS3inUrD+QMRfHxC7mcIL4yIQuWR1UN22PPBuLiibAd48ot7ViPU8F6pF9GxCMKLc
         0a5v9fAJtGtgeudNf97U2VbLCKc0z8F51ElFY8ynutQXgEdpUwVEgynvn1tW2vIbSoGk
         0RQoMN2yrf0yi77ZDEMbCSH54IZc+h7QZMhtewpurDAPJ8o2SjtkA/uIeP+MvZjCC4F9
         cxhu0PlVfto7ei1LnjZxXTVJUaLSoHlPF6QdSm18PSq0cCIf7JDdxmqEqBiaJjINiB2s
         ss/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714157454; x=1714762254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJvwxFcTYLVvrhwsYHxsoqzSVJd3Wrpy950jhWuu9FE=;
        b=Bt+CKNpgVXfHjcqPQjXh17EyG6bYzWhRoo8QJmeSE9WSRGbbHK3Wnq1P8ranw3sRMf
         RTrE4ogR0ZrkLdHfSOnkGCUqQ3QaqgOzDJ4PTtRh2QNh+xaSvyLj62NViw8ZJi35Qt5J
         pxXs4XZK6KAs1f0kDtz18w1OlASoUUn4CAg6giT/2iWCMdz4uuMT7PZrxkgyPcNq8PaB
         pmy8w5rDUx1r+rxv53d8rAUamn2Dvk2ej2kD6+NfFZ8424S1hNrLZ4F73ObiqX4XAkf+
         74TS2ZAtxxGwnIsPbH8zzjxtkKU0/ys/hJ0Mxek4p+by33gIkqXIzcoJvq58gSgIjDls
         RVlQ==
X-Gm-Message-State: AOJu0YxdC9EGf8I4i5RsNenNfLWsjzrTajGVrWucxIhf+L8uCbr/Xz9p
	9LBQ/iZLcH/mQTftUE52w+GK4mW7ZEbK/L8BGyO5iugAnXRQCjSeLO7B4g==
X-Google-Smtp-Source: AGHT+IGswRFA60TNXV6DZUM536p0b4PXF5ecEQDri+cPFqPs9I4hKsh3n4yqw0kxKc0cl4yd5qlfiA==
X-Received: by 2002:a05:620a:c06:b0:790:9edf:5f10 with SMTP id l6-20020a05620a0c0600b007909edf5f10mr3516907qki.27.1714157454032;
        Fri, 26 Apr 2024 11:50:54 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a0e1600b0078ec71866f7sm8130633qkm.58.2024.04.26.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:50:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Add summary reporting for rteval
Date: Fri, 26 Apr 2024 14:50:08 -0400
Message-ID: <20240426185008.225739-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds an rteval section to the xsl file and generates a timerlat
report at the end of a run. To use it edit your rteval.conf file
to comment out cyclictest and uncomment timerlat

Another interesting thing you can do is uncomment both of them and
get a report from both in one run.

You can also use this with the summary report, for example

rteval -Z rteval-20240426-3/summary.xml

will work with timerlat now. (or both cyclictest and timerlat at the
same time.)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval.conf            |   1 +
 rteval/rteval_text.xsl | 103 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/rteval.conf b/rteval.conf
index 4c32fcf4d842..601410b51c28 100644
--- a/rteval.conf
+++ b/rteval.conf
@@ -7,6 +7,7 @@ report_interval: 600
 
 [measurement]
 cyclictest: module
+# timerlat: module
 
 [loads]
 kcompile:  module
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index f526526d4d49..1e9c0f0d26c5 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -201,11 +201,11 @@
     <!--                                                                        -->
     <!--       select="cyclictest|new_foo_section|another_section"              -->
     <!--                                                                        -->
-    <xsl:apply-templates select="cyclictest|hwlatdetect[@format='1.0']|sysstat"/>
+    <xsl:apply-templates select="cyclictest|timerlat|hwlatdetect[@format='1.0']|sysstat"/>
     <xsl:text>&#10;</xsl:text>
   </xsl:template>
 
-  <!-- Format the cyclic test section of the report -->
+  <!-- Format the cyclictest section of the report -->
   <xsl:template match="/rteval/Measurements/Profile/cyclictest">
     <xsl:text>       Latency test&#10;</xsl:text>
 
@@ -237,7 +237,7 @@
   </xsl:template>
 
 
-  <!--  Format the CPU core section in the cyclict test part -->
+  <!--  Format the CPU core section in the cyclictest part -->
   <xsl:template match="/rteval/Measurements/Profile/cyclictest/core">
     <xsl:text>          CPU core </xsl:text>
     <xsl:value-of select="@id"/>
@@ -300,6 +300,101 @@
     <xsl:text>&#10;</xsl:text>
   </xsl:template>
 
+  <!-- Format the timerlat section of the report -->
+  <xsl:template match="/rteval/Measurements/Profile/timerlat">
+    <xsl:text>       Latency test&#10;</xsl:text>
+
+    <xsl:text>          Started: </xsl:text>
+    <xsl:value-of select="timestamps/runloop_start"/>
+    <xsl:text>&#10;</xsl:text>
+
+    <xsl:text>          Stopped: </xsl:text>
+    <xsl:value-of select="timestamps/runloop_stop"/>
+    <xsl:text>&#10;</xsl:text>
+
+    <xsl:text>          Command: </xsl:text>
+    <xsl:value-of select="@command_line"/>
+    <xsl:text>&#10;&#10;</xsl:text>
+
+    <xsl:apply-templates select="abort_report"/>
+
+    <xsl:text>          System:  </xsl:text>
+    <xsl:value-of select="system/@description"/>
+    <xsl:text>&#10;</xsl:text>
+
+    <xsl:text>          Statistics: &#10;</xsl:text>
+    <xsl:apply-templates select="system/statistics"/>
+
+    <!-- Add CPU core info and stats-->
+    <xsl:apply-templates select="core">
+      <xsl:sort select="@id" data-type="number"/>
+    </xsl:apply-templates>
+  </xsl:template>
+
+
+  <!--  Format the CPU core section in the timerlat part -->
+  <xsl:template match="/rteval/Measurements/Profile/timerlat/core">
+    <xsl:text>          CPU core </xsl:text>
+    <xsl:value-of select="@id"/>
+    <xsl:text>       Priority: </xsl:text>
+    <xsl:value-of select="@priority"/>
+    <xsl:text>&#10;</xsl:text>
+    <xsl:text>          Statistics: </xsl:text>
+    <xsl:text>&#10;</xsl:text>
+    <xsl:apply-templates select="statistics"/>
+  </xsl:template>
+
+
+  <!-- Generic formatting of statistics information -->
+  <xsl:template match="/rteval/Measurements/Profile/timerlat/*/statistics">
+    <xsl:text>            Samples:           </xsl:text>
+    <xsl:value-of select="samples"/>
+    <xsl:text>&#10;</xsl:text>
+
+    <xsl:if test="samples > 0">
+      <xsl:text>            Mean:              </xsl:text>
+      <xsl:value-of select="mean"/>
+      <xsl:value-of select="mean/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Median:            </xsl:text>
+      <xsl:value-of select="median"/>
+      <xsl:value-of select="median/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Mode:              </xsl:text>
+      <xsl:value-of select="mode"/>
+      <xsl:value-of select="mode/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Range:             </xsl:text>
+      <xsl:value-of select="range"/>
+      <xsl:value-of select="range/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Min:               </xsl:text>
+      <xsl:value-of select="minimum"/>
+      <xsl:value-of select="minimum/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Max:               </xsl:text>
+      <xsl:value-of select="maximum"/>
+      <xsl:value-of select="maximum/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Mean Absolute Dev: </xsl:text>
+      <xsl:value-of select="mean_absolute_deviation"/>
+      <xsl:value-of select="mean_absolute_deviation/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+
+      <xsl:text>            Std.dev:           </xsl:text>
+      <xsl:value-of select="standard_deviation"/>
+      <xsl:value-of select="standard_deviation/@unit"/>
+      <xsl:text>&#10;</xsl:text>
+    </xsl:if>
+    <xsl:text>&#10;</xsl:text>
+  </xsl:template>
+
 
   <!-- Format the hwlatdetect test section of the report -->
   <xsl:template match="/rteval/Measurements/Profile/hwlatdetect[@format='1.0' and not(@aborted)]">
@@ -340,7 +435,7 @@
     <xsl:text>us&#10;</xsl:text>
   </xsl:template>
 
-  <!-- Format the cyclic test section of the report -->
+  <!-- Format the cyclictest section of the report -->
   <xsl:template match="/rteval/Measurements/Profile/sysstat">
     <xsl:text>       sysstat measurements&#10;</xsl:text>
 
-- 
2.44.0

