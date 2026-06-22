Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978502836A0
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159709; cv=none; b=umB45oMW8j8HqrP0Osgn04IOh7quhiuvzE8KI0hNCfREbFp55J9eVY8+ZidhTTtvUtUqp5Bpv6za2eO4eZGCru6q4zMFdlh1yLzp19g8eo1XRwZ7KrmhznbrLUGoXJz7VwKDpRbS1nkvM2hfHwASGf2e+EdvQLCbZTHQ4COAUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159709; c=relaxed/simple;
	bh=4BUscVkerUi1cg9gA9pTiOeVvpzgAnsxLZrR0CykbRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXQaSKtQpO1FmtxJMYVArKW1qRoxfoyhVcwNxdnnAdJDNLVPE0NwR8MIfsWt+UU+R7Z2BYTJGU5GTPJe9upLEhJf+I5+yhK0T5EGQmnqAEOE3flZKPSpT17R0kN+QdqAx5QhQDZjjebnAi20tBNrDK3BjoF9ySTRU65OFFppYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5Xn7ext; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5Xn7ext"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9156b74006aso324856585a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159708; x=1782764508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxE+2xGNPEmUKUE+0JB+fczwCkOYKL6yjjxp5SaW2g0=;
        b=T5Xn7extSpm4sL0T4UrNj3i75n161OcV0xJ1w4AFuzI3Yy8QtMHiuUzKKGiR0AknAk
         mCleRGza+e4FFKmNUAznvC1Na0nyOmoDU4dqPdR0TkCFORPdrAstJsaS1Zw6oTiwt5JU
         vHsMZ8gNLf+xJludnffD/ZufUggLKGaou50aGuOAk2Xl/UB9Tpuz285mEsKmLJGA/sFT
         sUk2BC3qM6khNJt6oxjieLdV0tkSb3jdm81kTdZvzziJrsCr37TKm8cMs6PW0zj7nxJl
         HvHTFiK2gaOTG1QDA+vjfItT876+kQPivVgHzF0/6v4mPu5UsaNv0k0yVu1ihkjvfP0s
         eDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159708; x=1782764508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxE+2xGNPEmUKUE+0JB+fczwCkOYKL6yjjxp5SaW2g0=;
        b=FJVGdkYh1D2piqmEscoE/wfLpplv5VT6dtv2IlytxDmfJLQYhagL0HJSz8cb2gYcva
         x99dyHrFp//a/HImiEzY2QJhLqtRm+qPsEF4RqnEKpxZTQQBiHoNpo8UuU6Sma3Jb/OG
         /0oxu/qppEXblK5vJv/E3Y8/brsJv+G43BnXxGqv/l8A2WS/ZzjrKzzqd9VsAcIDGE8L
         M7c/a5wuHwq4tr7gf2jBl/QYkpKQ3zupW1HxlLtRKJ49jebQnwdZ4nTrcuVI0YSgVG/x
         YAiZr02pIOfKANVbUrO8dIUrRQmm0tclRouwR64Kndku01Eh1hjVzX+zXOyzI+radUIj
         cmCg==
X-Gm-Message-State: AOJu0YxZIom7f/vAcmOYCdgm6j7tCcAeiQNjPiSPJU/ZanqDJSf2FtC3
	8b/mZOpF8RuWSzBU+k1iPquI1QcxqYvF+wzi6JDhk5c5XjMk35MaHLhS8l1VQQ==
X-Gm-Gg: AfdE7cmzzBPqZGZMtWaiVKOux9ecj31ZPMFwg5D0emQUZEW0RLQgDH0OBUZMG9k3yye
	rNBEKNqQiwZ729isYVsCfx0ANszUHcZpN2uUmYEyzFEvHgKvv7wjHBCxj1OIJVKo6UYaBCibD2e
	Ercft+wapFWh8frkIZ9SjHBygPjteXxIz3D+kAyKrzdUptvnb6+aWnWDiJpY0rJ0HeO0LLBZEPS
	w/fQyAmDlp/RNkHzu28EDkyNGT+a06hbh0bp46GenirhKcimaBQzDnpQ9niAmLXOqMu0MOXels6
	f5HI3UcjL7mBUzQI0YuUzRipkf/45fryvjUA7mXcxA3IdDy5RKZh/bRnvTHWU8RTWGX1nljziH2
	3oAvZHv6BH2RHEcJ+NtmpjGEQX/eNrUfVRV2+4YTaTJveD0fD+Mx5/UIaYKQ1QbwIH8exjs7GTB
	a+itDGedbreLh3hSkeiRTn1FN7UWTSL4NZJ1ajwMViebH71fZXgW8YHnUZNyPwNDU/JN+dBPGyI
	txSSi7QgQ==
X-Received: by 2002:a05:620a:1a29:b0:915:8f08:5fa7 with SMTP id af79cd13be357-9208dbcec8cmr2566635785a.52.1782159707468;
        Mon, 22 Jun 2026 13:21:47 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm70661285a.45.2026.06.22.13.21.46
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:21:46 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 1/6] tuna: Warn when user-specified patterns match zero threads or IRQs
Date: Mon, 22 Jun 2026 16:21:26 -0400
Message-ID: <20260622202131.182067-2-jkacur@redhat.com>
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

