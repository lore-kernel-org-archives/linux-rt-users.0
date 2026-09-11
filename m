Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C14028E2
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152981; cv=none; b=rultwqIg3pIMO2joP5SADJDV3aNY14Uf6XQDMwUf7oaf5G8jKtI9Vf3akmClEXpuhZf1cB2QDf8p7IoIHMvDk/8bNwrUU11LMgxwuj+259k0/EvRc3pX11aJqmPhpg0adcwPk5oVhky0Bx8YmOGocY8NVrgHWRfFb57hTeeDx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152981; c=relaxed/simple;
	bh=j1GJYvderXrCsewGsZG+jb9GnpYcVydejVfvbnMS4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlhmEiWRWkZI2/rZT5zRT60QfDG94q/obttmg2dRaE5ytBDWHqdCJwExQyC/6hUPQkesPJl58muPdb3YPi5vi0kpgaV+dnStygnxvqGLTb2hSM0Bm4N5kHJEUZqyoqaWB4StS9/uQ7+/OYUj4kB1MhWrGOuSUWYWNxTM2RmxYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXyQk/HB; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXyQk/HB"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso2608826d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152971; x=1789757771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XcGIBhqo1aCcytx+6pnnKO6ENTiiR8ZBI/kDvmEBRCg=;
        b=lXyQk/HB6OFvw7ngrV+iGTBf6IvB7pWi0qAB/yFJIvj4zmn7ufUu3/2EIMzFSWdSLi
         erX1R652HxEy3QbrYnFZfqfYlnSKmc8/dm0ZsIKWjv6vbPIbe6iyShs1DQxG9RROtDhW
         XKj9F6Z3XsIfuLkZpzpv5LpbvSn5hQ2xf1aBS+pAcQIsxGgMcw113rOiaDTW4S1qGq8h
         NClZiSFu34eN1t03dSGvrACBCaDskyEMebLCQfD+3ME3/Ab7Et29cwPzMQaMM85xa+k/
         QQPfOMaHSpPjFMVynteKvF6ZXU8SitmznQnl9CTJ9eWAZLjfms1gfTt/nVkSVoVKSCds
         lRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152971; x=1789757771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XcGIBhqo1aCcytx+6pnnKO6ENTiiR8ZBI/kDvmEBRCg=;
        b=DPQHqtNAiQ5xb8nkyoe+c5tfg00s96xnIJQ1v6V38Ya4/F6bIiuqXtRJaRRpcCA9S9
         srBP4ktpQnonZceOzFfFXGw45V5uvP1V1pmVzQk/sxZqtrRKs1othbB1V4ZqMniHq1Qg
         ef3cmXn/JLuDW+jEzMED1ldtnCOlOdI3iwMlcJRJkaI1E+BV70QsGSDczD8kR/nzDgAl
         nXPA04URl2pV/u2+2N2Ow0nHmu46HzPQZxg8PV8RtQC1rl6RMgcJgRCQT9dju6JMg9Yg
         kL1eGG4wXZdgICWuWt2vguifQYfcTTF797XP5zRstpk+HbHyGB8XYsQt5o9bj1CkrjpW
         h//g==
X-Gm-Message-State: AFuF++m0hh3x3lS5P4iq7Z5hiTsOIF7WPjpJQHl62cncHJ9LeoiccFHA
	TbRDi8GBmsQGR7bh553TJI/ShaKpAmLwgtVGgZdwkho+iis4QU+gbqXtnX9Kyg==
X-Gm-Gg: AYBFou2WETqqMXp4Tb92JXU7H+KFbFDCXFwDMiETPpzE+BUnx8WftPN1U3bL06/1EW6
	HLvW4I3h989kQhLnRCnzoSMJkP6pbZlQ5mtf0JILQmCKkUR1eUll2NaoBKK2QcGonDc3BirfEd1
	Jz2/HMLtrM85oUk+krr0GMBKCSsnbZ/Ep+GJFsv4pn5FimchiZsS89qTtw1TM6sfpjMuEdWzunD
	vd3en8Oo3QtgzznWuqibbz3oFy3yaahi07J3pH9/iDsAZ1H0QMPXh6B586KMsn/jpznOkV+QBtn
	2c0+KdGLOKoMPGrRf4E1mMmf9STZp/K2eDjrJW2cYtTKZAzQQWyO45ypQ/vwPQ8/D+6W3PVRPFE
	vns7Jupn2xoRrbI6BXg+MfeC1lQuysjAcJ83qCubXEGiWwGbJDEbZuMqjvaAYf1W1DRXNoHo4Mz
	f45cDa2nu91c+6Z+WZeGpeuKs68RePubPxhf5/JUVHIrv9jwFQuf5ShL6crAoycRT++NRzAtlL3
	XfYRWEe3eI9TA3qwT5+LoTVyjNIepXEQ6ZxVey6AWejedECp49vtdBNv8b33nIA
X-Received: by 2002:a05:6214:2504:b0:907:dd19:fcb3 with SMTP id 6a1803df08f44-912120f0f85mr75243426d6.24.1789152970037;
        Fri, 11 Sep 2026 11:56:10 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:09 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 05/10] rteval: Fix rteval-cmd path detection in cpuset test
Date: Fri, 11 Sep 2026 14:55:38 -0400
Message-ID: <20260911185549.604199-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911185549.604199-1-jkacur@redhat.com>
References: <20260911185549.604199-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test-cpusets.sh lives in tests/cpusets/, so the repository root is two
levels up, but the rteval-cmd detection only looked in $SCRIPT_DIR and
$SCRIPT_DIR/.. (that is, tests/). As a result "make cpuset-tests" (and
therefore "make test-all") failed with "ERROR: Cannot find rteval-cmd".

Add a check for $SCRIPT_DIR/../../rteval-cmd so the script finds
rteval-cmd at the repository root.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index e81030344250..e624086e6277 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -3,12 +3,16 @@
 
 set -e
 
-# Detect rteval-cmd location (works from root dir or local/ dir)
+# Detect rteval-cmd location. This script lives in tests/cpusets/, so the
+# repository root is two levels up, but also handle being run from the repo
+# root or an adjacent directory.
 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 if [ -x "$SCRIPT_DIR/rteval-cmd" ]; then
     RTEVAL_CMD="$SCRIPT_DIR/rteval-cmd"
 elif [ -x "$SCRIPT_DIR/../rteval-cmd" ]; then
     RTEVAL_CMD="$SCRIPT_DIR/../rteval-cmd"
+elif [ -x "$SCRIPT_DIR/../../rteval-cmd" ]; then
+    RTEVAL_CMD="$SCRIPT_DIR/../../rteval-cmd"
 else
     echo "ERROR: Cannot find rteval-cmd"
     exit 1
-- 
2.55.0

