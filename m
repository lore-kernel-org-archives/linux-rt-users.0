Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC233CE9D
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541895; cv=none; b=dJeAz0TnXdYjn6AS40uwwybWVZ2zymEtevYhgOHr6fPWBph+6ufZqm4rl6qHmyhpnB0YlvkbgyvHZdXcjxpJcetycKL58M4QWCauNfYI6/BZI6cRmJyIxupHCE3IsbmiYGQT9cmKCLL6DBGIHm+C+2ZF/PQkyeF326z/BNDN1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541895; c=relaxed/simple;
	bh=sif1VXa5T1wHL7o4E/i1tKc64OxRhN/aQldcp2+fHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8K1aRog4FIDEbM9BHfeznOTp+5CD3/bUU+oclVKERK2nKu6E3sR4tcs/Zh+6imc4rF4guufTOmCB+6lR0KbScIFs/JZ+7XJgAhhmE6/T8l2xAXSwbOyYSJxiNlwEHUpa2UTP6XiJkAO1417rEUzQkX0zMoz2L6kLDtq8zAiiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np3NcR7n; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np3NcR7n"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b1b8264c86so107997985a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541891; x=1763146691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMm9zf9vcK9PNdpIOEYCzv3fK3C4NDoFcI+O7UsYaI0=;
        b=Np3NcR7nPHzeXgk2qgO5b4VnEfxOxWmvoAfhV9VQgQ07drtsPt77K2ok1o2e6kvWZ/
         fVk/dnT6xjGDbH4P1pS7Tgw+A8Od/zIPBjlZxjJL1ppYgrgBhMO9IFukNx0UOi6YVMnR
         ulAOtUf93Ab+5WdrmdTbUU5xso0fBlfq/SUvkWzr0gTm9zxqHNO8mCURqo1v33cjWXpF
         3hASjeMFu6H5AqNNxx/MNj7YvVsDEcpF+JCGiGG3BYbeWXJwgNixb2viPWPj+SZae5mn
         qw8vWPrXK3e+ZJ5AkVc6fse26rlmALB9du/AHI2+RJjsYDTGWVVuo5QWo0NLd3qAHdQ9
         1FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541891; x=1763146691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMm9zf9vcK9PNdpIOEYCzv3fK3C4NDoFcI+O7UsYaI0=;
        b=F4Bq+hjTzqsDcR6pL5uPv810XUAfCR6EpgsKiqL6gh4IZBOa9/rBWs2eVTbFBesgA9
         ox5QVRnostkH6HM63wQolSjLdv2Ws5TXGS5ls+/RpAmrpyn7KjCc9iwqbXm1JkXGg6vq
         Tf0MG7qfHTnLkjDowEDBdS782y41TFcBW1wgS84hxHKBruDI+B2x6Gm8RIAwPUBFO0n+
         DVKiT6R1o1Q2eniWKNh7jJJXSW4l50iZrTPkeyj7wf31BQLOrMuIvsrf6B63RltI2GGc
         N7O801ofH0r8ICUVscXPzZxYx5G9W/c4wfBbOverTOwrdir8XSVUJd9VHKC4uduZ0/VK
         1IRQ==
X-Gm-Message-State: AOJu0Yy/NiCD8AJ8JR3kH6VrbJA2FaUd5txuuV/0K9L8shzA3CM05C7Z
	TnFm+kKJUGED19bZtiKhWQu85WgsqSymrsPvS/+DpoFWudk9JDWGBoOkcbsk6yj5
X-Gm-Gg: ASbGncsSJ4HSFF6VvW4Qa/xvKofs73K5DhPg/130MZfW9PWxel9Uq27V8U9e+NBROQR
	f2RYCm63zb2kcfsFPWjCV/hdJEDZFdWD4ypr4rvYmGwhvlXcKsLG1XQHZsYgYD8kcoqaAlOd+qw
	BSgyXetvK3DfpA19Hgxv8ohB7ae4PMEPgp7XOyXq5cltMR92AEG1LwPiG5aTRqgWL3irW/0gPD1
	5TjnoHZx7YTRtVT3oTM6mNDqtOarPH4cbbIZIT6HOH7lCZh80pf/pBU2kepd5rE2+aAhXOxTqgh
	dlJhL+IQ28W6WOxOglBpW6ElLKn8IIOl8un06jGN9iYigpu84R4pptaGuFETK0CR76bK+Mc4d5g
	DiMzhrX+06f0GyGa69EboKC6c1AVCdHzHrsD2BvJALVxQ1ECf+oA4F9W4tn0O0SY29ku656Y+AF
	UjcXgzY5fm
X-Google-Smtp-Source: AGHT+IG+8eWuGADs5kdN+KZGUKixRJqrndxihA62M3rLJu0GDqd3jE09lqAwmz/QyuSCgLCYII5z2g==
X-Received: by 2002:a05:620a:1a0e:b0:8a4:6ac1:ae9 with SMTP id af79cd13be357-8b257efa544mr42240385a.3.1762541890701;
        Fri, 07 Nov 2025 10:58:10 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:10 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 12/23] tuna: Fix show_threads -t and show_irqs -q
Date: Fri,  7 Nov 2025 13:57:21 -0500
Message-ID: <20251107185732.23992-13-jkacur@redhat.com>
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
2.51.1

