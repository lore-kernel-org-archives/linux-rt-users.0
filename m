Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568233CE9D
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541890; cv=none; b=jsLsGkLcWDRNcEC9uBXLgC0CdZulFyEmSTg/Qqu9bgkMV0Jq9YOyNboJ3jszVVOUf9sV7rmQ/LJdQzur46aD2VUPOXkKTTVW1S2ia500EuOeISZFUrX99wYf3RevvCWzVieqJ4Agmm8c9YtOxQTmcat0s8ZGTvwMBID9e7HOKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541890; c=relaxed/simple;
	bh=O2y0HKU1BZoVaZgtLrOZraWEfYoAlHrcp3v1er8whzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgVE2MmMDntcxt30MChBcQg7wwKVAJMk1dREsPlKuN8nIuFWHvbFQIR8zOPZoCnrdQFZD6zUUiW8sJvASlL6rU5FpSj6Npdx6UKTShha5W+rvvvYPAz76LvUAj528sfNmuj4v7vTKDFbqXM7fJ+iTXLM7Wja+tHI7tRfI4Drj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMb++H0L; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMb++H0L"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b13120ed52so88664885a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541887; x=1763146687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrFpFezJc7j+ynmtPqaFhhQM6nSrUSp37fPYuI9Y06k=;
        b=CMb++H0Lm1Qf0XePf9w83FNIXkYSwSyZrPNjzxN+S7wJBsBNL5qY3NexZ+FRa1bQ1c
         mNreiNPC5cFCl1DzZY2Mk8JiMqSfWCgNkfHq7DVzGXmSvsrdP813Ud6IRTtzSh3JCIzq
         vrJ1h5rPSEQaA7fi/stT3o/4DCmgzjfcjLYDcktVg0Ear8Xo/L+rpGKijHjgDdWuCgw1
         2weufOzYqR7hIXaDDkXWT1TSBgzIKIS5u2o1SmTSrtToOp+HesmYmbA0LPQbZD7MFiQt
         SrD+2j2qMfHf4whOkjgxLOt+gPC9cohYTMv8wT6wOxZxYYLsGOZXDWbr3a/tHU/n2Pk9
         YDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541887; x=1763146687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrFpFezJc7j+ynmtPqaFhhQM6nSrUSp37fPYuI9Y06k=;
        b=IhANi/tuB1aebsQGGifTGqopwIUPp2q8sjppJ7Q3nvjJfJ9/1KuECgKBcYkOUIqz6S
         8CoJN6/k7hUO0I3uJqGvEhBBqhjtO5pl91nI9iFqsxm/AwUKcbtm2MyZB1dyz9YHtv3T
         LfwO8kIbT1kUXMoix100EIBGJGZHPDnbmSnFRO4+kyZ8kN2B02U+IggX4qvElKHF6Qvl
         eZLmp+3IEFFluxieHCpua0q+NCiduRCPQVSl5P7xyFw8/P9vnIZ6lvoZF8jirCSM6A1Q
         2K+Qy6nuf8guPC5XtHcQhtXk4cWqzTnhgLXKbCadyihaDXEVy2ygZJLkwzhTif1OWGar
         ZOcw==
X-Gm-Message-State: AOJu0YwnTkp+a162NHD2z5rW2vs/xYQnijsxkkayvL15D+n3KMGaUgFN
	hHfHQtLXxUpv9hBR8fGzpzVW9yvg94h7OU1aPmWGgFgsHc3ZOnWDdogIDPW/eBQ3
X-Gm-Gg: ASbGncsnDqhLFqnKxdtTJ6MUusKjEUgULp7f7bHHzW4TGPrG+w7sKtW03OHkxkCYf05
	j3xQgBRZrU133tLKS3jD/JYd7ks3w6L9iYQbWIfrsjKUP585RIoCHxyEz5Sr4jjg7ztQidUTlxh
	15ESM9/+cwkKCSgLrlIZXJwPFq+HroAs91BYqyAcxO30fkFQ3fEQWeyYTCL8kYNbYpEanUeJJzb
	+/npFdH3xlcNf7gfbPVWeNzOj/mTHQZssTFHtGK4Fcqpr+jOQnF9aevc96eNujFSCVm2YfvTIW9
	noqTWbaBzzuZai1tvj7YValbQO9w2VMdndFCYUBa7S9VtilHw9DkUEHy2jgza24GJqENCq40ZSF
	WaQDU9DggmNpNzKhBEcKOlUvf+S8AaI3zcCzjKY/xclYFF9PpXgO0NJZPRdnaFxc=
X-Google-Smtp-Source: AGHT+IGsLAtayxR5pnzVMMqX3HNofWSIEmvU2h1sFNZhYeLIpnzYo4IKkkK33sLq9C4oaaVlr3GOcg==
X-Received: by 2002:a05:620a:2a04:b0:857:7b07:3af0 with SMTP id af79cd13be357-8b257889eb3mr74959985a.24.1762541887369;
        Fri, 07 Nov 2025 10:58:07 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:06 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 09/23] tuna: utils: A few tweaks
Date: Fri,  7 Nov 2025 13:57:18 -0500
Message-ID: <20251107185732.23992-10-jkacur@redhat.com>
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

- Change copyright to 2025
- Use is not None instead of !=
- Add a few document strings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/utils.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tuna/utils.py b/tuna/utils.py
index f55432dbbbb0..75900bde3d51 100644
--- a/tuna/utils.py
+++ b/tuna/utils.py
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# Copyright (C) 2024 John B. Wyatt IV
+# Copyright (C) 2025 John B. Wyatt IV
+""" Module to return cpus and nics """
 
 import os
-
 import tuna.new_eth as ethtool
 
 # Collect a few globals and functions so they can be reused in other modules
@@ -12,17 +12,19 @@ nics = None
 def get_nr_cpus():
     """ Get all cpus including disabled cpus """
     global nr_cpus
-    if nr_cpus != None:
+    if nr_cpus is not None:
         return nr_cpus
     nr_cpus = os.sysconf('SC_NPROCESSORS_CONF')
     return nr_cpus
 
 def get_all_cpu_list():
+    """ Return a list of all cpus """
     return list(range(get_nr_cpus()))
 
 def get_nics():
+    """ Return a list of network devices """
     global nics
-    if nics != None:
+    if nics is not None:
         return nics
     nics = ethtool.get_active_devices()
     return nics
-- 
2.51.1

