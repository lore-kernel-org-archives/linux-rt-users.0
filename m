Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E018DF89
	for <linux-rt-users@vger.kernel.org>; Thu, 14 Nov 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617563; cv=none; b=WXjMvTqz4svwCmS8eHQPJkzmxfS2vmPdI/H1e5n8Y/80WBnNS9xej3TbYp0q4sGgcV5p58CsnTgZXt9TL/dldUA2qzC5NZsMGHzkbkzhfw4cl9gaC0vdQUJfj0JzPLF+QNoTvshFHncHQufIodTEn3Rv8FC1Iym/VKYOf7ESEEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617563; c=relaxed/simple;
	bh=KFi47GKn7XUklh+ywLyFQAJJpM+XBYyN3peGYN31+Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjQtvrDAS8DjEj+xLAELnO93R5gnzctTQhDibbGF0n6bsuRqqAF8eQ2zBcPiSuexv1c9b7h6iQBA2zy5QB9eY5tWNhmlF1yPnFjLGaV97arN4hlEMaxP8TmmJQ7u1XtklZpC7WuDdKnawrTsmeY3N9oM8hArtMsxRG20BOuZsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZVNZa/I; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZVNZa/I"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b14554468fso66610185a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Nov 2024 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617561; x=1732222361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZPqGkqHRywePOg3cilNG9Msq6ZlH58z3PQGwbE0FHM=;
        b=dZVNZa/ICDHvdYdBel54NsM1yf0Nzn2jLCr1QZLQ2Sj/81slyf5HVl0jhihaFh77je
         u5N7Iuu6O0qpB63gZdu7YOUhxVrAx7fCC1IXum6FHdCc/wX5wKffuHuBQTGOk1iYFgns
         a4Z1RAxCcJPXC3L0ze6f5Lugvi0AozQY+kk9d3uahCD+2DwsSEovdytc9t3QqEMiolxA
         fDBViryw4uh8Us1IvvOHlUmkZzpbN2jwgogjOHnhOdcuUszCPjhXT1Xo0N25GLQPS/H7
         OfwVxzGZs5mVTPLvy5kjoMZW++yt3j7FL2Dzyf7d6u1ocqXpoRinsvBU8XENJHbZz69N
         laaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617561; x=1732222361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ZPqGkqHRywePOg3cilNG9Msq6ZlH58z3PQGwbE0FHM=;
        b=jvOJRXDooCozR6I9qcf+qxFKGGfMWRsC26YdPG95HqJX6gGW0iYVzztsdlxjtiASWe
         BvttPf7gNbbRYLNTLngK96AuZTMNXwGcU6FRmmE4si1gg7JRLNthuPF/DiimPJQXzfnD
         ahhNxHTqSeSKq/uVCb1fFGeIGK4UHaLAnoMBVXFIzf7pETMx//e8gW92A5ya6lcensLU
         L3GN3+AsMYZ3c9nmA1KqICnrduAyoI1CTXrIX8DmBGOs6NDxydvHnXN4HerPG8igE/ZI
         aZ62HNR9QNxIqGRMdlf1xPBNtDB68zV02kU77ZGrxeY0VGdtZAFrCiSY1nd3TLpgtRPI
         A8TQ==
X-Gm-Message-State: AOJu0YyyzGi+2ZNi3460aeU94uZhF+ym8QZlB5Aj3iVzalNMXsPuDJBN
	6DRLfs1n5Fpj9SAAfRUZUgmCYKEtGyQkV0AT1K92qElAoq3fmSalnndvug==
X-Google-Smtp-Source: AGHT+IF9YLAV53q/LZ6YH1/1/qUjjpI01gcRyaSg2iabKZ6Vv+9kLz66DfOIM5NPBG7ePkVmPfxM2w==
X-Received: by 2002:a05:620a:1996:b0:7b1:3f19:b81a with SMTP id af79cd13be357-7b3623678aemr41744685a.53.1731617560644;
        Thu, 14 Nov 2024 12:52:40 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca51c6csm88203385a.101.2024.11.14.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:52:40 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Make rtla timerlat the default measurement module
Date: Thu, 14 Nov 2024 15:52:31 -0500
Message-ID: <20241114205231.252497-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114205231.252497-1-jkacur@redhat.com>
References: <20241114205231.252497-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change makes timerlat the default measurement module.
You can still run cyclictest by editing the rteval.conf module
but if you don't specify, timerlat will run

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd  | 2 +-
 rteval.conf | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 4e13d312a24a..9875903c0107 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -250,7 +250,7 @@ if __name__ == '__main__':
 
         if not config.HasSection('measurement'):
             config.AppendConfig('measurement', {
-                'cyclictest' : 'module',
+                'timerlat' : 'module',
                 'sysstat' : 'module'})
 
         # Prepare log levels before loading modules, not to have unwanted log messages
diff --git a/rteval.conf b/rteval.conf
index 601410b51c28..46a9b1743716 100644
--- a/rteval.conf
+++ b/rteval.conf
@@ -6,8 +6,8 @@ duration:  60.0
 report_interval: 600
 
 [measurement]
-cyclictest: module
-# timerlat: module
+# cyclictest: module
+timerlat: module
 
 [loads]
 kcompile:  module
-- 
2.47.0

