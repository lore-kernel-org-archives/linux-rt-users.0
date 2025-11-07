Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731333DEE8
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541899; cv=none; b=X0nI61FuWlA92p38RP3h7oLJRc1r42pXQb8BoVcsvbRb/O7slCKYzeqX11A1XmXPRq52IThnA452nPqoo/nrITP2ES+kujYeKGHIhCDGBv1nDgnHsWEiYW5Ci/iLsVolc8TPRnWFT3JgTflopF1TsrSvJ5Yg9kaq2JsY6v+2y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541899; c=relaxed/simple;
	bh=hRFfMi58MLEtnlC9+YNjyCB9I4sBXLYGOyo4KzHc51Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsVPoaksTiwov0gOfZVROqn9lPLJ3FM2zPja3ygGLUs1k/Yx4WjQ+fPU7bySHhQt39yxvDdU1g2qglZDkz8w+u4L+qe0OlqIl/yxivCuBx1mzJiys3a3NKrgXKBs6KROmbG4LtiojUOU6cWOOevfp/z271253Q1qtZBY1e1jaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icBwvM+K; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icBwvM+K"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2aebce7fso101329785a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541895; x=1763146695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB8pZ/SL8RcQva3VZOIu0y3NC18ZgDDKWZ5U0KralJc=;
        b=icBwvM+Kg03zT4KAkt3ss3J23mKdZCweZ/eiAGskp4EjPvCNJsK2Fn9oHUlqV7Ap28
         Fm9CvVlJjaYfyxfc1K24RWR/c30SWZM/FzbyZOE2CCCTyrXfcYw22bv0rfby3y7OTrl6
         ffIWM/Llwq2FKU0Fh/y73OMcULFUjKbOpmvUwY/kn2ksGK3r3f+qRZsSWtS3adPM1KlH
         1xxZyqzONO1yO0mz+DjW+MVpr/jQCH+uyMjk/K6FRhPoY5//6H9YsQ2bmPWnVJJii4Ky
         JLGJ58/BQMHBPg3APWZaz6rXLX7J45/7+C5F22vnc/yASF4ylD+c7w1puBKF27X/haQS
         BPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541895; x=1763146695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PB8pZ/SL8RcQva3VZOIu0y3NC18ZgDDKWZ5U0KralJc=;
        b=WM2EAg7PI9ghuoUWzilq249ITLbzWHKf3/8n/Qxs8jO5lCPgQgsYHonDdSihsp39EH
         oo8lwej24zrBPQSM7CJVbww+U/v5mOa11jg9HZFqpZ0nZ5nbhTT4ZX6BG9JauAQz2Q5o
         Gr3W9zq2UBhpR7XnI/Kzg1OK8TKCChmj0lvqZ2jp4sC6uC9s5E5KBg9I45MoKWP39S5R
         K/Im3cXXdPqHefBotuusoePfNiTBVso6fwqM1DD9wxOGIwcMB7V2GdWahJJhUfSDK9dB
         sxAwkDQf9zk33zGR55gOTqLrswDqSnBmkKQGBUWiCmmBTES1GxZjZltXyVJquHvRi4id
         5pUQ==
X-Gm-Message-State: AOJu0YzZXGuiumcNeJZCBg9W961IzEqe1prPTj4A/3+IPFKoQQLKX5e3
	zAxevd1gjTr2c+N0kqOp87Hc/QG4ADPi1azVLcwExgobmMlQt4Ualu2OnTrLPUKS
X-Gm-Gg: ASbGnctnvljn+ozyWBHpiCydOPTrczvjxODhh7sInijUGzpOmto/4m+EWMfOuLe656r
	sIFMQBpT+EJNT8Yt2yIu7Ahsltnpn3rfr/yaWWP1R6LqcFBONM8mytZ51RKmBfw8qGarZCti59q
	lvro2Ct3TePRla1RPpIIqrycfUdi77dQkU9ZJEI2lZEdj/GM2UK0Dw8hrI6pbZ3IKRWj969U0jx
	x4HwM89vjvFPuMufT68Z5OpwdZrMfq0DTCO0Rj4+Rheui9bUwfkHMBHd83GBmwBPWtgSiXd1xT3
	yQO/tOqNnkBe90FK5U5oTgqQwK5P0Vf1zLyUICJK0BpTnFbF1iQeeHvFQ/xIXGabbDYKjKza8ke
	C8FnrtX1RqLdrj8v2c9zJWKjDMTRMcFJwPFpAFKP08sUumDmzcEhjiUmIY1olXtg=
X-Google-Smtp-Source: AGHT+IEYnSC+nYJ4eRcjooNl/8mFUowwDPVUev5opnjspndf/diyW/Ffy+OOYldpUxWmiM9xTN91LA==
X-Received: by 2002:a05:620a:1919:b0:8b1:7c0c:e27f with SMTP id af79cd13be357-8b257f8626amr42680485a.82.1762541895373;
        Fri, 07 Nov 2025 10:58:15 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:14 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 16/23] tuna: replace match with if statements
Date: Fri,  7 Nov 2025 13:57:25 -0500
Message-ID: <20251107185732.23992-17-jkacur@redhat.com>
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

The match-case keyword statements were introduced in Python 3.10.
This patch will accomodate older distributions that only have Python 3.9
This patch will make it easier for older distributions to use newer versions
of Tuna.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
- modified commit message
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/cpupower.py | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tuna/cpupower.py b/tuna/cpupower.py
index ec04b908855a..ecb2507b2127 100755
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
2.51.1

