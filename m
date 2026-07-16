Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2B443AA8
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223981; cv=none; b=L2dZJHlz23rGks4wMUox54j4BeuRfYs9wLFJvPVxo+uILrKtOHuK8JdkoETLVg2NJwNS0wge7x0ewbpY36EaZc9jiBYZy2VWqxAKg2awJJ1GcjmtSRh2F7k+uY7J6FGTZNaGvWQ1BQ8492IReJF2YhmAKykqRU/p4L6i77IAC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223981; c=relaxed/simple;
	bh=8ChrZr0CByIJVg4ARS1drmbGTwsfTh1rE7UwBB8rmFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtD7EWX0b06tkPgkDgNyCimqwu91G9sVg2SH9nZmdtris+CMF0UlVUaxgLKf1JMembbAxSmtLg5ZBG+K6buedsCfPO1RSyBPBX1e6vnd2fY/SuKmylkyePfzahgCJ9YNpH/ojAB7TcMY0MP6h6zFyY5815oMSqQaum9eajjBlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj8W+eTh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj8W+eTh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a449c57so64173501cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223978; x=1784828778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFhOdOM9mVgkGFUMYnZPsQBw1VBGppGnFEMAWwEpj4o=;
        b=fj8W+eThpAdHgS3KUT72UejSChivi4iAnwkMmszo3TQTrnyuzknh3hBjZCslrH3c/r
         Qy4kOU5Y76Skbb1E6/5dV9saaYqX/g0uAbV1aEbGcsQZS1JEqyd8YGaV5ITFprfBlcPO
         OJTu58BBQZtzmo3fqCcgemzP8H8teMVRPAbjMMMPAKcmr1tdu/dwG/J7FBmJP6DVtbeJ
         j9dVPHjZ4HmSwvVIQsctNN4lkQA2eiMyUibMCD2RMfs/x5qIrtBjve4qUtihCZkKAa65
         /Km9pMHKYTgZO1z5CLIJmjWjMRWpnZLvhHQSHgE/g2aOqsbNhLxFoRFk3xKNgJs4jajq
         39vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223978; x=1784828778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFhOdOM9mVgkGFUMYnZPsQBw1VBGppGnFEMAWwEpj4o=;
        b=BLOSabJYwYfyKdtTIOSmODkk6xkdSpXWfHzEuZDm+6xvyhO8dTV2B8Oqxkinmmc6aw
         wEBnzKl9JKRzn+DFPL3cbRwrIrtA+G+CPIUCRwTRLnoAzuKqRzdZ7K+P2FpkBP8qlNcV
         1aaHwc+L7TrrhQ/p7V/IzqNf026/zDhtRCrJxyEcSPcBortTFqFIhyHc9V4XIVdm3Ycx
         Mv3NyVKKfqrxohrSFdq7NP7vGhp3OxJR3z5HPDqD6Iqshi02woRHI9rdpGXcJwvmg8mk
         zTq64o3i92EIFC/g7/gRh8itxXfneDEAsYffIocwckcECY7K2jW/ANasMQ61a/44pdEs
         AfwA==
X-Gm-Message-State: AOJu0Yx8dSTpsHjKm7DmnOrEJZYIiHztZ1EmwskNeqh3DK6Ex+vD1W/B
	R0VxbDQiEtxD8BxbOszOeITGsE7JS2TOgfDJx8E4nrRB0inx6f0Go8GXgIXdfw==
X-Gm-Gg: AfdE7clvjgA+A3ksZ4yMcikEgela5OPXOtZuoiaO79GzahMl+zmydW+AWteclOmudT3
	1uE+fuSbT+tt2OZDIBMbsjvhSgYI8p+PV8w/oiRqc/APXWuOEwXOgSxzgGMIhkIT90wne7fWL6M
	7ibQ/Aagup9aWWAoiYYNpls/Yb1a6tGhl5qoED/Geaah4o7yEPFpy3TBf7B2Y7bPUg0IXuEHIry
	jWuzC4VuwkNvtf71Os4u7ZYqI/F7Cq2L69wqFgTIlpTt9oBOG2c8pt2BRumYfsalxyhEnG11eyF
	HlAw4C475PBFBONVFnqzJE/J39oIO9DNfaAnwdu1X/ypX4o4TmKS8lUrNUQ+jOTjybdOoTGG2G5
	PotdoPin0tCM7gxEGIlRbACegGmRLGyPocGDRKejboD1GGVg+dKKJmEOQwn+elHsLa0cg0ZU6UQ
	uwf+eH0fxgO7vxqO6erz+U69qvPwEwIjVYU7YCDsYeFzneFe7HrfQ3pNCmezdRCyzpnlkg
X-Received: by 2002:a05:622a:9:b0:51c:ba4:d837 with SMTP id d75a77b69052e-51e3c1556famr137965301cf.18.1784223978501;
        Thu, 16 Jul 2026 10:46:18 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:17 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 7/7] tuna: Change default profile filename to cpuset-profile.yaml
Date: Thu, 16 Jul 2026 13:45:50 -0400
Message-ID: <20260716174554.126145-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716174554.126145-1-jkacur@redhat.com>
References: <20260716174554.126145-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default filename for cpuset save/apply operations has been changed
from tuna-profile.yaml to cpuset-profile.yaml. This better reflects the
specific content of the profile file, which contains only cpuset
configuration data.

This change affects:
- tuna cpuset save (default output: cpuset-profile.yaml)
- tuna cpuset apply (default input: cpuset-profile.yaml)

All test cases explicitly specify filenames and are unaffected by this
change.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 3d4414d93d0e..5436f68c5029 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -324,13 +324,13 @@ def gen_parser():
 
     # cpuset save
     cpuset_save = cpuset_subparser.add_parser('save', description='Save cpuset configuration to YAML profile', help='Save cpuset configuration')
-    cpuset_save.add_argument('filename', nargs='?', default='tuna-profile.yaml',
-                             help='Output YAML file (default: tuna-profile.yaml)')
+    cpuset_save.add_argument('filename', nargs='?', default='cpuset-profile.yaml',
+                             help='Output YAML file (default: cpuset-profile.yaml)')
 
     # cpuset apply
     cpuset_apply = cpuset_subparser.add_parser('apply', description='Apply cpuset configuration from YAML profile', help='Apply cpuset configuration')
-    cpuset_apply.add_argument('filename', nargs='?', default='tuna-profile.yaml',
-                              help='Input YAML file (default: tuna-profile.yaml)')
+    cpuset_apply.add_argument('filename', nargs='?', default='cpuset-profile.yaml',
+                              help='Input YAML file (default: cpuset-profile.yaml)')
     cpuset_apply.add_argument('-v', '--verbose', action='store_true',
                               help='Print detailed progress messages')
 
-- 
2.55.0

