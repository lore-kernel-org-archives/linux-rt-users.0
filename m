Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337E1FDE09
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Oct 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856144; cv=none; b=anG8nIK8YYmz9SM2bdTICuF2uCkXjquDtBpnBoBjQuJFZ4KOZ7Vzq3cc24DknyFr5UoNZZjguSK1Sm2Aii0Mwz2yhWOIC3CLC0CcOuMTSwkFpelISNWtKHWP0LTBxYqAkTBBTEVsEOUUKeew0EaKASdiy55yS/NcbGuoxKLCxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856144; c=relaxed/simple;
	bh=j54A15tgH2Jw/eJ0WFxvdPgTgEXEPenckJfLZqbg/fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLQT3aHDb9f1QDde99j+OVrYxMZSrWritRUDWKSsqqwjwZehhYnL9mbuz9V7HMK/HYmi+0afT1jz/WydInyrOCNz/daHQmOEnO5HQS6qd5hNqbWQpY9JA8DbgW23nH/zBoCPmjYOXMFNiacUyF/ikT6uM3yVILdzzfPme28UMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixm1Hr3B; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixm1Hr3B"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-86420079b01so685609785a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Oct 2025 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759856141; x=1760460941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ish3EKICTn2TGjVpsSUI1LVPPY+mfE76QgsWZxyKX6c=;
        b=Ixm1Hr3B6jbDlxYZWx22OuVnQqb+ueSGS/GsUATRpxu6hNDk3u+4oWgQVlkacHkrxj
         pQ/ODnaaRufrIbrXlqyU0B4s2LHmfJkCd+4dwJ/50jA7Guo7HFC0K+D18b3UYarDWzWR
         Hz2e8AD+9kJ31M3Qjj2seU/Vy7BRjaNwKd1trbXs3zOpPWMdsiXYebAWJplf5w4y6u9B
         J0IwWq/+hDILBX8g1VQ5Mvi+YyVhNBRET0deVEbgHGqJGaYW9q/1aLkaUQY5Xae76hTE
         T5SHoCzDxWWMJBj2eKugUv17d03nfjWU/cnRbC4sV+IPAA9R3edSL4RtHlsryj2aRe0a
         QP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856141; x=1760460941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ish3EKICTn2TGjVpsSUI1LVPPY+mfE76QgsWZxyKX6c=;
        b=ket3ZhehJb5QGEH8v50Z57yk2jdpNICr80Y+7QVuJjtaq5eFKOZkj80S9FL9cZ9hbe
         /+RZporO/p44zQSJldphE1XCaEiJnj8rKcUJ29JhAXkyDR9imYNpWx6443DqWMSFk3Xy
         1fisQQm54Vsfoct6CkvwrAfIEPg1Kf0O3A0kjd3ROSo/ZX9Wv4CUGVJdPDSLnK2mqBz8
         gbw6lisBA5jmXka3bG0lxGYegrv2OJN+i0taqVDvq8Iq3Vui9LVR9sac6+3OZ00/LLS2
         sSthBtlx5PioGD55rMKvly4Oj3dEkLYjTBg6kn77ezEtprJAOnq44WiI1gdp9uHpJJN3
         qLbQ==
X-Gm-Message-State: AOJu0YxBXPIkXTIi1kSnuUjtasiceIgyWAa/XWFumO82SMLN2Tty3Mp0
	6jvmMxq7zS4SUZAvDqooekUQd5UROcZEi7jj4QYzRU7nDgjRy45OKUUqlRhjewJs
X-Gm-Gg: ASbGncuXrRQJ26Ne5EqP2vqp9lkb/cFxgaZPdRQGnfl/Iz7IWsbNF7LBRBnvSo92aQ1
	O8s1e6lkgapcjCytBqee9+I3ATWPKqu248ai/B1mll/8fdLjwTVv6JINHN/DHtRxIh6yi1YhQzh
	CCIs/JwkH6Y6E99A3Khu+Rap0h3/IqYwPDjXNCp5QwoUEbWttErZ0JKO4NgKtcbJ9ImlZk41UZH
	dCQmBUvh2/hptx1fXoiSkmFfh1VfDIKYIrhT5bUqJUkTyX8Py9aOao/Tx65CjUHZ0qKH5COeD03
	GgUAagYyaIFLfXKScTEAjiMwyrtErx2Nrei1mttyad9vd0QYAz2MzC2UuWtUn2ninU0QBVXSr1G
	oxflByvIg+pCKBySvX7ZR4RgFKkke8IPQLWJKaJGZR4PtpfL+
X-Google-Smtp-Source: AGHT+IFrOc6eD5MZMOEQDgrKd/Z67WmGwq/Gw/IuU5hKg/UvE5zhfBm/FOtV08ZvsMNjXa1UQu+8cA==
X-Received: by 2002:a05:620a:4083:b0:863:696d:e372 with SMTP id af79cd13be357-883527b6734mr78384785a.62.1759856141337;
        Tue, 07 Oct 2025 09:55:41 -0700 (PDT)
Received: from fionn.redhat.com ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777892ef75sm1603948885a.31.2025.10.07.09.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:55:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH] tuna: Fix setting a realtime scheduling policy
Date: Tue,  7 Oct 2025 12:55:18 -0400
Message-ID: <20251007165518.28218-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the tuna documentation if a user specifies a real-time
scheduling policy then the default priority is 1 if not specified.

Fix this in the gui by explicitly setting it to one in
thread_set_attributes

There were also some incorrect debugging messages in
thread_set_attributes because the affinity was sometimes treated as a
list and sometimes treated as a set.

Fix this by converting the results of os.sched_getscheduler(pid) to a
list

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/gui/util.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tuna/gui/util.py b/tuna/gui/util.py
index 92bd368179cc..68bd7578f1c8 100644
--- a/tuna/gui/util.py
+++ b/tuna/gui/util.py
@@ -68,6 +68,9 @@ def thread_set_attributes(pid_info, new_policy, new_prio, new_affinity, nr_cpus)
     curr_prio = int(pid_info["stat"]["rt_priority"])
     if new_policy == os.SCHED_OTHER:
         new_prio = 0
+    if new_policy == os.SCHED_FIFO or new_policy == os.SCHED_RR:
+        if not new_prio:
+            new_prio = 1
     if curr_policy != new_policy or curr_prio != new_prio:
         param = os.sched_param(new_prio)
         try:
@@ -82,6 +85,7 @@ def thread_set_attributes(pid_info, new_policy, new_prio, new_affinity, nr_cpus)
             dialog.destroy()
             return False
 
+
         curr_policy = os.sched_getscheduler(pid)
         if curr_policy != new_policy:
             print(_("couldn't change pid %(pid)d from %(cpol)s(%(cpri)d) to %(npol)s(%(npri)d)!") % \
@@ -93,7 +97,7 @@ def thread_set_attributes(pid_info, new_policy, new_prio, new_affinity, nr_cpus)
             changed = True
 
     try:
-        curr_affinity = os.sched_getaffinity(pid)
+        curr_affinity = list(os.sched_getaffinity(pid))
     except OSError as err:
         if err.args[0] == errno.ESRCH:
             return False
@@ -116,7 +120,7 @@ def thread_set_attributes(pid_info, new_policy, new_prio, new_affinity, nr_cpus)
             return invalid_affinity()
 
         try:
-            curr_affinity = os.sched_getaffinity(pid)
+            curr_affinity = list(os.sched_getaffinity(pid))
         except OSError as err:
             if err.args[0] == errno.ESRCH:
                 return False
-- 
2.51.0

