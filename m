From: Jan Engelhardt <jengelh@medozas.de>
Subject: Compile error wrt. RW_LOCK_UNLOCKED
Date: Mon, 2 Mar 2009 14:48:07 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0903021447160.30028@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:47929 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZCBNsK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2009 08:48:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id D232A43A2F96
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Mar 2009 14:48:07 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,


the following minimal testcase fails to compile on 2.6.29-rc6-rt3 with=20
CONFIG_PREEMPT_RT=3Dn.

/dev/shm/m.c:8: error: expected expression before =E2=80=98{=E2=80=99 t=
oken

---8<---
#include <linux/module.h>
#include <linux/semaphore.h>

static int __init m_init(void)
{
        rwlock_t f;

        f =3D RW_LOCK_UNLOCKED;
        return -EIO;
}

static void __exit m_exit(void)
{}

module_init(m_init);
module_exit(m_exit);
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
