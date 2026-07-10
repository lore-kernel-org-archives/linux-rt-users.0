Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A263368A5
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692952; cv=none; b=MnF4kWDgSomyXohigFkOZ42aoCYTVen8KKx8iceY2mursMBlPh/jGBSOgu1CLxMVzfVFLnTXfvVmW5eV53dNWbb8IjyYZJxz3DzVqTqR4HP9FZjxWwDy6poh3BLobJM+whKUaoxz4bDbIjw1jQN19rGisNT3PxjCBSGelJkX+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692952; c=relaxed/simple;
	bh=0JAIhU6nY8CXSe27LfgktZqUBjEfKnbHNGdUVeLfnrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL1aOcq2zzambA5FWoi6ZS5jdfLQLyIxNipH4Bg3IbLFxMJ4VmYOvSEM+A03K/Z6HzJ6PWEsNMMKTub7lDoRMNVhHLcz/odG4pB8E45FFFQdDp5bm05CtrP1VOaF61oX44sufU8UNNVGQx47jOPZaBD5P7EZRygpouzi7vyQIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX7EIngQ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX7EIngQ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-738a5cc517eso586614137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692949; x=1784297749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7ySbfEbRojhhWGCD1QfYy4KwAORmXwj2yuEvr3uSZs=;
        b=WX7EIngQVAuY/0/96iBV+9ORtC7IFYSGeHjd7oLTLC4npjZ0aUqyo1/V78em/NvKsn
         RKTVRs/SylVb0/ERPIeuK/uf8HWiswciFJqtck1B4o7kvQc0EmzFq7Qr6bcfYdw99dL+
         n9MFrHU70vAPKJhahmmvlMLdzmTz6rg+OZVmbBwMv+dkCM+G6djdS1FjCPQf2TFbNus6
         yoUYqhDJYASUq3pyBOkE8ys66keyhYDUKATagcKuhBtJFhvA7oUEeJu9Yp08GfAuD8xh
         N9yf+6VwDqz5/SJYIVlalhBerHisoOrYyTSGeCAeiULQelm/hhxnbL3Oinvbpa/Rc+ea
         LXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692949; x=1784297749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7ySbfEbRojhhWGCD1QfYy4KwAORmXwj2yuEvr3uSZs=;
        b=etujPsWAXvYWSXjExnudS58fhJr1U8UcoI/Tj4+RnL4BBKGfL82UpOZx4mOEkDf3Uc
         D4EUi1EdQN9a++iuQglMpW02d3viNuSDpTS0UPMc2tz+ZGAyiRaO+9mIq2mqqCnDXNho
         V65/mVCnamnV7lWgUw7Z0uDcQQO28rpqRKM+aWdb0SS4Q1AE4NhnJrQBMDk7eop6JOGL
         /6ztsy7rSx+kToJs3ONpWWdYWYsvnsM5QBhnxWz4dWfc0Eiaa/IQ8AYI3qQJEyMNP4uS
         aSa1DWFtYBkhF4P2y6clhwCPl8/EpwsP1QtQgCIl/8USjLzJ13WFqN4d0TLIFwklVM5k
         NLIQ==
X-Gm-Message-State: AOJu0Yx9MLu2hKtvr76UXkxdLgclIjzX/I/cJIRZtqYk5zxjPwXaoPt7
	/rXH5hg2zHN3+7l9f3zIwg1Qwn7xE4P8koZs24GvhNQFa9kCCWHWsO4fBqzxZw==
X-Gm-Gg: AfdE7ckoag2YPP7I1m1zJaSwwUssgX4QWzNfnLXUsDmBvYb/HgJOnMT/G+IxDq1nQEX
	JFV24J1ZOU89P0tqiPpdgjh2vZj6oWPdHskNGxf2gBv8TiA0CY4FK/OGITTupC8K5B0QvcP1/PH
	j+946bnf2H0rM4DfZtNX/ufEw+kESYPwa84eeZG425vLRmYdJ6IHEnd6h0i6rf8BKebgCcigy5R
	+7/LjydBQJX2DcUzWrSO7Q4Hux9gpLaWsvrDQknNdVYtDRu3loYK/fnVfl0uCnfFE+vItSfAm0B
	QU7NsALF3vtU6jRineviYPHN+H2971HWqwPT4sxOmLy4ZGza8wtKxkBCthlKRwXZGlpEi6Ba9bv
	yy9e26HSdPE/+RDCJuRYMrEHY2HtANElUf5ONu3luDjXmQuMe9PNx4CCeftd0CIZoEQW5DNeoDT
	H0ZOxb/jh1QyDUCmp0hixDyaPCtVxzay41rPSM7aYalz5pLJF0jrb+/LYpyoBWgvgx1lRf/18F1
	Q==
X-Received: by 2002:a05:6102:8001:b0:631:26f6:7022 with SMTP id ada2fe7eead31-744e0406554mr7862304137.23.1783692949291;
        Fri, 10 Jul 2026 07:15:49 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 02/36] tuna: Suppress output when pattern matches zero results
Date: Fri, 10 Jul 2026 10:14:40 -0400
Message-ID: <20260710141523.36440-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
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

