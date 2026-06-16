Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC146AF15
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627451; cv=none; b=Xz1vHHbULTiH+2Gsdx0iwp9vjzu7ZZjsXQHe9Dmd7YrJCVjO9l+OxqCvtsykAN87ZHQo9DEHlXE6CYTjy1olZAjVs3cQNRlCOWsG15adgbZZtePj2/bc7LuTq4RNflCzyPKsBCQ0ZXedt8h/L+7EqZtW0QEsrY7D7OWBLpzL/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627451; c=relaxed/simple;
	bh=JA/xZZzfKBHm1UrnzCmuqdR9QCkAIobUB7dIj3MNUg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6521//NddEJ6feruqeOxBgkQqIFRu9p9i5bdhMb5mghguVkBD/LUHi7qOiLCcuKjBB6ygHcH/Y6Fs7DnBlDSiblkiCb8CkhQt9/gibzZNGy3+g4wSaz5mUtJvJRBEuOGzP8tiM31G+vpWfZUbe37CYnBMHZUPbaCXvMhrNeASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zac39gMM; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zac39gMM"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59e23d70dfaso2178458e0c.2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781627449; x=1782232249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMDGHaAkA4aOwZmQXZXc8fo6HJls8LRiuSKEN0F/jXM=;
        b=Zac39gMMZfUbTvH0RnGGpd6LqNYY756gldl1rHAhfNjGuWTML5vliyDBnVsZF6rU6G
         RWxfkO3u9X1d9j+Yw+vZ43LZcyjEZ94Qrcmor59Rb11bDa71N/mqjqpruk7lGU0tOf07
         uaEyFDBZgIuvCIi0b4+RHCVLa1devPvsa3xh97XifHsuAdXu60eY9KQPVDjYYkvo+b/f
         yG6NnXqzOjtMfKvANpFvCmv7ZCjUE8+EV9Rk9QD0sVuNGRhwqwnGeI/+mbdq1UldyCFU
         zYED5WwouUqCIgqu87lV5pxo5JsvQSjK9Rr6QhLvz1L0ytmuF5gTByhkNFhCu9/0iwaA
         joMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781627449; x=1782232249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMDGHaAkA4aOwZmQXZXc8fo6HJls8LRiuSKEN0F/jXM=;
        b=R4fIKxYWYaZidx1Jaob0oPo/2He5iRhY0xMVlcTyujLgdq241oaB1gDhpep0knSotR
         wqK3371oGVmwiIwyYT35EYxJhVdYjejFN+U/WBJPe6sjGJwCpHz1j2O/fdAf8QpUL2Pg
         fpczk3FIZTlWrtW3mFKfhqLtM6b0yMuE0HmHzpud2HthCv2Ynr6CkaJ3EkUVAgp7TbF1
         XYK+N0sxOngkP/ARHFCeJEc+uBfFJL5wH/Pq4yxyHKgWLuyTe5Xg8wlb30nquy/MfB9Z
         rFxVQUIxmwgO7CjKVKta6F8EVnSgHxCEWJRheKfvloYiipgLAm4cgJ94VVuxX2SvTo2J
         +obQ==
X-Gm-Message-State: AOJu0YzXoCmTWFAWEf1nn7BqVqx9YeAlDo7iYrKR/mXCJAOKk4tP5y2K
	ghDjTF1h86WpNsqj/e8or4yJ6/lsgzVxulKAlpc0rYGtwZ85jUBXOtSe4GY4VA==
