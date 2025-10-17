Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA623A58E
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667899; cv=none; b=sa55a9dsNqRzUfOSxIRx0U2HOpkC0tPY5gDQ9qf/ketL8QG8WyLH3AN5vc+m0kumNcpXkP+tRMo/0vblyzyIOGf2u+8646AmcJw4TUzRB90qWt+RfJZ+9J8jjOZ56yKp++A01yilJQG1RIKVpNOD+4VIxrKC5QiVpFOOppHAqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667899; c=relaxed/simple;
	bh=OodlZ7Bmxn1+lMlsSJu8/2aglAFHdSIgQJJsHJY2aN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=EKcru2wrjpZ92KO414PDwUdjgfO12l8ZWcyRZuUd/w9zr5blcEyLHDq1efKaxwKOUBXIHHZLly18n5vZcFXYLIKVvts6WniHzuJLQRh4totEWb7+10k23wHlRw8rjOZAnY5Js2r6cRa6z8+0tM9rKdOpeyoT7FHAIIeaKaAWRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghaQ1+j1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghaQ1+j1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FFFC4CEF1;
	Fri, 17 Oct 2025 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667899;
	bh=OodlZ7Bmxn1+lMlsSJu8/2aglAFHdSIgQJJsHJY2aN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghaQ1+j1m/uj/UBYQfVwuwwC0IIds0yZhRR7nICX7KnKI0XhcWDjnRIltqff1+69I
	 8xGr7UPqPIdfT0ZtX8TQgspULPK1JPmyGPeWH3CRXHB5lZkOVIW28xjCBt5I300UmO
	 zD+0Y4ICCTh9TPKJZK996FPWBz2y/nfIcQc8L20Xh9H1OPv+fcu/mFEBDwCCI9qeGL
	 eqfIo3HZB5KMtJ3NJ48MnQZQIlu1xqOF4hlp5wlmi8wc6mtOPpJInKpsFgln+Z8JzN
	 B2rXLJ1ZeGeuPfhdfQhXtNxHGefAy6RScfb9RzCv3YNLC7ecpcUAhXQzd3pcyQMipx
	 fPxosyRjgFCpQ==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Claude <noreply@anthropic.com>,
	Clark Williams <clrkwllms@kernel.org>,
	wander@redhat.com,
	debarbos@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 09/12] stalld: Add defensive checks in print_boosted_info
Date: Thu, 16 Oct 2025 21:24:41 -0500
Message-ID: <20251017022444.118802-9-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Clark Williams <williams@redhat.com>

This adds validation and bounds checking in print_boosted_info() to
prevent segmentation faults when boosting tasks in FIFO mode.

Changes:
- Add NULL check for 'type' parameter
- Handle fill_process_comm() failures gracefully with fallback
- Validate cpu->id is within valid range before dereferencing
- Provide informative error messages for invalid states

Issue: Test results show stalld crashes with SIGSEGV when using -F
(force FIFO) flag in aggressive mode (-A). The crash occurs during
or immediately after the first boost attempt.

This is a partial fix that adds defensive programming. Further
investigation needed to identify the root cause of the crashes
in FIFO boosting mode.

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/stalld.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index ebca23105ce9..466b6db15668 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -435,10 +435,21 @@ void print_boosted_info(int tgid, int pid, struct cpu_info *cpu, char *type)
 {
 	char comm[COMM_SIZE];
 
-	fill_process_comm(tgid, pid, comm, COMM_SIZE);
+	/* Validate inputs to prevent crashes */
+	if (!type) {
+		warn("print_boosted_info called with NULL type\n");
+		return;
+	}
+
+	if (fill_process_comm(tgid, pid, comm, COMM_SIZE) != 0) {
+		/* If we can't get the comm, use a placeholder */
+		snprintf(comm, COMM_SIZE, "<unknown>");
+	}
 
-	if (cpu)
+	if (cpu && cpu->id >= 0 && cpu->id < config_nr_cpus)
 		log_msg("boosted pid %d (%s) (cpu %d) using %s\n", pid, comm, cpu->id, type);
+	else if (cpu)
+		log_msg("boosted pid %d (%s) (cpu <invalid>) using %s\n", pid, comm, type);
 	else
 		log_msg("boosted pid %d (%s) using %s\n", pid, comm, type);
 }
-- 
2.51.0

