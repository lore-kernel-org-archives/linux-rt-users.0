From: Jean Collas <jean.collas@enseirb.fr>
Subject: Get RT-linux working on a Routerboard 532
Date: Tue, 01 Jul 2008 21:28:32 +0200
Message-ID: <20080701212832.fjqvznpqm80c88cc@www.enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plan.enseirb.fr ([147.210.18.60]:42436 "EHLO plan.enseirb.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395AbYGAUDu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Jul 2008 16:03:50 -0400
Received: from localhost (mx [147.210.18.15])
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m61JSYrD004336
	for <linux-rt-users@vger.kernel.org>; Tue, 1 Jul 2008 21:28:34 +0200 (MEST)
Received: from plan.enseirb.fr ([147.210.18.60])
	by localhost (tan.enseirb.fr [147.210.18.15]) (amavisd-new, port 10041)
	with LMTP id Yin8fkOuQ-Hn for <linux-rt-users@vger.kernel.org>;
	Tue,  1 Jul 2008 21:28:25 +0200 (MEST)
Received: from enseirb.fr (www [147.210.19.96])
	by plan.enseirb.fr (8.13.8/8.13.4) with ESMTP id m61JSUQN004331
	for <linux-rt-users@vger.kernel.org>; Tue, 1 Jul 2008 21:28:30 +0200 (MEST)
Received: from enseirb.fr (localhost.enseirb.fr [127.0.0.1])
	by enseirb.fr (8.13.8/8.13.4) with ESMTP id m61JSWQe002870
	for <linux-rt-users@vger.kernel.org>; Tue, 1 Jul 2008 21:28:32 +0200 (MEST)
Received: (from www@localhost)
	by enseirb.fr (8.13.8/8.12.10/Submit) id m61JSWgn002869
	for linux-rt-users@vger.kernel.org; Tue, 1 Jul 2008 21:28:32 +0200 (MEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,

Everything is in the subject, does anybody have ever tried to get  
real-time linux on a routerboard?

I am trying to do it, but I have an issue with a non-existing function  
__bad_rwlock_type introduced by the rt-patch.

Thanks for any help,

Jean


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

