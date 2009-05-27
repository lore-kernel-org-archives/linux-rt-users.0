From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH RESEND] cyclictest: calcdiff calculated wrong seconds
 if the difference was bigger than 2147s
Date: Wed, 27 May 2009 23:53:07 +0200
Message-ID: <4A1DB643.60302@agner.ch>
References: <4A1DAF07.6020704@agner.ch> <826434.45900.qm@web59805.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.deheime.ch ([62.12.167.34]:42262 "EHLO limpopo.deheime.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351AbZE0Vwa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2009 17:52:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id AE628C
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 23:55:44 +0200 (CEST)
Received: from limpopo.deheime.ch ([127.0.0.1])
	by localhost (limpopo.deheime.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBk6wI++SRnz for <linux-rt-users@vger.kernel.org>;
	Wed, 27 May 2009 23:55:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id 55A95F
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 23:55:44 +0200 (CEST)
Received: from [192.168.0.20] (250-251.0-85.cust.bluewin.ch [85.0.251.250])
	(Authenticated sender: falstaff@deheime.ch)
	by limpopo.deheime.ch (Postfix) with ESMTP id 255F8C
	for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 23:55:44 +0200 (CEST)
In-Reply-To: <826434.45900.qm@web59805.mail.ac4.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

My first fix didn't took into account that long is 4 byte long on ARM. Therefor 
I changed it to long long now, which works on my ARM board...


Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 src/cyclictest/cyclictest.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be9a3f9..3035a0a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -287,18 +287,18 @@ static inline void tsnorm(struct timespec *ts)
 	}
 }
 
-static inline long calcdiff(struct timespec t1, struct timespec t2)
+static inline long long calcdiff(struct timespec t1, struct timespec t2)
 {
-	long diff;
-	diff = USEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
+	long long diff;
+	diff = USEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec) / 1000;
 	return diff;
 }
 
-static inline long calcdiff_ns(struct timespec t1, struct timespec t2)
+static inline long long calcdiff_ns(struct timespec t1, struct timespec t2)
 {
-	long diff;
-	diff = NSEC_PER_SEC * ((int) t1.tv_sec - (int) t2.tv_sec);
+	long long diff;
+	diff = NSEC_PER_SEC * (long long)((int) t1.tv_sec - (int) t2.tv_sec);
 	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
 	return diff;
 }
-- 1.6.0.4 
