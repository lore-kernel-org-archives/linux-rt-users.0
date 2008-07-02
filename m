From: Jean Collas <jean.collas@enseirb.fr>
Subject: Get RT-linux working on a Routerboard 532
Date: Wed, 02 Jul 2008 16:52:45 +0200
Message-ID: <20080702165245.ezannbafk884owos@www.enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:59906 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbYGBOww (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jul 2008 10:52:52 -0400
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m62EqlGx024333
	for <linux-rt-users@vger.kernel.org>; Wed, 2 Jul 2008 16:52:47 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id c3pnz4-NESJ4 for <linux-rt-users@vger.kernel.org>;
	Wed,  2 Jul 2008 16:52:37 +0200 (MEST)
Received: from enseirb.fr (www [147.210.19.96])
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m62EqiVW024324
	for <linux-rt-users@vger.kernel.org>; Wed, 2 Jul 2008 16:52:44 +0200 (MEST)
Received: from enseirb.fr (localhost.enseirb.fr [127.0.0.1])
	by enseirb.fr (8.13.8/8.13.4) with ESMTP id m62EqkYT018114
	for <linux-rt-users@vger.kernel.org>; Wed, 2 Jul 2008 16:52:46 +0200 (MEST)
Received: (from www@localhost)
	by enseirb.fr (8.13.8/8.12.10/Submit) id m62Eqk7X018113
	for linux-rt-users@vger.kernel.org; Wed, 2 Jul 2008 16:52:46 +0200 (MEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,
As I had troubles with majordomo, I am not sure my previous mail had  
been sent, otherwise sorry for the inconvenience.

I was wondering if someone has already tried to apply the rt-linux  
patch on a RB532.

I work with OpenWRT to add the RB532 on MIPS machines. I am trying add  
this rt-patch, but I have an issue with a non-existing extern function  
introduced by the rt-patch (__bad_rwlock_type).
Can anybody help ?

Regards,

Jean

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

