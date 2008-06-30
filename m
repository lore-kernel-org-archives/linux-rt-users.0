From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: [PATCH -rt] Add schedule_work_prio() and queue_work_prio().
Date: Mon, 30 Jun 2008 11:18:56 +0200
Message-ID: <c384c5ea0806300218u7b5050f0nb77f66f53f3dc364@mail.gmail.com>
References: <c384c5ea0806281023y6fcfb0f4o1a41aef3856bda9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:3692 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbYF3JS7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 05:18:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so277825and.103
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Jun 2008 02:18:58 -0700 (PDT)
In-Reply-To: <c384c5ea0806281023y6fcfb0f4o1a41aef3856bda9e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Please review the patch. I am especially interested if the analysis of
the problem it tries to solve is correct, and the approach taken.

Obviously the patch will not apply and my statement about
compile-tested was obviously false. (I wonder what I did compile
instead):

+int queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+  return queue_work(struct workqueue_struct *wq, struct work_struct *work,
+    current->normal_prio);
+}

I am preparing a new patch, and testing this on the target were I saw
the problem, first. I'll follow-up with results and a new patch.

Regards,
--
Leon.
