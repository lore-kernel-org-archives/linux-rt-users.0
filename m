Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505B23C8AE
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667904; cv=none; b=Q4IxscuHq1HeYR3siG2ofPPC5SGhbF1UmiMWd/Fesb0wnBGf4p014p42mm9C4exhHe9USPKQJGfXFDx2cilVA/mdxmctOusaLlCtYlNca9pYjcgG7jtD6MILDUIsxgCqo6Tlbfy98arESgWe4f3SgQsN82KAKR/YZRfURO9NJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667904; c=relaxed/simple;
	bh=5VIeRBMB3Hva4TW2XSe4Xfje1SzuhiEncV3VzzNSTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=ZR1r5PpkBfso6FDb0kARkTfYpKdWQpIvsDfw5Go4qY+7DZlepIQOfDA3EdDJ+22+BTaCE3zDH0q1FBoWLPFHrOt2Z7aebohDABwsoUvd+qie9ddoOGkREa5fSPvastl34q674f+CqibKTfESfIsGpP8/MZKJ+goZQwzK53Sw6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkT5Jrup; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkT5Jrup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25BDC4CEF1;
	Fri, 17 Oct 2025 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667904;
	bh=5VIeRBMB3Hva4TW2XSe4Xfje1SzuhiEncV3VzzNSTuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkT5JrupViapPo5pueZ+lbzosREAFs/U9KdrgIPZNJdabH5vHF7skCRgHEHW4wDLt
	 LJUIZ8w6Gs7sphDSbgkZ0BHwTUP2UjY4MRbvAWEU3hXacK+Q9xQgEa13urtRnObJZW
	 Lu67Q4oV6lUwUlPL1UGo09u9EEFzAfXMixSZeYdqJtwF1P80rWAOv0y3XnNB/ZhSfz
	 Z1tw6GiRAqmx7d7TkaJdOUxYAxHN+ao0740hE/Wl91MBCPyny/HrVoOe35N6sZuBDx
	 xEijbrTDuR4SkCBp+CK5CKF0aQPtuViIeH99vvUiVnLGNT00dmnjm8bZh+uPl7ce8I
	 P+HX/Fvr1cG5A==
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
Subject: [PATCH 12/12] Fix segfault in adaptive/aggressive modes
Date: Thu, 16 Oct 2025 21:24:44 -0500
Message-ID: <20251017022444.118802-12-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Clark Williams <williams@redhat.com>

The merge_taks_info() function was unconditionally calling
update_cpu_starving_vector() at line 389, but cpu_starving_vector
is only allocated in single_threaded_main() (line 1007). This caused
segmentation faults when running in adaptive or aggressive threading
modes.

The fix guards both update_cpu_starving_vector() calls with
config_single_threaded checks, since this vector is only used
in single-threaded/power mode.

Root cause: cpu_starving_vector is a global array used exclusively
by single-threaded mode to track one starving task per CPU. The
merge_taks_info() function is called by both backends during parsing,
regardless of threading mode. In adaptive/aggressive modes, the
vector remains NULL, causing crashes when accessed.

Crash backtrace:
  conservative_main() → get_cpu_and_parse() → sched_debug_parse() →
  merge_taks_info() → update_cpu_starving_vector() → SEGFAULT at
  line 362: if (cpu_info->pid)

This fix allows test_starvation_threshold.sh to pass on sched_debug
backend with adaptive mode (-M flag).

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/stalld.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/stalld.c b/src/stalld.c
index 305618e577fc..130a7d4eaf9d 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -386,7 +386,8 @@ void merge_taks_info(int cpu, struct task_info *old_tasks, int nr_old, struct ta
 	int i;
 	int j;
 
-	update_cpu_starving_vector(cpu, &notask);
+	if (config_single_threaded)
+		update_cpu_starving_vector(cpu, &notask);
 
 	for (i = 0; i < nr_old; i++) {
 		old_task = &old_tasks[i];
-- 
2.51.0

