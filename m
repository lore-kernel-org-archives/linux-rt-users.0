Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FC1A9F95
	for <linux-rt-users@vger.kernel.org>; Fri, 22 Aug 2025 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830625; cv=none; b=UewB+PAMHCiNSfZs4Kg1gx1Jamd3jdGkyfScb+aD1Qdf47YBjdIg9nBV+Ss1q7q1lmv59aPgxN+z4hcOuylt1Ep8wTpe7XuxbPAae7j7NR27nl4EY2UPBJaui4P0DrrDjZfn09mvJMGtY2UrXDnfNSXNr7GJCUaLJ6fJQbmf3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830625; c=relaxed/simple;
	bh=S8mUcVGvpx6GkXgFyk4VlWdn4UXJH+HuyrMHSLsxKsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHB//h/X0il6K4qX8n90w3e03hwTs4bV40H/SpDFAoo+PBhtS2EFC2IgshLZNrvm9p9HIcq/Jd6zoiNl8todqM1lZFRZ13NgyuoYyy0kA+9PppXG9LNMXYaytTZ6gluamLiih1TNsrQjbTRDRlz0ZWlTRw/BKGaqOlKuogMniq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5gYUARi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5gYUARi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755830622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lTgcycUmki4dDoOTaj4IqPtLApgdXT/XmFDPlHS9mcE=;
	b=G5gYUARioyOhlPHAEam9kyPJwlduajAhpIIQqornVS11RGX5dQIixFvtEshXYNnWAUxj5a
	YNkIB4AU8Mv60iPaXfUtL9qhev9Nspe6Q+TmU0mFP7aUqdXST2ROfgbZ+WtYKmuuH9eeJ9
	Ytf1D7LM16aiNll9pd/0FnmRfEB3bOw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-9sQscknzMPa_wihQWBvuSg-1; Thu, 21 Aug 2025 22:43:38 -0400
X-MC-Unique: 9sQscknzMPa_wihQWBvuSg-1
X-Mimecast-MFC-AGG-ID: 9sQscknzMPa_wihQWBvuSg_1755830618
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71d603b2fa1so25088417b3.1
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Aug 2025 19:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755830618; x=1756435418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTgcycUmki4dDoOTaj4IqPtLApgdXT/XmFDPlHS9mcE=;
        b=B+MnIhiyiRuef0qdynXVZdTebXd/vMox23pJinmCLu1Vd+w2SGT9qSEMcniLld6j7D
         RvitwG+S32bVD5L8lAiQr+16IRt6h5gsna3fvpych4k3wCHnaA3UGxnpjgxiqxTqRPRy
         JOGYRny8wnzfLlg38HjpwGgTOR/UrAMC1ZI3z5N3dqK/VfDxgUxrXtQ29EimU7xL9/sF
         +B+sDzDcCrRYEDSMn1UrpWtuNpmpAin0GRmFVwPUBEvl/FMhA9U9m209Qvqos2JuHfMj
         o+iHKXwQSVotbs122sxweDtjboHXs2WHmrWhVypOn6PZz2WdDpCyVLuTcZOJBdSCnXDa
         pLkw==
X-Forwarded-Encrypted: i=1; AJvYcCXCvsiOQOWkfRJJvQgpFTpHgvqrTrg+l6GgGQWRcgnrsa7y2AKJRakEKT9k7d1Iv87OerVC4RLrqnXKaAFPfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8BjtHNIQdIITlpYZSgZGzQ7R7rzVUM3fuCCX/JSICHDqmAZZ
	MtEBLq4CaEVuf4Ra4s5ySZEjhn+qCB7QZb5Nos9ANaZ0DoYhN3AYQotPUjrfprryTJTDos4XJB9
	pLWMMPQ9pJ7Hhx1rS/wG+K85+4YPyjOtTDLbyGq7JLmOoOQVsm13MfylFxQg8m6uBbZniJE+cAV
	hLS4E=
X-Gm-Gg: ASbGncvqqDdowaTTDyvglkFjOIJKi0vWvCzCoE3CIgv4lkN/tshcvf068wSGc+3vQEb
	j+zIMRHsPPsLI4xClGqfo4GKF/DMnzL/M44VSajEdlfKNOdCQy4KDsdOPAI9nWb2dvfYLkABtjA
	4ocLRHKMOaS57M/YvauSMA+w1mqHVYTQc3/RWjGeZaXTEBq7F84ZW1AU6uwxF711GCPS/lcN56b
	UBih40hx+BDG/paRH844gz5hgxL3GpM8sBI3f/YEyMPWHVLOB74ygefDleWLt/YMk+nlvZAqudu
	T4OodN0nj6FymcxWuLtzCgyQPuBMg6x0qWrAj4z2pfRWXzwY
X-Received: by 2002:a05:690c:61ca:b0:71c:1754:2696 with SMTP id 00721157ae682-71fdc412ca2mr19095247b3.36.1755830618114;
        Thu, 21 Aug 2025 19:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMSigQcGhq5eJi4qOCr65xZeP0gQty6RO82e2qMiyE2akS/094mmeUmt53KD2IACMvSAYWhA==
X-Received: by 2002:a05:690c:61ca:b0:71c:1754:2696 with SMTP id 00721157ae682-71fdc412ca2mr19095057b3.36.1755830617745;
        Thu, 21 Aug 2025 19:43:37 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.64.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fadbb4359sm19462477b3.18.2025.08.21.19.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 19:43:37 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>
Subject: [PATCH] tuna: replace match with if statements
Date: Thu, 21 Aug 2025 22:43:19 -0400
Message-ID: <20250822024321.61951-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The match-case keyword statements were introduced in Python 3.10. At the
time RHEL 9 and other older distributions only have Python 3.9. This patch
will make it easier for older distributions to use newer versions of
Tuna.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
---
 tuna/cpupower.py | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tuna/cpupower.py b/tuna/cpupower.py
index ec04b90..ecb2507 100755
--- a/tuna/cpupower.py
+++ b/tuna/cpupower.py
@@ -38,20 +38,19 @@ if have_cpupower:
                 self.__cpu_list = utils.get_all_cpu_list()
 
         def handle_common_lcpw_errors(self, e, error_type, idle_name):
-            match e:
-                case 0:
-                    pass
-                case -1:
-                    print(f"Idlestate {idle_name} not available", file=sys.stderr)
-                case -2:
-                    print("Disabling is not supported by the kernel", file=sys.stderr)
-                case -3:
-                    if error_type == Cpupower.LCPW_ERROR_THREE_CASE:
-                        print("No write access to disable/enable C-states: try using sudo", file=sys.stderr)
-                    else:
-                        print(f"Not documented: {e}", file=sys.stderr)
-                case _:
+            if e == 0:
+                pass
+            elif e == -1:
+                print(f"Idlestate {idle_name} not available", file=sys.stderr)
+            elif e == -2:
+                print("Disabling is not supported by the kernel", file=sys.stderr)
+            elif e == -3:
+                if error_type == Cpupower.LCPW_ERROR_THREE_CASE:
+                    print("No write access to disable/enable C-states: try using sudo", file=sys.stderr)
+                else:
                     print(f"Not documented: {e}", file=sys.stderr)
+            else:
+                print(f"Not documented: {e}", file=sys.stderr)
 
         def get_idle_states(self, cpu):
             """
-- 
2.50.1

