Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33F34C98C
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159711; cv=none; b=eCglB20ZFQKFCx+uAhKNRsiO8D7MpCDXzgOCOpMtHjru1qjhmaVtEVMLtWfq6JE++S54f2cUmI7izevjVdyeM2To9Z0gHFlV9AMFfEPJsmyZz+tN3gp5T69UAfFW6uLJTxM8/atcw1eukQB6+6PESS8yLuLnWRhKU8Z/yShAF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159711; c=relaxed/simple;
	bh=Fs/6YEfxMkaZHII/Q64dubynvhkGmnQ1pvTK0oZPPoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo66yNYwkYGi7F+nl+QCPmnoEjW2oH8s4UULnwQoKujwFC05KQdQPWVAP5LJHDp9EYgPccUABitc3Th5i0+CJcvKT9ULRJYqRX3hYlR0+GHnwM86NQjNpDFjV3E+x2iNohvBBi2b4bNuo6HQ129bSNtaJycQgG9hMqzvx18dKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9/3S8AX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9/3S8AX"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91563abd6a9so250036985a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159709; x=1782764509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWL5Lnorrz0tXUooAaSdF36VKBT9Zx3xu9tcm+vHVbQ=;
        b=c9/3S8AXE8bg28HtjA803bvpGBxKSgwQDucEPHwLMmNN/iJHHR50+ud+vpyHOYA6YL
         I+CYhIzF37gF0jKPf7L/KUs5qtFIjFbvUcFv42/TfPT0ppZfV3JfVdEfPEDIiEf2AyOl
         v89GueLhuMoX1Zgk6nUu+ZVQnCtRUAoj+HN5sgX84RB9YM+F7/AeW41ZFWU72KsaX8o6
         OYFHTNTjd84MNQlangbx1eg9KChFO1yefTQD4YXSuF4bdaToQzzN7V1xCnSv0KVGCjDx
         yrRLIDEknxldbBTgL9E45E2qhgJpEqnQ+KcD2jAlxfnV0A10z9VNtt9I0Z70GRjbMBRD
         U6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159709; x=1782764509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWL5Lnorrz0tXUooAaSdF36VKBT9Zx3xu9tcm+vHVbQ=;
        b=byLfQ2zSEWFfStV4a0jITeq1ou+aGgzk3X1vvSdMITKo0Teg01wQ81oZC3TTcXhjE/
         3MIkAk1ciY7NkV2Zan7YJ6aGSzxdw8LdZuxmjz3cl9oatjAqeAEIuzVltWA5tSMiVbhp
         I30GC/tDOEJLGWqrQc0dPa3aAn0kJpNbJ4sPzlWmArBrKAhtZlsCZVgtITPRoGK7zOSm
         CixqJPUseVc7mNCvvGbi6IBodRWwCifJ+2WxXIAUUQyO9lXVf0GLwZKeesCCaoPoSIA+
         nuErj7s0a9OVUR5G57V41HTXf/D+GZO6+UUkLEmUasG2Mq+yvzrexkAHxEXXrtZanV9d
         r85A==
X-Gm-Message-State: AOJu0YzIEibD+ijIxRRTr7MvBVSFt4wmuZ/7sz1bvWuzEG4hL14Asz40
	tZOd3+Tx0T70OBWTV2QDOPFVRz9ABxCTcWRgke3RIvlvDBt3Fj2XtMXzJmIkRw==
X-Gm-Gg: AfdE7cmRr5khZESSYhabrRYUhvYmS2Ya4wg0huKPW/v5PtBjjMUfC2WXbxDo070PBgk
	8ziwvhn8Hjt0WIb9fhXbb3aPovmRouuhAvotkK1Zjm3rsOMpqPti+vAKsmniv7b23tAHeA8iPWT
	HAA9UK74BvTXC2NdvkAJ9EGjSExOyAJWl3ZOCBKExXAeM46y9Wn36vXQ+tqCrcnOuuSzmRHhnhN
	SMonEpHFMl+D/4NNXfGbHhdXjnPe8CXOJfeMmz6sToE9zm1tQkPK+W7N8kiKompVHjVkc11aLIe
	DXwCOPSrnwFMAE/sJoR0Mq3zRX2i3vzx7l4vJi8PwvjhmuCUDI+uFuV1uVG58Wz7oAJGPdOyax9
	0EyygYyiKiuzmjypkAFwXTQO4evTeN7nXIiWBYXdkwJRWBBaTSSQ2HL3pYwY9FWequGJVAXHRkK
	C7uKbi+TahTk0lO99sVogYD/8DFse4DjHIqMHP/fI4qQkndWutb3r4VdliL0cgCyaHo9G6GLOLI
	qlW5ZUoAg==
X-Received: by 2002:a05:620a:4394:b0:8f1:5e8f:fff3 with SMTP id af79cd13be357-9208cdf3261mr2402205085a.26.1782159709187;
        Mon, 22 Jun 2026 13:21:49 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm70661285a.45.2026.06.22.13.21.48
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:21:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 3/6] tuna: Make warnings opt-in with -w/--warn flag
Date: Mon, 22 Jun 2026 16:21:28 -0400
Message-ID: <20260622202131.182067-4-jkacur@redhat.com>
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

