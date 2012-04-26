From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: some rt-preempt help if possible.
Date: Thu, 26 Apr 2012 22:27:30 +0200
Message-ID: <CAF-VNap+wE=dPy-J7BcZhS7K9AZRBW61TC0-7gAVuoqUzu-e_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54691 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758892Ab2DZU1c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Apr 2012 16:27:32 -0400
Received: by lahj13 with SMTP id j13so9608lah.19
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Apr 2012 13:27:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 Hi Everyone,

 The linux cnc is trying to port their software to rt preempt, however
there is a patched version for emc 2.4 that works ok, and when these
patches are brought to emc 2.5 it hangs on startup.

 Aparently it's a mutex that hangs.

 Now any help or pointers would be appreciated, particulary on how to
debug a mutex hang ....

 Roughly the same code runs ok in the old version, and most people on
the linuxcnc list are only familiar with RTLinux and RTAI. Any help
appreciated, since the code is still 'wet', so this is a small call
for help is someone feels like it.

 If it's of topic, or not interesting please ignore.

http://news.gmane.org/gmane.linux.distributions.emc.devel

 / regards, Lars Segerlund
