Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BE24A047
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470013; cv=none; b=EzHsNRKkdG7yoPbKXe4+0LpR3s9TG5F1CSF6TDquH/UvU7ekEJ0dylYWtDmsqRUR18C4R0x3wwUWy+Gi/546acsF/Lh6adrKYtdLInaoZxnQvjzDIPILCXAJsTgnZ10653VY/RZRPcCprkGnDf5JlOB0U8pR19D3CMTvdZbYfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470013; c=relaxed/simple;
	bh=3FzTVuSixL9dUtGBL9PAlUjNWX8Guuq7ZGx7dx/IXNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FV1XOQvgla65i6dIghj/f0RUA4azSyMY0/b+nW8cWDNvuuiAZabjaDse5umvLKLKd/xTNNlzMBo7zeIHDldgx1jFGCNM9Yim1voyLrDaUyBvxP4a33naKP1f2HrV26Q/yI12jR78ScJyPwevbuVuyZKoGZK8a6PzC4wKf1gNzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAQq34+Y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAQq34+Y"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab9ba884c6so32038301cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753470011; x=1754074811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BFs5Kfr93O/qi6xw1FSkulVWyumfVU8r2H+UvsUQmCg=;
        b=BAQq34+YwYxqQ2623SihNWkrhc0aTNhq6iBPE5q54FbbVpS5h7rORzQ9EBaC09UYJQ
         d3VwI9RLd/myDBVlvHtUT7cyC1QKxvMsLKLiGr1/AmW/L4OCVG+2imBmPrFNuh6P7c8b
         /i6yy0LZHp5TRjewplazdHsmW0Pvzjy9Xxpi+qKq8KhTEaEncN9RhGP5d202jUvJF4jM
         hbWWLaBeRM2S3P0BrUsy1z8rb/DjmFmx5PoahkRgrWAKVGkp00PWKsuvK1BfnFlsjRn/
         wDnrmdT2eQRmPuzeGny/PoSu/U558guOJtWHgMAB0ylJ9GuGeN7L4qkiWOgE3GrEpDZF
         m4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753470011; x=1754074811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFs5Kfr93O/qi6xw1FSkulVWyumfVU8r2H+UvsUQmCg=;
        b=NBHpWFbYTMzZAOLaEmWXtk/XdtHcOw1tt8lVuwZC7pirHIIq6zuPEH193wfdxLtyAq
         B6z2ap2TWUAQkdT2MPWe49xMWLtQsCeL+KgfJtnevxITRw4El2+FqJj6zKOfLzN2yUAC
         Boh0yuw1AOwPSnL9JihSUumQfE8Hc0YidmnCBZTHzxmsABMqpsJHgzOYqz5wuS+NlyWE
         Fqq+ABIldYNkr7VJ11ReME116N8Lpho76nD2N0KBqF64zr5UmoVvIA4r3TXF/d11AgIb
         GeBSKvIDoSURV57PdvVFrqZUXNBQn72x4Yi2mFOzTpZtWfdoHvj8zXKfFda0azu9HUNM
         18Fw==
X-Gm-Message-State: AOJu0YwR9mKg0t7lNL9Sunz7iTRo0JVJ/c0oBN/YEfRHf4/09krx6bYS
	Q8p+4pnyg7skku3Bjv1DCUzdintFvHJGGWiqeEJWbf3GuOgFXWUWwuwMJKK09xKw
X-Gm-Gg: ASbGncumKM8kN5q/KESKdUhni4Zaz5db7qpIeV+sGJTyeiMmMPjRofzSHKkSOycppYx
	8XFhlMN+prpYIwQ9SgOWhSvrH/5jt9ZqvXNm4NDum1wzGIvgk/vaahUDJRXXJfF1dPjvmKMGc3b
	3N7/OoFay/nJH9mMjEfGq7+RHqAbkkwYHeg6dl/KMHcQ3mdiiopYJtc6rYiV8jWIuVs6dII8r8A
	bIO0AgPXsPpdFMRNvq9TsvnlMUrj57tfCbZ8mDmt6KwIsh/4knfFGqcvyUv0+dTNh2M61q8lfvG
	wU1w+rk4DRrFtz0JH7gq3nR8ZMiSMHmx5guKoB8mnKRWqA0NA1XTL9vcwbTayeamLiN0gFHK5DP
	0iIr5WOhEH8LZlSBPA2YP0l8UAb7ZNlOzqw==
