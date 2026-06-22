Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71934BA53
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159710; cv=none; b=i4pAwDCcnnUP2beFk1gIGyCQ15YiCPDcZnMn304byK6DGPVrTSzEuF5kG2VJMrpBOIzmwV9AHazIDWm7GfpARYH+ISJC1ytkKkXxOymvaCSAezrpiwLuq9uhsVL80BntVeAMzcjQL/ZXAalUBxJnEDs8x9G3EserDMQHLAynPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159710; c=relaxed/simple;
	bh=0JAIhU6nY8CXSe27LfgktZqUBjEfKnbHNGdUVeLfnrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmLmB6FAM6k2EDtoyxNqeSygr9yODxsb26BPu6Wz9pe2yVMIfLnFWUfnH70MUFgxqut0k9ewe1rutR7agHAgrox+9KX7Aim1icUbMhUQMF33PvJlm6R2RvfnMKzxZhp21pqTRExRPO16fL7odFkzksgypjQSZaoOFwlk9Ug97ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnNu3sFr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnNu3sFr"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-915ab38ac14so590043785a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159708; x=1782764508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7ySbfEbRojhhWGCD1QfYy4KwAORmXwj2yuEvr3uSZs=;
        b=WnNu3sFrtrIq49IZsw9CStNqRMCvcuMJ0VfrtrNo+FTma7d6wz5fEvylCejd1QwoHW
         m8HDle32a90qKgo8TBWV9IQMXCzfVaxTJOoI2QZQQT6yixlE8c5n/RCnS0rLJXXyp5Uz
         6b58X5iHFOULZnpHRR0xbD504KUDaUY5MIyNNQiHThUKQPc0HfnuX10p0Ot4CkV6Xe4c
         z0U1WIRGBlpjSfL+P2VwpmHsbpO48f0HiFyViJt0rM0u3NkR8tW8aLkWYBWTp5hqDuau
         TV8SCoAkA5fzhEb/OPtigILxjiEslbi2SpVkfIFUPixlNy4WHKTTOQtHkxMctZUOin4K
         CTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159708; x=1782764508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7ySbfEbRojhhWGCD1QfYy4KwAORmXwj2yuEvr3uSZs=;
        b=NfXjcfEuQB/HnkvDfA3jtwZxDjeaJqsgXF0dgq8Cfh7CehME6a2cWJ/MvH1dIlEZDs
         LGsFwVva45BiPV3ZKbScvezp5JixwYXDykT8dwHDkyS708nfNCXPcYo+OQVF4ZruhalT
         vGHM7bwGcxDkKPYFxljhljQgCRe/uBPjwlHd4FM32roniHD/NOO7+oHJAxcC2RGbHQ5x
         S7nfIjgbxM1cKqoTNEFWRmq3QoCdBAWv3iGu8fW0Z4qcqUTMcTcVlARyqlsmbShS04ph
         WJuIxCIWpxu7J9hDFQt/nzD2XMXsDuTgRqT2NTAb8UZNiT4CcIwnpU6xSvFowNrdlK2n
         10Hw==
X-Gm-Message-State: AOJu0YyRkqhFlOmikDw8mRjc9DwjJi76IXU7g3YGod5VPGM1IxPbW2mh
	KLVS2MA9faKNWjKLyHC49Zddf1fY8Bezt3S2oAyh3YUaINzQbvyjdAsp+6XifA==
X-Gm-Gg: AfdE7ckxfEEoHpIPkNPM7Is6eUFlasHBBR2KlO/3q7JT3WkVWuQKj9yvi+zfrFrVQkN
	3tP5q6XXDOmuF+8HDJA69DFWwKuU81DK0uPdlyDtDPpLDaR2V/P9IBEGxzP8qCKLJ/u07GZz+Xu
	mspjm4iGNWMB+krRkUu2palRAMfCaMmvxutUiQrveacMNlZdYstr03pb8GmuLu8YcJ9ObcUd3sG
	uwbIbOMl/nonfZsfJ69s7GOmlu/B780QHqMmcobNXWqol+3+6nMyb5ZX9AJydJFxbNtH2/0HNWQ
	VjtUxKFnWa6bGisOKTQSFgDkhybaYu5NWGpxVxLbcpyXPeUyhnAU37EC3ThflNgxvkTR7IsxI2n
	g5oc5oO2pI4NEF/7FNuHD4hJVZYOgizl0iiHVOKXrMpKEk6YKva6qSA7X1X9b40+AgLDEzvoz6e
	EbvgEOvt6hPyVDVJncH2Ez5oX+8+IGvVFOEf+3WU4TWRzWrak6YmXLBpGNVD0+iWn/jUawEu1ph
	AJ/CO6hlw==
X-Received: by 2002:a05:620a:a511:b0:920:fa37:f249 with SMTP id af79cd13be357-920fa37f4c2mr1979094485a.22.1782159708345;
        Mon, 22 Jun 2026 13:21:48 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm70661285a.45.2026.06.22.13.21.47
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:21:47 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 2/6] tuna: Suppress output when pattern matches zero results
Date: Mon, 22 Jun 2026 16:21:27 -0400
Message-ID: <20260622202131.182067-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202131.182067-1-jkacur@redhat.com>
References: <20260622202131.182067-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user-specified pattern matches nothing, showing empty column
headers is redundant after already displaying the warning message.

Suppress the display output entirely for show_threads and show_irqs
commands when patterns match zero results. The warning message to
stderr provides sufficient feedback to the user.

Example:
  $ tuna show_threads -t 'foo*'
  tuna: warning: thread pattern matched 0 threads
  (no headers or empty output displayed)

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 015bb7a54663..d9d1eaa83757 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -746,11 +746,31 @@ def main():
         list_config()
 
     elif args.command in ['show_threads']:
-        do_ps(args.thread_list, args.cpu_list, args.irq_list, args.uthreads,
-                args.kthreads, args.affect_children, args.show_sockets if "show_sockets" in args else None, args.cgroups, args.compact, match_requested)
+        # Skip display if pattern matched nothing (warning already shown)
+        has_content = False
+        if match_requested:
+            if 'thread_list' in vars(args) and isinstance(args.thread_list, list) and args.thread_list:
+                has_content = True
+            if 'irq_list' in vars(args) and isinstance(args.irq_list, list) and args.irq_list:
+                has_content = True
+        else:
+            has_content = True  # No filtering, will show content
+
+        if has_content:
+            do_ps(args.thread_list, args.cpu_list, args.irq_list, args.uthreads,
+                    args.kthreads, args.affect_children, args.show_sockets if "show_sockets" in args else None, args.cgroups, args.compact, match_requested)
 
     elif args.command in ['show_irqs']:
-        show_irqs(args.irq_list, args.cpu_list, match_requested)
+        # Skip display if pattern matched nothing (warning already shown)
+        has_content = False
+        if match_requested:
+            if 'irq_list' in vars(args) and isinstance(args.irq_list, list) and args.irq_list:
+                has_content = True
+        else:
+            has_content = True  # No filtering, will show content
+
+        if has_content:
+            show_irqs(args.irq_list, args.cpu_list, match_requested)
 
     elif args.command in ['move', 'm', 'spread', 'x']:
         spread = args.command in ['spread', 'x']
-- 
2.54.0

