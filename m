Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC91ACECD
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527734; cv=none; b=nIMcfEBJCzfRjssTgS/+A/6k973GArdHLwE+GcjhV3gYh1/rZijmf3CMNRbsdft8QOXYPPqIlFdKGWOLkoASU3Bj9Dm0kpKpzESenEWtmJC4sAZsC8NMZeynYLtShZkG5UhsTL4W7Ec2VNkCC0qcAJNigvPshH7lG5TcaTaFMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527734; c=relaxed/simple;
	bh=dOOyFguojxwEeeUGM4J+zfFTibsmxOQbNNqWVNxn+cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/LZ7zhrZw3vzdq2UESJvi3l8BGNa3VLxOgFQ1trRIjZZEa9qidexSbSgz13p5c8O2y4WCWzJoQjLc5Rwmi1qVUs5D5BMK79ORxjyOhnQxm6o4MFAJgaDgz4DZ6iGQhvRPJiuKYCV0veXkMZFHH7NJMecbuhLseSEVBu71xZLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e94W4MBf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e94W4MBf"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5b8d13f73so191491985a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527731; x=1746132531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HuWQtXW5dMXVMNDeiod/gwKmHb1Y+csPXw0q+jxB0To=;
        b=e94W4MBfk8R+UcvDCe6aGBOFTjFvDLB0V8/POwsNh+UrMQcCq9POxtceraJUGtoYV7
         q69xtYY0fblP/UWQaED4+M+XTB2fo6z4PeSUzWZdKmNKveuegF+O/0LK+4SR72Fz11d/
         QYEDdd3MellSnXRMxeY2o0nAtue2zak+SYXRdHxCYkUoC6k7l9YCnyT6IVcxsGjyM9/D
         IrAaac2ceL7fHRFiZopX6NkcO8cKHyKbJ1trVwp6VI2UOXvxl1FsGNbn0s7cwrdg8VCZ
         0ocuOZBS9XcRQPXXspXlTLuAeqYrz7ZVcxZKRibiVwfXAHNdchTRRFLigl+AZOEYd3Au
         uVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527731; x=1746132531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuWQtXW5dMXVMNDeiod/gwKmHb1Y+csPXw0q+jxB0To=;
        b=nesA7iA6T9zTzQlhxTV1rFEhgpx3jSO2JulbCUMcxuBAPNjjyUYj+AeR5P9kcdg2yr
         1kkhr520t3gmvsyEO96oxSgQCU9YMtxNhir3We8/37uooyeGbErz2GGA8aib9Dt/t8vQ
         WYGHRDTKQMkbugZpFBCSbMzcHzM4nD5M/UtuzoUI3gMeSzrcDLiNH+JaW626W6k/YH80
         0m7wdOj8Llkr/viTmvQuj1+n0lwVEIBdm5qD4HZ0B1heZoBWfgKj4Ajh84Alvo8bpVoO
         kkOPsrSjPRVasz24akSngPHEmf1l/L6v/Ip5fZcb7uIBdjZJsCSFuQ9UX47ay3qP8Bzy
         EMdg==
X-Gm-Message-State: AOJu0YyEgw5lzuBUx70CQBA0WM61MI1IHs0qsAryT+TmCzuT1PfoqD9D
	K1p+PW/DaCR+9JxS51pwx/vTdQ10QdGeB6UvYMWK5/qL1Ve7we+U2mZMBA==
X-Gm-Gg: ASbGncuMMRNh2BRwqwVqZQm/5eZ5nOB0tL3sR1/fma1dnzRnVX0JWTwp27S4A0FZqVt
	n2EUVkvR4c7WoRUHuIa15LfyV5t720qSImQgkZZA35iZFjgtk/4OcU/Orbtdk36vl4rEMHN+gTw
	GYAcqeqkeQpZN5hHWCZd5nTw7o3S+Z/2z9avQ48Wb2ZnKppQ0QDLnP/zRzX3RCnzrIHHQ7kAjtL
	JIfkM9yDfeu2pANedGwQ3sL2EDc/dhnXUHWBrf7/YK4EcZaUCTwgtUuNB1bJlJ4aaGv+0P6hFAB
	rjcDeSVa7Gs/zMtPyeX7V/di9ZwVz3+aNEA6LyV9tDexyQ==
X-Google-Smtp-Source: AGHT+IHayhQiOLoIMIu2UiTaimufeRnNFknNai8pO+PWXupibXBuB6JpxFixPwEOfNUr2ENUjXByOQ==
X-Received: by 2002:a05:620a:3949:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7c95ef61316mr132029485a.37.1745527731129;
        Thu, 24 Apr 2025 13:48:51 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c19sm130932785a.85.2025.04.24.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:48:50 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/5] rt-tests: cyclicdeadline: Fix usage for duration
Date: Thu, 24 Apr 2025 16:48:39 -0400
Message-ID: <20250424204843.79193-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the usage message for the -D or --duration option to indicate that
the default length is in seconds if you don't append 'm', 'h', or 'd'
for minutes, hours or days.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 32fd0d0e280f..04e61edc68d8 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -688,7 +688,7 @@ static void usage(int error)
 	       "-a [CPUSET] --affinity     Comma/hyphen separated list of CPUs to run deadline\n"
 	       "                           tasks on. An empty CPUSET runs on all CPUs a deadline\n"
 	       "                           task.\n"
-	       "-D TIME  --duration        Specify a length for the test run.\n"
+	       "-D TIME  --duration        Specify a length in seconds for the test run.\n"
 	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
 	       "                           days\n"
 	       "-h       --help            Show this help menu.\n"
-- 
2.49.0

