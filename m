Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A004201004
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667893; cv=none; b=cYsm3ruoNjn3fzh0v5T2E0hmlxrodmw04YOaSFFAW68udEAV6f9fUZ7gjYdhQ5Lqbef1p4OHmAnr20clFapF73m6cIR+YgSY2+fngrgcKRaPMGLB1fjaWRJh/rpLb+IGnJvWh7kXvUDz/QXp+cUamVo1kP/6wMXt1DerzoXHPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667893; c=relaxed/simple;
	bh=7889+de/ICaAA5Ndia2neQzn/OCZMdaRet4Y4E+qx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=RNSQPQXVEr7fvjC8XtDDMh1k+aYWI7TnX7L+mW/NR8hFLi7wL10GGwerxtgruLVUvvDwwGubdkzPdzGuVDBO2IOQneLgeAWMs//OeUVTKehjZ2P3iRVNOdNdRvY8jUZ14A9zOpNG+IvRphJu+zuWXYsa4RJD8JjvJIm9mVgnPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfpku9T/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfpku9T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C3AC4CEF1;
	Fri, 17 Oct 2025 02:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667892;
	bh=7889+de/ICaAA5Ndia2neQzn/OCZMdaRet4Y4E+qx2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hfpku9T/6LDIiO68HLjtEafTXC6JTXReJCCmQ2KF6oBpqeYHRKXMtDzM3xEnh2Rna
	 MiE78N4IjTwiemTfAd9sLccHJaCdpMrtve1D4D0+z3WxqsCZ4smWr4b+DLjBbY4LUY
	 C6jd5kIiBa0iQyfyI95nSyAhrJ0vAVFhlUzGiWhTKOvEY932xg6s39Q6zWHkVt4uTB
	 YFnxXEQ1D0JDxZY+khBmgDDTMozUxy0ndeej8TvPzEmj+gbH4SIpVPl/FQAR8fOBgD
	 6YkzL4KR2KdnO75DBmizrDFyURrwycupL4pnUczDUYk4xEIYR+3GmtikVbhGyIVUe3
	 5W9uLX8GrW0Bw==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	wander@redhat.com,
	debarbos@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 05/12] stalld.c: initialize cpu_info->idle_time to be -1
Date: Thu, 16 Oct 2025 21:24:37 -0500
Message-ID: <20251017022444.118802-5-clrkwllms@kernel.org>
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

Initialize the idle_time value of a cpu_info structure to be -1 so
that it will be presumed busy for the first time through the loop,
which will force an initial check of the run queues.

Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/stalld.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/stalld.c b/src/stalld.c
index e8c927750ee0..6cd4bf68d04a 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -293,6 +293,15 @@ int get_cpu_busy_list(struct cpu_info *cpus, int nr_cpus, char *busy_cpu_list)
 		 * log_verbose ("\t cpu %d had %ld idle time, and now has %ld\n",
 		 *	     cpu->id, cpu->idle_time, idle_time);
 		 */
+
+		/* If this is the first check (idle_time was -1), assume busy to be safe */
+		if (cpu->idle_time == -1) {
+			cpu->idle_time = idle_time;
+			busy_cpu_list[i] = 1;
+			busy_count++;
+			continue;
+		}
+
 		/* If the idle time did not change, the CPU is busy. */
 		if (cpu->idle_time == idle_time) {
 			busy_cpu_list[i] = 1;
@@ -1168,6 +1177,7 @@ int main(int argc, char **argv)
 	for (i = 0; i < config_nr_cpus; i++) {
 		cpus[i].buffer = allocate_memory(1, config_buffer_size);
 		cpus[i].buffer_size = config_buffer_size;
+		cpus[i].idle_time = -1;  /* Initialize to -1 so first check doesn't skip busy CPUs */
 	}
 
 	if (config_log_syslog)
-- 
2.51.0

