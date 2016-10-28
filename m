From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: cyclictest: Correct short option 's'
Date: Fri, 28 Oct 2016 17:11:10 +0200
Message-ID: <1477667470-9691-2-git-send-email-jkacur@redhat.com>
References: <1477667470-9691-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36098 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932873AbcJ1PLg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Oct 2016 11:11:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id c17so7849304wmc.3
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Oct 2016 08:11:35 -0700 (PDT)
In-Reply-To: <1477667470-9691-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The short option 's' was originally intended to be the short form of
--system

Commit b35bc97cfd05bd27324b9c373ff8c5e0bcb07f7f
which added the new option --secaligned broke this, by accidently
inserting the new option between the short form and long form.

Reported-by: Daniel Seemer <phaiax-cyclictest@invisibletower.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 5e23fc58f602..3f1bef1ffca9 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1688,7 +1688,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		case 'R':
 		case OPT_RESOLUTION:
 			check_clock_resolution = 1; break;
-		case 's':
 		case OPT_SECALIGNED:
 			secaligned = 1;
 			if (optarg != NULL)
@@ -1698,6 +1697,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else
 				offset = 0;
 			break;
+		case 's':
 		case OPT_SYSTEM:
 			use_system = MODE_SYS_OFFSET; break;
 		case 'S':
-- 
2.5.5

