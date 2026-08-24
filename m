Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94C3E4C72
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2026 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566785; cv=none; b=mCNThJXngNLEIbgDgy3GNz0OuGIz0WkGX+oNJT/PS1sH3dq8Zx85E0xuWglQaxiNmg2YLRh3WJb35t0sJ+dtNjxPVKLkxQdcoaS9KW8+VbanxE+Cl9Y1y3DRTGqs5EG3NylK4igB+Hlkqv4yTKQq4k+THxsykvfjDcsjw32gv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566785; c=relaxed/simple;
	bh=BBJ/hrareb1n3p1wxAFG5IER59L0VBpRZZdkoKjTUuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnYyBTsxS1viSdrI9WvUbjvCYn0CTBdev/yCYeuhpv/8EKpyYijF61xR18k5IuID3p1eAmI+9OGFcy22qlMv7V776oIeun4xgcbsHjTP3Gt8d1zfewOUSVsCHe9OJHog85MfMJH/89dFuVdAobKMvAnkXQhp2pWwQFXxAyrOHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgKoQLN+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng5LLWD1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgKoQLN+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng5LLWD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787566782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xOETYnLn6DXwoJl+Ub/sKnLF7uvMM3vh37KzUDXSZvQ=;
	b=PgKoQLN+eOni8g1afgZCzJLaBzE1YMfPiv4Ovs2C8WNmsJ1IqYFTkbB55Ri9F6kFT6g4nQ
	BAmqPMoO07hEohMRpPALb1j4caeLTFnLYUvnG9fgM7+aDqk6o0pHZ7es8f59uFo9x5hGwZ
	3Q4B9+E++Tra9Ncona1j8kp3kxillc4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-_AsLP0XTNBa4MWohdZF4bA-1; Mon, 24 Aug 2026 06:19:16 -0400
X-MC-Unique: _AsLP0XTNBa4MWohdZF4bA-1
X-Mimecast-MFC-AGG-ID: _AsLP0XTNBa4MWohdZF4bA_1787566755
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-698a99b6140so3327824a12.1
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2026 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787566755; x=1788171555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xOETYnLn6DXwoJl+Ub/sKnLF7uvMM3vh37KzUDXSZvQ=;
        b=Ng5LLWD10wCcOu2QGkyQxpdSUm3u+0MdI9ZvnEfZeuP3TNXNZgGhc1UNuPzfEthdOB
         luUP2ygc5AsQhqP07AHB424p5KJjtvsoUc+73KVF3lAyIOY7dZJXzjqtwwcGNzsf88ed
         6fRi+HJGmz+OlN9xpgG8yGgRPailmSep/VruRZS+nWtNnbp27bB7TElgp/MF3aRmLWR/
         9Ineun88OiKYS3mTxp+b6WaQDwwxNou5HyAXeM6i53VUPz0VC3E1UcZ5qTnJUL7fyzHs
         p8HcUQbISxz4b7wcTJ76XWvDPQZkJfhFyyBW3w9MW2VfNXCF1/aSyeAe35CZZqateADc
         Qydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566755; x=1788171555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xOETYnLn6DXwoJl+Ub/sKnLF7uvMM3vh37KzUDXSZvQ=;
        b=GB5GL8Fj+xFEf6soByahCQdK4RT2JpUIDbO08FYpAkPVg2TGS1JGdCTRIlmRqCycpc
         d/gRgHI6jJ0rBSZk9ZnYOJCGPv5SrVF5VBcMOkpbmVfclpP4n/UH4wWGq1LVXTSq0HfV
         aHx/4AR9qZt8GBeCIVOt12qAxc9qkBAjuEzTP6UnJUmiwJZzhY5qrhDpwC34NE1QQrPy
         idxYXixv73RhuIWBgVYyxH5kgyZ4q5sLuFTjPAHn9T0Kgmkt+wpRRgwbjoMJ1vNJqwMO
         056k6duKDW053n8vxAlq67vnhJDXTTND/iANYCBnsAmO/wrprRVrByuZvN3vaAGnJ3uk
         sd8w==
X-Gm-Message-State: AFuF++kKDJxWJI26QHBCfq3vGueycA10N8pgShNcZx+xTsBPuV4+6Vf+
	kxptCEhX0C/OzKwE8e2Up4q9flrbKqlotbC/ITH19XO1rGw8+8qzMgYSim640pW9AlE+1LutVdF
	Qa7evV4gZL5FYaaj5DErZFGbVlkW7fqgN7uOVcZezDdRnvi6weMLhjC6wJgzONtesUxU/
