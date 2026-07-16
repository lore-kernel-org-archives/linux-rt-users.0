Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E743030C
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784229041; cv=none; b=jWM9gLpUp0EqQ1e9HJDW79Qwf2xkOIbUxySxpF5AV0+SjO6rX0JXhJqs92IunBwpOsenr87O9GWqE+PytDR+bZtCkRCg4qjf5XqBVUfUeQzK02CR7wGc4BqAEVVcqUgnCHmnS/1HTloXQKFonitxTG7JZ5ERq6uZ4drHkNzQeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784229041; c=relaxed/simple;
	bh=WYxKMEKlXG3pGKgIh5l4+YYcUsx2qnFAZSpFmg1v33U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tci4LqOQ+7N1fZKLFnK9YSabhNdImcrdQQTRb03bBBwxENwPcGIPBMv8fYMFQapaETJRIPI3BlicPieJGNLjOE+fOHT7RX21qNa9ZZNFx5CU2y4Nu2dauLi6L9QnobD1CtjDukqy8iJsArPPBPvO12oytMsuqtSXK9S+OsJzsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0NHUgaf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0NHUgaf"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfa429aa6so4104031cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784229039; x=1784833839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J7TKsQe90r+dYmKVl+b7x0OQYOPGOucxJ+q8uzmS1CM=;
        b=e0NHUgafaR1O6rGly4yFdaPgUgB0liPzTuK4X7RfRJdR6PZndFCVFqwZck2oa6F3Tk
         RjOWXjFpAreE4H4dttQ1PVDaWsDunj4ZpkgJOWlvq7sgD9Oy7wCaDuppvBFDhQnov8dV
         ecfDnL3YUeFb1KjMyDi05/gX4eAO5kL8YG+YMlB4ilBBeftypsbnL+hTAv6edS9txP+X
         0hFJIz2hvNhMk7H9LAxyOnI802wJQxxETmhAf+0dgplC07Hhm9y0syx7XakkQQHSO3Qe
         EerY6PpJL2MtzKOQ2tXo6N1n7rf3kv+WV+ERpgiVb6d/Rf7cApHiy4mgYLQrM6RoukvA
         3rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784229039; x=1784833839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7TKsQe90r+dYmKVl+b7x0OQYOPGOucxJ+q8uzmS1CM=;
        b=glwNGPy7LrFRQ1PsUUQzpCshqB7/zpmjEOdWoQeQj4TDCZPiEUsPDghNpNm9ho7MZN
         l6UX9Pwd3XmMh4YVP4zyLRdR8Gc4VTgNjl28H+hYWiL4P2oPbOf7v3H8BGkLBShh5Vyy
         g1JRYIG3OfVuAVQIQALZXimmHtCbblKu6r3FF8fnZU4IL0EPeo7wfvjxd6QaSmJLbpv4
         5gOsN82B3gNCHQDsgknJYLv2xilBSYorj7AES7N9ZmPDkRWUgR6nc1MqwuVitIviZxYq
         OVEltIPKfY0W27ifD9WAW24ZFWPkZOc+nZeBU/dMNcqJD7DnqU/s6XfEXrapxJIQXHsU
         C/pg==
X-Gm-Message-State: AOJu0Yw1IIMgMsphgWbZqLizxuxOUPKXB2mb+C5GGQe4TrIZseWqfETW
	XgjposAZ4DLIC+O+0dnU2kVeHgUnQ1ya7N6HjlBthFbBrhI0bfi1Fy0jDEgI2Q==
X-Gm-Gg: AfdE7cme/Vz2C4kj2quqNerMEMJ808fAo156EQg3cIMQC8QKu6rfo1k91tYzLw4s3Ji
	jiTm3tc86XdlfNzbl7QfWtt/xzTtXmLQVX+VZk2+iNlzUgaBR/6ZXc8mrRjG/IslhG9BQ27p2KW
	5rv7C5y5auWqABBhqkZ6aq4KhEuCMwH5n48TuYguOeaxfV0vJqm1WqhkusgVC5hsxIEeaC60cY8
	OkVliRO3kRRp8uugzceU0RNaofVKLeXFz6DUR17HlLJCFI1qk1+HIk+XBq1XtX0rcQmwT7/eSov
	fDa2Q66AtA83tsO8DPJiLOyhcwoWP1L/j7nV9PzSduzrQuTTlXZ/wMPbXdE3JLzDmrWeRpxePEO
	zr4Tq5FgPQU/UhcpSjTH6XjIs5DpbEVz8awkOFIhfqJbSLpjcSP6Z7mg4DhlV3jLmuTi9SmtfO6
	FimEYU+8HiLua1YSMAO1AQy7FSSncca1a0rxBZQHjgGopNygw6uXfXxsqfrivRKrZxNRh+fx6jP
	jt5+Y6y0/hf0rebTYalAEslkCFDIaKJEottYIbYeqrlYbrO2GzaED2jOYvF
X-Received: by 2002:a05:622a:1650:b0:51c:4f35:81b8 with SMTP id d75a77b69052e-51fbf2b69bemr39474471cf.7.1784229038706;
        Thu, 16 Jul 2026 12:10:38 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm158236771cf.4.2026.07.16.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 12:10:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 3/3] tests: Update cpuset_destroy test calls for new parameter name
Date: Thu, 16 Jul 2026 15:10:28 -0400
Message-ID: <20260716191028.152934-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716191028.152934-1-jkacur@redhat.com>
References: <20260716191028.152934-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update test calls to use 'names=' parameter instead of 'name=' to match
the function signature change in cpuset_destroy(). The function was changed
to accept a list of names (names=[...]) instead of a single optional name
(name='...') to support destroying multiple cpusets in one command.

Changed three test functions:
- test_destroy_single_cpuset: name='...' -> names=['...']
- test_destroy_by_pattern: name=None -> names=None
- test_destroy_default_skips_empty: name=None -> names=None

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpuset_cli.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index 619c719094ac..15de63e769aa 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -300,7 +300,7 @@ class TestCpusetDestroyCLI(unittest.TestCase):
         self.assertTrue(os.path.exists(path))
 
         # Destroy it (without force, no tasks)
-        cpuset_destroy(name='test_destroy_single', pattern=None, force=False,
+        cpuset_destroy(names=['test_destroy_single'], pattern=None, force=False,
                        include_empty=True, recursive=True)
 
         # Should be gone
@@ -317,7 +317,7 @@ class TestCpusetDestroyCLI(unittest.TestCase):
         self.created_cpusets.extend(['test_destroy_bulk_1', 'test_destroy_bulk_2'])
 
         # Destroy by pattern
-        cpuset_destroy(name=None, pattern='test_destroy_bulk_*', force=True,
+        cpuset_destroy(names=None, pattern='test_destroy_bulk_*', force=True,
                        include_empty=True, recursive=False)
 
         # Should be gone
@@ -339,7 +339,7 @@ class TestCpusetDestroyCLI(unittest.TestCase):
         self.created_cpusets.append('test_destroy_empty')
 
         # Destroy with default (include_empty=False, which skips empty)
-        cpuset_destroy(name=None, pattern='test_destroy_*', force=True,
+        cpuset_destroy(names=None, pattern='test_destroy_*', force=True,
                        include_empty=False, recursive=False)
 
         # Non-empty should be destroyed
-- 
2.55.0

