From: Pankaj Gupta <pagupta@redhat.com>
Subject: Query - state of memory hotplug with RT kernel
Date: Thu, 2 Jun 2016 06:10:41 -0400 (EDT)
Message-ID: <420969271.56780563.1464862241604.JavaMail.zimbra@redhat.com>
References: <1997236940.56779393.1464861408686.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:37864 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbcFBKKm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Jun 2016 06:10:42 -0400
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id u52AAfkq013944
	for <linux-rt-users@vger.kernel.org>; Thu, 2 Jun 2016 06:10:41 -0400
In-Reply-To: <1997236940.56779393.1464861408686.JavaMail.zimbra@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Recently, I have been debugging some of the issues with memory 
hotplug with RT kernel. I want to know state of memory hotplug 
with RT kernel and if there are any known issues or work going
on upstream?

I came to know that there is rework of 'cpu hotplug' going on.
Not sure about 'memory hotplug'.

Any inputs or pointers on this?

Best regards,
Pankaj
