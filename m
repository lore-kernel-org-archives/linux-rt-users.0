Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24E4A0150
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116008; cv=none; b=l9xz4/E0MpxtyFHV8VleDSRSKvZEM4hq1HUhOnpihXHX/5tYFQZKJ9//UrCLbEjFAUXSmZeuB3ubBhEXhzbnxH/11prxrYB9hMrou2s5LdSGQchyeVneuEXWxxz1XUhKcNcGx8d26FFxPWR3IsvBNgoK8RhHgyN2dT00lIeG0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116008; c=relaxed/simple;
	bh=d9Z6Fo9OfqdWfL7JSysRm5zpI2b69YEChrw6z/46jDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok4HKWAk3PhqgesyziwJZ7zMm4vrMKlkpa9XnypdLIWGZhCITvfh1+c6q+KC9aVk/akkt4o3C5SFuPfzw2Qbn84EqjivwIh2L317pMHX9sE3cnqeoVarjoCUkwYZOAFMMiUzKvvp6lYE8sMdJnmarnGQ/rOCV+6vSJpZnpQhZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlfcW7ta; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlfcW7ta"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-90cdfc93e00so2176286d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115997; x=1790720797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Se/9yfbju2rFQCCIGZhsvppD402MwlTxvXfBCJWecx4=;
        b=IlfcW7tarCcYD6S4miULWN0OT1f3WA01r53RbzVMQPETO2IpW9fuH7OGJf2qMFa8b9
         LHfmhy/I9H1B28g23Q4+WQ4bHV/2tGOdj+5WcXkTbYu3y4NBQbXCXGq3cvNBW3wdys1I
         yG391Z6DkAnYMnRZjCrM12HQvDmMypJRxMRAdZS4+tjzYJpGSQYGSgUR91rsDHgGaaRn
         HPRggh8BiJSHl2aOYlarPlPwrgLMQ6PIye7eaar9SFgwWsTrUJahczfs4Jrhggq+smN6
         8BHX7F0LrFC8AcHEXVxHKSY+GXW+6WF3S8oBNdilz2sfrKkKfXMNWVeUsdrwpO5GkUOJ
         7GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115997; x=1790720797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Se/9yfbju2rFQCCIGZhsvppD402MwlTxvXfBCJWecx4=;
        b=yeH0lJkYUzcL2G9RKfZfx9B4bal8BsSoZoTyyMe1kRJ+88GCskJCDZhADkuAW4zP+0
         N7greCsEKTwfqxWZRT9tn/ewLmE5jwIcws6M61CXTxyXxw2Hi5+mW968LVLlvMLqNELX
         yvRFr/+92lJ3aR7Mn0xQeuD5JElF7+vVruxV8O3T/4WkZBXfxyp+8o4lF6SwfzMK63dL
         kXdwZMoCQCG0SsdwyXaHgNxxIBm2Fu8Kbl2mj6g6PqwHfA0EnDKGYGjrkyWtZ10tFOCW
         V3XpbekcrSCLXHHA1hRRFJksTU2aHKI3W+I0tNThRH1pMV2IddaHzgaobStULEgbS3is
         Jl/Q==
X-Gm-Message-State: AFuF++lPUhJ898bg6GWL2iVfa4rj51+CUzDVke4X447asZTGqzGdbCXx
	pfzTo/kyyMntCk9bXRp8WjGgT9cJJuAXdiGgIKogrTSl1uXuOvCgj9xAlOaDtA==
X-Gm-Gg: AYBFou1gEQAf5Clw7GIoSZ/4zqKeeg/CtlIHJQQwsfefIwfY9yHys+rcWkMRG8uUvos
	nVj/Rw7NFZx7glxjucWyHMUIKu0sJjBEKX54qDgFmvcr2osMWNcbEAW2aRs/9bgM9sQjB2JhI7R
	WpKmlg9MDtNrOicrM6kA2JuuWggaHeKTKCBsBxt/WkJcyWGsdXbITqAnj7C2JTzA1lVt9ToD6UK
	f6GYTya8dyPurPMht50TqmMXmZ2aL+4EOcG5BqR/dZd7LfBb+MkHjLWZapmNhnrhQrofn866VZf
	FgaBAwy2SZO/q5nmx6XM6pehrEOQVdDHrGYrE50E/YEM7XqsHzkAhRZfDwRj/DGDvmzfLM2En2R
	POPMowB9lMrSuEfaoKSnLzKZR+Azm5IRwLha1vfMwR26GzoH8dpX0DIxhEswzc+r2ooy4KcLEYE
	xkhEZe2f6tspkwuHCYyL/UjA2mkDv/5Gi7Qlwg8NW/bNZE7EQT5xi5vXWtMukUCaORALhSyR57G
	bA5e0RbuImmOTnAF8RFvOicdRCtpL3fGQSSyz6LMzdeWP+Ld6uh4xU=
X-Received: by 2002:a05:6214:419c:b0:912:5e6d:cff1 with SMTP id 6a1803df08f44-9140c3c367emr15916146d6.32.1790115997064;
        Tue, 22 Sep 2026 15:26:37 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 7/8] rteval: Guard load module config iteration against non-string values
Date: Tue, 22 Sep 2026 18:25:51 -0400
Message-ID: <20260922222552.482102-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922222552.482102-1-jkacur@redhat.com>
References: <20260922222552.482102-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoadModules.__LoadModules() and LoadModules.Setup() iterate over every
key in the "loads" config section and call m[1].lower() to find entries
whose value is the string 'module'. This assumes every option value in
the section is a string. Any non-string value (for example a boolean
option) makes m[1].lower() raise:

    AttributeError: 'bool' object has no attribute 'lower'

which aborts the whole run during Prepare() whenever loads execute.

The measurement module already guards this with isinstance() checks;
mirror that here so the loads section tolerates non-string option values.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/__init__.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index 1ed005cc4e91..efe0fefa16e9 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -91,7 +91,8 @@ class LoadModules(RtEvalModules):
         for m in modcfg:
             # hope to eventually have different kinds but module is only one
             # for now (jcw)
-            if m[1].lower() == 'module':
+            # Guard against non-string option values (e.g. boolean flags) in this section
+            if isinstance(m[1], str) and m[1].lower() == 'module':
                 self._LoadModule(m[0])
 
 
@@ -104,7 +105,8 @@ class LoadModules(RtEvalModules):
         for m in modcfg:
             # hope to eventually have different kinds but module is only on
             # for now (jcw)
-            if m[1].lower() == 'module':
+            # Guard against non-string option values (e.g. boolean flags) in this section
+            if isinstance(m[1], str) and m[1].lower() == 'module':
                 self._cfg.AppendConfig(m[0], modparams)
                 self._cfg.AppendConfig(m[0], {'cpulist': cpulist})
                 modobj = self._InstantiateModule(m[0], self._cfg.GetSection(m[0]))
-- 
2.55.0

