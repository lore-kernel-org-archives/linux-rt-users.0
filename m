From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: preempt_disable and sleep()
Date: Fri, 14 May 2010 00:02:43 +0530
Message-ID: <AANLkTinbwZK5Tp6aI4ja38XaiiB5aIyECzHPdMpvkaIy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54449 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758672Ab0EMSco (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 14:32:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am running RT linux .

/* code snippet */

preempt_disable()
...........
sleep(10);
'............
preempt_enable()


will this sleep() will cause reschedule ?.

if an interrupt comes  while premption is disabled , how it is handled ?.

Thanks,
Ratheesh
