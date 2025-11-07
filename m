Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BD33F36E
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541902; cv=none; b=KrKxedpTlHU6zs+Soi8up04hVJgjPToaiWxqhhXhUS9AwYNNNoI+QsFTiur/WssfG5B28lkiRHt9f9c0ieiqhTBv2FYjliidJcBlGrUAF4tNGIGXkF7BA9nHvaqvqHmFcy9in6OQNM/ZPqq/uuIPiTHRNOZDxmOaGXNTCReJtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541902; c=relaxed/simple;
	bh=jngxCYksZTS4tt0ARlisHczBIkID55lPwyw43b3rvCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kerDAB0OuPVpo9QbZkxGN1gVZI+fb97STwOwIMzM5Doj/1vDPpIusHkLfvnZxrJmScsJ3TFdzfCxOBJ9LUJhC2bUex5QcVduEIwLrOrsj+6+Zex5HxQcCvnz0Hlx5rAaHSvmNQjBztTr8xp/fBEAcrlhC9CD1W7wcHoAUVZJDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl5Y7v3F; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl5Y7v3F"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89e93741839so78370385a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541900; x=1763146700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsnXPRAn6A9eNFlABbJt6acWqa/X0+XhC8p29C2ad4s=;
        b=dl5Y7v3F6k8pP+1Dgvss03c8dbXBqPjXOXzBiZOj+hPZM3R0bmQzFzDAN+WUVIMboM
         M9e+oUQsR/p6oDY8kE1r/jB57Cq9aFBG4CkH0wot0/AQVfszW/vYu0K44SLjk0LJG22i
         1jNXSRfoPUje54yhzUXLnC9GPDBdOt908rdfd5eiJKwjdH9qLauB9VWZXt0dDbwxpsD5
         WoOj51C3Xp2YwoTz4RHzpFiOyzj180R0jIr/CXjMzNAGV0G8+J2SlNVatpD1uyOPHZXX
         wFOtgYJrr4KqtRpXhHMx7OanVxpWnEU4Vf/Sihrh/HUtpRyHUS3O/hKvd0hitkn78cQB
         PFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541900; x=1763146700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsnXPRAn6A9eNFlABbJt6acWqa/X0+XhC8p29C2ad4s=;
        b=XvxquOhnraCUVrv333j+Sn/qW04xZ6s1AxfER+somO2S1YVS40jAcJ93oClhUYnqFL
         eD4rK3poXGCnf3Mo3+dCQiTyjn0Oc7JtfrrlabtL5J7ATRpOZnRewr2iY0rL0xqwAh+P
         MonxnpDtC5nSqHUCOR4y9lEMAFZYBVhPyyKrwUhpfTQbu7EE9YFzsAkMliLcpalV3QFl
         JYcgEd0Mv50xsARxPMDsjixBywS5MPwiTNOdql0YYNAnyH3sXOBgwXbr8A2BXozVOSQL
         cG1+ClKjyy0FFLdI4hxVOjEVcR5wY/UN1VGv4gAEkChjnK0ePg6lHJrBrL7FHEj2VPIe
         +BdQ==
X-Gm-Message-State: AOJu0YzvDp5sc0YkCCNDs/pDY7HGOrhNODmAQxl3MzUlRmvkxkakRyFK
	EyWxBUnexUqunU5onjXYxygRUaavxqcL4rG28U2Ztohu8T0V/MFRN+wMTJ4CvQpI
X-Gm-Gg: ASbGnct31MqSkp/a1R6WczEir/CrSdyMQgGyVwKGMRt/79SzMoUWsLdAuoo0R49dDNN
	gidO8/ExXaoiIfVMSbjXTFwQxrrkJuR2f4qRZop79gSxos4N/pD4FArvMEpT4yjr2KKl/Qrwklj
	yBpL+VvmiHcLys21wzOS1lLoaFXnCLgHrP/YU8KyBFF89N99XokL3mJiX/M007x2k7iTzIZi7V/
	QbtfcqzseW7pz1gpthHnpqGpJeLzBV6Py+vS/VJVF2/ti76ayKLxIdB4jrq8AUnYi2eXQb7NYNW
	DrAjpEtIbyRPRriYdrK/V0CmPxvOyhcO0LWchXJR8+A1v0I2ITbttx2A1OsPmcA71LUT+JULOrn
	CMsd7UHnGcbB+IWAGtM6OCPgMrhtrkT7zmNhl2n91c9iDMSYhJzvNDnGhy5iBV5Y=
X-Google-Smtp-Source: AGHT+IHyKEEWYVoT5Wc6P/hfziN8EoAXu7/W/FRtaHa3ERHWEH3p6/cKnZ7V5RTTuTB0MTm7ZLkvuw==
X-Received: by 2002:a05:620a:294b:b0:849:e64c:b7d4 with SMTP id af79cd13be357-8b257f68d83mr45590885a.66.1762541899733;
        Fri, 07 Nov 2025 10:58:19 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:19 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 20/23] tuna: Update setup.py with co-author and metadata improvements
Date: Fri,  7 Nov 2025 13:57:29 -0500
Message-ID: <20251107185732.23992-21-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add John Kacur as co-author alongside Arnaldo Carvalho de Melo
- Add explicit maintainer fields
- Update URL to current kernel.org location
- Add project_urls with source repository link

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 setup.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/setup.py b/setup.py
index f119e75abdeb..00a79727ba02 100755
--- a/setup.py
+++ b/setup.py
@@ -18,9 +18,14 @@ PYTHONLIB = relpath(sysconfig.get_path('platlib', SCHEME), '/usr')
 setup(name="tuna",
       version = "0.19",
       description = "Application tuning GUI",
-      author = "Arnaldo Carvalho de Melo",
-      author_email = "acme@redhat.com",
-      url = "http://userweb.kernel.org/tuna",
+      author = "Arnaldo Carvalho de Melo, John Kacur",
+      author_email = "acme@redhat.com, jkacur@redhat.com",
+      maintainer = "John Kacur",
+      maintainer_email = "jkacur@redhat.com",
+      url = "https://www.kernel.org/pub/software/utils/tuna",
+      project_urls = {
+          "Source": "git.kernel.org/pub/scm/utils/tuna/tuna.git/",
+      },
       license = "GPLv2",
       long_description =
 """\
-- 
2.51.1