X-Gm-Gg: AR+sD12h1VmVq0RNxqHahpHtSCDCP4bLPQhYyKdDtc9zFZzAhhVhbslcG2OaQ1T4Lmv
	Fnif3q5KDqUJP+VwpddyoQzld8GrIdEscJ5pje5qKHIj56zjw/g80XXtlUqiV9gGYee20Y/cL9H
	RPjLYFD3gkpOuyyKuDucnlyj2H3rzf6l5DJqI4BMv5FguYMox8HmtVMVelaFpANQPkiqF27csWE
	m1B/ZPTH00s0Pr7auC0E2BxuUKwDcX1iWFS0TtwwTq7YXlEoWezbws10mOeWK1TAc0aHgQ6DPge
	uxhGVTAk/Npq3sSppuXfJeNbGX5jsuPkg86ggeZj6FV45G65V7OX77P9rlVf5mkCS5Gp4eT2DCW
	d2OirhKbR0PPZH3JHrO0rwQmJfunlhtLfZuhYtw==
X-Received: by 2002:a05:6402:3647:b0:6a5:7aad:e75c with SMTP id 4fb4d7f45d1cf-6a57aade7fdmr17244973a12.6.1787566755349;
        Mon, 24 Aug 2026 03:19:15 -0700 (PDT)
X-Received: by 2002:a05:6402:3647:b0:6a5:7aad:e75c with SMTP id 4fb4d7f45d1cf-6a57aade7fdmr17244945a12.6.1787566754877;
        Mon, 24 Aug 2026 03:19:14 -0700 (PDT)
Received: from cshulyup-thinkpadp1gen3.raanaii.csb ([2a00:a041:e223:1b00:cde9:6812:f4a4:646])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5ba19e053sm1425209a12.12.2026.08.24.03.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:19:14 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh=20=28Schneider=20Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v3] clictest, cyclicdeadline: Exit with failure when breaktrace threshold is exceeded
Date: Mon, 24 Aug 2026 13:18:52 +0300
Message-ID: <20260824101852.2237494-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cyclictest and cyclicdeadline always exit 0 even when the latency
threshold set by --breaktrace is exceeded, requiring test harnesses
to parse output or json to detect a failed test.

Set ret to 2 when break_thread_id is set, indicating the breaktrace
threshold was hit.  The exit code enables shell expressions like
"cyclictest ... && echo PASS" and seamless integration with testing
frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
JSON output reflects the failure.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v3:
- return 2 on failure
- reword error descriptions in manpages
v2:
- refine subject
- "Assisted-by" already conforms format AGENT_NAME:MODEL_VERSION
- add sob
---
 src/cyclictest/cyclictest.8         | 11 +++++++++++
 src/cyclictest/cyclictest.c         |  1 +
 src/sched_deadline/cyclicdeadline.8 | 11 +++++++++++
 src/sched_deadline/cyclicdeadline.c |  7 +++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index fc6121aa4d47..c52e09cbd73c 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -311,6 +311,17 @@ in mind, below cyclictest example invocation can provide a good start:
    --histfile=output.txt
 .fi
 .
+.SH "Exit status"
+.TP
+.B 0
+Success - breaktrace latency was not exceeded.
+.TP
+.B 1
+Error or invalid argument.
+.TP
+.B 2
+Test failure - breaktrace latency is exceeded.
+.
 .SH "See also"
 .MR numa 3 ,
 .MR numactl 8 ,
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 71cf5cb25c22..032b3e411afc 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2337,6 +2337,7 @@ int main(int argc, char **argv)
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+			ret = 2;
 		}
 	}
 
diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index bfc6327c51da..39b5d422a452 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -58,6 +58,17 @@ Send break trace command when latency > USEC
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
 .br
+.SH "Exit status"
+.TP
+.B 0
+Success - breaktrace latency was not exceeded.
+.TP
+.B 1
+Error or invalid argument.
+.TP
+.B 2
+Test failure - breaktrace latency is exceeded.
+.
 .SH AUTHOR
 cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
 .PP
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 0c6c96976010..b0f84c22247e 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1315,10 +1315,13 @@ int main(int argc, char **argv)
 
 	loop(sched_data, nr_threads);
 
+	ret = EXIT_SUCCESS;
+
 	if (tracelimit) {
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+			ret = 2;
 		}
 	}
 
@@ -1334,7 +1337,7 @@ int main(int argc, char **argv)
 	}
 
 	if (strlen(jsonfile) != 0)
-		rt_write_json(jsonfile, 0, write_stats, sched_data);
+		rt_write_json(jsonfile, ret, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
@@ -1344,5 +1347,5 @@ int main(int argc, char **argv)
 		fclose(histfile);
 	hset_destroy(&hset);
 
-	return 0;
+	return ret;
 }
-- 
2.55.0

