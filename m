From: Karthik Singaram Lakshmanan <karthiksingaram@gmail.com>
Subject: Re: [rt sched] SCHED_FIFO task of lower rt_priority blocks higher one
Date: Wed, 3 Mar 2010 22:54:22 -0500
Message-ID: <1ca41c0f1003031954u6e948c74n4cebdecbbe52f5ae@mail.gmail.com>
References: <ac85e7a01003031921x2102d554q86c76e560f7ef6f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux RT <linux-rt-users@vger.kernel.org>
To: Xianwei Zeng <linux.xianwei.zeng@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:39680 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab0CDDy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Mar 2010 22:54:28 -0500
Received: by gxk9 with SMTP id 9so941098gxk.8
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2010 19:54:27 -0800 (PST)
In-Reply-To: <ac85e7a01003031921x2102d554q86c76e560f7ef6f4@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
=A0 =A0If I am not mistaken, higher value of sched_priority denotes
higher priority.
=A0 =A0Therefore, looking at
=A0 =A0 =A0 =A0normal_prio =3D MAX_RT_PRIO - 1 - task->rt_priority;
=A0 =A0 =A0 =A0you can see that a higher task->rt_priority will transla=
te to
a lower value of normal_prio, thereby occupying an earlier bit.

Hope that helps
- Karthik
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
