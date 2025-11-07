Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCC33C514
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541884; cv=none; b=nyam5xka4eYjdJTDKI2dTFAcl/pe6rB4tmAS7JT7M9maRE7vaAkSR6bVReesOF6E4HtD28l0R83yFVlQQtDUymdYtz1QMwKizm0ZRCyqacz/7+JOI/rxyltvIEJTerwC2/GRkiqc+6mAfV2TyTGqT3Aj2JQxag8/APrUMCIh0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541884; c=relaxed/simple;
	bh=xh+nED5eR80sOBXa2WqAODYAS9gRCXP8WTk7fshIJGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql7H9Xg735JFcTZOj5VsNC3BNPHl/amjyRqn4yshPM+7MYKldcglHlTAEzTQGrTE3JvWejhQr1PylwiHrFydJHyAoNFFdanMImGfZGUFdOijwXvap0uYGbxrrrzZD726mqShfCyrqPmSJgFasgY0q2yt1LeOl3LhzyfAnoeG2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgffQfQ2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgffQfQ2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b22efd44d8so121743985a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541882; x=1763146682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOxKaeoeBL2vT91Jzn6rWx6yx/uAiPfizl/T9oAi6sA=;
        b=CgffQfQ2mjLGIbZ3TQ/X5R8PLYrFySMv/IhwRoulQ+XR8GFe1BMq0P5kOUhY61l6r2
         NiLLyrKX6U4vkgi3boGCiZGHSSiJOqvY07Ch1qxRB4kDcLtN+llvMxlMg5IPCSRgNUBy
         iyzBXJ5Ah+Fzpc0hy0M85thUY3tYzniVKC/x+mseEEihHLDPRmoqtuMUoU0yZYLwbBPb
         9dUeKmd8/p8MpwzeN01t9XkA9yoPY/q5sFQ0dbVm0xnWkpZxx56WzDqgmwLBC4/bF91/
         0a5ezabCy9L5kvZ9+YFWaDb+qE48gNkHrBFXMC6CulCCj50+DbHhIDBMAw54BrU6ch6K
         5B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541882; x=1763146682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOxKaeoeBL2vT91Jzn6rWx6yx/uAiPfizl/T9oAi6sA=;
        b=PWYYbAzLD9YopgB9SbrsGmeFdjOF8bngGxjI/6NdYBDQQSzvHqt7ZKSMiBsK89jMlQ
         g3VlWR7jjMub0IAquPuT50bO0+MQ604NKyNUExhs6Fdm8bWvcP5LAGij8FJhdvOEs8SY
         aZnH4ta1fDzM+v9DVQySDF/oJD6RRhoQfbLf6dF3kNrxB5Pv82CzcvPjwd0xzfoTXbhB
         XzEe8+mSiEYt/ln2vmmkxYP8/6TjPFZPgud/J5cqcVMzRe4uaRUJxVwGr/sf6A3R+0jZ
         8dKjv3tD5ocykI7/KEXULAWwmOjLf/lja0ugSZY8auxrbz4QUsUlytEEMQwLFRn3j6Oo
         bpgA==
X-Gm-Message-State: AOJu0YyVkFYZfjMuut/4RkxLnUBPZwacMWHhg1up3614GkJ8paRp9F3A
	sKM4fMgAuf5U7Jm8bLXBIUOxSu4FDf8M5GkAbllM0Dtqf+tDBVn4oK2SyGlNIgHa
X-Gm-Gg: ASbGncv9WqlLCbe6MIuKQpiYWbzRZsOS/IWe2jBv29J3lqKs+xDZGzHsy7rTywCtz5A
	5F/m0/cJyOmlpa1Rd5yAd5/+EWegFRftA6Iq1w+Z/k9487geYTMx8ZGuMV0rkbt7Xdz5Op9Zm0j
	fAOIg2ZmjDfpjtEub/xLFspsnOIbOYZrE8EqPvqF9SZ7UNG4DtvmSQmlRzxX27mUZbe0yf282Hi
	Z7g3ATUzZzL79m+8TsTQKz/ZBnXrBBwdr454dpmPh0r8QSU7RdW5Im2wis41ELx3+0skY5CcWPD
	8YY7eVDSYG899cDRf+v0PcxXrgAZKTe10xBtytUSsuenZcRREDkSnTe+5y0oGAcaIVv2mLYedC+
	FMnE8qlI+IxD+xjStFUd+Yta7FNxdDEnPB6M0Cigo92N0VND8PbZhNwPJ/hc8WTo0N30yzxE5dw
	==
X-Google-Smtp-Source: AGHT+IFfPpJpMgvf4uMKKmPuXuR/z8A3hniToL5a3wpIFl/XHJFp0+As4ZXDAQm+aksr3zx8zzFmeQ==
X-Received: by 2002:a05:620a:4888:b0:8b2:213a:e2e4 with SMTP id af79cd13be357-8b257f6a0acmr40842185a.84.1762541881819;
        Fri, 07 Nov 2025 10:58:01 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:01 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 04/23] tuna: Fix string syntax warnings with raw strings
Date: Fri,  7 Nov 2025 13:57:13 -0500
Message-ID: <20251107185732.23992-5-jkacur@redhat.com>
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

From: "John B. Wyatt IV" <jwyatt@redhat.com>

tuna save <filename> allows you to save your kthreads tunables to
a file to be used by rtctl. There were several backslashes that produce
an error that pylint and Python (at least 3.12) gives a SyntaxWarning:
invalid escape sequence

Switch the strings written to the file with raw strings to resolve the
warning for this section of the code.

Tested by comparing the diffs of the files.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/tuna.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tuna/tuna.py b/tuna/tuna.py
index bd678e2dc7ae..d4c3e2c1a661 100755
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
2.51.1

