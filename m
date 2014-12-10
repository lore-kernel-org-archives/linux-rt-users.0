From: chase.qi@linaro.org
Subject: [PATCH] pip_stress: increase usleep for ARM devices
Date: Wed, 10 Dec 2014 16:25:01 +0800
Message-ID: <1418199901-3175-1-git-send-email-chase.qi@linaro.org>
Cc: clark.williams@gmail.com, milosz.wasilewski@linaro.org,
	naresh.kamboju@linaro.org, jorge.ramirez-ortiz@linaro.org,
	anders.roxell@linaro.org, mike.holmes@linaro.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61148 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbaLJIZX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2014 03:25:23 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so2355076pab.12
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Dec 2014 00:25:22 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Chase Qi <chase.qi@linaro.org>

Hello,

pip_stress works out of the box on my x86 based laptop, but
doesn't work on ARM devices, returned 'no inversion incurred'.
Follow the comment to increase usleep value, 2500 worked for
pandaboard and 3000 worked for Beaglebone Black board.

I propose that increase the usleep value to 3500 from upstream,
so that we can use pip_stress right out of the box.

Please let me know if this is acceptable.

Regards,
Chase

Signed-off-by: Chase Qi <chase.qi@linaro.org>
---
 src/pi_tests/pip_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 2b42b8f..553290b 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -162,7 +162,7 @@ void low(pid_t pid)
 				statep->inversion = 0;
 			}
 		Pthread_mutex_unlock(statep->mutex);
-		usleep(500);
+		usleep(3500);
 	Pthread_mutex_unlock(resource);
 	waitpid(pid, &status, 0);
 }
-- 
1.9.1

