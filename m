Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC324CEEA
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258389; cv=none; b=iwIArHKicOEPYT6k8lL99GROlwztrpkSWIrc5qzU7srmMEr0rEQ9ty6QrpKW5EScTAfJcfBENIXhluIOI9SMry0cWvGOmfj3HZDNrBs1ywJleMsOzcG3PvKzxe2CW6DZAM6m+x7ScE+3UAZYevOsO57+V8HU9JhcafZ7UHyWVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258389; c=relaxed/simple;
	bh=nOx4MM3Ew5SQ4JEQFDlWDJi5Qe9d3mYZu4utLB2Y9MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUMFRGia5Ym2T2TCD8is+QifVJegFoK+XXX653PvtoiarpWmRcpGwz31+7xtpCyg2jGwj9o23cy0Fijjzbc897NO00ezhyDFqX/9yX8SFpTp70h+rn6/MGYZti5dsB2dGEiZa7vmqB6/N417NQahP7YKhgmugy0XTLc+nXZcTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6DBng5s; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6DBng5s"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7389cff36bdso5574137.1
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258387; x=1785863187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3bi+h55pP+dcK6ujhvGNqNP+RaQwelR9q1drl/6KzM=;
        b=j6DBng5sHGX+zxz/+pVNzHvbqYL2ypi9ixhf/+2kL7+LpRhr5R64Be9cgDZMStDJX6
         9AXhUU0c0IFFVZEQaPRyr4OM1/8nItrn1F3JmmaZV+ZUQLxhQ7/gjQ8R9cWkJHFhT0B6
         oJbjg3TIXcdcah2q2KN/jG90/pRGgnsn5pROUhInQj4OSc4APoGL+sfs2RE8/TWaH5pm
         +68NJq20YVdncZ1O0CkX3X23Yy0IRM2jUnHQh+v/DGrn/DKTOvkjajjAB968KWPeQMS2
         caRjpCwIZWyeIfUjwzGyL0nWlAbRGJRJMslaepplws++YoqPBymKEPFt67PJxkcmyn3i
         eR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258387; x=1785863187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3bi+h55pP+dcK6ujhvGNqNP+RaQwelR9q1drl/6KzM=;
        b=DJ669QBBPwMljm2XWaH4++SOSSxlBhK6UVnv8yU2lNjRhf99684A0uTkZpG9O32Ko7
         dn4S+SR3hqUZSfk+9zcH7GWvG9An/PnqsGkQcklBRGKm3PkeXfYOJhXsp2ns7ZZ7S4x4
         x+IFayLX4yeOiw5wGUF4EredXFHZLufxJ6qLhQqssI7IEBFRZCHQFG/062ZWNipjnMdf
         xV7EYBAaW6T/ZkMyK3zzF0trAM7X2uB14e2bHkXuvQjCzx7Ya7GijTaq8D2QDtS2eBI7
         1bLWH5CIXUV2UlyBd65tR8+PxI5dw0GQBb7k5Z88daZp7XFKPApZVYEZoiV2BnEkKjYg
         j8ew==
X-Gm-Message-State: AOJu0YxYS9nGcnfrJJzQO5YadQ+viVs2dUrh5XWq47ohqSv5WiP4Cy+n
	+MN//nKxBi86JegqHGo9MNNoa/OFunZXXXMGUFgNPD4M9IzjwefT8wnxdomEJA==
X-Gm-Gg: AR+sD11DkwqobAiTFCixdPrExDa6BhhBK5yFl3Ukd0zA2GSCHe+L+RUhpF61Xeiu0jV
	aRxpIa/PUz9ZhQvQb9IOKSXS/tGDyfjbVadt2wQU/qbA7JVjvxcF6RpCA8wopVDb4Yx1RXDpQjP
	ekxdcZ2ZA+FQBr8jERCubQLtTvk3tudkrzuoOwrELkpHxragiT3xXZLZ6thtTmYr88c4FXjVlgb
	xmdnmsWcclcRrGcCHb2hL08SJ8AfY4Em5FAHXbg1s4oxX+oDemgJR5fY1NVx4GVskLyPfFFnVPi
	0OEsYNtx4eNEFyYlJXPl1lbctbO917Flc6h/yfhsnUNKTO3Psv5ydIZ/qhu4IhQzblOq/lp78CF
	WaDjrg4lLFFpJ/8my2O1/c5zf50HLFeFNqDwle9O8J0Or1CBUCI7QM8S68trP0h4/FworM08yK8
	+5atB4J1BncsuPOJb+0ev55+wmpJBjlp5VZTOlp3s+BA4bgmMgzlybjbJ5iE0H+NNl5317
X-Received: by 2002:a05:6102:4429:b0:740:2664:801b with SMTP id ada2fe7eead31-754a048032fmr1728508137.11.1785258386542;
        Tue, 28 Jul 2026 10:06:26 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3aac2sm3229676d6.30.2026.07.28.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:06:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 4/5] tuna: Add intelligent path resolution for cpuset apply
Date: Tue, 28 Jul 2026 13:06:06 -0400
Message-ID: <20260728170607.176811-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170607.176811-1-jkacur@redhat.com>
References: <20260728170607.176811-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When applying a cpuset profile, search for the file in standard
locations if the user provides just a filename (not a full path).

Search order for relative paths:
1. Current directory (./filename)
2. /etc/tuna/filename

Absolute paths are used as-is without searching.

This allows users to run 'tuna cpuset apply my-config.yaml' from
any directory and have it automatically find the file in /etc/tuna/
if it's not in the current directory.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index cf33af13d5d3..25515d5ddd5a 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -118,6 +118,36 @@ def get_default_cpuset_profile():
     else:
         return '/etc/tuna/cpuset-profile.yaml'
 
+def resolve_cpuset_profile_path(filename):
+    """Resolve cpuset profile path by searching in standard locations.
+
+    Args:
+        filename: User-provided filename or path
+
+    Returns:
+        str: Resolved absolute path if file exists, otherwise original filename
+
+    Search order for relative paths:
+        1. Current directory (./filename)
+        2. /etc/tuna/filename
+    Absolute paths are returned as-is.
+    """
+    # If absolute path, use it directly
+    if os.path.isabs(filename):
+        return filename
+
+    # Try current directory first
+    if os.path.exists(filename):
+        return filename
+
+    # Try /etc/tuna/ as fallback
+    etc_path = os.path.join('/etc/tuna', filename)
+    if os.path.exists(etc_path):
+        return etc_path
+
+    # Return original filename (will produce meaningful error if not found)
+    return filename
+
 def gen_parser():
 
 
@@ -404,8 +434,11 @@ def apply_cpusets_cmd(filename, verbose=False):
         print("Error: cgroup v2 cpusets not supported on this system", file=sys.stderr)
         sys.exit(1)
 
+    # Resolve filename (search current dir, then /etc/tuna/)
+    resolved_path = resolve_cpuset_profile_path(filename)
+
     # Apply cpusets using profile module (passes cpuset module for code reuse)
-    num_applied, num_warnings, num_errors = profile.apply_cpusets(filename, cpuset, verbose)
+    num_applied, num_warnings, num_errors = profile.apply_cpusets(resolved_path, cpuset, verbose)
 
     # Print summary
     if num_applied > 0:
-- 
2.55.0

