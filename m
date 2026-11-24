Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482511;
	b=nGzQSV6/MFc7ZeeuhuE5rvQeCYL9ofKLKZ/YPEx7QEpOXokWQDtwhGkiEr4vD0SF8MbM
	 MdF4Y/gwPW+/1o5PAIFO3u/WrSDCMKWe1SmFWTHDiStWvcl2l5ltTh43kZx94psMZsHeu
	 vCRHZYsQJpvAkumw3XmTiD0H3+47UzH/iSaLrCO0EjB9TbFMwWlG/mvv/SAoEtNECk6lT
	 sCXDeRneZVo561a0Abb3HK/KFwak5Q1qigVGTTveTASvkHiauPM4QE2op4ZVuWGuUtH0M
	 SOEibQjYwTm+pTLL4GGJ+k+mOoleiVlerTWPQSFGKdC5hU38Cshp3+RW9FrN63rlSJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b1pyHOpbtmGzUqIYV1IQoThQdQtyiJMvIdzf01qt0gE=;
	b=fKgya0aNjaCTYltPzxGryjo6icPpti2PAkJt4iroM9mYFUl4EtVAjCMPm/JjvwMFWfFO
	 JWbdVkTyPXkt4wspKkrTq8iw+I+IG08Owp83BuxRbAv2fBmHbUPqjHLRVFXiN0o0gjU+G
	 +xRtIidsWh3ftF8Bd3GmSD1yGcXRswwWCAatFKd5CCB9Si867nIFlYh8rrVGDe3YhD1XR
	 TGjv2iIf9ZEiOJV1HjC+wpewwi5YOhPxwGUtGmJrSuy8ZPWWCAT92eoOASXrASmK2MN7B
	 yKsuGNLj6Xr2Ag8Kkc/CvxRwI4lgD6Hu3gH40jNDXBMv24mR/PbpcRHyjK3yrzqEHAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DdFBGc+C;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F93606A31E
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F93606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DdFBGc+C
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9213e130a16so22103456d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482509; x=1796087309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1pyHOpbtmGzUqIYV1IQoThQdQtyiJMvIdzf01qt0gE=;
        b=DdFBGc+CXhqEa1mv8SMYquytBAp0L5smO/6QvnHf/jb+me9z6iuQHB7kpHw8OSrlAF
         pw/B958DLXvjmnrYbACoBT+AKZ4CaYWkB4r//wLvDMARKruwUwVlmU/MDcUzPTTF077y
         5Kp4knZGs+a951PKOw8MvzopGfxNhIr0QVhDCuPA9Ybpg36B9Q2m5SoQZ+poaLFiXF48
         Bc6Me8GuN0SRaM8VxYfGyGVI68nshuF0JNq8gGGUD3xcYI+LulOmPcEa3EeDkn2E5c/l
         YwQ9Kj/2hGbUv/A0m8tRC0xuXMG0T2TazlFwST9J065LTEeQH2T+4W3tbH8jIg7YzPuJ
         FucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482509; x=1796087309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1pyHOpbtmGzUqIYV1IQoThQdQtyiJMvIdzf01qt0gE=;
        b=RwTJn30sobPORhfLp99R0ix6VUEBFp0GjbP3DOpzsif9inRPkF+4MS1xMrTJUwAlgG
         rPs3Xq4DZqeFayYPFohWPjXX+ZFygDCow/PM4pvJk4CuTgFgukPZIzfz3b45djlNn2F3
         hH6W/nUjncIvohSh8A2ERxMFVU6djJQd6+ptiuOrYURH9lCfjg/gWcLIGWXrKrheyo75
         ysD2iNE+Htr1yiBvLfIV5aIWCLNptIKT9lj5gqiqGqXnfONCo36f8pJr7VrKZRheXI50
         /BoJI9nY8tYv/XRVw0omhK/xj7vfousYJiEW0BxhQIvBIgfmXjOMFSH1naLUJH608ygh
         IMug==
