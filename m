Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587224CEEA
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258385; cv=none; b=iQA6bPCRqeGyGb7YCVLmol2jIBvN8zvakdOV0V7n0nJeDwCzkubCuGKffJAg9xFA8ANvzoiojZfMdk9gE7nNue5TlhgIdDHfohPggvmSO+80N2NxBU/8n7wv7U0hRaxr86f25cQXfKw/3CUfJiHbvIZ102eTs90a9G6CCl1w93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258385; c=relaxed/simple;
	bh=RFjQJ5ADN6eGN3TTZlbURZNwFlVOlyTUSTyuRoFxz1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iurZR1OCM8ML1AqK+SgD/DZ54UXgCKMumpLdPMfl3ywvhXYO6+PdBFYZViKyeAi9gWPjdytzRepD/lCVI6R1ul9tsY8oOaJ0udPWu/CDtzFKmDywqoreknJUQufGZSAhuoiQUd7AUrEnszKPn0e4SL5juMTQRnl03krD4X2R5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwLo3YQE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwLo3YQE"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f032b47e3cso322966d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258383; x=1785863183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDXfZMViTi4GWftNobW4e4tFnVhRK2pFmrSxw2gE/8M=;
        b=MwLo3YQE46MyRsk99NCX8PDzrHZRjk35NRdLDaek9koj+ooHmT+uWOQGKio+5NSM2C
         Jw4OArx8LEcwjhYFsdfa9NIzMcOMYW36af65KENvQjrAd+Jjd/2fLer2h8HGzAhMFg/L
         9zs/5XyT8R4/2z5cMbryTwE8FhSrAljWOEAIhSXvChxQag6ptrF/f0r0Bk25M9oxo+mY
         ynl5AxsZR+z2U7AJejQ4ofSGSx9j2zWgtZ+jBc0cOffSEGsYl9ytFqfqsnCVOtxUK3/R
         1Cj02mo9EMdC6wQZtB3laEHPxTe7BfeXAf5VamhrE/TUJMigPQzk/AlJtrxDh6sjhCtb
         HNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258383; x=1785863183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDXfZMViTi4GWftNobW4e4tFnVhRK2pFmrSxw2gE/8M=;
        b=D6Mf8BCfBZAVM6cNt+qt5uD7O4KYWN7OQzk6yAWxBYCJP6X1IjaG42k4CCQ175RoLm
         kiRBDCu2LmNxezTVQ7TBWQ2A0KUSVYkyMrbF/mp48kePV01OCj+Pu1tf7RWWNlxf3ghO
         pEnY5LkRAiDpSSIZksBTClgJKEq+wjkj/ZqoZF0HQdloh5gJkxFceIX+MRiLdmelPVeL
         IUqb9FE0odI7EZ4Np3vnkIzon3ENl0Dw6EjRIEzyaG38gL2SAkypmlE6UAE5Od+oO1Pg
         bA8CUtPWT8KHvUXZ6mNfgshEa0mOD/DwWbBRyaH6m+H9YcJKOkHXZtT3aYwDQgS3PbJB
         CJbA==
X-Gm-Message-State: AOJu0YzwayvyrJmdcmFnz0uFaulugednGp3Icpr1gE/32VXU5jJu6iOZ
	XAwKSIbnkjxOqt8D38utwTvVPqqn8f1t2MdcRSOhbvEx1yiv1BZNeikQpH8V4Q==
X-Gm-Gg: AR+sD11fqPmvFYXsI3Tv80V/PuUPRLyMZykr760vusIdn0V0V3Wn69Q7Kp9x/ZP1ODH
	uNV6HYULkYR5geeHC6f83PKnXI61h4ZgUJQkQVhpu6aU9wB8XKzOCTkxMRRqToRyKuj79Kfizpm
	6gm8f9KQz8WGn2W+UgPLmfU6nbAFMtUWXa3A0ixVH53bjjMGAG/xhdH/D68TkOIRIF3vVkK54ud
	yfNeU4113Fo1VAEAoL40BBa0ocKg5rkg3bnCtpcLClrYb07MovhgfU7HC9SYgm4hVEcK99rkCSB
	4F3JMgfKX61LT2oc41t0v1Xl08CvBFehWCn9OoRL1J9EQafA3hmMJ5BpKWim2Xe1SgcVwAy0dHt
	uJf4DjIAHvU4lZgWypsUa0FHNMlV2T7WQj/MIIgwMtPTC+LvELK/XJdb230Ezz0DuZlUEZ2Y6Qq
	dZ8JJdhcNBHwGd2UW6DaALUsNpi6r4zFILxeup/JihhyhZp2qsPgXbTnCA5lxGeLYYaLm3
X-Received: by 2002:a05:6214:f2c:b0:907:893f:6d8c with SMTP id 6a1803df08f44-9081731de90mr38574886d6.55.1785258382798;
        Tue, 28 Jul 2026 10:06:22 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3aac2sm3229676d6.30.2026.07.28.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:06:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 0/5] tuna: Cleanup and improvements for v0.21
Date: Tue, 28 Jul 2026 13:06:02 -0400
Message-ID: <20260728170607.176811-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1: Remove obsolete ChangeLog, not updated since Feb 2013

Patch 2: Change cpuset profile default paths to be context-aware:
         ./cpuset-profile.yaml when running directly from git (tuna-cmd.py)
         /etc/tuna/cpuset-profile.yaml when running from production (tuna)

Patch 3: Update the man page to document cpuset save/apply commands,
         fix cpuset destroy (now accepts multiple names), and correct
         housekeeping default (partition=member not partition=isolated)

Patch 4: Add path resolution for cpuset apply - searches current directory
         first, then /etc/tuna/ for relative paths

Patch 5: Get the tuna version from one place (tuna/version.py) instead of
         updating setup.py, pyproject.toml, and tuna-cmd.py separately

John Kacur (5):
  tuna: Remove obsolete ChangeLog file
  tuna: Use context-aware default path for cpuset profiles
  tuna: Update man page for cpuset save/apply and recent changes
  tuna: Add intelligent path resolution for cpuset apply
  tuna: Get the tuna version from a single source

 ChangeLog       | 152 ------------------------------------------------
 docs/tuna.8     |  52 ++++++++++++++---
 pyproject.toml  |   5 +-
 setup.py        |   5 +-
 tuna-cmd.py     |  61 +++++++++++++++++--
 tuna/version.py |   7 +++
 6 files changed, 115 insertions(+), 167 deletions(-)
 delete mode 100644 ChangeLog
 create mode 100644 tuna/version.py

-- 
2.55.0

