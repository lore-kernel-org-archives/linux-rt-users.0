From: Karthik Singaram Lakshmanan <karthiksingaram@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Wed, 3 Mar 2010 22:53:25 -0500
Message-ID: <1ca41c0f1003031953k16c62637ke7151737c527afbf@mail.gmail.com>
References: <1ca41c0f1003031952u7a9ea0w5adf4f0438b8fe0c@mail.gmail.com>
	 <0016e646086875cfde0480f186a0@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Linux RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f204.google.com ([209.85.210.204]:55519 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab0CDDx0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Mar 2010 22:53:26 -0500
Received: by yxe42 with SMTP id 42so86723yxe.4
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2010 19:53:25 -0800 (PST)
In-Reply-To: <0016e646086875cfde0480f186a0@google.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
=A0=A0=A0 If I am not mistaken, higher value of sched_priority denotes
higher priority.
=A0=A0=A0 Therefore, looking at
=A0 =A0=A0 =A0=A0 normal_prio =3D MAX_RT_PRIO - 1 - task->rt_priority;
=A0=A0=A0=A0=A0=A0=A0 you can see that a higher task->rt_priority will =
translate to
a lower value of normal_prio, thereby occupying an earlier bit.

Hope that helps
- Karthik
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
