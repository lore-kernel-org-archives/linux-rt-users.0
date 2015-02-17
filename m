From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests] pi_stress: remove timestamp of compilation from version output
Date: Tue, 17 Feb 2015 16:08:59 +0100
Message-ID: <1424185739-29680-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35436 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbbBQPJD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 10:09:03 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Having the date and time of compilation is hardly useful and is in the
way for reproducible building binaries.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

a few people work on getting reproducible builds for Debian. Using
__DATE__ and __TIME__ obviously makes the rt-tests package fail to
compile in a deterministic fashion.

Best regards
Uwe

 src/pi_tests/pi_stress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index e273d62..9b33fad 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1235,7 +1235,6 @@ void process_command_line(int argc, char **argv)
 			break;
 		case 'V':
 			printf("pi_stress v%1.2f ", VERSION_STRING);
-			printf("(%s %s)\n", __DATE__, __TIME__);
 			exit(0);
 		case 'u':
 			uniprocessor =3D 1;
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
