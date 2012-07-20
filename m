From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: rt & hotplug work....
Date: Fri, 20 Jul 2012 22:07:38 +0200
Message-ID: <CAF-VNaoh=t50=6A-OXitYPJxz67Es_jFQeqsXcdJThexb8uHSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61615 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab2GTUHj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jul 2012 16:07:39 -0400
Received: by wgbdr13 with SMTP id dr13so3985323wgb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2012 13:07:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 There was some cpu hotplug work recently, and I can't get my head
around what happens with a dual cpu system if one core is shut down,
specificly with spinlocks.
 Won't it just hang or spin a lot ? I was thinking the locking was
different in the build for uni of multi processors, to eliminate the
deadlock risk on a uni processor.

 I do realise this might not be rt specific, but I'll ask anyhow.

 / regards, Lars Segerlund.
