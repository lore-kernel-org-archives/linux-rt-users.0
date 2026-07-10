Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B1340281
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693004; cv=none; b=s1htpkId1fWU4Y1CIqKoADOU/NUvYvjRtn27gX5zpCzxFa4g1G1QSUTKUcayMgO8KR+uK0YFJJuM/BChonTr/kpWYbWfzIzrVsQ/LjF9YPWhgAPyUokp2HGhG9uersRbik0pK9GZFlnB3B6ZDexJKHEHrPGqR3sqU86x8Cqn91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693004; c=relaxed/simple;
	bh=5Mo7VoWWRULDx4nj0NoTexI6YlbRnkWYXtR+IYcbcIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gur3SiqedNCSdQxMtuZKer8smq+blNgdSfdk3OetvDdkfn4+4VPOQwhHhdBbcpLmKuYTj5WipphcQfgmQ916CVK+VNexaVJHwAjSjjxqbEqfx2WPIAnemE0oU0ICGjFw7JU/AuYl3vhQxXaJvoU8+z6aOqxRML6ObQRwZePsn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9Kxcxd1; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9Kxcxd1"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-73770fd1cd9so322662137.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693002; x=1784297802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C73rBfyWOXliX/xBtZmIyuUdkXS2HpTsxvdGU5SaF2o=;
        b=R9Kxcxd14fYRA4WtOeiwqHb/tMQBd/C5bDrsARJFXlHk6EshEnGcvKiAVNDUTEUksN
         RUM8TDltTvwO5WfGQcXHxqT3x4LA81TvKHHVUozi5eRS162xCx3quqL7qCTX29/kKG6r
         Toh8yjvO913nCfKazDknghpVG55baLGVnZYjI2RCzv0YbOKMJz1+LJ/hhvoYofU7MtEg
         OcK6k+6QUhtQ+KUcl9UjtIBqLQlRsX3p5hgGOerDWrqRcASnU8qS/CVzppf8FPgjF29s
         zctGPPkseaUcLOdDQVxy2dLW7yg2ySYdgd6/DmXQUy5EA9GZuYtBoKsPfcPODzBM++48
         yw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693002; x=1784297802;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C73rBfyWOXliX/xBtZmIyuUdkXS2HpTsxvdGU5SaF2o=;
        b=TDzVJUPdLnL9450pJFF0EawCcONc+kH6Pra7NHPwLTMr6Ziw8Xza5ts0Mwq1BlcAsA
         Lo+dlPPhArnkk4L0pmv+4pmgeKU9fP6/aqD/d2L37WbIZTKT32qSRikqGjNIrbqiPM/C
         NXeEuCYND+57KyNw9lp7hPY7/h21A+/0Y7uJ2ksEsxYFfPaY6taooDqpItC8DxCddF1f
         4ii5iFHTq/01j8TAV2Ioh434esiBWJNqhzFOhBVB5/iwF252aAwE/BHdmo9/wSXKOENj
         34ShYdOkduZ/HR+pLTX5aONcQZZFqhEZ/G+D3ZenOEE1V4l874dkqXEm21+nA49+b2qa
         ef3w==
X-Gm-Message-State: AOJu0YxYEI3wFh33wyoyIdseG1DuQ9eI/lonj4kpvz4wZciFKjFWTUTl
	5fSOUkZjwQYgZQt86HruW321pPIXREOUIhzdMUaUmvCZQoaI3ykbKdezY/uSaA==
X-Gm-Gg: AfdE7cm5ewqEkzNlvL/gIW7Sd/cd0r2QwDuCbYeEO1oCf40sTuwDfW6LnpWmD1L1wOD
	+9itbt9NZV47GgWeT9gxlPxQmZXmGkXEHnZzzZr/RPg5WXq2zN6J1Il+sxoc0HHKH+VrXuz8Frf
	+x9+GAsUyV1B4Br4UWsbA4ntB9YEnFteNJ/UI6MwOmP9xeR79VeqbskHmK/fhqhCQK+LNYlEoor
	dAsuBONnYw7GNNzNLxBORgq90zpAEzPytpdU1u4pCljwMwtMrIq1Jh6c5Kzag+C/Ek5hkgxbT2s
	m7qsE2LaCeB4X6eIMeRxjewWAnmc09LNajv2xtGpLysSy27g3kWmIYDJ65gwCdWoEzFy5DZO0ue
	LlukMr9Q8DTOeIZsIj9AQkbV8Gdt+dO1k4u/uggFlgIgANjVtlebwOubj3+TB9VqdLVA7kSqBu2
	hgyTa7vfr7C8ipZVNOpST/5p/ZImt/96tZSgrUjGgP2PYHWEvFoSj4j9puAoef1WQy388/bfWol
	+M7PqifdaXp
