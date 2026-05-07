Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512647DD64
	for <linux-rt-users@vger.kernel.org>; Thu,  7 May 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182157; cv=none; b=d6UE6hUWWQ2VlNQqFOpoMKJaS7sU91kE8x/Jy6Xmx+7bhvpxlL9S/7SArd/gCVTqQTApVyVYnPYl3XLfqGZnG6ZXsA/uDppNYfGSJMvEVYn+gcVVn6So+UKQOJnxsjPGFdUzm+ZGt7wM+KHxblVuXjFq9wI8idROr+0Wkaqxzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182157; c=relaxed/simple;
	bh=oetw0fOPBAfbNATV3DcgqSaafpc6i2Z9e+d6wrRe5AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fagf33LkjzYqznMez8re/SvP1d/yUXunUwRPRkZZ/4TDbHaXVsujF3vjTJmGbpFp5m2m6TQoS4+Wm3TXBh/FHMFO+hgoMK27EzDuzlkCcLzOrsRnFZLr7+MJjLklIWA1nCSBH+QN4USuVwP3bpv5zN81penBBKzsJVRyoV2v2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu0UCMG1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu0UCMG1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fc496c8baso10203231cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 07 May 2026 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778182155; x=1778786955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uho0T/tSXrvJ8W7UDsZA0IRMzmaFS4LEWaugIxQxNqc=;
        b=iu0UCMG1H/BNMlIeiXzpQlWox169hvd8P+qx1Z1zZPxndjzFgFJV0OtfAsYKizxUqK
         lY+9Wqni5Sl5NRmv40ZRMITrldOX88uYq2nHtwUzj9zEwlklqoutID87KdoKiG0pcIc4
         XLwb2kUY7cyde7XCfbMCOKfpCoyqfTngBdKX2qV6j3PHHFVNsYhc2OMavw+/QX476lNQ
         kxTRcpvSOt2F+ExCCa7LXIVmh9BBXrUasOl1T7XZnP2Ckb6FQzvzs0y0cTKLQorhpSUH
         xjbnmdpA8jQvrNI/EKtFz20iP1kZJP0ezSOAoRToVNkZNh5Ey90J265p/O/l8M4ckPgd
         fgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182155; x=1778786955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uho0T/tSXrvJ8W7UDsZA0IRMzmaFS4LEWaugIxQxNqc=;
        b=Mr6USOIuX1LtC2C9Z36Agd00yCCPNHFQRMPLpGTw6MEQi9WEuPfLtJrMMYWxr3RMs2
         kpJJ8sqbuFuAO7+QECgeV6vwDBE9Vu1ZRbd76ECYolEePtNAZOK7K0LM9J9lLJ+1iurG
         xAS2LQbHIg8YQT7Uj/4SKdL1U+uXgugs49fDpGgsxLgMRlq2S6s7FCjr3fZBGdTxeeUF
         gcd2ZiqUxEW3J9ziyXtvYhi7c+sG3Q47IyetV7s6bN5gCPyNAarc/kGiRxUz5mzm8AU/
         HzdpbjpWRGMhmodz4Qoq/7+LGQ5Oc9lp2WbtpTlgVQV6VLhTT2Uxyc0RqsqnsSDbomp7
         THHQ==
X-Gm-Message-State: AOJu0YyJaC4dHk5QKpLvgy8AzX0SlmpwpWvjFRIQtkIYDlWFX/UZHxAY
	ojmr/n+ugDZBzqNxC4uiebIKBC9lZCHdo6quhidF4pQUHEhs9MJmR5neaEpmOg==
X-Gm-Gg: AeBDiesJOHfEVhVf2PaRW3pHccyB9k6x67kAZGJMZukez+A2MV3y+VljwbhB1vYOVkv
	IWPc1I3cJHIlu4yTLqLS7FgkE6yRYJo1HNKyrzER73d8VefiJR35ESBaoiqXRXEosE/kdNNujup
	QBVct1gZr4KtoehPdJzPjze4I1j7DkgNm2auq8bfQ7bIoBE3WUtlXNkhvdviLuTGvmXVq877Vxh
	ThjT2MMF8Q++KUYwprE99fDK1m7X3JSfTiceE4Tr9Gb2Vb5c44EAwHzBcyIj+p8UEkbjlZxifuL
	9V4rByocul9MExddkyHm/A1eIw+9wZa9BSa4sEaq/uuYyrg8OYIL1XrtjjlZplDNKS2exPArC+5
	10E9FDMs4BDItuWjaghWGpB7j3Vw6aSZPoGVpFkeSGZ82b7QXsZYUYuULdXn2PekLUXC5NFO2Ml
	2uOUXYdvtzSxd51aipFzJLV5f7Na9Ojw6oarhxw/o2D9FUYy2IHbW1ilhUmzBUnDnkyZ2hQpU2w
	NfppMVHpfltjGb4Iv6a8UKUMqKkpA==
X-Received: by 2002:a05:622a:18a9:b0:50e:6302:340b with SMTP id d75a77b69052e-514621ff185mr140482681cf.53.1778182154616;
        Thu, 07 May 2026 12:29:14 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51487d1de9esm3102711cf.27.2026.05.07.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:29:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 1/2] tuna: Print warning if setting affinity results in EPERM and continue
Date: Thu,  7 May 2026 15:28:57 -0400
Message-ID: <20260507192858.186090-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When trying to isolate a CPU, if setting the affinity on a process fails
with EPERM (Operation not permitted), this can occur due to security
restrictions, namespace isolation, or lack of capabilities.

This is commonly seen with PID 1 (systemd/init) even when running as root,
particularly when using 'su -c' which may not grant full capabilities, or
when SELinux/AppArmor policies restrict the operation.

tuna should print a warning that this pid could not be moved, and continue
processing other processes, similar to how EBUSY errors are handled.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/tuna.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tuna/tuna.py b/tuna/tuna.py
index ef60c033362d..8e57cddd0c13 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -370,6 +370,10 @@ def isolate_cpus(cpus, nr_cpus):
                     comm = ps[pid].stat["comm"]
                     print(f'Warning: Unable to isolate pid {pid} [{comm}]')
                     continue
+                if err.args[0] == errno.EPERM:
+                    comm = ps[pid].stat["comm"]
+                    print(f'Warning: Unable to isolate pid {pid} [{comm}]')
+                    continue
                 raise err
 
         if "threads" not in ps[pid]:
-- 
2.54.0

