Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482515;
	b=Q3U02zrgAJMPUJ46TvrA3/+kZLUv8FWMbpJ8ddU0Ul4l47TAPnGST/CQ07XPXNdIZaFZ
	 LRCESzTkvJC1eFuGddS08XwQnFXg9lugNhvzlDSkOT/KM6e6Cnxn6HqU4hGAqvIQUqxa6
	 hyAZHd004QEmYkmuxxUoGLYCtX71cK3NIBmzcAPO5zJaBUsfabHfx8Qy9IMB5DJ8Wt4+x
	 A9mumqOCoWU0GHcaEas6GlFZ8umvXwEykK+kLiQvtOrGb1NfV0S/Lt4ZBa0Cr77YiYVmT
	 5EVp0bsvo/zyCVVg0r00KU1YNuo81cHyF5BhVS8YynYdmIqZ67/AW01r4hy1WSOvCAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ZUMYf9E2redUyKPFVI0L140VWQI0uUBteqwe8VSBlo=;
	b=oSRwCP4+JbP+n2gTZAMG0ImEwT2fWu5uIaISK7YF0K0pkVi3tD7pnYUL82cTjbH4U/WG
	 Y6eLz53a+hFbDrctKtdH9AOs/aZfSagpftXM93NoDhicW/A5rNwwerfk/Z/ZCfytzNJAG
	 wUXqL6XB7SV0pplG2AuEkm6wy0SoQTU8OD/vmotpFyrNX5U+APPN1uFs7fEVNk1iqDcnU
	 6ILaySmKyUp4msSK+M+4LUSB1t3ajIQGB2sTwnp0/fI3KG/ypxmWaBdXn/en0y3LoB55r
	 VBUrrAANN88gcy2EFyNieqrEcRGfbMvPD4V1loVjT8OhPOIW8g9wO+WsyN8KU7vsCUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdyHdtXb;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F7606A336
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D01F7606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VdyHdtXb
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9213922de73so71532626d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482514; x=1796087314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ZUMYf9E2redUyKPFVI0L140VWQI0uUBteqwe8VSBlo=;
        b=VdyHdtXbk2jmGvt1oginU3v//LkZqSzD65d+9ykxgl72SVU76UGvcmE5dyw1oCjcP6
         9kdI+FnPeMFRZdt5o1DKXuVjVjc71ayjV4HkPpjrV3FZ9Ckj9hYWrNWjDENUpxxEGB7C
         Uvk+mXeSPoedByKSWyuo7TKEyUNVObKk2DZhBGWf3qHL8vesvrO1RRy3b525U3IjBJY7
         bjhtxwFQdGs6si/puJkbWblwc7hJhAbkrp8mdwjMvyKwjHrQy5cASLRxyGbPZkPy+Yw8
         35406uRS3y0vYCKkNBQGMorL5JQNa9wRqSnwGFfU6wAGJE5yhU6ogLYOYk3xexRQ8Oxc
         Giyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482514; x=1796087314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZUMYf9E2redUyKPFVI0L140VWQI0uUBteqwe8VSBlo=;
        b=BvzT2xtUTi9AVvaKCeDr+Bar4cHOuDf2URZm8/9W1g5+GgzQaLxF9CaYML2aoIQe/C
         f2CvZvg9AFB6cGkfiP7+EuMwmEMLhP4ZF+8XvPPHbGB+Kz62xStr72jPBW3XiFjGI7H5
         fg+kKd2PFLuS5NxzYP8tpR6LEY2Adek1/m2XzMwm20Nc5IuMN2vtO4ilBg1jWwBGJ7KR
         hSzEkhHV5JVo/gq/7KdmgyDlcfMJsMTF387FoSzwPVSluFayD0ead7+HYvjuwC/wINAo
         YBx6HJMJ6fSQ23FfVQYarhH8yxmpxAF53oH+BeEpABfZvloIU+NT+dZTQnXEqLQXMPZK
         Uz3g==
X-Gm-Message-State: APuU4Z/r4IA0pANSOdBySY4NaqXgX58DORX3GxzBY74O38sNY8TjzWQJ
	GFbo6yXXhbLq5RM40lFey6iMzLa0oO4q58h0UPsFtTiP5jmK9PkwO1zlo5kKBw==
X-Gm-Gg: AZFdTZfT1FAsxrQXBzNEb9738kYMlGltoRKP8Jt1CxqQrKjgkB37pHR6pcHgK1TVhY1
	Sf4heBvfXYJUJWa+CWNR/rmx9CUXSf/s9zCTfjgyoQwVw4czppcfhRVcxkwQpTbd9dttynt3YR+
	nPeSQJgQOjdaGR5kDOQxYHBmbQnjCRuLpGeBgp+YlyhuFeLhBW1mOXp51KD9afzkMFjDLDnCVEQ
	9FHPSsYMYdrer8QR0mR3+rFizedHGyrHuortH+gnBEEofjLpu3jWE2n2rpBTNLwgFKXjnkMUE2E
	mEJ5PvNXYnMEeq4fNs7pPjI7jyctO3VR+zS66QBuBr2pprseKz3QnYDFuCpPfkMg7l6C49wHq4u
	BFp/7jKfe/lGjL14xruECJx8oP2kenQrS39mjpMqAwlfqjYAhx276Mns8J89QhzkGIYx4H2YYnG
	9xHt3aFxzsauCRlEzPwy4a5JTQTB3HRdlXEGib3FrxqkjwhzMVYs4o6ETHbeAwgkeiflLs457M6
	awDL7yLtKKcm4l2Ls7h/Tr+eV0/wPoVNzyVCZkcZ/t0cirLY5T1DHg0JObVAHtvAAHK+oJ7OS+w
	tNQSAEx8Lhe+B/a6EO+x7k6nt/nVQTJ5lBuL7qQF3/amIspvHbV4z0GCYre6SyiRLBRcz6xpuXd
	K3I0zl0kl7/pRVyTskgBUsPyLnH7E7wz0Oz7E
X-Received: by 2002:ad4:5d61:0:b0:921:2f0f:6970 with SMTP id 6a1803df08f44-92134a7c16fmr247979886d6.19.1795482513795;
        Mon, 23 Nov 2026 17:08:33 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:33 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 3/6] rteval: Fix validate_stressors() docstring Raises claim
Date: Mon, 23 Nov 2026 20:07:45 -0500
Message-ID: <bf4cd08a8720be5026c24048548b9c5e96b36ea7.1795478784.git.jkacur@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795478784.git.jkacur@redhat.com>
References: <cover.1795478784.git.jkacur@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_stressors() does not raise ValueError on an invalid stressor;
it prints an error and calls sys.exit(1), consistent with
get_valid_stressors(). The docstring still carried the old "Raises:
ValueError" wording from an earlier revision, which was misleading.

Document the actual behaviour: it returns the list of stripped,
validated stressor names, and exits via sys.exit(1) on an invalid one.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/stressng.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 479248875fae..eed1263690a0 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -21,8 +21,10 @@ def validate_stressors(stressor_list):
                        (from repeated --stressng-stressor) or a
                        comma-separated string (from --stressng-stressors)
 
-    Raises:
-        ValueError: If any stressor is invalid
+    Returns:
+        The list of stripped, validated stressor names.
+
+    If any stressor is invalid, prints an error and exits via sys.exit(1).
     """
     valid = get_valid_stressors()
     if isinstance(stressor_list, str):
-- 
2.56.1

