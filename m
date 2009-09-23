From: Azraiyl <azraiyl@gmail.com>
Subject: Re: 2.6.31-rt11 freeze on userland start on ARM
Date: Wed, 23 Sep 2009 23:06:28 +0000 (UTC)
Message-ID: <loom.20090924T010608-530@post.gmane.org>
References: <3efb10970909211136g4e74c8b3vc339d548cdd0959f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57275 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbZIWXKB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Sep 2009 19:10:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MqayJ-0008Kh-Ld
	for linux-rt-users@vger.kernel.org; Thu, 24 Sep 2009 01:10:03 +0200
Received: from 216-3.2-85.cust.bluewin.ch ([85.2.3.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2009 01:10:03 +0200
Received: from azraiyl by 216-3.2-85.cust.bluewin.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Sep 2009 01:10:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Same problem here on a Olimex SAM9-L9260 Board (ARM926EJ-S). Your "fix" helps
aswell.

