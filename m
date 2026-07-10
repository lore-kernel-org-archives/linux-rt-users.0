Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F423D281
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692954; cv=none; b=TIbMcgH4nQBoSP/OIMN5Ki98ZrP1+gMMdB0Vsmbm+TlE0SyTrf5EB9bS6VQti2BfOlrh0oYqXecFhXPdZI6GFK6662tNYRQBk3AvG5P1d0Fwup89uBIbA94nhfMcF1Z5OJ1PbkvrEwTqDLsm/xSnLurTxKCW2gZNuZW5iXFG+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692954; c=relaxed/simple;
	bh=Fs/6YEfxMkaZHII/Q64dubynvhkGmnQ1pvTK0oZPPoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mygWJMV7Q8/eG8D6wd+BaOgQLgXEUrb5p39fvFrWnMvQSNj9Jn0DYFkv0M9HUxZWHqDsGZpPSO4rlSgYQhOOU0oVqwS7zmOBuHB10hSZUYdZuhezld8VUoX4w9eoWWiVK2TsEauawEKD85pNhGAnA510WXdj0bJ1T+618bcijGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/7T9d5x; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/7T9d5x"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-73770fd1b65so301347137.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692951; x=1784297751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWL5Lnorrz0tXUooAaSdF36VKBT9Zx3xu9tcm+vHVbQ=;
        b=j/7T9d5xxT63GV82jaGujfSFltKyVtL8Ld03JE8cL49zhA1bmgvY7Y60WbE09Fy/fv
         mh2b5tEB6e9R3DOYnd6z9vTulm4A+bULmNp62BUsiZK6UDR3oHESzxc9tiDwug1TjOc2
         QfZyXVDq1vHZbZsXKjZbP6gLNtci5aEB/9trkPxjdq6DbBFd9+yIGyGv8uT6W+KdMx5S
         uIv+iiwS/pWVGc4UDOPVhT2Lby7AyX0yPiyYRP8dJyfRQGKlxuYKG8vbYOYyrhxfIaiD
         6e18kumIft6Fl2RVg1qWBxCJUGHbEt6cHpslkuhbJHgwH3zEX5AUFbbvnZzdBNIjcmCh
         i/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692951; x=1784297751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qWL5Lnorrz0tXUooAaSdF36VKBT9Zx3xu9tcm+vHVbQ=;
        b=VSu9JKU7jb+itLM7CcC9YYdwDDeHvKRzev7t4u+GEfuNdyJeWRYzgRbosXD9+qt24e
         INu1aG44phZbhQ2H/FMEjdo00d6KC87/QMcGJAEJkDBQ3ANrVFBiCURg/IzZmJgn2llu
         AOC8yccdq5sTMavPWYBvpvdQs4nVqXfrLFavEro/KYWOK/LDUbyjspv1p4JovoUkq01t
         47oWQRLI4nbaaadbJti44nl3h4Af1RAJ7DXnv7DtthrD9RKC+uMHC9jdP/OleAwyKRZv
         R9zF/yiyX2qEHzYIRx35BVwL3+/1R2eGmELHhh9zQ/vmzTMHUNkkwkIj01XRm3/KYjlh
         dqMQ==
X-Gm-Message-State: AOJu0YxE7UfKORRcMvsWdsv/CMFW2ANQcAV51ZSGnCK2HfT46O7DJ4rh
	DTIvQ6KO1DeuhA5Q/B2O3OeerBjc2W9BmccdKFHe/hA0RJ1Ijb4So/V28JKOGw==
X-Gm-Gg: AfdE7ckVAbe0KJWed2EmPRhENZSNgcB0msccPoPrOdw7UPN57Eg8SSmc5JeXQUpvUZ/
	DC3dKNF9TUetxYwoWDPz1vbgEXZ3YU07BOd/myBzD4oAwuhF+0njJTFhIT3O959YKDEEGcdavjs
	rrgfWFwpB6UCm/lPH6I30tXkN4UKEeKwstR1BrSXQau4DrdROjkaz47uWfxaH0OKXG9pwocE+Vr
	LnrLL8MoFVGskUX/b+EMGQqTPIxNS+ow88X3ShDPw5A16D0vh1NwSqcWZLzWp+aNfJsjHp2V1/g
	wV1E5V18jyJfmPM7O52GDQEJzrvabkM4RrZA+8zxDiSzPRJFTpqxFOarZFHmO5w9juOWnUbg8S8
	9bcRFdDnjSBEWXEEdicVeqtt35GdF5/0KWmkCZl8rD5prq8VP3otp2gtvuheBAhZBw65XWAEdMr
	2gwo27bbT+43LHI5YPKQxQuvYvg7LWrQder3MPq75F0Gni8y40pyip22qoxzYfbocd0F7PcTNaU
	xaHSS6b0Sgy
