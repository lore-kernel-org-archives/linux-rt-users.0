Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0272571C9
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470015; cv=none; b=CmhHRzOYeEs1bld/LY0a74m3EFkgv5btWZ1c4xKpoa+aEGphGAF7q0eYCuZHYC1N9GA5IpL/qDCXmRxY1z/GTzldraPwSVx6w/wlp9flhMH8V9YY9AbSvyIcKjd6X+UYZ9dN/vllYpthIfhjNvQMWyn9Tamh4SnB9hIUwCwg8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470015; c=relaxed/simple;
	bh=RS+TF6mXrrsJz+M/jvegihU+AqNf749At4T8aVC2g3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMh38+9HAVTXmqkFq7t4t682tnLZuZvgSYib2SezAdkE6wNkOadvdJwy42eMO2rivk+FQhelwVQd31iQis4hvRqhLio0re5t43mX7A8BSh6bti+xPmmkdUGcTVXvnbbwIiElg244YA0KBFZfYnk/eXvnabuMBSAa5OxdN9ZFt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X06WMVk4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X06WMVk4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab7384b108so27058991cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470013; x=1754074813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O+LW8Qu11sUz1SudQgV3ED36f0DQ0OZu2gAZNCTdAc=;
        b=X06WMVk4FdjKczZFj582yCc8cRVJPPidAkZgZsG8TIaNxdVbAWfGLK4HlQF2aY55xo
         l2+//oqsM9UdmGgozjmvF6+LDvwpEUrd80EJqDSJIGCIPslZWfdD5Mj1mbOpORzpWWZZ
         hBoKYXI4Fe8IGBqM/PdGtKX05jB7bATMLJqOENgB8p7v2eNCvR/F1Sg5SRUSO4LzzAO8
         RPbmowictxMoa+H+jAI6uzSIhAyPmdtHAcsbcl92tGa1niG8SWur0erJwSecjx8Lfxb5
         fmmpUyhnjBwbyMmwcgIK3OT/jh9llH2GQ+wcNDcSddxNJ5GpiqWtlJoBDIhMlvHa7fcB
         MUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470013; x=1754074813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/O+LW8Qu11sUz1SudQgV3ED36f0DQ0OZu2gAZNCTdAc=;
        b=lZlPGAAVdDXReWvwamO60VufOYZNaazLEqhgvV2Et2jCz0CNxUx5SiH1GDRRUf1gvm
         NGhz1fKQt1C/CeVoBgZbSqwI+5IwgVq+Qx4xDunOTVzDi9uN+m1cXFYdvSOQPs5EZjO2
         /xy1t52Cjdmp6nYCJ65u42fDSbg2WPppxDz4c31PVZ3FnEeV20qnodxjIUtJIaOqdRcP
         mtDLChNZ6Gqw1Ude6RbWTUDpxn/yq4v2edpI9rUeAf4NnQ/pi2oN5qSEALTJpYIoHAUd
         /Puu6lEF5JP7F250+jfvHpqnM4Gdiini5zYf8Gu0vjGsMKuVXaQv66HIU7iEmQvbzJd3
         FiQg==
X-Gm-Message-State: AOJu0YzXScsL2ONr3bz+JVc0GZRoA2fZv3DdUZTULAwnm8PyO3x4v8tx
	uICfvLktZ0g7npdr5bPR9thomUe+mpbTyRUuyDb7XJgz25eesIynoBEm5TPO9cTp
X-Gm-Gg: ASbGncug03rZGswEY1WLb/7xE9feGNqCZjJND4wIsMamlY69ISNcd28qSVITmkrvUX/
	A3ixMXmGzFCwitGd7Mwm5qivCpg0DExNWNno5ajhyV554G6tRtDxIY9z14NErraHWiE+8Z146wO
	/YhBi3IGhYEZJMvLls2s0tnePm4MaKWUJ/1Iu7+vpCnoShAuPbHWTcIYzMixD9PtHamBKz9GJ9M
	zZ6F0c+gOk/kjl3mFsWmlx1jeDn8nheb/qeB938BMYTcdXJ8VLkFHuI9w4SI8/a815cWNa1F6Wn
	adUKBDrDTXpbxsC2Uld/Vdj3GhB7lAPYfltPipWIUKAKoWdH90jkKVepanGKd648ip/m+8xpLxN
	2x8DHyzZhm5snhgIwi4ohi5OReai2CxV5+A==
X-Google-Smtp-Source: AGHT+IGfE1uf7K053luqnMulvqQIgT5dulatssG93lJb6H9XZkH8dQq5BfUf86QPS6d4otXCXDBnAA==
X-Received: by 2002:a05:622a:1ba3:b0:4ab:6753:9388 with SMTP id d75a77b69052e-4ae8f085ac7mr32261001cf.48.1753470012846;
        Fri, 25 Jul 2025 12:00:12 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9966c3cfsm3184641cf.48.2025.07.25.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:00:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Wyatt <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] tuna: Add -U and -K to the move command
Date: Fri, 25 Jul 2025 14:59:37 -0400
Message-ID: <20250725185937.72945-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250725185937.72945-1-jkacur@redhat.com>
References: <20250725185937.72945-1-jkacur@redhat.com>
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
2.49.0

