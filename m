From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] trivial: s/specifed/specified/
Date: Wed, 24 Feb 2010 17:58:06 +0100
Message-ID: <1267030688-12244-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100224165611.GA22159@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40830 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab0BXQ6N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2010 11:58:13 -0500
In-Reply-To: <20100224165611.GA22159@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/cyclictest/cyclictest.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 8f846c6..91e1102 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -130,7 +130,7 @@ set the ftrace tracer function. Used with the \-b o=
ption. Must be one
 of the trace functions available from <debugfs-mountpoint>/kernel/debu=
g/tracing/available_tracers
 .TP
 .B \-t, \-\-threads[=3DNUM]
-Set the number of test threads (default is 1). Create NUM test threads=
=2E If NUM is not specifed, NUM is set to
+Set the number of test threads (default is 1). Create NUM test threads=
=2E If NUM is not specified, NUM is set to
 the number of available CPUs. See \-d, \-i and \-p for further informa=
tion.
 .TP
 .B \-m, \-\-mlockall
--=20
1.6.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
