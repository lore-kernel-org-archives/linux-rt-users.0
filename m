Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352F29DB86
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692957; cv=none; b=aPKyC13iFz4zn60OlKnOvZZj5M9xbXH104YsmRATf6Zf2feVF/d7XyO2X0EU2GsO/pd6a7Tb/XtN6k67c0gxKA964UcubB7Xpmgimfk74F1dRSG6Pa5M6SgaOR2IjxZwBDPgvther9ypnoCI4KqNU4uHw5T/lZy/loUD2O+FbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692957; c=relaxed/simple;
	bh=pWmnXSR+tUhB3yRKasLz665YPlLgfwg4Q6gAg0r2+UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWB97X8gzdM8cSILRbIiRkOoM/KIoQ9O5PLBZKjTBbGuVj3RUDs7mYZ1P5EdQbLcp5WDxiuEc1qdGrPntAFOOg1JnBayCdIqtWR9yePMeGgaspeYU2BYZG6gnPt7Q+xtXlG96duHXfqNLcq29SjVMWZuv2070ih3DxAiqTkQ3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWnIO17L; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWnIO17L"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-73720e58dafso502185137.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692955; x=1784297755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fpOovkyEFp5uRW1wIvI7tY/yM6Db8DvdgV3uWMvdaRc=;
        b=EWnIO17LwsPDVIt24+y63Crscp8U/a6FcQY2eIhcPE+1hOPfU6OCk7Vb1IDyWHpOs8
         lOyNDw6tF5nM71c6Z7tdBc7KchqIaA/fiepJ67cF+8mIeQJv5eTgAKoob6/oUo0Pgt8Y
         TISJSTIBAfjht4fmTPic0cz4TCg0FC1szE0ezqwOI9CNW3QblIeBHfjsBPjvD4JFtqc8
         t50VuQv0JaOsm0NP7gSbFZiHsJ5b8IDffuwLfL3a1BaRPY3qjiYMQBK/hQUW/nItFlrw
         ek/zLuSDybqW14k0DMAEdWelnikpe+RJ79CPCsAFVmfy8yAGaJw/LrcbhR9gXU8UnhQJ
         hn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692955; x=1784297755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpOovkyEFp5uRW1wIvI7tY/yM6Db8DvdgV3uWMvdaRc=;
        b=WbYKpxrhNwRGGKDfgaUwBGSZegqzrEfNZGwzw+P10q4RZTHWb4nNfl/51WIlxbJShg
         qv2EpFS9gC6I9JqbdSYNZ5dpQmdg4EYafGVsQYObniUkXC4J2JZgx2iCJkBJO8aJSLuV
         xJpq8Lsebx+jtn3RzZ/BnWmZAEEW7RSbaexvmDyGbPfAymUoq1pPKitriCgPDa0cq/iX
         4I4iCfnAGb0eLyseKbsC8Ofl0cc5C53oDWNG3pu3nWC1Sx8syuLZD9M4+4nLhPYKsfov
         S+N0GJfHs+tbjQR8PIfkAVgMYOUgy17WEJLlLkh+wI5i3cQXNxDbmCidMVkyJpFlwiWL
         ekBA==
X-Gm-Message-State: AOJu0Yzqzb/F1kvHdWfu5gb6lW/kIk8onUEnXQDLtjMykniZdGamLTeV
	A3iLR0IKol2eVjSwRJJ4oNWnOjObLs4E7ct4+1a6MX4jXsEHlyyesgXyo5uPnQ==
X-Gm-Gg: AfdE7ck8XfzC7jYHtwNzCbcQ8sw8OITbjkShwujdd7Ope+bQd7KoYSWNRd4lcnCPaaA
	Nw5s8oNkhGFlolnzMKfj/xMh6fDh1QH9xvHt9liD4rnhBqyYm2V8YUC0vZtcXQEov0naizAbTjI
	09szfn8NCQnzFkgbvJt3StPbsNTmWokTvl561RGJM04jwWO5GFUXuWSIazyXq8w/H7NDbGZO626
	KZLoKqra0cGcQ0YnepJQF+EuaZTdYjBwVAwtQhLXSk/IF0hhGEWFVVyt57+sf9JpXzKTLtRt/i3
	Oauuf06+Le0vMEn2mH0Ehos/DUFoEi0HQuWiYuozHeOXSrph09E524ds6qObR34JzMqI77E9kpA
	3WteYqugrnhudl7eUJgMgWjXPSfKRI5fcpCMwA+CSqEQIJa3Vp0Ru5yaJxHNHaN7Z9+VlhvcLoZ
	EGvQYnNAwbVSF9iKYxV4eKRZUc0k1lwQW6KE2xQcwPkBCz1KnLD2dTiS1n268cfdsvVH8a09/l7
	w==
