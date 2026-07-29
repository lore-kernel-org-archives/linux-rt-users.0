Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD527FD74
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jul 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334855; cv=none; b=BS1Q4HbvAl3gsNczt7T61zvuLLiwi1Sa625uzXHy6OCfScVMwtPNqWFIpao6h4s6sI7FHH5W1EtSnGY9lelIqFOpGf3mKMl4r8/BTYlhpHspzzJfkR1LgzgyJGuDGCA+Tf+oz2OFDC0/3q4XmkhWUG2h2PhggpN+7ba/kDupDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334855; c=relaxed/simple;
	bh=Uw8d1B4dsDdMYzoFfNuiaUs1JtXhroXh/jnwc8CZbnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UT89Lr75p1T9bVfVxnBSPkdIgSDYEGj4d0tPTOZT1/bN5Rs5k508Z37U+kbzOn0mVONVHDm844Je+z6FKZPLqPZy5QM5Jqw7/ojsxtBDpBhIHB/jQNLPYw5RMxaaj4MYJ7aEq3YJauxaY062ilGSxoM2bVozS8KrUA/vv0zOdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUiKIaFB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUiKIaFB"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c160420289bso147212166b.0
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jul 2026 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334853; x=1785939653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xv/Yq7gl9gdrKbO1FMT2QzFuUW1z4siUwldsc+iZxmk=;
        b=hUiKIaFBU+iUASpmdwIAxkF66ADVlAp8+pY4rocZSPwA1r9TxyVdSNy0AEoUqnUfKa
         6ScoJb8i079wOO52l75NWdzfb94pRpzc/J8Uv7zwhpc2Sif9jzqT7ndxGXv6Vd7ETqMy
         b7uqP0SAkn9gtHsGOl7xhQLtaWb/Oz97dGDjYUNhbta6dY3HLD24q/g+MMgmK7hHbNbo
         mtgm4iv2eDyPM2Nwp8dJejk1XE6NwRZA4Ylq6axq6cPikrFNgNEFGmQ76xEoozKr0Pkr
         2syRGtvxRATSGQLTjyXk4h9OiQNsOunBOF2do4c8rIzyVQIC36ezhrBeLoAzE4hYjIph
         3gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334853; x=1785939653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xv/Yq7gl9gdrKbO1FMT2QzFuUW1z4siUwldsc+iZxmk=;
        b=lbM98wnTvNsCBQaUQwdCUOHcNwHqU7eUCKu71tZGCHArNpZ8owlf+L90hAHvFrPqqw
         UqdaYERmJB3ocx8UM7TQZhoR13nJaK4ALU5jC4iVEmEyLG8SNtEen2Qf637u0slDsucQ
         FbI2dGW7wnYg//+YhaBABiWT2VV9tPlftzxO66CsoF6dpLtvgILriVH3XWa3wWNWXD2M
         d4RovPw5Y8fVPUaf6N13MBKIHZ3HwTJgXMjUFtg90xPerDBnCNOOJvEHFrGeME8dtt9F
         HqwnUWrChdeV9StkiiUfljcbLZHRC3EUnqdeKfIYGLW9Y6bryPZb5DCOLPPJHpTJhtGz
         MOyA==
X-Gm-Message-State: AOJu0Yydz04/D0O5QPcrmoPBKw3voMpShGf3+u2EpaZQDpl8GDvmWVok
	S2x/pHTHZnSYLtpb8zPOEDVuauCVaMGSTfe7mtDSC+WfKFPS5/sRPfiQFvUfoQ==
