From: Rasmus Ahlberg <rasmus.ahlberg@electrolux.com>
Subject: Blocked kworker in single core RT system
Date: Fri, 9 Dec 2016 15:44:56 +0000
Message-ID: <DB6PR0601MB24234A8580A50FC97001DD46E0870@DB6PR0601MB2423.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Rasmus Ahlberg <rasmus.ahlberg@electrolux.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:49371
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752840AbcLIVTI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Dec 2016 16:19:08 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
We're running Linux with the RT patch on our single core ARM embedded syste=
m, kernel version 3.14. Our application has several threads, of which some =
are running in mode SCHED_RR, with different priorities.

One of the higher prio SCHED_RR threads is dependent on data from the TTY d=
river. In the driver, a workqueue is used to deliver the data received, whi=
ch is serviced by a kworker. The kworker runs in mode SCHED_OTHER. If one o=
f the lower priority SCHED_RR threads is running, it will therefore block t=
he kworker, and indirectly the higher prio SCHED_RR thread.

Our tests show that the problem can be solved by setting mode SCHED_RR for =
the kworker, which makes sense. However, this is not easily implemented in =
the real system, as kworkers are created and destroyed dynamically. Also, a=
s the kworkers performs work for other drivers also, this might not be opti=
mal.

What is the recommended way to solve this problem? Is there some kernel opt=
ion that solves this, or do we need to make our own implementation?

Regards,

 Rasmus Ahlberg
 Software Developer, R&D
 Electrolux Small Appliances
 Cell phone: +46-(0)738-857392

 S:t G=F6ransgatan 143
 SE-105 45 Stockholm
 Sweden


This email and any attached files is for the attention of the intended reci=
pient. The email and any attachments may contain material that is confident=
ial, privileged and/or attorney work product. If you are not the intended r=
ecipient: (a) contact the sender immediately and delete from your system al=
l copies of the email including any attachments. (b) do not read, print, re=
tain, copy or disseminate this message or any part of it. Any such unauthor=
ized use may be unlawful. E-mail transmission cannot be guaranteed to be se=
cure or error-free as information could be intercepted, corrupted, lost, de=
stroyed, arrive late or incomplete, or contain viruses. The sender therefor=
e can not accept liability for any errors or omissions in the contents of t=
his message, which arise as a result of e-mail transmission. If verificatio=
n is required please request a hard-copy version. The Electrolux Group www.=
electrolux.com
