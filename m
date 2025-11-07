Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A933EB11
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541899; cv=none; b=ZdwB47u1HZTck07s2S5fesmHtGNpzS6bawcVBMiVTlP9m0rkANqE/jsqIuqI3G19bJDyhJELKdyMOQCoHWmvvvDHEPxJkKR5bkp61YR1Pjx/euqa3dTNIpkBsDfcFiZVxfqVpOFo2uGc8V/38CQXRypcCNC02+CM4skLfV6lxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541899; c=relaxed/simple;
	bh=XgNortcX6ZlpOTSvX99x86B9H0o438mX79tlVrUEXRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnzmsMF/d1C2fU/LjV5UQroYP9frNsySO0SGRj0jzRNrw2LOKru40NmjioigpPnezeydV5uG0lTZMQvu3qWbxXWRoghS03VpUw5tHTjg5m8cmUx36yhMyta0MPC0n1zyjwLjNDJwq7sSNeLdnLoqBk3CJUvDkaiPK1GZbMijXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdYxV46p; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdYxV46p"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-891667bcd82so112459685a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541896; x=1763146696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T0o7ELchYWS6s6Gw22hCBfaWmHls1SpXOJReWeMZ9o=;
        b=QdYxV46pzDth8N0IJQCUorjNXMX9eI5il88cB1QwwpUlUvP3cl8aHyxFRJ8pMjT/MN
         iltm9/JQsHawmEY5KjpXOmL0e7WZpSkZ1Syl1SlNS/Kg0QefeU02RDibktYGFliv/07E
         eaCJmILes6Xi+QGFkzvFZKbYCtSOAFgRrbRGEJTtQDfbZ1OyBEA+iUHVK7lNiJgE9l0+
         fJU86VeHjTf6UL7k35YSb/zh0QZ0WXqFqJhpYHGMZLlCfd+6HsOgMs1usQ6WSGMpolaF
         CMq7iWd9ikwrA0i6dLtUWqyWEOPQVwhx+HysrJChFflBefBhSgRp1QddtobNizSP28vx
         w3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541896; x=1763146696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8T0o7ELchYWS6s6Gw22hCBfaWmHls1SpXOJReWeMZ9o=;
        b=qS+OmHi+MifJP6n/UT4HKJB7LsBb88v+MommAYuhcfaX0Pn0m+jtkE/hzj4f+fbz7l
         7BzxO8gBDkciZ+JUwQ7fkvd/6hsZmCA/7ESrMNjSfNRpTfiea7bEcYnwVFICcTP8YtBV
         ivPacD8QoUEeTgFmwNJpBHZbEBh47aebd8GTbf/X/N/Ln4pF8s7jp1JRVTW/3/4V4QER
         wzXGYzy4vLTgqAnRQffuhEz6CD2LIRUaYbRQJaBy3VRe3qgFv2V3DRCB3trEqCeCnHAD
         tzeJ7Eo6MaVCr0AUTMpMyODK5bubvZ5vJZkwH+5uA3yY4ZdLuuQUvVMOHlgp++r0V7kw
         djFQ==
X-Gm-Message-State: AOJu0YyG/KiiHErUqkL99tZLm66YgZLF9oAKA9/3jToKuk/6FlUG9aHO
	R98Weo+Xi9zmscbUE1lTXgROSwoiVXksHdzZz0JsbdmklssdzdjgpJfkW5ZoxTua
X-Gm-Gg: ASbGncs1jVOrahEx+YBlDowYU+1iDG4ue3A/A+iRFlTQyqCEODKRdcTXXegb7MEGDIL
	tgM+4f9xSX9DFUMxJ+RVRJSUbEZ6vlGLZe11p6Rz6Gj9tV/RpgyXPZPC2ztUlJah2sJnV3OZTxx
	GEauJ+3IUzBYHbxNbxJuVgv/5+xBKmOlCGUs2lEvBNwn5Ev6jplC2b8bDUwsHMuehACYaWYz+ZW
	FYHjyxyyu9dZExEqSw9XaY6eC6gdCxhn/VQl6DU49Z5pNqCwGuJvfYWcJXNkMYMVLaD9EzeVTid
	lXraHB0hQmqxvtjj6XcnzGFngpua7YistVSftk0/sAQOQrwTFDLYQiTpOsV7pXI3Fog9HM7xPTn
	dp6HgfTi83MMTIGYHCRI4Xm6MW0etQRo223jFTNaXTk68ycSFqQWLOKkDQPoxFYg=
X-Google-Smtp-Source: AGHT+IGEObG/NKxCZQRv8iIso1RPvbEUfnQYrykwVVS0WY0XUuWJoG3012cBcsDhEQsMqZQ1BGwBsg==
X-Received: by 2002:a05:620a:bce:b0:8a0:4d8:81fb with SMTP id af79cd13be357-8b2578b5e75mr76422185a.45.1762541896481;
        Fri, 07 Nov 2025 10:58:16 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 17/23] tuna: Proofreading fixes
Date: Fri,  7 Nov 2025 13:57:26 -0500
Message-ID: <20251107185732.23992-18-jkacur@redhat.com>
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

From: "John B. Wyatt IV" <jwyatt@redhat.com>

Fix some small proofreading errors.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 etc/tuna/example.conf   | 2 +-
 tuna/gui/profileview.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/etc/tuna/example.conf b/etc/tuna/example.conf
index 7bb293e3d2ed..0d3353f4132f 100644
--- a/etc/tuna/example.conf
+++ b/etc/tuna/example.conf
@@ -55,5 +55,5 @@ net.core = core
 
 #special section for this file description
 [fileDescription]
-text = This file contain some features for tunning kernel params.Mainly this is example file for demonstrate tuna new features. Params are set as default or most uses value
+text = This file contains some features for tuning kernel params. Mainly this is an example file for demonstrating Tuna's new features. Params are set as default or the most used value.
 
diff --git a/tuna/gui/profileview.py b/tuna/gui/profileview.py
index 7570bc0e57ce..e5022b8b6dc1 100644
--- a/tuna/gui/profileview.py
+++ b/tuna/gui/profileview.py
@@ -104,7 +104,7 @@ class profileview:
                         "%s\n\n%s\n%s" % \
                         (_("Config file was changed!"),
                          _("All changes will be lost"),
-                         _("Realy continue?"),))
+                         _("Really continue?"),))
                 ret = dialog.run()
                 dialog.destroy()
                 if ret == Gtk.ResponseType.NO:
-- 
2.51.1

