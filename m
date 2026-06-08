Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF803E2AD5
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943662; cv=none; b=i8O/6TZpUeLgYyo6nSVkSII306H+sMwILgbkm0P1hFN+Ysxk/AoTwcHlLkem5t55E79tcL9kwIAzpCXNII9JdyuPTfvPHCDD2Cs+96jXCoiMUorCZ9ZmgntpOWsaBJUVCssFLCXVZYcEpQga9aAe2rk/nHvuT6exTcuhogFNqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943662; c=relaxed/simple;
	bh=xjEQ29/TKU7TZ28KACW+OUu9BZ//J3oHv6hoNbFSxLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LS0zbQRgHrJmrKKWsrAc+UTEbtkPwGp5PBcwUKfeLP/3TbSmwMwtrdJ08twobEom8JFHN2icXrI1OESEWoiPt7rdoKxG7W+e6IyglK1hSGQzqHuaJVm1MrD/NYiLO/PZZJ3e8SL7UlcYr4CtdUesFYv09Di9dUqC3b+0+WtXCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exKli1Qg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exKli1Qg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1UJVGHUsBynuMlW5oSBucSbYzgyALc99WGOrxz1KJc=;
	b=exKli1QgjwBARx6CM9f9J2cEVLjNajMx42M/ag3bWw5RTw03XfxjY6eOC+gA1/9UA7WWZK
	90aZAIpUjPdFWR00mPQlHTEU9sIzGB4YSyHyaurKehdZSwTjUz3yTALFJiH2erngnwLNMy
	ke1bXAuunpyTVZyhrXS6H2GTwVTYIv0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-pd-PxeRSNE-ESasr3oZnJw-1; Mon,
 08 Jun 2026 14:34:12 -0400
X-MC-Unique: pd-PxeRSNE-ESasr3oZnJw-1
X-Mimecast-MFC-AGG-ID: pd-PxeRSNE-ESasr3oZnJw_1780943651
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EA31195DE17;
	Mon,  8 Jun 2026 18:34:11 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A5DD36927;
	Mon,  8 Jun 2026 18:34:08 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 43/52] stalld: remove async-signal-unsafe calls from signal handler
Date: Mon,  8 Jun 2026 15:31:53 -0300
Message-ID: <20260608183206.140526-44-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The inthandler signal handler calls log_msg(), which internally uses
fprintf, vsnprintf, and syslog. None of these functions are
async-signal-safe, so if a signal arrives while the main program holds
a libc internal lock the handler deadlocks trying to acquire the same
lock.

Remove the log_msg() call and let the handler only set the running
flag. Change running from int to volatile sig_atomic_t as required by
POSIX for variables shared between signal handlers and normal program
flow. Move the shutdown message to main() so it is emitted from a
safe context after the main loop exits.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c | 4 +++-
 src/stalld.h | 3 ++-
 src/utils.c  | 1 -
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index feb0099..a9e98ff 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -109,7 +109,7 @@ int boost_policy;
 /*
  * Variable to indicate if stalld is running or shutting down.
  */
-int running = 1;
+volatile sig_atomic_t running = 1;
 
 /*
  * Config single threaded: uses less CPU, but has a lower precision.
@@ -1247,6 +1247,8 @@ int main(int argc, char **argv)
 	else
 		single_threaded_main(cpus, config_nr_cpus);
 
+	log_msg("stalld shutting down\n");
+
 	cleanup_regex(&nr_thread_ignore, &compiled_regex_thread);
 	cleanup_regex(&nr_process_ignore, &compiled_regex_process);
 	if (config_log_syslog)
diff --git a/src/stalld.h b/src/stalld.h
index 03a4ca1..8b6ab8b 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -12,6 +12,7 @@
 #include <regex.h>
 #include <sched.h>
 #include <stdatomic.h>
+#include <signal.h>
 
 #define BUFFER_PAGES		10
 #define MAX_WAITING_PIDS	30
@@ -213,7 +214,7 @@ int check_dl_server_dir_exists(void);
 /*
  * Shared variables.
  */
-extern int running;
+extern volatile sig_atomic_t running;
 extern const char *version;
 extern int config_verbose;
 extern int config_write_kmesg;
diff --git a/src/utils.c b/src/utils.c
index 738d059..b3b17dd 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -169,7 +169,6 @@ long get_variable_long_value(char *buffer, const char *variable)
  */
 static void inthandler(int signo, siginfo_t *info, void *extra)
 {
-	log_msg("received signal %d, starting shutdown\n", signo);
 	running = 0;
 }
 
-- 
2.54.0

