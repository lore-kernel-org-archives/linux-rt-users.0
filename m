Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD82253EE
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667898; cv=none; b=lz01voSbYNlLKxhZy+PmBbXzyXCyoG0nGutoUFewHfdnpmK6vQ5QmHj2GkaZyd90jR+NilA+KqKnbXfqhslulN4ogtjxsfkxAaThg+WHKjKXD9vewe7Gc/D96Y1W+ODhsxx/tUcSqAO+vxEpTTSc970YAvIrZJsf7AUM6KFWydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667898; c=relaxed/simple;
	bh=RcVRdqUTGNEtE5DEq8E5jrZaaXij7IPYLUcaeKPvK5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=UEDCIa6wzfk2FzhEMerweylLH3/wmXZXWTGatLDy1OcZHO4xW1zYVQj1HsOi9jPcCv+g6ewQi+QTQ8dsnL1a6CiOgz2O/BAZAWEi+kiOBpgKWmAI9rRpTmgXXmT3bMoITOf/7PEdX2PAQFfU+mgcWTuFAxd5CeYt9aaqNftWzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmZ+Dcj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmZ+Dcj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F39C4CEF1;
	Fri, 17 Oct 2025 02:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667897;
	bh=RcVRdqUTGNEtE5DEq8E5jrZaaXij7IPYLUcaeKPvK5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TmZ+Dcj03gr1vSDqyT95OQAKLZoT/cEowHEKYiWr4p2j6S7tHkg61xEuK1X+pPk4V
	 5vWE1jX7IY7peAk5cQzynCKdahZ3lP5FWmQMh5D1Ik/yEiKwqrNq25ZlgphNCf0fqR
	 2vASlKZtvq8gsgZ/9PIFvgERL7mCSeHYahYdbcKvlnDoJA9M5u8I7/u4Jz5c3gsJLD
	 UvzCLx1FB9ntAlU80bnrMA8N6pcdWFALAwJgJsDmdnO5WPVUAkFuuTRJenETh8jYku
	 s/MbOWUgNyiGJNVyvg8Oz9FC+ZCGhyaoeMgl9ZrMprlk4QxyUNj6HHUzFzjpG3Wafj
	 HpuBeiYyxwgew==
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
Subject: [PATCH 08/12] stalld: Add -N/--no_idle_detect flag to disable idle detection
Date: Thu, 16 Oct 2025 21:24:40 -0500
Message-ID: <20251017022444.118802-8-clrkwllms@kernel.org>
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

Idle detection is an optimization that skips parsing CPUs that have
increasing idle time. However, this causes issues in controlled test
environments where the starvation generator may not prevent CPUs from
appearing idle.

The new flag allows disabling this optimization for:
- Testing scenarios where CPUs need to be monitored regardless of idle state
- Debugging starvation detection issues
- Ensuring all CPUs are always checked

Usage: stalld -N or --no_idle_detect

Implementation:
- Added -N option to getopt_long short options
- Added no_idle_detect to long_options array
- Sets config_idle_detection = 0 when specified
- Added help text: "disable idle CPU detection optimization (for testing)"

The config_idle_detection variable already exists and is checked
throughout the code, so no other changes are needed.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/utils.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/utils.c b/src/utils.c
index 91c99c0a1270..8f1fe9266db9 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -767,6 +767,7 @@ static void print_usage(void)
 		"                               starving_threshold time, dispatch a specialized thread to monitor",
 		"                               it.",
 		"	   -O/--power_mode: works as a single threaded tool. Saves CPU, but loses precision.",
+		"	   -N/--no_idle_detect: disable idle CPU detection optimization (for testing)",
 		"	   -g/--granularity: set the granularity at which stalld checks for starving threads",
 		"	   -R/--reservation: percentage of CPU time reserved to stalld using SCHED_DEADLINE.",
 		"	   -a/--affinity: limit stalld's affinity",
@@ -996,6 +997,7 @@ int parse_args(int argc, char **argv)
 			{"aggressive_mode",	no_argument,	   0, 'A'},
 			{"power_mode",		no_argument,	   0, 'O'},
 			{"adaptive_mode",	no_argument,	   0, 'M'},
+			{"no_idle_detect",	no_argument,	   0, 'N'},
 			{"help",		no_argument,	   0, 'h'},
 			{"boost_period",	required_argument, 0, 'p'},
 			{"boost_runtime",	required_argument, 0, 'r'},
@@ -1017,7 +1019,7 @@ int parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "lvkfAOMhsp:r:d:t:c:FVSg:i:I:R:b:a:",
+		c = getopt_long(argc, argv, "lvkfAOMNhsp:r:d:t:c:FVSg:i:I:R:b:a:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -1138,6 +1140,10 @@ int parse_args(int argc, char **argv)
 			config_single_threaded = 0;
 			config_aggressive = 0;
 			break;
+		case 'N':
+			config_idle_detection = 0;
+			log_msg("idle detection disabled\n");
+			break;
 		case 'R':
 			config_reservation = get_long_from_str(optarg);
 			if (config_reservation < 10 || config_reservation > 90)
-- 
2.51.0

