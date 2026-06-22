Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA734BA49
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159715; cv=none; b=sK0iYlwohcwQyx8WtjPqsGzMveh7G+Uytint/QcKiLANZhCxEu0Nn4nEeLfkgK7T5Ky1v2kOoqdCdGNBQeUH5d1HJ6ru16X/iltwvq3nCqc6gn3si/msAS2hobu/tf9bewBhJcRwb/3dmDABvV9o9RJcBUatLPq+cYKQs1s92bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159715; c=relaxed/simple;
	bh=KHQiCnlKMJlcAVF7WkhjFJmdt8uYD6CUChOLzc89PCw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESr00wX9AvcjBiY5q9b3bWCl7/bELdEgWGLI9HaOgIGuwMHNrdZh3arWmhA6UAu2HyjACk8YrhVwP66ecKJ1T6D1AokCHy5gl7DIQp+PZR4TFbErFx/PYAF+20bHifHXnuhfI3gE/iNluFvglM1LacDYkfpRNkd/qy5Ao6r+3vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXb6UPFL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXb6UPFL"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9159f631656so42135485a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159713; x=1782764513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsWTJBkx3diUPRMRkO81OHx7pyIKwEbxfHAGJFdlovc=;
        b=lXb6UPFLtpuBTSlyyfkixXLkrax+BhlZRfBmIUqp4dFDZBLzA/RlACfRqBUG9V7/gE
         JjMe8AdMYCtSx7eCkVmKpEtBBQ62nrOrDLxrb8oMoh49KZhQESgXivBh/mJPNXRJ2o67
         GDEAgbOO6q6Bo2mtnn4x7VpPnBe+hBiItkqDn3ZQpS3soEiM/Mj2OhRlx30t8RZ4VIDd
         ZdfFVR7mn/Cv5Lba8WuA3gC5ISnoIbyja2TrGKCjMH0uI4BjK4k0PUFjw9kAen6LyXym
         tk4Q+x6lkVADgwMOJlApvcBD/KSeS2Vus37VxNzaHTeDnxaflphesLdYqsh0BzeVQZoB
         tyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159713; x=1782764513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsWTJBkx3diUPRMRkO81OHx7pyIKwEbxfHAGJFdlovc=;
        b=MdNy9mh+0aAeh6clQFcHtfbK0UcyYWrlerU7RqED8tCNx4rpw9rdNEATv3XT1jEPQS
         oF/1S1vIW8gzTicSxwdMRNbu+NNlPuFwMnimcUgefcryZKXV2KwoZDunIwc9u8KZIVgB
         s9aRFRG52WNYVjUXMWOIVJT2f0rHx2jMkBtTeuuAK6DJWZ8CCL8HkSeFWPVY45KUTEp5
         GuIW/YY2bhyHUfljEDvAF1DXRmWhrTy+UYevnUHXmfx7gbDJFCEG6bRsMKwUHywo0TR2
         rPSX9zQU7433Hx8jcaQaHY3bUL53kGNYEpEaiy98SRe/hZch3JQceno7HTKDMV148Dpf
         5U/A==
X-Gm-Message-State: AOJu0YyCDX0HKwFiJohcTft/+yEzR+NjLLb/Bo927CXWiEnPNUIuJMGH
	WXz+LWVYs6r1E8FwDT2K4E/ZWWBm+ctEgaj6pfJYukRyk3yddpkPbHEiGt+qKA==
X-Gm-Gg: AfdE7cmG0jQy8KKJHdtzXWmHZ3l2h7PW/l7iWwjxApmbBM/Yrny4exV+RGRGn61uM5y
	czubkTQvvpc/rbXNnwNry8u7amYW0q+dP+l1grP3rbzmc184XmODNHoWWICgwhnZWhc0NN2Jwxc
	6CppOo0CWlwY9zqyrCtmLese2AvYLmLFO5qkPBZV+LErO56dpJVCHaMGwailnCvcKFHsk0rTRdz
	6yuSUjyeHkXi3H6zbK+rZt9z4l4Ic7xu8rTHXL6MR7QMRhb5fC6jjKZSnKtiuiW2lt3/5Pjreg7
	KTt3igPlSaFjGmiaA7mZ0MsPeLogNHDbI0uL4dUCWOx+oGFt4wvuzuMjtMoMToT/zcsmXGZAm0h
	ySXUV09A6FPFfm6kjHBygVhZIr/Ky9mt4GnZ44iQYtgHDV09T30KTM58/N4HLcPAllXo47GS0zq
	OgcPI8m5MxHTJ+3qnpfzm5C89IuqOHSXOA5bA//j5oMN6CCdxfJ5rcHwuS1LRgfqcaMLya+RRe6
	Sha5HzXjS7M01+5HU35
X-Received: by 2002:a05:620a:4107:b0:915:6ce1:3576 with SMTP id af79cd13be357-92601f1bdbfmr170665585a.20.1782159712813;
        Mon, 22 Jun 2026 13:21:52 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm70661285a.45.2026.06.22.13.21.52
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:21:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 6/6] tuna: Add centralized input validation for CPU numbers and RT priorities
Date: Mon, 22 Jun 2026 16:21:31 -0400
Message-ID: <20260622202131.182067-7-jkacur@redhat.com>
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

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
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

