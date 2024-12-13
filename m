Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E518F2FB
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121099; cv=none; b=LZiCQnwXwkTrvP0facJYAAgGWXhLlOKO/ACOIMY5SSJHPKaGfaA4J8FSxAQndxxB0kkVBZx5VMZ/EmRUb++CHSxnqHXjfXhJWWxV1sG13e0zX1fWEx5bTagDbzZgz50gwu+RkeAt0iR0xejdoMVJtVQiTn99V0jLoc2BYbRWDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121099; c=relaxed/simple;
	bh=EMa1SJfHocn2Wo6sVtkap0P3s3ftqdXD71JBGaO4xm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IO/CrbYTX7mQaVC44yriW2zOlD+tZbD0TgAr0iUo17Md3TJeEmQT5GDq24rM85PB76HY58EP63/d28nGwNnaRRWd78hM4Ic0heu0QOafQQVevYU+SENneWgPX3PrpTiCILMOt/zRjrFfVTqcSciqygrwItWXw96MMwHkbRRihx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvZbcvx1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvZbcvx1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a3f1e667so8252951cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2024 12:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734121096; x=1734725896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jS+QUs95T6y9ilZMfaELdLAaEmTkJHYCoX2ClhjKuyM=;
        b=jvZbcvx1O7vB7ebrhEs5TrHaB2fEXb6MS2yhoeQ4n8vZMiUHRd/j1DFIdSzOTJkrMM
         m2fjDqDt0FsNYdsSvEneaJo3TshmPWDd3VjdDo706XYBsn38rb6uKERb+2ipwfhDqFRn
         AIvAC/HYumpAXx2hS3SxLwMJKlY4Q4CaVF5NMlHplPNyGWkzr1gUcuoUqJqeh0+spVsK
         m0esv/Dh3dmMiU5Eh+23TsI8sMdau909w/aqeWisWRQIPkKwR8kbVSpPIH54/jB3gTiU
         JZKgOVSmkdlZ/OUvt7GCp+UGy9djgfdX9X9dbd6ERTl//8y5ZVj+VZvWRLHnCOKKCcpZ
         KcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734121096; x=1734725896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS+QUs95T6y9ilZMfaELdLAaEmTkJHYCoX2ClhjKuyM=;
        b=kjMrDe2hdhbYRp5U+dzwP26ew61zkw6QregPVFbRB9oilR6sP8pkz1keEMtC/Z7qJK
         uBeB250zND//cNATmTiqKWf5KaqRFpl2fHKfM36LNUUsh3gb1uoa1yk0iP0W++p2jZSP
         egVxALA2wHBK/stoaFwT9dkvOrEpas8CBdWLQHyJ0OpHgVwS5x1xPcS+/tG5Rhkra/4L
         wZYKhvMO8N7nq0jyTbMf1I+DcM5IgkHRV4KGm+I2knTIaw/GtAyfo78lBw5+TbnmhFOq
         s7L0VIC+8iOLpAfkl1+U37eji0CrUH45aSdBw2Mu03v6low6Q3HFZX53BMRgdhTy5ASC
         mmBg==
X-Gm-Message-State: AOJu0YxFEgVtvJIXlUvebXvcyynOQE1+9bm7YqpiZZbdpS1dallfop47
	4aqRmS56HCf4qTyiL5zWUlmAQAW9FZbur2Z9ESs3L+Ow85ASt5ROHBkTLA==
X-Gm-Gg: ASbGncvxt4ooobPpnSYdRzQuX4NfPbOaFIdSvxtdijiEF1DIEiEgF0PhFzrzi5wwQe3
	opfVJphSNoIawdT7DdfUCGSGe2ayArGRZPGWadoMnUkXm6p/0lxRkETPMkDZR27E3763M68Ojj7
	ZzHjgMftH2b7BixjVoFs+sEtyGvYkUci0OmGICY7cZ18DY/P/2WD3ch8TmhoPugTD/65m7VPjLE
	HXM07Sl8RC5qS3JaBBWIKzsp0ZK5z0uCfw0FI6uL4n1MFam+FaB0yp/KdRoLw==
