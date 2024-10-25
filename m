Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B520C324
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Oct 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882940; cv=none; b=BB+hXCKtzo2FyBveHcUjgwqij29sg+50e58yA2/jIro4fC0YLSlYRtVomwFULniqBL9cl8rt2XR4Oh8RJnov9lGzqVJYiXm6WLXx7U2hb5zlFVorxjGyFEpr0FaiOW1CzHIzyO40noKCbvkktpQ3S3B/zQAuvbOkmfGyAK2KglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882940; c=relaxed/simple;
	bh=CB86kaYbLj2R7GhN7nwitq3GQdNXE7u8Y/qkF9Gugu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIy80zAxXPJU7LPVaxMrlrBFCQEGSLJT8i1/mGUfPXoMWsn926Y+HyIBk9jwj3aiEXkjMYhGh0LVxkvvXwu8ikj/b0EbtUgmC90QbLzWy1wCfIQfannMfgzhoD/YFUCcqtoMLLK8sNNDl0Mwlz0+vgFncZDCKLi07gNYdU6Jt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIbv4VqE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIbv4VqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729882937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vGO3wXYinHgxKkQUgJBE+nXI2pjidZp9cUEzx+9MF+M=;
	b=MIbv4VqE+/H7ouP+i8l/4NXYC3vxowzCojea8eVaMxgSXF/IcYnG5GEdT8SXJdDNNBNiqF
	KkJ7fRv2oVEItOOkktVmd6iimZVGCQ2HpB6S7XfjRFUemQRSkuPZA7L32d+0jj68650qgI
	6/ACgRYXzOUzfLs+DX+YvMVIz8iJnUM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-4qiwh_GNO1qHRLjmfj5JLA-1; Fri, 25 Oct 2024 15:02:15 -0400
X-MC-Unique: 4qiwh_GNO1qHRLjmfj5JLA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a7fa073718so331026585a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Oct 2024 12:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882935; x=1730487735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGO3wXYinHgxKkQUgJBE+nXI2pjidZp9cUEzx+9MF+M=;
        b=u502xtdXDPAzs7ZX3D+yEHwMYuoeBd/+dvMZrdn8KEIrfBsKDq+J6QiH/M1sB5sqkk
         CVUryEUbxETZE4Z9N7AK+isf3dunYzd3dilfVJ68PPrb8XPeIXKl2aqio0WYppJlzmRF
         pJr3vfo3o8KPSRS5lGef+RcoZNhU6Dmm/nS5BYuyBB5ToIwy6qn/Qqu/4Sv5+IhC6m2l
         /9JVeNBjacXeecNNLPiU0rX5e3lu0Q667wEaoE/Y5EpOVlK/z3fes2Cvg/N0I75aufb7
         C45/X5o4s4wErqglTHtPJHAoFIOjoiyz5Pjn6whdHC9ZsuzDBc03qwkq1jXoGgIIzmxm
         Pgrw==
X-Forwarded-Encrypted: i=1; AJvYcCWVSlQQLozvnI7tSiRcXQ8o6WVtq8GpLIRZpU4VAz/4f8pU62EHO1vuLbMSvHOsRtNbhYheBoIgfWcjzaihow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgyjkCkW6JsseJN6hNuphmyQcrdL8iCibyMHyhVZeFQLzPMoi
	w3qx5G7a54ayYQ9gNeIIgyyKlcGi0zDRxQ8PLroa5wL4gn9gl0ukpgpyD+w9Rmv3N/ogsCA+Sgi
	0kozNxm1nGid0izULTBAYwt56Ccdk9rtske4RL49VDDJI7kyjevstTVrLD9rKfkAo
X-Received: by 2002:a05:6214:498c:b0:6cd:f6de:8ad2 with SMTP id 6a1803df08f44-6d18585e41amr6953556d6.45.1729882935064;
        Fri, 25 Oct 2024 12:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDiCBqzSySleUXhSa+nFQsZy+DucGvhQn8zSfeKi6JItSL3VAtKvzTyFEsgx/SR16lN3db6g==
X-Received: by 2002:a05:6214:498c:b0:6cd:f6de:8ad2 with SMTP id 6a1803df08f44-6d18585e41amr6953216d6.45.1729882934749;
        Fri, 25 Oct 2024 12:02:14 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991c8cesm8217346d6.69.2024.10.25.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 12:02:14 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] tuna: Fix string syntax warnings with raw strings
Date: Fri, 25 Oct 2024 15:01:44 -0400
Message-ID: <20241025190146.149123-1-jwyatt@redhat.com>
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
an error that pylint and Python (at least 3.12) gives a `SyntaxWarning:
invalid escape sequence`.

Convert the strings written to the file with raw strings to resolve the
warnings.

Tested by comparing the diffs of the files outputted by save.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tuna/tuna.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tuna/tuna.py b/tuna/tuna.py
index bd678e2..2dbc6cb 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -669,7 +669,8 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
 # The regex is matched against process names as printed by "ps -eo cmd".
 
 ''' % filename)
-    f.write("kthreads:*:1:*:\[.*\]$\n\n")
+    f.write(r"kthreads:*:1:*:\[.*\]$")
+    f.write("\n\n")
 
     per_cpu_kthreads = []
     names = list(kthreads.keys())
@@ -688,7 +689,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
             elif common[:8] == "softirq-":
                 common = "(sirq|softirq)" + common[7:]
                 name = "s" + name[4:]
-            regex = common + "\/.*"
+            regex = common + r"\/.*"
         except:
             idx = 0
             regex = name
@@ -701,9 +702,10 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
         else:
             mask = ",".join([hex(a) for a in \
                      procfs.hexbitmask(kt.affinity, nr_cpus)])
-        f.write("%s:%c:%d:%s:\[%s\]$\n" % (name, \
+        f.write(r"%s:%c:%d:%s:\[%s\]$" % (name, \
                            tuna_sched.sched_str(kt.policy)[6].lower(), \
                             kt.rtprio, mask, regex))
+        f.write("\n")
     f.close()
 
 
-- 
2.47.0

