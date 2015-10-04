From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests 1/3] backfire: remove unused header file
Date: Sun,  4 Oct 2015 12:48:41 +0200
Message-ID: <1443955723-23042-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik Austad <haustad@cisco.com>, Josh Cartwright <joshc@ni.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55312 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751315AbbJDK5J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Oct 2015 06:57:09 -0400
In-Reply-To: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46rom: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
 src/backfire/version.h | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 src/backfire/version.h

diff --git a/src/backfire/version.h b/src/backfire/version.h
deleted file mode 100644
index 669b388a5363..000000000000
--- a/src/backfire/version.h
+++ /dev/null
@@ -1 +0,0 @@
-#define VERSION "0.5"
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
