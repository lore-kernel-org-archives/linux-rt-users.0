From: "Koehrer Mathias (ETAS/EHE1)" <mathias.koehrer@etas.com>
Subject: Realtime tasks and cgroups (cpu.shares)
Date: Mon, 10 Jul 2017 12:57:05 +0000
Message-ID: <cb8cd411e19f4039b7edf024b7762041@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:40613 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbdGJM5I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jul 2017 08:57:08 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
        by imta23.fe.bosch.de (Postfix) with ESMTP id 99D70158012E
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jul 2017 14:57:06 +0200 (CEST)
Received: from FE-MBX1012.de.bosch.com (vsgw23.fe.internet.bosch.com [10.4.98.23])
        by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 9D45A238025C
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jul 2017 14:57:06 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

is it possible to combine real time tasks and cgroups (in particular cpu.shares)?
The background of the question is the following:
If a real time task hangs by accident in an endless loop, it blocks the complete access to the system.
One idea could be to reserve a small percentage of the CPU for non real time stuff to
avoid these kind of situations.

Is this possible?

Thanks for any feedback on this topic.

Regards

Mathias
