Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F30361DAE
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229037; cv=none; b=TUn3kqYP624ZjFzyN2GBY0mTucKxOf5dZCVrTgjQgaKNWLo5Sy38dBJIdx8/1Q5p5n4ChU6p2TxBSovHmUIeJzOxP+SyfaMKdAQBqFlE5B6ppZnxfpF43lr1nzMXyzG4Vw7q73teqdyQKlDt+iaD7IlPowKmOVR4y2WjjvLJoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229037; c=relaxed/simple;
	bh=prORjTkJolboFZI3pm11smzZFFZrrOpLGOZ8LveIVBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gA8N9oz2HibwuIQ/FxC3Hyk03lMRzM3NXYPuxE7P1URPFn1tsN6qOLQwKFatqlGTJaW0w33n9ABYEhrGJ92SPYyEkJSlk3YhF2eP9pcGkZqn102h4OlVJfy5fQP5V+QdPLzhHsK54NEVuYxYRg1woAHgPUfUlreepb0Gogs7aWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi3osmHC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi3osmHC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c08df8513so25420201cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784229035; x=1784833835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJgPy8oUcIjlNnwiENYFGtMoFr2dHuSMGoCo4+9aRfk=;
        b=Gi3osmHCrP1xYORviHEn/oidqMFCZQ94eBWiU2bJONn8O3R1u6u17loM6kypS4udIX
         325uPk6iPazZGJZLQjuPIsBIuphhCXaHWQnA6zCadau7+YPgd3aH2ZsxYPkiY0ijyh4j
         o92SwPsGb4SGk8gW50yH8CjxX8wV0gbCyYG0Psurh8iPd7jtElSI3ErXORImT5BkVlaq
         jegtoHBYUQZDnhL4GnTEuluoOfwd7Z6XH0hy9o2QRtSn5qaxgMKv78ROmDiwvnHu1p9w
         DNUasIDurQ/2iq+2Tow9GDNcaoMQorgn1uGBRZd3c93KZUsP68MVvz1p5Wej+389x5Ee
         +cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229035; x=1784833835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJgPy8oUcIjlNnwiENYFGtMoFr2dHuSMGoCo4+9aRfk=;
        b=UuKoBLDRQV4WPZr+ulVp9m/rwOm9mGyq0jEOuEAkVcXbVYhYTTdbYL35y5B9H3LgY+
         BjU45QTWmmsu6sBYSa3x1Amp4TodLvJ9tASoAEr51ZxtBa0DzDv66fDtumA2IOqpM5ei
         nrCSTB932eZrZq6apoRtHXRrrApSE8xcNUwiiirUwZ/cYi7a5VPmW3sgYYSmsI8MH2Ty
         MhFlbRQVnPKiP/PmurvX7hPsvQMBBo7Nz+JY+jHbn4lWouZackrzZpGon90yIRgnJub1
         HRGi/7E0uEEzudIgrDy+giSJ9mMSm7ZLx+N6VMEVIN6U0/dF5mGYYZRIhxt3wkxkEZLo
         8rcA==
X-Gm-Message-State: AOJu0YyJBEIjy3YAZYoaBMbrz5qGAH046zG1W/txxLz+G53J4dj/dmzq
	l62uIlEO3IHIrtE1kv5pmG0J8mEbB8Nmw0f/gT90TTDi81SEq/ZzHgexVaIEIQ==
X-Gm-Gg: AfdE7cm+7t9WN8Xlxn8oG0b5MtzD5nO7aLdC5Q5IQJYABrCllbX7ZXGDWgHK60xmM22
	CgDDDwjh64Ta91xSoWRsaVNaXld6K01cHsmd33Z5idLFTyarGh4hTqBDKjsnQCU0HbcdHFOy6hI
	cC+T44cJpMt/r7NPCiaOMowV+X++WdQGPhUaiI7aourSoXF8Uqpe2eP3kW90H1twBkJR0JZk7aI
	gNq4PoMrqywIvQR/m+FjIYqGptD5XK41wklYLuLoeIov+BgTX8Dvol79y7ftwxj5kCfEClfVg1U
	NzAah1LnvzevtLughJsz3knKcYbtqiEgFDpW0gns7t4gexzSQ8o2p7L+ZhQaBvv7/r2hw8xO4hw
	coQHjy/w0m7LK0wkqW09S7ekjNFlDnZBEEKcff9DS0fGYz5ubEGqhZ5mQGZXlVrUHCRd7XQg6U7
	yHjxFjUlf33MHa3CsOEE6E9kDXR+VyT0ADTgY/ECEs+TU+p6pPpsCcZoqqWqq1/3DXUOSbWntmP
	PfAx4OWAmJHI7xwvdxKFD0gZBoQhjDjFvC2/wG1XYkDWnlriHevZ2PN5IZP
X-Received: by 2002:a05:622a:4291:b0:516:df59:32cf with SMTP id d75a77b69052e-520bb76149bmr9697691cf.7.1784229035178;
        Thu, 16 Jul 2026 12:10:35 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm158236771cf.4.2026.07.16.12.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:10:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 1/3] tuna: Improve process migration messaging clarity
Date: Thu, 16 Jul 2026 15:10:26 -0400
Message-ID: <20260716191028.152934-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the migration report from 'failed: N' to 'N kernel threads skipped'
to clarify that these are expected kernel thread rejections, not errors.

Kernel threads (cpuhp, ksoftirqd, migration, kworker, IRQ handlers, etc.)
cannot be migrated to user cpusets and are correctly rejected by the kernel
with EINVAL. The previous wording made this normal behavior appear as
failures, which was confusing to users.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 5436f68c5029..ae02f2d50936 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -1704,7 +1704,7 @@ def main():
                     print(f"Migrating processes to housekeeping cpuset...")
                     tm = cpuset.TaskMigrate(cpusets_init, hk_cpuset)
                     migrated, failed = tm.migrate()
-                    print(f"Migrated {migrated} processes to '{housekeeping_name}' (failed: {failed})")
+                    print(f"Migrated {migrated} processes to '{housekeeping_name}' ({failed} kernel threads skipped)")
 
             except Exception as e:
                 print(f"Error creating cpusets: {e}", file=sys.stderr)
-- 
2.55.0

