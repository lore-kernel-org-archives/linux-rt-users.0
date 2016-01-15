From: "Mathias Koehrer" <mathias.koehrer@etas.com>
Subject: Kernel thread's CPU affinity with isolcpus kernel boot argument
Date: Fri, 15 Jan 2016 12:15:28 +0100
Message-ID: <5698D4D0.3020907@etas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:15680 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbcAOLPd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 06:15:33 -0500
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 8F8131580002
	for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 12:15:30 +0100 (CET)
Received: from FE-MBX1012.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
	by vsmta14.fe.internet.bosch.com (Postfix) with ESMTP id 6532AA4047C
	for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 12:15:30 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

we use an Intel Core i7 machine (64bit) to use the cores > 0 for real=20
time tasks.

=46or this the kernel boot parameter =E2=80=9Cisolcpus=3D1-31=E2=80=9D =
is provided.
That works fine for all user space tasks.

However, I noticed that most kernel threads use the affinity mask 0xff.
I can change this by using =E2=80=9Ctaskset=E2=80=9D. However, I am won=
dering if there=20
is mechanism that forces the kernel to consider the value of =E2=80=9Ci=
solcpus=E2=80=9D=20
also for kernel threads.

Kernel version in use is: 3.18.20-rt18.

Thanks for any feedback on this.

Best regards

Mathias


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