X-Google-Smtp-Source: AGHT+IHUJQ5TYFurYWf+lEQ2QDwYceZNUZ5wDinjflSZtgsLVKRzx77HN6SQ/qC7ASCyBgAt13yhIg==
X-Received: by 2002:a05:6214:2684:b0:6d8:b401:44a6 with SMTP id 6a1803df08f44-6dc96853460mr60054456d6.43.1734121095744;
        Fri, 13 Dec 2024 12:18:15 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd363165sm715456d6.78.2024.12.13.12.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:18:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Fix missing statistics for system with timerlat
Date: Fri, 13 Dec 2024 15:17:59 -0500
Message-ID: <20241213201759.190139-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing statistics for the system with timerlat by fixing the test
in rteval_test.xsl for stoptrace_invoked

In addition
- Add --no-summary to the rtla command line
- Parse out "ALL:" for good measure although this should be surpressed
  with the --no-summary command line option.
- timerlat reports stop tracing when receiving a SIGINT, so also check
  whether the maximum value is greater than the --timerlat-stoptrace value

Tested the following scenarios.
- timerlat-stoptrace USEC is NOT used
- timerlat-stoptrace USEC is used AND the max value recorded is greater
  than the value to trigger stop tracing
- timerlat-stoptrace USEC is used AND the max value recorded is not
  greater than the value to trigger stop tracing

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 14 +++++++++++---
 rteval/rteval_text.xsl                 |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 3fcdb5ff2819..5bfc495217ea 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -230,6 +230,7 @@ class Timerlat(rtevalModulePrototype):
         self.__cmd = ['rtla', 'timerlat', 'hist', self.__interval, '-P', f'f:{int(self.__priority)}', '-u']
         self.__cmd.append(f'-c{self.__cpulist}')
         self.__cmd.append(f'-E{self.__buckets}')
+        self.__cmd.append('--no-summary')
 
         if self.__cfg.stoptrace:
             self.__cmd.append(f"-T{int(self.__cfg.stoptrace)}")
@@ -392,6 +393,10 @@ class Timerlat(rtevalModulePrototype):
                 self.__stoptrace = True
                 self.__posttrace += line
                 continue
+            elif line.startswith('ALL:'):
+                # We should only see 'ALL:' without timerlat --no-summary
+                # print(line)
+                continue
             else:
                 #print(line)
                 pass
@@ -424,17 +429,20 @@ class Timerlat(rtevalModulePrototype):
         for n in list(self.__timerlatdata.keys()):
             self.__timerlatdata[n].reduce()
 
-        self.__timerlat_out.close()
-
         self._setFinished()
         self.__started = False
 
+        self.__timerlat_err.close()
+        self.__timerlat_out.close()
+
     def MakeReport(self):
         rep_n = libxml2.newNode('timerlat')
         rep_n.newProp('command_line', ' '.join(self.__cmd))
 
+        max_val = self.__timerlatdata['system'].max
+
         stoptrace_invoked_n = libxml2.newNode('stoptrace_invoked')
-        if self.stcpu != -1:
+        if self.stcpu != -1 and max_val > int(self.__cfg.stoptrace):
             stoptrace_invoked_n.newProp("invoked", "true")
         else:
             stoptrace_invoked_n.newProp("invoked", "")
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 70f3e0fd4b1c..146302744f58 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -342,7 +342,7 @@
     </xsl:if>
 
     <!-- If stoptrace_invoked is true, no Statistics are available -->
-    <xsl:if test="stoptrace_invoked != true">
+    <xsl:if test="stoptrace_invoked != 'true'">
     <xsl:text>          Statistics: &#10;</xsl:text>
     <xsl:apply-templates select="system/statistics"/>
     </xsl:if>
-- 
2.47.1

