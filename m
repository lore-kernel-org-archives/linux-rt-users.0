From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH 3/4] rt-tests: Clean-up - protect rt-utils.h
Date: Tue, 22 Dec 2009 00:09:35 +0100
Message-ID: <4B30002F.3030209@osadl.org>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com> <1261431950-28500-2-git-send-email-jkacur@redhat.com> <1261431950-28500-3-git-send-email-jkacur@redhat.com> <1261431950-28500-4-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:37083 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbZLUXKE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 18:10:04 -0500
In-Reply-To: <1261431950-28500-4-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/21/2009 10:45 PM, John Kacur wrote:
> Clean-up: Protect rt-utils.h with #ifndef RT_UTILS_H
> [..]
> +#ifndef RT_UTILS.H
Macro names should only consist of alphanumeric characters and
underscores, i.e. 'a-z', 'A-Z', '0-9', and '_', and the first character
should not be a digit.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

diff --git a/src/lib/rt-utils.h b/src/lib/rt-utils.h
index fbdcf2b..e7a1908 100644
--- a/src/lib/rt-utils.h
+++ b/src/lib/rt-utils.h
@@ -1,5 +1,5 @@
-#ifndef RT_UTILS.H
-#define RT_UTILS.H
+#ifndef RT_UTILS_H
+#define RT_UTILS_H

 #define _STR(x) #x
 #define STR(x) _STR(x)
@@ -8,4 +8,4 @@
 int check_privs(void);
 char *get_debugfileprefix(void);

-#endif /* RT_UTILS.H */
+#endif /* RT_UTILS_H */
