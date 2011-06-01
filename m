From: "N, Mugunthan V" <mugunthanvnm@ti.com>
Subject: up port rt patches to 2.6.37
Date: Wed, 1 Jun 2011 12:14:51 +0530
Message-ID: <45EE9921DD12714AB1D7B7B9D2FE208B022EDE07992A@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59296 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab1FAGo5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Jun 2011 02:44:57 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p516iroA020496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Wed, 1 Jun 2011 01:44:56 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p516ir5d027787
	for <linux-rt-users@vger.kernel.org>; Wed, 1 Jun 2011 12:14:53 +0530 (IST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I am trying to up port the rt patches patch-2.6.33.7.2-rt30 to 2.6.37 k=
ernel for arm. I have ported the patches except "set_workqueue_prio".

diff --git a/kernel/workqueue.c b/kernel/workqueue.c

@@ -1176,4 +1223,5 @@ void __init init_workqueues(void)
 	hotcpu_notifier(workqueue_cpu_callback, 0);
 	keventd_wq =3D create_workqueue("events");
 	BUG_ON(!keventd_wq);
+	set_workqueue_prio(keventd_wq, SCHED_FIFO, 1, -20);
 }

While booting the kernel, no user space process is coming up.
After run_init_process(), init process has to start executing, but init=
 process never comes up.

---
Regards,
Mugunthan V N.=A0

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
