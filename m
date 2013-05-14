From: Heiko Schumann <heiko.sirona@gmail.com>
Subject: Highmem support on ppc32 plattform with PREEMPT_RT_FULL option
Date: Tue, 14 May 2013 13:04:34 +0200
Message-ID: <CAKQvxgWOcnK79bn1f0LWqvagAEXVrS39eGv0ESUvp4LwdnGEFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:45445 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab3ENLEg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 May 2013 07:04:36 -0400
Received: by mail-la0-f49.google.com with SMTP id ee20so369995lab.8
        for <linux-rt-users@vger.kernel.org>; Tue, 14 May 2013 04:04:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

i=B4ve a ppc32 processor with 2 GB Ram. I use a 3.8.4 Kernel with vendo=
r
and 3.8.4rt2 patch. To support  2 GB of RAM i=B4ve to set the kernel
option HIGHMEM. But this option is not available when PREEMPT_RT_FULL
is selected.
Is there a workaround or additional patch to use more than 1GB RAM on
a ppc32 with the option PREEMPT_RT_FULL?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