X-Gm-Gg: AR+sD10iOpBcc9C8kxsqLq1VDCVwsHRntVDgUmWOQtZb5pFrMsxVn8noyZRwnAB+82M
	Bdv1StD/N6RUp5JNz05tiI5Pt7nm+Mx3rHJsnQkMw0jHuilxGCAseOfc+OYhYU6v+wDoHBOzi5P
	2P5VFz2wtD/bfMBlXMqrqLsFKRmyLs2otQChYlPqmxgmlxyF0SK3kHXy0NFaFivz2O+hz07NJpH
	ecKGwqF3idi7N2YknyJFmb4j4Lh3Qs07/GyfEcdjbzxz8a+cP4jM2SQDpR2w4gxbL+9PuTxM23o
	cms19pLebm2CLOMkb3O3c6wKVueRHAWtE0lZ5FRmuB9Ve8dSt9hp/D0rJg4jQxFWYQbmfEKWdiv
	XuRCbjXev25BaL+82gigst2ApSDk0MG6Qk2jqWQqwyT/TyiloTrbxM6ffAexZ3NZwPQceu12p5u
	gNKLLcAvEFUovIy225gcYKSFhtHBQ7ujSjQqmAdmbtDwL7LJmC+QO/y27AFoAk1nJfw8jrJ6mtS
	Tjmq4dhmtHfMlW44BhWyWPTltEBcgOKTSlQWW++EFsGD8dssc9z2s8=
X-Received: by 2002:a17:907:94d5:b0:c12:86a5:3ada with SMTP id a640c23a62f3a-c1f72142f16mr426005566b.36.1785334852390;
        Wed, 29 Jul 2026 07:20:52 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f84022981sm124138066b.62.2026.07.29.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:20:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] tuna: Add error handling to cpuset profile save function
Date: Wed, 29 Jul 2026 10:20:36 -0400
Message-ID: <20260729142036.27868-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The save_cpusets() function would crash with an unhandled exception
if the parent directory of the target file didn't exist. This is
problematic when users try to save to /etc/tuna/config.yaml and
the /etc/tuna directory hasn't been created yet.

This commit adds proper error handling:
- Automatically creates parent directories if they don't exist
  using os.makedirs() with exist_ok=True
- Catches PermissionError and OSError exceptions
- Returns 0 and prints clear error messages instead of crashing

Also moves the os import to the top of the file for cleaner code
and removes a duplicate import from within apply_cpusets().

This matches the error handling already present in apply_cpusets()
and provides a better user experience.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/profile.py | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tuna/profile.py b/tuna/profile.py
index 8372d081546f..fc1a64188c7e 100644
--- a/tuna/profile.py
+++ b/tuna/profile.py
@@ -9,6 +9,7 @@ including cpuset definitions.
 """
 
 import datetime
+import os
 import sys
 from ruamel.yaml import YAML
 
@@ -64,16 +65,29 @@ def save_cpusets(filename, get_cpusets_info_func):
     yaml.default_flow_style = False
     yaml.width = 4096  # Avoid line wrapping
 
-    with open(filename, 'w') as f:
-        # Write header comments
-        f.write("# Tuna RT System Profile - Cpuset Configuration\n")
-        f.write(f"# Generated: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
-        f.write("#\n")
-        f.write("# This file can be applied with: tuna cpuset apply <filename>\n")
-        f.write("#\n\n")
-
-        # Write YAML structure
-        yaml.dump(profile, f)
+    try:
+        # Create parent directories if they don't exist
+        parent_dir = os.path.dirname(filename)
+        if parent_dir:  # Only if filename has a directory component
+            os.makedirs(parent_dir, exist_ok=True)
+
+        with open(filename, 'w') as f:
+            # Write header comments
+            f.write("# Tuna RT System Profile - Cpuset Configuration\n")
+            f.write(f"# Generated: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
+            f.write("#\n")
+            f.write("# This file can be applied with: tuna cpuset apply <filename>\n")
+            f.write("#\n\n")
+
+            # Write YAML structure
+            yaml.dump(profile, f)
+
+    except PermissionError:
+        print(f"Error: Permission denied writing to '{filename}'", file=sys.stderr)
+        return 0
+    except OSError as e:
+        print(f"Error writing profile to '{filename}': {e}", file=sys.stderr)
+        return 0
 
     return len(cpuset_entries)
 
@@ -144,7 +158,6 @@ def apply_cpusets(filename, cpuset_module, verbose=False):
 
         try:
             # Check if cpuset already exists
-            import os
             cpuset_path = os.path.join('/sys/fs/cgroup', name)
             if os.path.exists(cpuset_path):
                 print(f"Warning: Cpuset '{name}' already exists, skipping", file=sys.stderr)
-- 
2.55.0

