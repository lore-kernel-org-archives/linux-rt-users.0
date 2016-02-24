From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 1/4] pip_stress: drop unused variable
Date: Wed, 24 Feb 2016 15:49:38 -0500
Message-ID: <1456346981-24032-2-git-send-email-lcapitulino@redhat.com>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: williams@redhat.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52223 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbcBXUtp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 15:49:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 9DB213024BC
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2016 20:49:44 +0000 (UTC)
In-Reply-To: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

src/pi_tests/pip_stress.c: In function =E2=80=98main=E2=80=99:
src/pi_tests/pip_stress.c:94:6: warning: unused variable =E2=80=98c=E2=80=
=99 [-Wunused-variable]

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/pi_tests/pip_stress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 66b3dc1..812a703 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -91,7 +91,6 @@ int main(void)
 	cpu_set_t set, *setp =3D &set;
 	int res;
 	int *minimum_priority =3D (int*)&prio_min;
-	int c;
=20
 	*minimum_priority =3D sched_get_priority_min(policy);
=20
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
