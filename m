Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2559160
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240817; cv=none; b=Y5zSx4W1uR9MeG/BPxClkJb/nKg3zloO6kglLoBKmqPbKrm4WlgPKCzQxplPjL0re3I+CMod0BzYei7xhSW9YyWwNSmrV5AXO6/fGlwMahSMhP8iWqSGXgLUoIcEo56J6B4uzBN7gLPz+3lWR5ltPovdgdilV8U4h9IH02t9Cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240817; c=relaxed/simple;
	bh=itNXQ7HBlkqxoxvH0XJ3G497Ae6N/V2nYO9GjxLy6g4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GeJ3UAL1A6zIdvE6iTfMKffPdgkd+8VE1X11fN3z4ZocL34RYiBNV6eeczejpxqYUWcY1s4zlVp2RFrl91PlZEFS5KzQDVtsWso4mF3hbYISvy/+Pdrff3pv3s2lMSeloAk5QBEn7nRYApAckU1kClsx4kaJSGNYEfmlaR1kqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rodrigoq.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOLkLP1z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rodrigoq.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOLkLP1z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f0bso41490717b3.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710240814; x=1710845614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hTztD0aFTMKMydiGC0UQm3U9OY1gGOLq0J/H0NedfLk=;
        b=yOLkLP1zd5psjQMiOq6f9Y5oRA0fXJG0EuI1XPigWbY8LedDc0lHfx95HpMEnXa5I3
         qoln5Fm5oX63K1xHM5/Dhnvi9Vdir101ayIYiu5r7tJoCutdOZ8LnsKTDWA9gkRlVK45
         2oPBVFMxu2vG6HY94KDFla6DTKVUNrF/gYqIzG0HMqka+g8LnaiVxBEBUCXPL5UsJ7JJ
         OOdwAHGZHk8ws+jsG49ktm6UCd+rGVA9axQSKUaPtDdXaykXr1vjaf6lsf0VCW13578N
         vmj11I05QiFNxGpq+//yXUJeK3d0N4zLUQN8sdZbsVaDgCb3K35igPlpDDtiNnK5PmZv
         X7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240814; x=1710845614;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTztD0aFTMKMydiGC0UQm3U9OY1gGOLq0J/H0NedfLk=;
        b=ka8OJZcItvDaTFzItzcIMNBSbxAEGVF+yuOwpOT+kO4RlRocuN58LtsxcV+yewdTQj
         17MQXNZA8/zlswuZkun7H2PtPcxvvtHmxSzUs2vqbZeYE9TrsOhw0b6ObmbR0fsi6MG+
         NPUBPaa1jz8Mq2OAuyZE37crKRotjomRQ8oWNgwdXZKjHOwDL5FC0sVcnR8wBubnpI+M
         /LjrzOxhei4O2WnSZnWgfhF6+fAbilrlVCZYgeilrldvs2iTgWI4Q5gSjn4B7B7Twjta
         v9SBSGnV2uW3NvIvY32JroGbeLnZWJuIulZQXjQ29xUhjAihXVl5sAiYvSM5bIOQ6woo
         uI7w==
X-Forwarded-Encrypted: i=1; AJvYcCWNCM1m2lv/RgJ6qXU3riddqBr/7Xll4iwmdceqMImUwTgobqPkPQgzOORvjEx1BW2eGaraDhtkdSgMs7RytXi2ScgcKB4n4oD5FqkqjBg=
X-Gm-Message-State: AOJu0Yxj6Atwk7lKFxAJLedJXdmxWBf752Bc9BY2BrQ25RQn8f/jpxnp
	H8lueVWut7Z3+oblcKf1kPWQP8EqLFw7nXY/5OC+smZngWezhcEDPZcS5XoCeQ6AdTIjDNu1VoI
	SqJ2eNUP8kg==
