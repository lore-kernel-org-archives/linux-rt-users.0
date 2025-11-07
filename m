Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819C33C519
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541896; cv=none; b=ZQ1BBAOZicK5c6t/W+s1Ew6vBt1ShR4ruvqNo5jqRuivEdQAs8XpfZ8MjfJ3sNjg6TiMVT8NpPV5TVbCIvYhHfEYOHSZu5jUjM2kJKDl8C0FM+AgZKxzZYnTa8Oz/MC0DOqUfwrJTGxhhwbN6Ul6ktZq0inNRX3dqoDRY8X8mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541896; c=relaxed/simple;
	bh=L2N5BVVwBVt0wD4rztuPuzCGfDNXZBvocYuiwSH0/JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogn4ed7FBRgYVWVeYsgRZKVIr2swIxCeJXnLfklpNEtv8ZFPRieONy2cZ4FxcDn64cYIKu91+U8/UrhfOrOB7RWXy8Ya/JoQxam5Px0wC18QN0M7XV8cvlEPxovtgVDLqRhV9SJvjDXHorMm57GYtekBAaWaB5R7PCezRDmSrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJwOrNfr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJwOrNfr"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88f8f346c2cso102143685a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541893; x=1763146693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev7RwbLZn/gJAhxPt25Llu+VsGcMGWrr43XoVoxtiQY=;
        b=QJwOrNfrXPRuAl6aawEVayTlXxiViZwsq5eXYO5UrIN+nuLaKqADMgsFEbSve4mq6a
         VYjqUwo4XzTPf4EtRB7yesyXr6jCQjxtO0yHweLDhxOj6r9NlvEe5L3qjGXAE64e40St
         vg6vu70HZd0rE6p6MsI670HFXuDtKUyTlVKSXqmcOwDHawhvq3uVBp4AuXTJR2AI+NMJ
         XdkzgroS3EOT49FTdwEHzi7MXzXTrv9O3cEntWpVD63MJ5Y3DURTpJEYMPlCjSNrERuS
         h0gunpoaCLC04BaXaANuan7MaGw3+yeo5v0yUpVTe00gdFUrUZeIzppCuWzNB7qVHMu2
         dR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541893; x=1763146693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev7RwbLZn/gJAhxPt25Llu+VsGcMGWrr43XoVoxtiQY=;
        b=i81N6EbiuGQBDpTONV866WF3f5AFvADVGX1qb9WtMRFAPfv2VCLbCQMq99QbDljmvy
         r1AgG6I5RqpY0geDhHL1Sn7PSXi0Utk1ku/Yk4qvZEBKBCgwd5ClfRAz9PXBlawCIRz1
         3TtulpnAronwjfOPYQ6ndN9u09p2M/LXyoCpaIOD6z+D4C6GaPNs9xaNPaEtCkCuTQxf
         RHw0jW2SWgAMbQwtrxNSX7G3W2xCXarapGQnu28eHB/CsL1VZN3us2T6BLfxH5H0e/Zy
         fr/AGGvWq+7sMt+mxV4PSoVBPrDN2BmNNm1osUwNksjBLQ9/6YR+3/NsbXhG6UADGDah
         XS3A==
X-Gm-Message-State: AOJu0YyBEo4XuZi1G2MbhpSznCOfmlik5enN7lMe4iEX9XURHN5Xa1B/
	khzpN1UjxcM9MdsZE3+iDnldWqhOI5qgk4zN5XI08i+Q9EngyJKnM9V1/oVcylVK
X-Gm-Gg: ASbGncuQd0iXg7U6ferMXcUbuu7Q+HGlGfYA5xPAAzO5ZhXW8QrcJmuZUR2boZeqm2q
	Y6GLBLwqZK0oqHAIgp5SSpd2nfDaL63s9TPIR4ThEWvrtZkwaM0Pw807pv2ARzt2aJhBMZqY8S+
	PBb7+LopgPZvx+WrQv10RguL81nPS1Z4sWd+4GRO2DhZeC2/7Hc0qIj+5WrUpF6TOB87mxWIp75
	C2txU66wOZ4KhE6D6oEpcgJrWLdgJUgUVIFWsiQaOnw2j3Cvo1qBwG5cum/UA5VL9tRtyPYn/mN
	euF7HvY0YWegvTM+jUxNDIVcDl0tnMc7zQshON11tsR5TPci30knlwGxkFWZNGfRfVset4vTdyO
	6eLjdVW97ZF9J/JACP4QoOSluJlVzoIA+QvUQcLZ+eJNemzchoLb/xSLz8RT/fCzRUkDl8iZ5MQ
	==
X-Google-Smtp-Source: AGHT+IG9P96My/r1YGyIs3irbS2ZNdnTk5nhIQWyx+h1+WR6c7FRJANrRhR+BaovtyO8H8wkdt488g==
X-Received: by 2002:a05:620a:45a7:b0:8a1:21a6:e054 with SMTP id af79cd13be357-8b257ef3f39mr44332185a.4.1762541893190;
        Fri, 07 Nov 2025 10:58:13 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:12 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 14/23] tuna: Add -U and -K to the move command
Date: Fri,  7 Nov 2025 13:57:23 -0500
Message-ID: <20251107185732.23992-15-jkacur@redhat.com>
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

Add the following options to the move command (like in the show_threads
command)
  -U, --no_uthreads     Operations will not affect user threads
  -K, --no_kthreads     Operations will not affect kernel threads

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py  | 4 +++-
 tuna/tuna.py | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 9496c61f0c2b..d0a3e6b7dbf8 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -174,6 +174,8 @@ def gen_parser():
     move_group.add_argument('-N', '--nohz_full', **MODS['nohz_full'])
     move.add_argument('-t', '--threads', **MODS['threads'])
     move.add_argument('-q', '--irqs', **MODS['irqs'])
+    move.add_argument('-U', '--no_uthreads', **MODS['no_uthreads'])
+    move.add_argument('-K', '--no_kthreads', **MODS['no_kthreads'])
 
     spread_group = spread.add_mutually_exclusive_group(required=True)
     spread_group.add_argument('-c', '--cpus', **MODS['cpus'])
@@ -746,7 +748,7 @@ def main():
             parser.error(f"tuna: {args.command} requires a thread/irq list!\n")
 
         if args.thread_list:
-            tuna.move_threads_to_cpu(args.cpu_list, args.thread_list, spread=spread)
+            tuna.move_threads_to_cpu(args.cpu_list, args.thread_list, args.uthreads, args.kthreads, spread=spread)
 
         if args.irq_list:
             tuna.move_irqs_to_cpu(args.cpu_list, args.irq_list, spread=spread)
diff --git a/tuna/tuna.py b/tuna/tuna.py
index 1380df0dadba..ef60c033362d 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -174,7 +174,7 @@ def is_hardirq_handler(self, pid):
     except:
         return False
 
-def move_threads_to_cpu(cpus, pid_list, set_affinity_warning=None, spread=False):
+def move_threads_to_cpu(cpus, pid_list, show_uthreads, show_kthreads, set_affinity_warning=None, spread=False):
     changed = False
 
     ps = procfs.pidstats()
@@ -183,6 +183,11 @@ def move_threads_to_cpu(cpus, pid_list, set_affinity_warning=None, spread=False)
     new_affinity = cpus
     last_cpu = max(cpus) + 1
     for pid in pid_list:
+        iskth = iskthread(pid)
+        if not show_uthreads and not iskth:
+            continue
+        if not show_kthreads and iskth:
+            continue
         if spread:
             new_affinity = [cpus[cpu_idx]]
             cpu_idx += 1
-- 
2.51.1

