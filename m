Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785CD2DC32A
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577538; cv=none; b=o5xvDgFOYSGU6egecDTlFHdyaO/6tNrZMFhdW8xKvcyc5uWRw0X4bE8iRVWW+sDGqWtKAUha9yVziKAUubob5poLufwy0cRZgJ7PNhxB66F5AlREZ1r03OHL4R4kPn2ODp6OHRVt7fASQ+oj2iJdtJkFaS2isbXRBCM7ArJF79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577538; c=relaxed/simple;
	bh=HGnKB7iC5PkMg7iSydLLOiFrau6S6CegRH+b+TfyOuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0WTneQwLzGGaT/jwuQfNUbYgn1h+DncKSpKplvOgtutujZvsVJc2kJJ2/ycVFu6jxYTPed7AyOPK7MsMHKE/lrvJ4qXYc2hQ9nSDzl6Bz0DsY8Y6pir7UL+pyyGlJu2le1EQGQPO9pV+0KRH92lVi4/eAdMVW63ptPabHFqOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvfG7t+Q; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvfG7t+Q"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a747448dso8010521cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577536; x=1778182336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYC962WIFhZ52uXG4G25kFCdEQJruceo0XzLMhg1AeI=;
        b=KvfG7t+Qm/xiOiAgCPBJpc5rJ9Su319RgYSzR3emT1ZU8NtOhouElEeJFXQwhO/0/2
         ll6/ba9dcv1nDiHlUJBqg8MNxC198x/+gxR35dyv1ZtW3MvlakTDk5cvUCPE3q5mRIVc
         HwuJwBlQ0+ahM4PB7jAP8liJqUX/jLtHAi/0BcJ77gGBwCkhG4WW0V++4EOZsAT1fvOz
         ge/08pWbUI6gleqIvL8sSz9Uk2o8IVkcbtIUUAr3k7UBPjD77FHFuwfzY3nCMr+OVKoF
         ZUnJKahUaVRaoVzSg/Jl+7nVIEBKc0lpU78gFcS0wNfk1Mbs8FESC2UW9vLSvLCSWDNN
         0j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577536; x=1778182336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYC962WIFhZ52uXG4G25kFCdEQJruceo0XzLMhg1AeI=;
        b=fCMAlcLG4dI94yM5t96wy9EPFsbWVZftOwZvDt0aZJpBkGqb7S23JfqIhnzBXB43lp
         QlTRqCtbgQb8glINMA5bhtKoeJPRoSwx+9MGbvD7+TSnpWP/VfTlaQMLemU2sbx+KL4H
         1aRLb/yy/xNkMTLNz/ou4mDGAITK1ZFZlqA5oi0rQnTD30puj4rkyJ9R1RLT9MDrfa0b
         8/Un73QZtKcuzfl54UXg6+VHJzatUYQfiM4z5y09rtTdAd2T54SAM04GAFo4dT4BpTWp
         IPb2XMxLKDNTXH/dskwjnGCIVBDYgtDGiSRES8x6p5jXpih71j8G9hM09LzRKh5eu+fr
         H16Q==
X-Gm-Message-State: AOJu0Yw0TRqLXPtpAcnagYX0SnL6yg9G9PyRXLWeajsJZ1aEDmv4J2Ig
	6wSFBHCOdTwOTUR60wTdTytM3ZawDfQ5EplF3EwPBY/s8jVslMzVYLobZMdaew==
X-Gm-Gg: AeBDietA0FT9mCpamQPpg362RbZ40IUB9emF0kUV2g3UZAAPL57l33nMEOzeRynYOwm
	+y9IXaifbR7yf1JkVperXCgcZagvOz1EJzg9g78ix2XVGiJn/2iO9nQsWY6XlmkXMTjAQuS4nX9
	bmjP2BCxHoAEzLnIdeynpkU8kM6vYTuF0TU20sivbM2y9yhOkXekQFAr40a8kIdwjfq89xuLlNK
	1u58yuKAkEq2ap6AzCZ8dsPbbp+UhnddahOAP4ASjrkBQ0KMRC6zL7v+TUf3EpaspmsCZaATKLm
	pMZj+7dfmbtTDEzKUeFNhQp1j9lFxlmaHVCn3wB59spvwGni601w7jMckwUHGsLwIbu1hPnMISu
	WaxbX4koaCjGRT2mlAT912TpA7LRPHi3xkdEkxGGOo+vuiGjBhsSIAgmuV3zTQcJk35y1vkVyc3
	94rNt3s9fbTCK1tzZ5lyAriH2SCzdsa6E2qEu7/agVk49Xa1SSULi8WA99wB13P66Upxu46/iad
	OFOU+DioERmcqx4Qo6g5m5FePFsBg==
X-Received: by 2002:ac8:5943:0:b0:50b:3831:417f with SMTP id d75a77b69052e-5102ae58bb6mr58983171cf.45.1777577536001;
        Thu, 30 Apr 2026 12:32:16 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:15 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 7/7] rteval: Warn when all CPUs isolated and loads have no CPUs
Date: Thu, 30 Apr 2026 15:31:44 -0400
Message-ID: <20260430193144.354599-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430193144.354599-1-jkacur@redhat.com>
References: <20260430193144.354599-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning when all online CPUs are isolated (via isolcpus boot
parameter) and the loads cpulist is empty. This edge case occurs when
a user isolates all CPUs but doesn't explicitly specify where loads
should run, resulting in loads having no CPUs available.

The warning guides users to specify --loads-cpulist explicitly in this
rare configuration.

Example scenario that triggers the warning:
  - Boot parameter: isolcpus=0-15 (all CPUs)
  - Command: rteval --cpusets -d 60s (no explicit CPU lists)
  - Result: Loads default cpulist would be empty

The warning appears as:
  "All CPUs are isolated and loads have no CPUs assigned.
   Specify --loads-cpulist explicitly to choose where loads should run."

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rteval-cmd b/rteval-cmd
index 37db9e5e2ce2..c48c3d89b82e 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -477,6 +477,15 @@ if __name__ == '__main__':
             tmplist = [cpu for cpu in tmplist if cpu not in housekeeping_cpus]
             msrcfg.cpulist = collapse_cpulist(tmplist)
 
+        # Warn if all CPUs are isolated and loads have no CPUs
+        if not ldcfg.cpulist:
+            isolated_cpus = SysTopology().isolated_cpus()
+            online_cpus = SysTopology().online_cpus()
+            if isolated_cpus and set(isolated_cpus) == set(online_cpus):
+                logger.log(Log.WARN,
+                    "All CPUs are isolated and loads have no CPUs assigned. "
+                    "Specify --loads-cpulist explicitly to choose where loads should run.")
+
         if ldcfg_cpulist_present:
             logger.log(Log.DEBUG, f"loads cpulist: {ldcfg.cpulist}")
         # if --onlyload is specified msrcfg.cpulist is unused
-- 
2.54.0