X-Gm-Gg: Acq92OFq0PINdd3vSZbGxeN/VWGZ9sx3Hj/zFcSaLjfcn/XYH7hGxOmgVDXalL/I98t
	y/Pn+XYyRxmVKo+7alaN1fQfs87JJUkT2Ibgc0Ep2CNa1u3plyiLt4HTXJ7JrnPO8CFS195srHH
	fNqiTX+Jvn038SSisTS7vXqAQDtRHFoyCvKXr1UGT9DJGp66qPmp0horYy41JNJoBvQYLAhq4Vd
	3Tut3jqr9yB4rA+r4A5SyUnvaBICjO/EznvDKnwDBo2KHb+q/zDa0c4sCp7iuGIFN0JCsadAxez
	AcRfy0B5/LRslrZa1pMbw9nEw0NarFr9q9LdZTPZ7U0pH/k9pbPwhrqLhST5eeicxi8nxjaNe/4
	8sRlWXkrereVr6XeD0tlrxDnSLlmh800Hk2CIbOykm7tDdSv2ZrqcM2Cbq53n8ezCZ+u5H90OCY
	4o6L4Us+CU1o/y8xEFnohE50+uB+IJZ3AjNYKjveieoTVbIqcfDXyDWPIjO4s/qDBnLPJ2kUsQt
	j/ExYKzTqAFrXNLFUUhXBG4AK0mvw==
X-Received: by 2002:a05:6102:2b9a:b0:62f:2d04:db5b with SMTP id ada2fe7eead31-7246d42dc41mr25401137.24.1781627449304;
        Tue, 16 Jun 2026 09:30:49 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm143761731cf.25.2026.06.16.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:30:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 1/3] rteval: Add container detection module
Date: Tue, 16 Jun 2026 12:30:13 -0400
Message-ID: <20260616163024.233604-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616163024.233604-1-jkacur@redhat.com>
References: <20260616163024.233604-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new containercheck module to detect if rteval is running inside
a container. The module checks multiple indicators:

- Presence of /.dockerenv file (Docker)
- /proc/1/cgroup patterns (docker, lxc, kubepods, libpod)
- Container-related environment variables
- Kubernetes environment indicators
- systemd-detect-virt utility if available

The module includes a unit_test() function for standalone testing,
following the pattern used by other sysinfo modules.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/containercheck.py | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 rteval/sysinfo/containercheck.py

diff --git a/rteval/sysinfo/containercheck.py b/rteval/sysinfo/containercheck.py
new file mode 100644
index 000000000000..c558ee05dd8c
--- /dev/null
+++ b/rteval/sysinfo/containercheck.py
@@ -0,0 +1,68 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright 2026 - John Kacur <jkacur@redhat.com>
+#
+"""Module for detecting if rteval is running in a container"""
+
+import os
+import re
+import subprocess
+
+
+def is_container():
+    """
+    Detect if running in a container (comprehensive check).
+
+    Returns:
+        bool: True if running in a container, False otherwise
+    """
+
+    # Check 1: .dockerenv file
+    if os.path.exists('/.dockerenv'):
+        return True
+
+    # Check 2: /proc/1/cgroup
+    try:
+        with open('/proc/1/cgroup', 'r') as f:
+            if re.search(r'docker|lxc|kubepods|libpod', f.read()):
+                return True
+    except (FileNotFoundError, PermissionError):
+        pass
+
+    # Check 3: Environment variables
+    if os.environ.get('container'):
+        return True
+
+    # Check 4: Kubernetes
+    if os.environ.get('KUBERNETES_SERVICE_HOST'):
+        return True
+
+    # Check 5: systemd-detect-virt (if available)
+    try:
+        result = subprocess.run(
+            ['systemd-detect-virt', '-c'],
+            capture_output=True,
+            text=True,
+            timeout=1
+        )
+        if result.returncode == 0:
+            return True
+    except (FileNotFoundError, subprocess.TimeoutExpired):
+        pass
+
+    return False
+
+
+def unit_test(rootdir):
+    """Simple test of container detection"""
+    result = is_container()
+    print(f"Container detection result: {result}")
+    if result:
+        print("Running in a container")
+    else:
+        print("Not running in a container")
+
+
+if __name__ == '__main__':
+    unit_test(None)
-- 
2.54.0

