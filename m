From: Monica Puig-Pey <puigpeym@unican.es>
Subject: synchronization mechanisms
Date: Mon, 20 Jun 2011 16:27:41 +0200
Message-ID: <4DFF58DD.3040801@unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver2.unican.es ([130.206.5.101]:57984 "EHLO
	ccserver2.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab1FTO1q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jun 2011 10:27:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello!
As I told you in previous questions I'm developing drivers using the=20
2.6.31-11-rt patch under ubuntu 10.04.
It is very important for me to know about which real time=20
synchronization mechanisms do I have.
I found the RT-mutexes, with priority inherintance, the plists (priorit=
y=20
lists) and now I'm looking for more information about semaphores. I=20
haven't found anything relevant in the code that I could know that they=
=20
work well under real time, having a priority queue of tasks waiting on=20
it. So I've made an easy example where I have 3 kernel threads with=20
different priorities each (60,70,80) in the semaphore queue. Then I see=
=20
is always the most priority kthread who wakes up the first. Good! It=20
seems to work as a RT semaphore!
In my code I have an error. I can use down_interruptible but I can't us=
e=20
down_killable. Why is it?
Could anybody give me some help about semaphores in the rt-patch and=20
about any other synchronization mechanism thought for real time?

Thanks a lot

M=F3nica
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
