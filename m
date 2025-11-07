Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39E33F38A
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541906; cv=none; b=U7Cu1p+bTA7+hbuORYcp6v/Fq+1JD5oXlU6JC7RcUUOIYSGFzMSSKGNTTSfp+dDdMpFO/dvb7xq0WXTGttFkqwDjYXl5O5GwCRHdjp3y1GDHurJ1eUnVcKK73TM7zG9/PxsYDCS5Q8ntTPkkN/Q8rYy8tiJZR7l6E4EHkbInFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541906; c=relaxed/simple;
	bh=dpIbS09gLEakYAcCR/N+EA8zeaH66uBkKz/7yY5HBhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n46mMxIzT71CjgzQngPkvM3FA8LzXCRlwLGbsF+glYPtGnNK+VEoahpNrJdSo9UZ9Di7LleLtJlIXBSxYN9RkzNNF7m9VbpLW6MMh8VRqMjtzNF8NGnKbTPWhPnfo6l+DKAT7lqWpUsQPRZU7QQbUdLwPI/ey6H+OmmM7wotbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyVhLlHE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyVhLlHE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b19f149933so107185685a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541903; x=1763146703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhrJnCNsclqJcWU/Ux9kxT9SwDFlkbwiMzQeTja3Q28=;
        b=HyVhLlHEN11oG0szJrNti06knfWvK3PdUDQn3b6jdQo9dzVCmGIGdN+eQ+nkETtrMM
         L73C0KQa+irA0WjVURK27KWg+oPwSrjgFZLw0MSKwsPprrM5SVNuvcLVohXbmths7Nyy
         9A8GIHcpzu5B67/iDtYe7FDH5lyug7Pr7WU+vGFeUJ8SGhSGb9Je+T7OdYYIdiNDjIOv
         4YfTKYPp3BkllnV7InKb7WArBkVKtQYb0q7aurcM83oLpqnIDoi7oaHs6bdQ1XIJQ7SM
         uTIPgLKWl40iGHsurL4rTRWw20LPOuLnFNDz7BrN7Rpg1XMHRjOfZRDM1qJzw41Mjtt5
         gAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541903; x=1763146703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhrJnCNsclqJcWU/Ux9kxT9SwDFlkbwiMzQeTja3Q28=;
        b=GNBfCPJKJZfy+/AakHx+6CLRkm/04DxlV/uM/JXaPytRTRDkbra0Se2OswAjxiJPGA
         cWpcU3LAKm0trjvfQUfEFy89/2PNncHpfBbbi0YK/wnGJT30KyoyEovwDePynhp829Fl
         LBSXOJ6hvyIeZeFR+EzsYih2M0UmG2bl0xyEgHgLEctsNEbt27Q1MXjh/WtCpZGZTZsA
         ACeakA6k8uhD54HheMGHqaeje1tX0XHvdGqhDRdyyUHAyvr5QCKxebgskJagN6gIGZ31
         h59KZSUITt55SngGZ9HG2wCjPdlutcC7kSUHhOiUDek2FiduL3zuQFkTCuZnJKjGIIio
         yV6g==
X-Gm-Message-State: AOJu0Yz8W/Z/jRs6wGt10FmtoOC38BZjji7xnGAL2NQ89lFPLL4STLXq
	huHL6QPJzA+362hPUakIfP8hdpBW95AEkxT1H2wr1SRFg1hl6HmJzQpXY+B9zy8Z
X-Gm-Gg: ASbGncsu/1rEJS4epDLoKHSvwdZO/mXKzoBkM0jW0tCm1Bt8JsM9svp8CkbSmbJwRHA
	q7RNKm9G0hk4zEp5GaZQW6piariTs3/x03IIK0axiBzzkuzX1mFOhLjxqMXMvn6rAw5jDQ/F2UN
	vge/kiYKasZa8Mj1yi8jDqalEMXGFj2bWzU8XFlcIM+TMdqXNj+mKVblpZlJnEktyJH5PzddDVB
	FMJDnzgIDX3naoIkOuC0HRK79cHZ4QLeKHc0GO2SA1anad7RSC984xzrCktcWaahCAnmiQK4U+g
	GtvPbZBlEpjivjs31TYme4mM8a0wzW6UyKzvuWgz9mJUHKzeVZok6gDLGJOPFOV++T7HopIRymo
	GKrqQUPYFWKSnVe/b8nSEhbVER5vwXf8nSYLeaj6gYD7nLap1I8Eh5eO4Z2zdvyE=
X-Google-Smtp-Source: AGHT+IF0IsTbu848Dr/p6Qfd8WwpL7HkQm9eX7drlm8BSAx5smfPqCdWzcKIGb3cdQCJnC7h085yPQ==
X-Received: by 2002:a05:620a:7009:b0:8b2:3641:39a7 with SMTP id af79cd13be357-8b257f5359dmr40654485a.54.1762541902974;
        Fri, 07 Nov 2025 10:58:22 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:22 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 23/23] tuna: Fix pyproject.toml build issues
Date: Fri,  7 Nov 2025 13:57:32 -0500
Message-ID: <20251107185732.23992-24-jkacur@redhat.com>
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

- Add https:// scheme to Source URL in pyproject.toml
- Remove long_description from setup.py to avoid conflict with pyproject.toml
- This fixes the build error with pyproject-rpm-macros

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 pyproject.toml | 2 +-
 setup.py       | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/pyproject.toml b/pyproject.toml
index 95ec65c55195..f0caac6df053 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -32,7 +32,7 @@ classifiers = [
 
 [project.urls]
 Homepage = "https://www.kernel.org/pub/software/utils/tuna"
-Source = "git.kernel.org/pub/scm/utils/tuna/tuna.git/"
+Source = "https://git.kernel.org/pub/scm/utils/tuna/tuna.git/"
 
 [project.scripts]
 tuna = "tuna.tuna:main"
diff --git a/setup.py b/setup.py
index b85673056c9f..a40f29ef3817 100755
--- a/setup.py
+++ b/setup.py
@@ -27,11 +27,5 @@ setup(name="tuna",
           "Source": "git.kernel.org/pub/scm/utils/tuna/tuna.git/",
       },
       license = "GPLv2",
-      long_description =
-"""\
-Provides interface for changing scheduler and IRQ tunables, at whole CPU and at per
-thread/IRQ level. Allows isolating CPUs for use by a specific application and moving
-threads and interrupts to a CPU by just dragging and dropping them.
-""",
       packages = ["tuna", "tuna/gui"],
 )
-- 
2.51.1