X-Google-Smtp-Source: AGHT+IGXDuaED3KaQno70dkab5//XbA/JiHYmN1lJUvTbduxOMMjSZtxZ2ApsPdpH4AtX/KvHcQOOsaGW7lhhw==
X-Received: from rodrigoq-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1b5a])
 (user=rodrigoq job=sendgmr) by 2002:a05:6902:1889:b0:dcb:abcc:62be with SMTP
 id cj9-20020a056902188900b00dcbabcc62bemr2362463ybb.6.1710240814381; Tue, 12
 Mar 2024 03:53:34 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:53:29 +0000
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312105329.3876232-1-rodrigoq@google.com>
Subject: [PATCH] Support --smi on newer processors
From: Rodrigo Queiro <rodrigoq@google.com>
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>, rt-users <linux-rt-users@vger.kernel.org>, 
	Rodrigo Queiro <rodrigoq@google.com>
Content-Type: text/plain; charset="UTF-8"

This avoids the need to update cyclictest.c for every new CPU family, at
the cost of generating bogus SMI numbers on pre-2008 CPUs. Based on the
comment from Daniel Bristot de Oliviera:

> When I added that option the smi was a relatively new thing...
> nowadays I think it is pretty standard...
> so simplifying it is a good thing.
---
 src/cyclictest/cyclictest.c | 91 ++++---------------------------------
 1 file changed, 8 insertions(+), 83 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 33fac3b..8a96339 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -404,7 +404,14 @@ static int get_smi_counter(int fd, unsigned long *counter)
 
 #include <cpuid.h>
 
-/* Based on turbostat's check */
+/* Guess if the CPU has an SMI counter in the model-specific registers (MSR).
+ *
+ * This is true for Intel x86 CPUs after Nehalem (2008). However, it's not
+ * possible to detect the feature directly, (or at least, turbostat.c doesn't
+ * know how to do it either) so we assume it's true for all x86 CPUs.
+ * Previously, this function had an explicit allowlist, which required updates
+ * every time a new CPU generation was released.
+ */
 static int has_smi_counter(void)
 {
 	unsigned int ebx, ecx, edx, max_level;
@@ -428,88 +435,6 @@ static int has_smi_counter(void)
 	if (!(edx & (1 << 5)))
 		return 0;
 
-	model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
-
-	/* Based on intel_model_duplicates */
-	switch (model) {
-	case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
-	case 0x1E:      /* INTEL_FAM6_NEHALEM */
-	case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
-	case 0x25:      /* INTEL_FAM6_WESTMERE */
-	case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
-		model = 0x1E;      /* INTEL_FAM6_NEHALEM */
-		break;
-	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
-	case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
-		model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
-		break;
-	case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
-		model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
-		break;
-	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
-	case 0x56:      /* INTEL_FAM6_BROADWELL_D */
-		model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
-		break;
-	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
-	case 0x5E:      /* INTEL_FAM6_SKYLAKE */
-	case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
-	case 0x9E:      /* INTEL_FAM6_KABYLAKE */
-	case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
-	case 0xA5:      /* INTEL_FAM6_COMETLAKE */
-		model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
-		break;
-	case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
-	case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
-	case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
-	case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
-	case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
-	case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
-	case 0x97:      /* INTEL_FAM6_ALDERLAKE */
-	case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
-		model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
-		break;
-	case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
-		model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
-		break;
-	case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
-	case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
-		model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
-		break;
-	}
-
-	/* Based on probe_nhm_msrs */
-	switch (model) {
-	case 0x1E:      /* INTEL_FAM6_NEHALEM */
-	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
-	case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
-	case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
-	case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
-	case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
-	case 0x3C:      /* INTEL_FAM6_HASWELL */
-	case 0x46:      /* INTEL_FAM6_HASWELL_G */
-	case 0x3F:      /* INTEL_FAM6_HASWELL_X */
-	case 0x45:      /* INTEL_FAM6_HASWELL_L */
-	case 0x3D:      /* INTEL_FAM6_BROADWELL */
-	case 0x47:      /* INTEL_FAM6_BROADWELL_G */
-	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
-	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
-	case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
-	case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
-	case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
-	case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
-	case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
-	case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
-	case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
-	case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
-	case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
-	case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
-	case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
-	case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
-		break;
-	default:
-		return 0;
-	}
-
 	return 1;
 }
 #else
-- 
2.44.0.rc0.258.g7320e95886-goog

