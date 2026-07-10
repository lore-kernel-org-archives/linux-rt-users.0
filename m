Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783CF202F70
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692950; cv=none; b=alDSFvVNo/rPfvaPD8VuurDUlQKxJgssTWWJ3EZiue0k+6ISurrgdXBl68TVEWGDg0x+IXieYOL12JpYOobO+l24du95/uSHIPlemQL7OrGGKd51BEt6WfqaV9umB7ew3miMwjSMzoxwRBthY485EwoZopvO5aVhThQ245sSd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692950; c=relaxed/simple;
	bh=4BUscVkerUi1cg9gA9pTiOeVvpzgAnsxLZrR0CykbRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6PXOAdg0nFGHTyb+wZPxRAMLZepUpeJ6mQMBEohbUVGbX4QXxYZ1MezaCY9vdPhEVh7yhVY0rq/s6dsirP32QN/1nSvOwbnAuRKfVxK2tXUZtKwiA0+92+CnH5s+S0j+dL410Dxo5j1yWMfsuBvVwd44JTzIjzMJy0Vl2qbMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCqqcUPl; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCqqcUPl"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bdd0779366so256561e0c.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692948; x=1784297748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxE+2xGNPEmUKUE+0JB+fczwCkOYKL6yjjxp5SaW2g0=;
        b=UCqqcUPl/xf5PEHupXzwgy5BPlA49S8ecflxG2dYdk3Xyp32qgIedM0Vi15l7jOTxY
         GFAhijUkcHvxzz3gv28Ksn1Xo1KE867GtfRvkkMT7ma9NWdHaeW9xxUaCHzDDxJJ1Egv
         Y1xCZocdn1mAVwa5zMsfaaw9BFOza1JkpX5uDjnQ8YqJ3CjhvPszTGyyEfi6Kz6daRjC
         AeZHeuw9ikfX9WGXp7um4toxsWVmy3Afa2l3mxguiY2OujRJsU12M1aoXhghMpssQoqO
         xX9rPl3KxKOLKD4C7JO5dMOPMyKlM/o8fPqXbh/AFnsxaGI9dVyF673iwhTY482Yhe8X
         d0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692948; x=1784297748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxE+2xGNPEmUKUE+0JB+fczwCkOYKL6yjjxp5SaW2g0=;
        b=mV7o6mhwUXEdP/h26DINROatVzfSHFshS3pSyNMs2LE9oYjEO+I3UNHaWMfXNocerE
         mhn5PnKbJQiRfgFAglxu05LC92oVBucqvd8Fy3HvyIBer2KLN4wRdo8V/YPQDV0UWgES
         y26gOWpw11DxU/iw+6fNOWulspgmadXNnUgmW5VVXlHg1o79Wgru/Hw3FTYMtN7+Mmfq
         ihXMHzja2RQANSxcqljjgMdj8PExm+wNbPm/aVOg6F/FJ3lH5sLkgEM10caL21ZjWlPK
         qpuA5BxN6No3P2wO6TlYGEOUBZ+vsoCo6LohxTE8o3MpKuX4Z7I35nxMc0qSdb7nvqJB
         nAFw==
X-Gm-Message-State: AOJu0YywsQENOdXKFLQiuFWBnWxVPIQr8Ffcaq+OC1PpPq4pf9IeFvMr
	gVBeVm+rFFCuCuj3BpejbVkr4+HEczWnob/1giiHvr4tgD5VIdtaLi9zn+Lq1A==
X-Gm-Gg: AfdE7clKiOD2OcHNCOQUaMccoC7k+I+TPcuBPukG/k1ZiDsyS5SQkRSNa2eYRxGuATd
	b1zwpcad13gyeNxx672gwWThmdCne0ttNwHfAWoryXkGEj+m0mwYpRN7L1Plr89uSZF2CKAt2G1
	fk8OlBUwWyYw+peEJ0aRMBuZhbTCOeRxN+iFbNRr7pFX2EGf5tKCIAUJ0gcuCVkwHcR62fGRBuM
	1U2xUnM8CchtR9HwFfOkXoEfn9mZZj0SZhlibcGNpDXHGwhGI9G+u/GCeDXFUpFNEh/PREe8Nbq
	gOtat/Wv+Woxb3PKfFxKjuuAoV1AUkJy8ptikwRuILrna3We6gzm6eCmhzBe6nUaJWAsx+nW8qC
	BB5jcRQcCGnMxB3lzTkaxAf3FBpRtUP9O/VOFHBi8VYGgdfztDX0PWwS8g4FBhO0uAF/V31M4qh
	W3l5tOShTMeqzJTm2MrzNWPaqpfTTHiXdw28AZEDoDQQRT3CxffhPl25BM6m7hHs7kOVoEOzXRB
	A==
X-Received: by 2002:a05:6102:4190:b0:739:8c52:f2b with SMTP id ada2fe7eead31-744e0312fa6mr6759185137.18.1783692948218;
        Fri, 10 Jul 2026 07:15:48 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:47 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 01/36] tuna: Warn when user-specified patterns match zero threads or IRQs
Date: Fri, 10 Jul 2026 10:14:39 -0400
Message-ID: <20260710141523.36440-2-jkacur@redhat.com>
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

When a user specifies a thread or IRQ pattern that matches nothing,
tuna previously showed only empty output with column headers. This left
users uncertain whether their pattern syntax was incorrect, the pattern
was valid but matched nothing, or something failed silently.

Add feedback when patterns match zero results by printing a warning to
stderr. This helps users debug their patterns and understand that tuna
processed the pattern but found no matches.

The warning appears for relevant commands (show_threads, show_irqs,
move, spread, priority, what_is) only when the user explicitly specified
a pattern (match_requested == True) and the resulting list is empty.

Example:
  $ tuna show_threads -t 'foo*'
  tuna: warning: thread pattern matched 0 threads

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 293044920223..015bb7a54663 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -712,6 +712,15 @@ def main():
     if 'nohz_full' in vars(args) and args.nohz_full:
         args.cpu_list = nohz_full_to_cpu()
 
+    # Warn if user-specified patterns matched nothing
+    if match_requested:
+        if args.command in ['show_threads', 'move', 'm', 'spread', 'x', 'priority', 'p', 'what_is', 'W']:
+            if 'thread_list' in vars(args) and isinstance(args.thread_list, list) and not args.thread_list:
+                print("tuna: warning: thread pattern matched 0 threads", file=sys.stderr)
+        if args.command in ['show_irqs', 'move', 'm', 'spread', 'x']:
+            if 'irq_list' in vars(args) and isinstance(args.irq_list, list) and not args.irq_list:
+                print("tuna: warning: IRQ pattern matched 0 IRQs", file=sys.stderr)
+
     # if args.command in ['apply', 'a']:
     #     apply_config(args.profilename)
 
-- 
2.54.0

