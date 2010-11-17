From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Slub support with PREEMPT_RT ?
Date: Wed, 17 Nov 2010 17:18:13 +0100
Message-ID: <AANLkTimUb7rfRKCwhnf3s=Qw+J79_PqL_1Zk=fz5B99q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56785 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934864Ab0KQQSP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Nov 2010 11:18:15 -0500
Received: by wyb28 with SMTP id 28so2137689wyb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Nov 2010 08:18:14 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi !

I am wondering why SLUB isn't supported with PREEMPT_RT ?
I cannot find any info on that except the fact it is not working yet.
What do we have to do in order to support it ?

Thanks in advance,
JM
