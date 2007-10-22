From: "Back, Michael (ext)" <michael.back.ext@siemens.com>
Subject: KVM and Prempt?
Date: Mon, 22 Oct 2007 09:01:00 +0200
Message-ID: <003F437218F04842B2A6976FA19368B1886B99@ERLM863A.ww001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from thelpusa.erlm.siemens.de ([217.194.34.71]:36083 "EHLO
	thelpusa.erlm.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXJVHPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2007 03:15:10 -0400
Received: from thelpusa.erlm.siemens.de (localhost.localdomain [127.0.0.1])
	by thelpusa.erlm.siemens.de (Postfix) with ESMTP id CB8E2DB83E9
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 09:00:59 +0200 (CEST)
Received: from thelpusa (localhost.localdomain [127.0.0.1])
	by thelpusa.erlm.siemens.de (Postfix) with ESMTP id BE034DB8105
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 09:00:59 +0200 (CEST)
Received: from metropolis.erlm.siemens.de (metropolis.erlm.siemens.de [146.254.160.192])
	by thelpusa.erlm.siemens.de (Postfix) with ESMTP
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 09:00:59 +0200 (CEST)
Received: from erlm802a.ww001.siemens.net (erlm802a.ww001.siemens.net [146.254.188.141])
	by metropolis.erlm.siemens.de (Postfix) with ESMTP id 9603A2BAA95
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 09:00:59 +0200 (CEST)
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hallo,
I tried to run Windows XP with KVM on Linux 2.6.31.1 on a 
AMD Opteron and on a Intel Xeon, on both it works fine!

After this test I patch the kernel with the current prempt-patch and on
both it doesn't works! 
-> After a very short time - I could see the windows startup screen -
the complied system froze!
 
Has you ever tried to do the same and it works?
Or will KVM with Windows on a prempt kernel 
- never work?
- maybe work in the future?
- should now work but this .. and this ... should be done and consider?

With best regards,
Michael