X-Received: by 2002:a05:6102:418f:b0:738:1fcb:f276 with SMTP id ada2fe7eead31-744dffbeddbmr7359433137.1.1783692997367;
        Fri, 10 Jul 2026 07:16:37 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 32/36] tuna: Enhance show_threads -G to display cpuset names
Date: Fri, 10 Jul 2026 10:15:10 -0400
Message-ID: <20260710141523.36440-33-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changed the cgroups display in 'tuna show_threads -G' to show
simplified cpuset names instead of full cgroup v2 paths, making
output more user-friendly and readable.

Changes:
- Added extract_cpuset_name() function to parse cgroup paths
  - Extracts first component: "0::/tuna0" → "tuna0"
  - System cgroups: "0::/system.slice/ssh.service" → "system.slice"
  - Root cgroup: "0::/" → "" (empty string)
- Changed column header from "cgroup" to "cpuset"
- Modified ps_show_thread() to use extracted cpuset name in display

This makes it much easier to see which cpuset a process belongs to
without having to parse long cgroup paths.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index c2208e268c97..4703ea41f8d4 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -358,6 +358,41 @@ def save(cpu_list, thread_list, filename):
     tuna.generate_rtgroups(filename, kthreads, utils.get_nr_cpus())
 
 
+def extract_cpuset_name(cgroup_path):
+    """
+    Extract cpuset/cgroup name from full cgroup path for display.
+
+    Examples:
+        "0::/tuna0" → "tuna0"
+        "0::/" → ""
+        "0::/system.slice/ssh.service" → "system.slice"
+        "0::/user.slice/user-1000.slice/session-2.scope" → "user.slice"
+
+    Args:
+        cgroup_path: Full cgroup path from /proc/[pid]/cgroup
+
+    Returns:
+        First component of the cgroup path (cpuset name or top-level cgroup)
+    """
+    if not cgroup_path:
+        return ""
+
+    # Remove "0::" prefix
+    if cgroup_path.startswith("0::"):
+        cgroup_path = cgroup_path[3:]
+
+    # Remove leading slash
+    if cgroup_path.startswith("/"):
+        cgroup_path = cgroup_path[1:]
+
+    # Return empty string for root cgroup
+    if not cgroup_path:
+        return ""
+
+    # Return first component (cpuset name or top-level cgroup like "system.slice")
+    return cgroup_path.split('/')[0]
+
+
 def ps_show_header(has_ctxt_switch_info, cgroups=False):
     print("%7s %6s %5s %7s       %s" %
           (" ", " ", " ", _("thread"),
@@ -366,7 +401,7 @@ def ps_show_header(has_ctxt_switch_info, cgroups=False):
                                       has_ctxt_switch_info and " %9s %12s" % (
                                           "voluntary", "nonvoluntary")
                                       or "", "cmd"), end=' ')
-    print(" %7s" % ("cgroup") if cgroups else "")
+    print(" %7s" % ("cpuset") if cgroups else "")
 
 
 def ps_show_sockets(pid, ps, inodes, inode_re, indent=0):
@@ -419,7 +454,8 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
 
     sched = tuna_sched.sched_str(os.sched_getscheduler(pid))[6:]
     rtprio = int(ps[pid]["stat"]["rt_priority"])
-    cgout = ps[pid]["cgroups"]
+    cgroup_path = ps[pid]["cgroups"]
+    cpuset_name = extract_cpuset_name(cgroup_path)
     cmd = ps[pid]["stat"]["comm"]
     users = ""
     if tuna.is_irq_thread(cmd):
@@ -451,10 +487,10 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
 
     if cgroups:
         length = int(columns) - len(s1 + " ") - len(s2 + " ")
-        if len(" %9s" % cgout) <= length:
-            print("%s" % cgout)
+        if len(" %9s" % cpuset_name) <= length:
+            print("%s" % cpuset_name)
         else:
-            print("\n %s" % cgout + ("" if compact else "\n"))
+            print("\n %s" % cpuset_name + ("" if compact else "\n"))
     else:
         print()
 
-- 
2.54.0