X-Received: by 2002:a05:6102:504b:b0:73e:751a:167b with SMTP id ada2fe7eead31-744e046d06bmr8076932137.29.1783692955341;
        Fri, 10 Jul 2026 07:15:55 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 06/36] tuna: Add centralized input validation for CPU numbers and RT priorities
Date: Fri, 10 Jul 2026 10:14:44 -0400
Message-ID: <20260710141523.36440-7-jkacur@redhat.com>
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

Add a validation block in main() that validates converted arguments before
command dispatch. This provides early detection of invalid inputs with
clear, user-friendly error messages.

CPU number validation:
- Validates that all CPU numbers in cpu_list are within valid range
  (0 to nr_cpus-1)
- Applies to commands: move, spread, isolate, include, run, save,
  show_threads, show_irqs, gui, cpu_power
- Error message shows invalid CPUs and system's valid range

RT priority validation:
- Validates that RT priorities are within valid range (1-99)
- Applies to commands: priority, run
- Validates both POLICY:RTPRIO format and priority-only format
- Only validates when a policy is specified or priority is non-zero

Old behavior with invalid inputs:
- Invalid CPU: Either silent failure (show_threads) or confusing
  tracebacks (move, isolate)
- Invalid RT priority: Generic "Invalid argument" errno message

New behavior:
- Clear error message (e.g., "tuna: Invalid CPU numbers: [999].
  System has 16 CPUs (0-15)")
- Fails fast before attempting operations
- No verbose usage output, just the concise error

Benefits:
- Better user experience with clear error messages
- Centralized validation logic (easier to maintain)
- Prevents confusing error messages from system calls

This completes task #6 from the argparse enhancements tracking document.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index f1605896c33c..b9a071414125 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -852,6 +852,32 @@ def main():
             if 'irq_list' in vars(args) and isinstance(args.irq_list, list) and not args.irq_list:
                 print("[WARNING] IRQ pattern matched 0 IRQs", file=sys.stderr)
 
+    # Validate converted arguments
+    if args.command in ['move', 'm', 'spread', 'x', 'isolate', 'i', 'include', 'I', 'run', 'r', 'save', 's', 'show_threads', 'show_irqs', 'gui', 'g', 'cpu_power']:
+        if 'cpu_list' in vars(args) and args.cpu_list:
+            nr_cpus = utils.get_nr_cpus()
+            invalid_cpus = [c for c in args.cpu_list if c >= nr_cpus]
+            if invalid_cpus:
+                print(f"[ERROR] Invalid CPU numbers: {invalid_cpus}. System has {nr_cpus} CPUs (0-{nr_cpus-1})", file=sys.stderr)
+                sys.exit(2)
+
+    if args.command in ['priority', 'p', 'run', 'r']:
+        if 'priority' in vars(args) and args.priority:
+            policy, rtprio = args.priority
+            # Only validate rtprio if a policy was specified or if rtprio is non-zero
+            if policy is not None or rtprio != 0:
+                # RT policies (FIFO, RR) require priority 1-99
+                # SCHED_FIFO = 1, SCHED_RR = 2 in Linux
+                if policy in (1, 2) and rtprio is not None:
+                    if rtprio < 1 or rtprio > 99:
+                        print(f"[ERROR] Invalid RT priority: {rtprio}. RT priorities must be 1-99", file=sys.stderr)
+                        sys.exit(2)
+                # If only priority specified (no policy), assume RT and validate
+                elif policy is None and rtprio != 0:
+                    if rtprio < 1 or rtprio > 99:
+                        print(f"[ERROR] Invalid RT priority: {rtprio}. RT priorities must be 1-99", file=sys.stderr)
+                        sys.exit(2)
+
     # if args.command in ['apply', 'a']:
     #     apply_config(args.profilename)
 
-- 
2.54.0