X-Google-Smtp-Source: AGHT+IFZTp4C1pHwHtiPsOrsjT5zrssbJT7YlYTiTlm6jFFSuaIVNv/o+1dV2U2VBlph8CKwpuwkkg==
X-Received: by 2002:ac8:5804:0:b0:4ab:5d26:db8a with SMTP id d75a77b69052e-4ae8e878ec5mr37750581cf.18.1753470010557;
        Fri, 25 Jul 2025 12:00:10 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9966c3cfsm3184641cf.48.2025.07.25.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 12:00:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Wyatt <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] tuna: Fix show_threads -t and show_irqs -q
Date: Fri, 25 Jul 2025 14:59:35 -0400
Message-ID: <20250725185937.72945-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix show_threads -t and show_irqs -q to not match everything if there is
no match.

jkacur@fionn:~/src/tuna$ ./tuna-cmd.py show_threads | wc -l
428
jkacur@fionn:~/src/tuna$ ./tuna-cmd.py show_threads -t "nosuchthread" | wc -l
0
jkacur@fionn:~/src/tuna$ ./tuna-cmd.py show_threads -t "Isolated*" | wc -l
55

jkacur@fionn:~/src/tuna$ ./tuna-cmd.py show_irqs -q "iwlwifi*" | wc -l
14
jkacur@fionn:~/src/tuna$ ./tuna-cmd.py show_irqs | wc -l
58
jkacur@fionn:~/src/tuna$ ./tuna-cmd.py show_irqs -q "nosuchirq" | wc -l
0

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 4997eaa5de92..9496c61f0c2b 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -79,6 +79,7 @@ except:
 
 ps = None
 irqs = None
+match_requested = False
 
 class HelpMessageParser(argparse.ArgumentParser):
     def error(self, message):
@@ -391,6 +392,8 @@ def ps_show(ps, affect_children, thread_list, cpu_list,
             irq_list_numbers, show_uthreads, show_kthreads,
             has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact):
 
+    global match_requested
+
     ps_list = []
     for pid in list(ps.keys()):
         iskth = tuna.iskthread(pid)
@@ -422,7 +425,11 @@ def ps_show(ps, affect_children, thread_list, cpu_list,
             raise e
         if cpu_list and not set(cpu_list).intersection(set(affinity)):
             continue
-        ps_list.append(pid)
+        if match_requested and thread_list and pid in thread_list:
+            ps_list.append(pid)
+        elif not match_requested:
+            ps_list.append(pid)
+
 
     ps_list.sort()
 
@@ -498,6 +505,7 @@ def find_drivers_by_users(users):
 
 def show_irqs(irq_list, cpu_list):
     global irqs
+    global match_requested
     if not irqs:
         irqs = procfs.interrupts()
 
@@ -515,7 +523,11 @@ def show_irqs(irq_list, cpu_list):
 
         if cpu_list and not set(cpu_list).intersection(set(affinity)):
             continue
-        sorted_irqs.append(irqn)
+
+        if match_requested and irq_list and irqn in irq_list:
+            sorted_irqs.append(irqn)
+        elif not match_requested:
+            sorted_irqs.append(irqn)
 
     sorted_irqs.sort()
     for irq in sorted_irqs:
@@ -540,6 +552,9 @@ def do_list_op(op, current_list, op_list):
 
 def threadstring_to_list(threadstr):
     global ps
+    global match_requested
+    if threadstr:
+        match_requested = True
     thread_list = []
     thread_strings = list(set(threadstr.split(',')))
     for s in thread_strings:
@@ -555,6 +570,9 @@ def threadstring_to_list(threadstr):
 
 def irqstring_to_list(irqstr):
 
+    global match_requested
+    if irqstr:
+        match_requested = True
     irq_list = []
     irq_strings = list(set(irqstr.split(',')))
     for s in irq_strings:
@@ -636,6 +654,7 @@ def nohz_full_to_cpu():
               _(" needs nohz_full=cpulist on the kernel command line"))
         sys.exit(2)
 
+
 def main():
     global ps
 
-- 
2.49.0

