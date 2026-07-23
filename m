Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906A368D67
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836086; cv=none; b=AdmjKOUi5JgV4YgR9c48RFXCqU/pkMBOANTNJoXGus74HnOa2Bj+Kt6owInnd9WUYgMrnr7D66Wzd+OiAXSCvOS4hfA7F0HcATqOdAGG1hXyumUE9JY+zSFTmLEy0ilWQfDTAKNVjlzRAiN7f8cs8F+2Xljy5AZiu0FRKTnfK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836086; c=relaxed/simple;
	bh=oMT4nDXeGzr+bBoT14rxV0rDyw8OA6UU7qk2wPkNDME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7nHG8ehZxY1pDUX4RL6HGbdmwIZS091hmafqc4HUEQu4UzWOYouevU0qQ7r+1fccZZwHrLjt+jJM6lQx/AdhYH4hk4ejFo9oaI3R0Kdp+7KOZ82uBzEznLVCCtfWp4wG8l4btdmDzts7xaCqXuUCRqw4rDWLRvPVZ9QnlKgIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c13pMOXt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c13pMOXt"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0a81d286so8072531cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836080; x=1785440880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ld7JX/F5ctfVirWZoET0hlKbOdac0155BdNlNduoBjI=;
        b=c13pMOXtEJooYIS8hQYZcjqBM3lCaeCudSsfto58ZQoAkM3DK2dmLBqfXrvK08CJhv
         kJdz3csMsIaLw7m7B4mLoel9sxAVZhjO47ZvB6F02Z3N2sP6HoyTfy89YNSihVMzJgYB
         9jAVE0d9r06PKsJwCerA1VokwuiD+VYA4Rw8zfTUnDz4gsVxaGV6TaYAnwmyld9XJZM7
         N35S71k/o7JqwMLCDXgAFlhGzOjM+THxLuwrY/PdZyJe8VM4kouP8p9bsYVy+vjV0Mu9
         B2h9Ep96BQ48WBVrh/+w9piHig7ApB1IusqHCrJJCiThCUyvKdlLCLMZRXPoaRUe8WCA
         cdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836080; x=1785440880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ld7JX/F5ctfVirWZoET0hlKbOdac0155BdNlNduoBjI=;
        b=MLSps2VMrIj0dC/dhvUwDDSFcUJcZMcwlQ5srFdqhEF5G957wbhin6QWTRFySHoJPO
         YqPCdja3W1OO2ICjeRhmovd82kEt/uecMC8bht6P6OBDSVKIUjHtbtRaRMJTKDzAUgmZ
         JCgi8WAL1hk3VpuPtXcUdGDRQUxHlcZ5qeijZK3nyfGwb4p1+C6j8l6IPvCEWebsK1En
         Ry4wgSPjqK/yrvXPo6du8TsoKeMZcfPiiZcUhLwrK6UkaWr26pYKR8DQJPhxaAThlcx7
         MrlMDNqt5fj3ANNpeVN3ComNM15ILvggF5NUcKQS67tX3ojDmA7RRRCJxRcXltRWCOVu
         vSAA==
X-Gm-Message-State: AOJu0YyMfjLJikFYBExDwP1sZ+pJEOEJiM9aWeMeXTZcM3oWZgr59NR0
	zMklu3RTPcyYqkcRE5cw6Pag0mlUacFeT2VRZ8YZWwojYlZXdugpf1bToyvvZg==
X-Gm-Gg: AR+sD12Hyts4ngtgcVl/GCxaB6yTw+L479vfmWaTyQFRYwHNeczpLXuvCwq8utpehJj
	giX1JhQaUp7EevWGdiK5UhfSeJPv2PoOoWzz2Hr4eKYoJ/ciABJNgf9nHM1Snn7naPT0LkDK/do
	SDB2TRhanngoRs0mq9pjbLOJcReXXB2HOXWYchnXroqpzBwNfoegOU2JoT8QZLcMCIfEe8OOqKf
	t8425mhS/gYk5wDiN9K8dRlqusH8UnyRNh60Rhy+qQWImdPywT+smgfqs+7XO+Q9znskILmQBru
	Ov+P9EmKEO2wArXsVEW8o5xerBJrRiuqsNgFyEyk26mviU/wQI0vsCT3SafbILWkyZsLd4NJ+w8
	ptQO1AuBEmPZzooA1sONTll+gwQxeR4OAIuOmzCzGIrNLO/93e6JTR+9iMrhVoDCNx2j7NxohSm
	dUhXoe3VaLEPpG12Jthal1dSBGRLiY4lnTE4qRDniJbKps85Lt0O2mWzZmCwG4YGQR22xzGH3RC
	jeM1KarfrLYEr3AD5dTJgpoUTR20vq/66I2PaDZf289WTymio9V/kcOszfJ
X-Received: by 2002:ac8:5d86:0:b0:51b:fdc0:ddee with SMTP id d75a77b69052e-5283ee2934emr38896301cf.30.1784836079821;
        Thu, 23 Jul 2026 12:47:59 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:47:58 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 0/6] rteval: overflow bucket support and misc fixes
Date: Thu, 23 Jul 2026 15:47:44 -0400
Message-ID: <20260723194751.625088-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds overflow bucket handling to cyclictest and timerlat
measurement modules to properly track latencies that exceed the histogram
range. Previously, these samples were silently dropped, making it difficult
to assess system behavior under extreme latency conditions.

The overflow bucket is reported in both XML output and summary statistics,
with warnings when latencies exceed the configured histogram range.

Also included are a license update for test files (GPL-2.0-only to
GPL-2.0-or-later) and a fix for stressng --taskset argument parsing.

John Kacur (6):
  rteval: Change test file licenses from GPL-2.0-only to
    GPL-2.0-or-later
  rteval: Fix stressng --taskset argument parsing
  cyclictest: Add overflow bucket to handle latencies exceeding
    histogram range
  rteval: Improve overflow bucket handling and add timerlat support
  rteval: Refactor timerlat parsing and fix max line duplication bug
  rteval: Reduce verbose debug logging in timerlat stoptrace parsing

 rteval/modules/loads/stressng.py         |   2 +-
 rteval/modules/measurement/cyclictest.py |  75 +++++++++++--
 rteval/modules/measurement/timerlat.py   | 131 ++++++++++++++++++++---
 rteval/rteval_text.xsl                   |  30 +++++-
 tests/README.md                          |   2 +-
 tests/test_cpusetmanager.py              |   2 +-
 tests/test_process_blocklist.py          |   2 +-
 tests/unittest-legacy.py                 |   2 +-
 8 files changed, 221 insertions(+), 25 deletions(-)

-- 
2.55.0