X-Gm-Message-State: APuU4Z88UtElxcbk/5WkdMxf/kXUvRoT7+h1yGlIMTdi6o8VZmpXY+F/
	dio0ILVDAmPvL6EFymILpxpbVMMB74/tsrqfS0AHRJrwAmT2XYkL3rq+wiRL8A==
X-Gm-Gg: AZFdTZffk2zlJwc1b7gAhq5KgGe8O6yDqTJMAMPCkB7eAui+yBqJYib79a0SoMsKOjm
	v+QZ2ymsyRrfE7wtb4bBW2qsObdky2hitHutYR9TvLYtuzTILkjETYOHZ+objApOTEozP7beuS7
	RVfhw1dTgD+ZP5JT4brdlCQzZ49VFU45E8bCz/658ZU8izCxLyMwk87TidVResfJ3FubJiP/OyA
	aLyA+Tnk+jpkcSFA/6768+J8xlAuasEdygFRTaXbfoEzR9w8Scj6dUtN8JveArx+B1655sMgyQb
	3r2oONLv6o7IwocVFxtYJViEz/HIPFwqFjVcCDoQAVvDBfJjEzJVhatqsC0L2+8b2MiKud4TNwi
	bLBL8hZA1pbq3SzIuekH96Be3VmNiae4r0F7VrnmP8s6oK/7IbI0GE4fO/amvqpaCjCun4aLtEa
	kVYOzutvO4MWhRfxO2paQSG/VZPmsuAPeHJOAaZTRclI+bdNNzCeLxBfTCyZIrQIo2G6Fwfa3Lj
	ShOOhbeAitSNIKJdP4X3+OEpj+lRz1aWqKLLJwR/eHA6bN2xmnvlT2FcWS80Jp3uFc+RCXdy7+N
	3raVgkkJO7MHdmzcU0qHV2dYchqgEA6xq7LMcxe5Chd8Osq9iSWycOMpeoEHMLfM54/LhACImrm
	pRzx/j+Dua0vPr803iWhCVFqUL8Q3kCqpYnc7
X-Received: by 2002:a05:6214:2024:b0:920:fe69:a3c4 with SMTP id 6a1803df08f44-92134ba0538mr252685226d6.51.1795482509511;
        Mon, 23 Nov 2026 17:08:29 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:28 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 0/6] rteval: multi-stressor support plus stressng and test fixes
Date: Mon, 23 Nov 2026 20:07:42 -0500
Message-ID: <cover.1795478784.git.jkacur@redhat.com>
X-Mailer: git-send-email 2.56.1
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

Applied to the rteval tree: Sana's multi-stressor support (v6), class-level
tests for the stressng opt-out and arg building, a docstring fix, and three test
robustness fixes -- making the core-sharing tests reproducible on hosts without
SMT, and making the cpuset tests select usable CPUs from cpuset.cpus.effective
instead of hardcoding CPUs that another isolated partition (e.g. intel_lpmd's)
may hold. Posting the series for the archive.

John Kacur (5):
  rteval: Test stressng opt-out and arg building
  rteval: Fix validate_stressors() docstring Raises claim
  rteval: Make core-sharing tests independent of host SMT topology
  rteval: Skip cpuset partition tests when CPUs are not cgroup-usable
  rteval: Pick cpuset integration-test CPUs from cpuset.cpus.effective

Sana Sharma (1):
  rteval: Add multi stressor support

 rteval/modules/__init__.py            |   4 +-
 rteval/modules/loads/stressng.py      |  81 ++++++++++++----
 tests/cpusets/test-cpusets.sh         |  65 +++++++++----
 tests/test_core_sharing_validation.py |  24 +++++
 tests/test_cpusetmanager.py           |  39 ++++++++
 tests/test_stressng.py                | 132 +++++++++++++++++++++++++-
 6 files changed, 309 insertions(+), 36 deletions(-)

-- 
2.56.1

