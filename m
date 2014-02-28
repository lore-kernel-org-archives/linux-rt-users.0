From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [patch] rt,sched,numa: Move task_numa_free() to __put_task_struct(),
 which -rt offloads
Date: Fri, 28 Feb 2014 13:00:47 +0400
Message-ID: <5310503F.2070408@pavlinux.ru>
References: <1393568591.6018.27.camel@marge.simpson.net>
Reply-To: Pavel Vasilyev <pavel@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:55224 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaB1JA4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Feb 2014 04:00:56 -0500
Received: from imp01.mtu.ru (alt-proxy-1.mtu.ru [62.5.255.74])
	by ss27-so03.mtu.ru (Postfix) with ESMTP id F3DF828402B
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Feb 2014 13:00:50 +0400 (MSK)
In-Reply-To: <1393568591.6018.27.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

28.02.2014 10:23, Mike Galbraith =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

Maybe

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -237,6 +237,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(atomic_read(&tsk->usage));
 	WARN_ON(tsk =3D=3D current);
+#ifdef CONFIG_NUMA
+	task_numa_free(tsk);
+#endif
 	security_task_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
=2E..
=2E..
=2E..

>=20

--=20

                                                         Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
