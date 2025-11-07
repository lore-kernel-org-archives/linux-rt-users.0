Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EE33C534
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541901; cv=none; b=ct7t6dGZBA0YzcdorSdVi9K0W7yaUgrIfI+wxUIHeyrmh54i5ggnafgoXMN30PNZaGIhVhUkhi1zzO0se7k8KS9GW96y+S3+3FCZnjpjUx+tuouoStUYffgGUeYiNcsTimt5EaaRji3Vg86+aVvBokKCzleH+Ft/NstR9Jfa9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541901; c=relaxed/simple;
	bh=luN/RYnGxLiTeB7vucWxStHvLlge172jb+gnVfMkEJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js4Hug65etaL0vv6i+0pGAgw7gKHFpPnJ1uwnKU+V06f8wTjan3eBztnHJFExepj75X2BlJxJnHIrFtn3J4AS3k/X1N7U9aMx5/bXgNHH1Y/VcpViS42PmCr1AFCykEkI4WHjcuH49x2dU+0l3kqgjO3pV6KaXmBQat3uSEVw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZZxr9py; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZZxr9py"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b22efd44d8so121770685a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541898; x=1763146698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFQ3+sWSbKic2EjXiUmG1tfB5eQSWsJbc/vP4MqezUI=;
        b=FZZxr9pyJuFWr+Q2MProaHkXpWlnvA5l13nuK7tV2ySHLXhC/urAbZ3L0f6OgrjZ7t
         Gdchc4bFX5u4FIavAEYEm23CsINDvWcbPO839l+MCnBjEfp9jFI5gJmD+w4pY3fLIRDn
         aTdyvnZyAufd3Dv9M9i0GyGmKJRV4svDybkOaNeY5uRGaV6mucj8B3IcNQRDCdGVgTTV
         dhdtBNh8RB9h8LnUTenyqwAKOahROZtCvt1ir+HrVLe0jhE5BpiQD3M8Sz7l/y0DgodP
         P6kS0SiLM6HYfPuS+7/zDi/dhb+U4KCRl433BT1ELOnz0n3i5XytJ7JM+wjWnkrXhXwu
         lqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541898; x=1763146698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFQ3+sWSbKic2EjXiUmG1tfB5eQSWsJbc/vP4MqezUI=;
        b=Z2U3nrb93kWQC2ffNXFXtBCVrkT8aBLMaOegTleo6nn7lZIgrbn8NYAXni9WZCpUSS
         Qdxnd6RPapSkUhyus2AMEm1tqF9rjjB93rhIE69yquC2+yJ1FoGfaZHilkZFl0tMYRVZ
         xIuwOu6+jsdkLqS4I5f7HYlEjLuaIqhv57lluSStU4F3vnNg2+VM2igRPAxRCoDsK+kV
         TYUqPORDMGNXNI5JdmA/H7K+REic0Skd7S4fGPVw06tJvnlKNKs81UkMRkM+5Sy7KsGf
         JiVcoRG7QBkLI1qCRvNvMoG8BajfpNoQQ7Nk6ZjBSPzYGujgkhP7z6QdVNkr0Po4RQeg
         mDbw==
X-Gm-Message-State: AOJu0YzHbd3zDLaV5sLodIEpkj0rO96rdpCTqqeFifOsfUZ7TC7TD0Gb
	avCFgXg0P5igQoto4EB2JS2yRfbyBuT+uI50fcwkghTCH/kMkyYrKoCV1LCTTsku
X-Gm-Gg: ASbGncuBuz2mNAb/b1o6xTnBqPGlA02iKjFnljKxY8x1ws6BS6wN/v24atQIcRA/UsV
	Qv5zpENFausgx7S5+YBtcnDpt9DYxAUkJaN2vNP+jAVvxRyZ5k//mXsZyIF0vaTrFZB2oirNa+m
	671/AvDEIZF9iiIBk/wFdb119WBhIsDrseb2dtr0NgHenP42+pDiEwR/G3XG+hXhtyonCOe+JfJ
	stmLn6Lju7uYRWUn9giDZYxnbc8Bx8M+RyluSdNvz7QI2ZTAmDhbelLey1Scw/xsDdGmtphFMfr
	2xyUrvBAyJxqd9K30ouQ5fvna0a5N1u3cTIiLW622m/DibPQjc39gCCMvkcq1F80LIUkZdfpfhP
	rbLgX+5tc/Yz+n6xj15eHYPCvQV3hMSsJZxZPZfqiXrntTnjHK+lK2W2ir7wYmWoJlBdLHM3u9g
	==
X-Google-Smtp-Source: AGHT+IGAOk3EPifJo1RwDwY9TMoVpTt7ymffiRx4jrBhBOPFdL3cmp0TMIb4yI/er4xaPmNtfvwYGA==
X-Received: by 2002:a05:620a:46a4:b0:8a2:6690:2413 with SMTP id af79cd13be357-8b257f3d42bmr41187485a.53.1762541898617;
        Fri, 07 Nov 2025 10:58:18 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:18 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 19/23] tuna: Fix setting a realtime scheduling policy
Date: Fri,  7 Nov 2025 13:57:28 -0500
Message-ID: <20251107185732.23992-20-jkacur@redhat.com>
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
2.51.1

