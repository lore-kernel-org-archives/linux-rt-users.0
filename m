Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558E1E22E2
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Oct 2024 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152784; cv=none; b=rwkBEp8b2fsSLTGx7RZcUoR8tWo68gookAwOcl9zPrWVeNfAGbF6ZDlQirWCW/BC5uayvwV7Cduweguo5Tj0QXrGq3ZlhU0zU4LO5kbaLQZa91cgNt/MER6mQW6KLOdhQwPm1Mitfh3pu5WYf+DHKONO/0xQ8TfmomyI1urLufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152784; c=relaxed/simple;
	bh=aEU3hEo4xW3opTNAPO4n3shV6w9e3E8lBbmuf7HANhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIbJsTaxX+KK83Tk0NMjg6l5TTX7+5lW1gt/t+0qPT/QugutN2ji5KeY5XecHW+JGpQICfZ40VAqi4VtfoG6k9fiklAeBT3EO/IiUia+Gsb5O50lySByv0bxnfmT5bXvRgn7z6yhdG52nk6eglqN0SqqsBxw7FqcB+pobagQP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPRbJAIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPRbJAIK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730152781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCkbzsQ7cczjjCkmOAYjMOOdihyMxQfKcBabQPvP4wg=;
	b=iPRbJAIK4uEp5lPjVqhsrfNub9/cOISSh/ncqx3rzkPh7SUoT7FGi2LrCPv54YKEL+GtDY
	Gt4PVjBLI0+LxwzeqBHucBG8qnH9/2QO9njon5nFDy4vjEWBr4R8PBxuF2iC51kBjdEXIG
	W6RNpZi2GeaLd1WiIfccnCu3tjxnSRc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-AuUYSMZlOl25mI4XRDVY6A-1; Mon, 28 Oct 2024 17:59:38 -0400
X-MC-Unique: AuUYSMZlOl25mI4XRDVY6A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b15d3cd6dcso890400285a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Oct 2024 14:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152778; x=1730757578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCkbzsQ7cczjjCkmOAYjMOOdihyMxQfKcBabQPvP4wg=;
        b=baXPV2wduObX7JhMtb7Q5IiLDo863pp8k3k6IOd7HNcZB49uLEqxVHj/5+MEjwBIN9
         0un6JS9rYoVWWfESqjOcZDtKYIOhNqDjDgjw9JS1DVkWJaYrT6Z6WeL+3wFSp11O+xea
         uoY82nvjgwiSAjSclISxli1Owjo+pk71cKSsE3rDGnyJSc5I/Tqdubtf+FknhFbwTGCA
         gA3PuHtnjZ0d+frCHI4E7cvxXvYwMtSuVlDQqgIev2ojp5+a22rm1VQUTyE9CWnK4eXu
         wtyVNLWeiG+5cbYYzBE2IxEO/j4cd9Xq7/SjBWBHK4/9Zp+Ri+me8mcLIt1Nlm+YdGRe
         eg1A==
X-Forwarded-Encrypted: i=1; AJvYcCX3VJeVrG0ENAfxp7paMWOsd0SrR6ijxxc4KRduHUmRFu35BputEntQKw1OVjrh6/izTuoSA7Tc/HbX3AkqOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyerHUJWpoZXe85+GrVmbAimQRSB0Vcv2Zv1Zd+mzNqIxVtzcK4
	uzFjuXvkUkPq40ss62Ys1aoupmdTj8LHlYyBbfPp0foh7dnCIiHWkGguAfutiVpjGcsj2Xgu6iz
	zJh/7T70duA5MYKFZCyM0nBHxVRxutt4hQ++870xgMmhUqPIMBVHsmL5cC19aVB9u
X-Received: by 2002:a05:6214:4283:b0:6ce:31c4:21be with SMTP id 6a1803df08f44-6d185865c70mr167426996d6.43.1730152778042;
        Mon, 28 Oct 2024 14:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0W8oB/h5JVtwecBlWp2n4TZ2GuoYeNghrdx9m5oaplbMOYJOk6MPP3zxiX9pqjSqfiTU3Ig==
X-Received: by 2002:a05:6214:4283:b0:6ce:31c4:21be with SMTP id 6a1803df08f44-6d185865c70mr167426846d6.43.1730152777798;
        Mon, 28 Oct 2024 14:59:37 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991c54esm36150266d6.68.2024.10.28.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:59:37 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2] tuna: Fix string syntax warnings with raw strings
Date: Mon, 28 Oct 2024 17:57:15 -0400
Message-ID: <20241028215717.250390-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tuna save <filename> allows you to save your kthreads tunables to
a file to be used by rtctl. There were several backslashes that produce
an error that pylint and Python (at least 3.12) gives a SyntaxWarning:
invalid escape sequence

Switch the strings written to the file with raw strings to resolve the
warning for this section of the code.

Tested by comparing the diffs of the files.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- Combine the second lines of '\n' to be concatenated with the
	  raw strings.

---
 tuna/tuna.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tuna/tuna.py b/tuna/tuna.py
index bd678e2..d4c3e2c 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -669,7 +669,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
 # The regex is matched against process names as printed by "ps -eo cmd".
 
 ''' % filename)
-    f.write("kthreads:*:1:*:\[.*\]$\n\n")
+    f.write(r"kthreads:*:1:*:\[.*\]$" + "\n\n")
 
     per_cpu_kthreads = []
     names = list(kthreads.keys())
@@ -688,7 +688,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
             elif common[:8] == "softirq-":
                 common = "(sirq|softirq)" + common[7:]
                 name = "s" + name[4:]
-            regex = common + "\/.*"
+            regex = common + r"\/.*"
         except:
             idx = 0
             regex = name
@@ -701,9 +701,9 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
         else:
             mask = ",".join([hex(a) for a in \
                      procfs.hexbitmask(kt.affinity, nr_cpus)])
-        f.write("%s:%c:%d:%s:\[%s\]$\n" % (name, \
+        f.write(r"%s:%c:%d:%s:\[%s\]$" % (name, \
                            tuna_sched.sched_str(kt.policy)[6].lower(), \
-                            kt.rtprio, mask, regex))
+                            kt.rtprio, mask, regex) + "\n")
     f.close()
 
 
-- 
2.47.0

