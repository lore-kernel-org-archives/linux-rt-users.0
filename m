Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC557201004
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667894; cv=none; b=hiGKzd1GYvb9eNSpcWXjjwuNdK5w816gFeLM3MyHzYmM6uy8wFyjZDl1JJWhwCvCplKM03vItp6gzC2H7szi2WO0YA+BNfHVZqdAJTogACGEovMta8pbg571oasg+8DRiCXEsoZUGBskZkS41CCVDMfKuJOU58bvjra8JTNnZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667894; c=relaxed/simple;
	bh=IqBw0Gl/60xEDTPKoN/HbSJ7VzcGNqzo8UlSMOVoYW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=VbkYeXw4OBLTLqYpEdMS1rthSEMqzruBWLxUqLp0rlQv/8RI5oKqZxQeaUJ0ycMkhjcwNwYT/Xen/rO5NjD+2FKS30GNLIRdfvqmmbnOyIe1yzQKhEgBLOWaoGk8jCELmi72JG1eOwtv+H8ZQz3q4w2wPKt1Q9R+uUStqRB7s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4svEatt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4svEatt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F734C4CEF1;
	Fri, 17 Oct 2025 02:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667894;
	bh=IqBw0Gl/60xEDTPKoN/HbSJ7VzcGNqzo8UlSMOVoYW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4svEatt2vwuktm+flycQ6ulGnUoYS4/T1d4PIssf1pllkv0MDuzqRTGmFsQTB/Oq
	 dcjia4V5IZL/pX4TyLN11Gyjon29NBByBaq7mnhthMk4eLoDOLZJ6gpGKuXWb49GBD
	 quCczBzt7tcqwB9xctsZX8dQItBW49Gg61Bq9tUGSFxUAEHwjPEdIlqe6x8yX4ghY+
	 gntz0mN2z1I+AGTjrH5Eg4JNkCoHqAJui4dlW2aIVFsNxTckps/ebrhCR+6hrC5DgU
	 zhj6YqcVp7rPZ6BgtxBba6Rf2MKxnqTNO/GDsDIxJMzfYquVnEhtTanmpcUsVseNlw
	 63mLiVSq6zaoA==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	wander@redhat.com,
	debarbos@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 06/12] stalld.c: get rid of misleading print about DL-Server
Date: Thu, 16 Oct 2025 21:24:38 -0500
Message-ID: <20251017022444.118802-6-clrkwllms@kernel.org>
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

Get rid of the assertion that stalld was forced into log-only mode

Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/stalld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/stalld.c b/src/stalld.c
index 6cd4bf68d04a..6adc3e9a8cea 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -1149,7 +1149,7 @@ int main(int argc, char **argv)
 		set_cpu_affinity(config_affinity_cpus);
 
 	if (!check_dl_server_dir_exists())
-		log_msg("DL-server detected. Operating in log-only mode.\n");
+		log_msg("DL-server detected.\n");
 
 	/*
 	 * Check RT throttling:
-- 
2.51.0