X-Received: by 2002:a05:6102:390f:b0:737:783d:1916 with SMTP id ada2fe7eead31-744dff914d0mr7588215137.11.1783692950957;
        Fri, 10 Jul 2026 07:15:50 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:49 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 03/36] tuna: Make warnings opt-in with -w/--warn flag
Date: Fri, 10 Jul 2026 10:14:41 -0400
Message-ID: <20260710141523.36440-4-jkacur@redhat.com>
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

Change warnings from automatic to opt-in behavior. Users must now
specify -w or --warn to see warning messages when patterns match
nothing. This keeps output clean for shell scripts and command chaining.

Also adopt rteval-style [WARNING] prefix format instead of
"tuna: warning:" for consistency with other realtime tools.

Examples:
  $ tuna show_threads -t 'foo*'
  (silent - no output)

  $ tuna -w show_threads -t 'foo*'
  [WARNING] thread pattern matched 0 threads

This allows shell chaining without warning noise while still
providing feedback when users want it.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d9d1eaa83757..c4bd55fac3df 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -97,6 +97,7 @@ def gen_parser():
             "logging": dict(dest='loglevel', metavar='LOG-LEVEL', type=get_loglevel, help="Log application details to file for given LOG-LEVEL"),
             "debug" : dict(action='store_true', dest='debug', help='Print DEBUG level logging details to console'),
             "version": dict(action='version', version='0.20', help="show version"),
+            "warn": dict(action='store_true', dest='warn', help='Warn when thread/IRQ patterns match nothing'),
             "threads": dict(dest='thread_list', default='', metavar='THREAD-LIST', type=str, help="THREAD-LIST affected by commands"),
             "irqs": dict(dest='irq_list', default='', metavar='IRQ-LIST', type=str, help="IRQ-LIST affect by commands"),
             "cpus": dict(dest='cpu_list', default=[], metavar='CPU-LIST', type=tuna.cpustring_to_list, help='CPU-LIST affected by commands'),
@@ -124,6 +125,7 @@ def gen_parser():
     parser.add_argument('-v', '--version', **MODS['version'])
     parser.add_argument('-L', '--logging', **MODS['logging'])
     parser.add_argument('-D', '--debug', **MODS['debug'])
+    parser.add_argument('-w', '--warn', **MODS['warn'])
 
     subparser = parser.add_subparsers(dest='command')
 
@@ -712,14 +714,14 @@ def main():
     if 'nohz_full' in vars(args) and args.nohz_full:
         args.cpu_list = nohz_full_to_cpu()
 
-    # Warn if user-specified patterns matched nothing
-    if match_requested:
+    # Warn if user-specified patterns matched nothing (only if --warn)
+    if match_requested and args.warn:
         if args.command in ['show_threads', 'move', 'm', 'spread', 'x', 'priority', 'p', 'what_is', 'W']:
             if 'thread_list' in vars(args) and isinstance(args.thread_list, list) and not args.thread_list:
-                print("tuna: warning: thread pattern matched 0 threads", file=sys.stderr)
+                print("[WARNING] thread pattern matched 0 threads", file=sys.stderr)
         if args.command in ['show_irqs', 'move', 'm', 'spread', 'x']:
             if 'irq_list' in vars(args) and isinstance(args.irq_list, list) and not args.irq_list:
-                print("tuna: warning: IRQ pattern matched 0 IRQs", file=sys.stderr)
+                print("[WARNING] IRQ pattern matched 0 IRQs", file=sys.stderr)
 
     # if args.command in ['apply', 'a']:
     #     apply_config(args.profilename)
-- 
2.54.0

