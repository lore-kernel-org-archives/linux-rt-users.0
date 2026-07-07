Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BA43C7C5
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jul 2026 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448310; cv=none; b=MbF/u/LHgUER9GqjZGp6q/BragTQRzC2LqLu9ZgBCQMpHv98nTq1aBQQTDpkA+E2zn6kEWf9D9sAp1foquX5f+XeLllGCUk7pLuPQXIcQbulE+03L7ym9FDWopfF59rU7IVCs0dZBH88jhsf+w/Blbg8aMqNf/9KlEWjQXN5BFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448310; c=relaxed/simple;
	bh=nhy4YWfm+8rFlKwoQ6kYTHQ2qlG11KlbzZt3i/Bjoy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQb25/UMmetnlg3kPoo8V4UGdYlOAJupQ1pmI3pSn49lOmqyVEVtwvJP/WWA+DVF0ciozolIy6gzPYXmrpqeZOCQUCek8G5LekgVh5zK4ecM8T6iDh8zFNAIK9NEjpG6MKn+NPpzKRhttkgNS2TziKVpigedrrRcrWINKZC1uhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdG84s4e; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdG84s4e"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f0079614b2so48213236d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jul 2026 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783448308; x=1784053108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEEtJ/X8bkbnOCSzo2yLeS8awWPTkFJlDQq8PLfpV6A=;
        b=WdG84s4ezbTKBLGTUR9BY76/jSnwxFK3+MJVK3iV6cr8DYJL7z27ByE0JynReJ1olI
         1lE7hxEX1MZCNAPWUWW8dQqElJGx/39k0iJJDIIsjxKYM2wV0Ww015nxuItvgFHgX8D4
         XUKx36sT9q04p1hcVhuyfoKRjzLOa/CJy99TNFBNkRLuu9rtD8Sdx/EtFLSTEfwjMAEp
         8nxbEo7kXMYhVRFHLemuho7uHCdYtb6M8w4T+ZVuP08qOHpJPrcj30SMFqiK2ZQJLR3k
         yVvakRsVNehsdwTM9n18+H6FCMggb8x4tfquj3c6gzkwB7nefswpBTHaFk45opBSTxx1
         PrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448308; x=1784053108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEEtJ/X8bkbnOCSzo2yLeS8awWPTkFJlDQq8PLfpV6A=;
        b=UO3wQ3Bdm5fKTMuzVjx8mGbbxGengl4PYOe45MgUHcBY18FT8qFpBeskGiDU3/18r9
         VF5+c5EcF72EkoBvvYSXq2fWNJdUWgLMow2qQdCKNX9DNdeiOAOuHC7MtIsGOktCGVsn
         3H5yPBmrUqciIyrdsZeZwsi28X8x25BjQn2RBzJuah9e3bHubfFBLGOXqyrILjKc/0kj
         DTK+siTXuR2m2qnyFfkECKmClVdGo/GfjTJBccxyWDjbPM4mSiLMLIIcFxI3SSlMvRvx
         Fd+akv7IQCQQMkilfxRO6HxYZPse+07dRDZwFAkyFPjTUE4kBw1Mr60cULTbhUyWik6m
         8zyQ==
X-Gm-Message-State: AOJu0Yxuf0hjhxCQeuuwAUAmogWnH9nDXlsZGnaY8CUC7JKGoUPgn0ZH
	kuDLFjTdc2AiXauzTSO1MCZsyuzDnElYCpGD22XsaeFGzH4RpkajwqjGtIZXdw==
X-Gm-Gg: AfdE7cnpRiuCh+27LU6I7jzk1b4ev3HSB5iI7zas5fWi/Kuyclc5gWFDRWSAYjuSSkG
	YeQeCc6m4s6P+Cfbm3/ovr4+zm0CmbN9F3BpTgEdLAefMdbRdkEMH+UKr32hknSZvPcFGtd6W4p
	b47xot7BkJijyfkzk0PPY7uwxULk3Zh7BlvUWYBNMoSSEwmtbdoktCDukdtnZJBYQ6ZuuzSHunW
	txQrusxyCsZaf0pKgQB22NgV1WlMEIkXtbSMWklwLhOiEYVXN5nYsJVYLkC4VDp8v3/2S+dZkZV
	UUck5w9afMZnUaaUejteynGZuSluaPAtSWqW7sj01EjSMPp7w73wSpsENKrdYdi47gEDrB78f8U
	4dLFLrweSNPyOTK/+TvHii6bJMgeb54q7RQqI2w6Bo+uqNHMIEMr8Pj/5AppTtaJ1jN2x6AJ8Oe
	nlq85Sc4ZEztBZn4V1oS0qKnaEUypI42MOCPHP9l3Pebeca8RzjrZaRZV3Ey4kGhRgCnEoS2+GD
	5ZsTlOdCw==
X-Received: by 2002:a05:6214:f2e:b0:8e1:4508:ee58 with SMTP id 6a1803df08f44-8fcb5bb3a7bmr75661676d6.40.1783448308035;
        Tue, 07 Jul 2026 11:18:28 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm179598496d6.44.2026.07.07.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:18:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH] rteval: Make thread excepthook portable and support chaining
Date: Tue,  7 Jul 2026 14:18:12 -0400
Message-ID: <20260707181812.133267-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706111601.363596-1-gmonaco@redhat.com>
References: <20260706111601.363596-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the direct use of threading.__excepthook__ with the original
threading.excepthook captured at module initialization. This enables
compatibility with Python versions 3.8 and 3.9 (where __excepthook__ is
not defined) and preserves any custom exception hooks registered by test
runners or parent programs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 2eadb2045e2b..6e49889a6d67 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -41,10 +41,11 @@ def sig_handler(signum, frame):
     else:
         raise RuntimeError(f"SIGNAL received! ({signum})")
 
+orig_excepthook = threading.excepthook
 def except_hook(args):
     global threaderr
 
-    threading.__excepthook__(args)
+    orig_excepthook(args)
     threaderr = True
     stopsig.set()
 
-- 
2.54.0

